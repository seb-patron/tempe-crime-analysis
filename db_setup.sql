/*
- Creates database, tables, and imports csv's into tables
-
- in order to import csv's, temporary tables with same columns are created
- then the temporary tables columns' are selected and imported into final table
- finally temporary tables are destroyed
*/

DROP DATABASE IF EXISTS phoenix_crimes;
CREATE DATABASE phoenix_crimes;

\c phoenix_crimes;

/*
- create tempe pd temporary table. this is what the csv will stream into first
-
- reads in all data from csv
*/
CREATE TABLE temporary_tempe_pd_offenses (
     x REAL,
     y REAL,
     OBJECTID VARCHAR,
     primary_key VARCHAR,
     occ_dt VARCHAR,
     obfAddress VARCHAR,
     x_rand VARCHAR,
     y_rand VARCHAR,
     disclaimer VARCHAR,
     place_name VARCHAR,
     OffenseCustom VARCHAR,
     locationTranslation VARCHAR
);

/*
- create tempe pd table. temp table will be copied into it
-
- note: not all data will be copied as some of it is unimportant/repeated
*/
CREATE TABLE tempe_pd_offenses (
  id VARCHAR PRIMARY KEY,
  latitude REAL,
  longitude REAL,
  incident_datetime VARCHAR,
  incident_address VARCHAR,
  disclaimer VARCHAR,
  place_name VARCHAR,
  offense VARCHAR,
  location_type VARCHAR
);

-- Copy the Police_General_Offense csv into the temporary_tempe_pd_offenses table
\copy temporary_tempe_pd_offenses (X,Y,OBJECTID,primary_key,occ_dt,obfAddress,x_rand,y_rand,disclaimer,place_name,OffenseCustom,locationTranslation) FROM './data/raw/Police_General_Offense.csv' CSV HEADER;

-- take the temporary_tempe_pd_offenses, select only the rows we want, and insert them into tempe_pd_offenses
-- note that some of the names are changed for better readibity, so our selections might have different column names
INSERT INTO tempe_pd_offenses (id, latitude, longitude, incident_datetime, incident_address, disclaimer, place_name, offense, location_type) 
select OBJECTID, Y, X, occ_dt, obfAddress, disclaimer, place_name, OffenseCustom, locationTranslation 
from temporary_tempe_pd_offenses;


/*
- create asu pd temporary table. this is what the csv will stream into first
-
- reads in all data from csv
*/
CREATE TABLE temporary_asu_pd_offenses (
     incident_id VARCHAR,
     case_number VARCHAR,
     incident_datetime VARCHAR,
     incident_type_primary VARCHAR,
     incident_description VARCHAR,
     clearance_type VARCHAR,
     address_1 VARCHAR,
     address_2 VARCHAR,
     city VARCHAR,
     incident_state VARCHAR,
     zip VARCHAR,
     country VARCHAR,
     latitude REAL,
     longitude REAL,
     created_at VARCHAR,
     updated_at VARCHAR,
     location_tuple VARCHAR,
     hour_of_day VARCHAR,
     day_of_week VARCHAR,
     parent_incident_type VARCHAR
);

/*
- create asu pd table. temp table will be copied into it
-
- note: not all data will be copied as some of it is unimportant/repeated
*/
CREATE TABLE asu_pd_offenses (
  id VARCHAR PRIMARY KEY,
  case_number VARCHAR,
  incident_datetime VARCHAR,
  latitude REAL,
  longitude REAL,
  incident_address VARCHAR,
  city VARCHAR,
  offense VARCHAR,
  offense_type VARCHAR
);

-- Copy the Arizona_State_University_Police_Department csv into the temporary_asu_pd_offenses table
\copy temporary_asu_pd_offenses (incident_id,case_number,incident_datetime,incident_type_primary,incident_description,clearance_type,address_1,address_2,city,incident_state,zip,country,latitude,longitude,created_at,updated_at,location_tuple,hour_of_day,day_of_week,parent_incident_type) FROM './data/raw/Arizona_State_University_Police_Department.csv' CSV HEADER;

-- take the asu_pd_offenses, select only the rows we want, and insert them into asu_pd_offenses
-- note that some of the names are changed for better readibity, so our selections might have different column names
insert into asu_pd_offenses (id, case_number, latitude, longitude, incident_datetime, incident_address, city, offense, offense_type) 
select incident_id, case_number, latitude, longitude, incident_datetime, address_1, city, incident_description, parent_incident_type
from temporary_asu_pd_offenses;


-- Now that everything is copied into the correct table, lets get rid of these temporary tables.
DROP TABLE temporary_tempe_pd_offenses;
DROP TABLE temporary_asu_pd_offenses;