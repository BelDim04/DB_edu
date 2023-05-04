import pandas as pd
import os
import psycopg2 as pg
import unittest
from dataclasses import dataclass


@dataclass
class Credentials:
    dbname: str = "pg_db"
    host: str = "localhost"
    port: int = 5432
    user: str = "postgres"
    password: str = "postgres"


def psycopg2_conn_string():
    return f"""
        dbname='{os.getenv("DBNAME", Credentials.dbname)}'
        user='{os.getenv("DBUSER", Credentials.user)}'
        host='{os.getenv("DBHOST", Credentials.host)}'
        port='{os.getenv("DBPORT", Credentials.port)}'
        password='{os.getenv("DBPASSWORD", Credentials.password)}'
    """


def set_connection():
    return pg.connect(psycopg2_conn_string())


class TestHardQueries(unittest.TestCase):
    def __init__(self, *args, **kwargs):
        super(TestHardQueries, self).__init__(*args, **kwargs)
        self.conn = set_connection()
        self.cursor = self.conn.cursor()

    def test1(self):
        query = """
            SELECT o.email, COUNT(*) as num_venues
            FROM booking.Venue v
            JOIN booking.Owner o on v.owner_id = o.owner_id 
            GROUP BY o.owner_id
            HAVING COUNT(*) >= 2;
            """

        result = pd.read_sql(query, con=self.conn)
        assert result.shape[1] == 2
        for i in range(0, result.shape[0]):
            assert result.iloc[i].loc['num_venues'] >= 2

    def test2(self):
        query = """
            SELECT v.name, AVG(vr.rating) as avg_rating
            FROM booking.Venue v
            LEFT JOIN booking.VenueReview vr ON v.venue_id = vr.venue_id
            GROUP BY v.venue_id
            ORDER BY avg_rating DESC;
            """

        result = pd.read_sql(query, con=self.conn)
        assert result.shape[1] == 2
        for i in range(1, result.shape[0]):
            if not pd.isna(result.iloc[i-1].loc['avg_rating']):
                assert result.iloc[i].loc['avg_rating'] > result.iloc[i-1].loc['avg_rating']

    def test3(self):
        query = """
            SELECT v.name, r.name, price::numeric, AVG(price::numeric) OVER (PARTITION BY o.rate_id),
            RANK() OVER (ORDER BY price::numeric)
            FROM booking.Venue v
            JOIN booking.Offer o on v.venue_id = o.venue_id
            JOIN booking.Rate r on o.rate_id = r.rate_id;
            """

        result = pd.read_sql(query, con=self.conn)
        assert result.shape[1] == 5

    def test4(self):
        query = """
            SELECT price, LAG(price::numeric, 1, 0) OVER (PARTITION BY offer_id ORDER BY valid_to)
            FROM (select * from booking.OfferHistory
            UNION ALL (SELECT offer_id, NOW(), price as valid_to from booking.Offer)) as tmp;
            """

        result = pd.read_sql(query, con=self.conn)
        assert result.shape[1] == 2

    def test5(self):
        query = """
            SELECT v.name, a.name, ROW_NUMBER() OVER (PARTITION BY v.venue_id) as amenity_num
            FROM booking.Venue v
            JOIN booking.Venue_x_Amenity va on v.venue_id = va.venue_id
            JOIN booking.Amenity a on va.amenity_id = a.amenity_id
            ORDER BY amenity_num;
            """

        result = pd.read_sql(query, con=self.conn)
        assert result.shape[1] == 3


    def test6(self):
        query = """
            SELECT v.name, a.name, vr.rating, COUNT(vr.rating) OVER (PARTITION BY a.amenity_id), AVG(vr.rating) OVER (PARTITION BY a.amenity_id)
            FROM booking.Venue v
            JOIN booking.Venue_x_Amenity va on v.venue_id = va.venue_id
            JOIN booking.Amenity a on va.amenity_id = a.amenity_id
            JOIN booking.VenueReview vr on v.venue_id = vr.venue_id;
            """

        result = pd.read_sql(query, con=self.conn)
        assert result.shape[1] == 3

    def test7(self):
        query = """
            SELECT *
            FROM booking.ProtectedUserInfo
            """

        result = pd.read_sql(query, con=self.conn)
        assert result.shape[1] == 4

    def test8(self):
        query = """
            SELECT *
            FROM booking.ProtectedOwnerInfo
            """

        result = pd.read_sql(query, con=self.conn)
        assert result.shape[1] == 4

    def test9(self):
        query = """
            SELECT *
            FROM booking.OwnerStat
            """

        result = pd.read_sql(query, con=self.conn)
        assert result.shape[1] == 3

    def test10(self):
        query = """
            SELECT *
            FROM booking.UserStat
            """

        result = pd.read_sql(query, con=self.conn)
        assert result.shape[1] == 4

    def test11(self):
        query = """
            SELECT *
            FROM booking.AmenityStat
            """

        result = pd.read_sql(query, con=self.conn)
        assert result.shape[1] == 3

    def test12(self):
        query = """
            SELECT *
            FROM booking.RateStat
            """

        result = pd.read_sql(query, con=self.conn)
        assert result.shape[1] == 3

    def end(self):
        self.cursor.close()
        self.conn.close()

