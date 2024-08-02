# This is the example of database schema

from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import declarative_base
from geoalchemy2 import Geometry

Base = declarative_base()

class SomeTable(Base):
    __tablename__ = "some_table"
    
    id = Column(Integer, primary_key=True)
    name = Column(String)
    geom = Column(Geometry("LINESTRING", srid=4326))