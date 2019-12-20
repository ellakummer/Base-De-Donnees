DROP TABLE FILM;

DROP TABLE COMPANY;
CREATE TABLE COMPANY
(   Company_ID NUMBER(4), --Primary Key 
    Company_Name VARCHAR(25) NOT NULL,
    Company_Country VARCHAR(20) NOT NULL,
    CONSTRAINT COMPANY_pk PRIMARY KEY (Company_ID)
);

DROP TABLE MAIN_ACTOR;
CREATE TABLE MAIN_ACTOR
(   Main_Actor_ID NUMBER(4), -- Primary Key
    First_Name VARCHAR(20) NOT NULL,
    Last_Name VARCHAR(20) NOT NULL,
    Birthday NUMBER(4) NOT NULL,
    Country VARCHAR(20),
    CONSTRAINT MAIN_ACTOR_pk PRIMARY KEY (Main_Actor_ID)
);

DROP TABLE DIRECTOR;
CREATE TABLE DIRECTOR
(   Director_ID NUMBER(4), -- Primary Key
    Director_First_Name VARCHAR(20),
    Director_Last_Name VARCHAR(20) NOT NULL,
    Director_BD NUMBER(4),
    Country VARCHAR(20) NOT NULL,
    CONSTRAINT DIRECTOR_pk PRIMARY KEY (Director_ID)
);

CREATE TABLE FILM 
(   Film_ID NUMBER(4), -- pk : Primary key
    Title VARCHAR(25) NOT NULL,
    Year NUMBER(4) NOT NULL,
    Language VARCHAR(20),
    Category VARCHAR(25) NOT NULL,
    Main_Actor_ID NUMBER(4) NOT NULL, -- fk 
    Company_ID NUMBER(4) NOT NULL, -- fk 
    Director_ID NUMBER(4) NOT NULL, -- fk : foreign key
    CONSTRAINT FILM_pk PRIMARY KEY (Film_ID),
    CONSTRAINT fk_DIRECTOR FOREIGN KEY (Director_ID) REFERENCES DIRECTOR(Director_ID),
    CONSTRAINT fk_MAIN_ACTOR FOREIGN KEY (Main_Actor_ID) REFERENCES MAIN_ACTOR(Main_Actor_ID),
    CONSTRAINT fk_COMPANY FOREIGN KEY (Company_ID) REFERENCES COMPANY(Company_ID)
);

/* Fill COMPANY */
INSERT INTO COMPANY (Company_ID, Company_Name, Company_Country) VALUES (1, 'Imagine Entertainment', 'USA');
INSERT INTO COMPANY (Company_ID, Company_Name, Company_Country) VALUES (2, 'Pixar', 'USA');
INSERT INTO COMPANY (Company_ID, Company_Name, Company_Country) VALUES (3, 'Twentieth Fox', 'USA');
INSERT INTO COMPANY (Company_ID, Company_Name, Company_Country) VALUES (4, 'Bob Yari Production', 'USA');
INSERT INTO COMPANY (Company_ID, Company_Name, Company_Country) VALUES (5, 'Carolco Picture', 'USA');
INSERT INTO COMPANY (Company_ID, Company_Name, Company_Country) VALUES (6, 'Lionsgate', 'USA');
INSERT INTO COMPANY (Company_ID, Company_Name, Company_Country) VALUES (7, 'Warner Bros', 'USA');
INSERT INTO COMPANY (Company_ID, Company_Name, Company_Country) VALUES (8, 'Paramount Picture', 'USA');
INSERT INTO COMPANY (Company_ID, Company_Name, Company_Country) VALUES (9, 'Bedford Falls Company', 'USA');

/* Fill MAIN_ACTOR */
INSERT INTO MAIN_ACTOR (Main_Actor_ID, First_Name, Last_Name, Birthday, Country) VALUES (1, 'Arnold', 'Schwarzeneger', 1947, 'Austria');
INSERT INTO MAIN_ACTOR (Main_Actor_ID, First_Name, Last_Name, Birthday, Country) VALUES (2, 'Billy', 'Crystal', 1948, 'USA');
INSERT INTO MAIN_ACTOR (Main_Actor_ID, First_Name, Last_Name, Birthday, Country) VALUES (3, 'Owen', 'Wilson', 1968, 'USA');
INSERT INTO MAIN_ACTOR (Main_Actor_ID, First_Name, Last_Name, Birthday, Country) VALUES (4, 'Don', 'Cheadle', 1964, NULL);
INSERT INTO MAIN_ACTOR (Main_Actor_ID, First_Name, Last_Name, Birthday, Country) VALUES (5, 'Brad', 'Garrett', 1960, 'USA');
INSERT INTO MAIN_ACTOR (Main_Actor_ID, First_Name, Last_Name, Birthday, Country) VALUES (6, 'Sam', 'Worthington', 1976, 'UK');
INSERT INTO MAIN_ACTOR (Main_Actor_ID, First_Name, Last_Name, Birthday, Country) VALUES (7, 'Bette', 'Davis', 1908, NULL);
INSERT INTO MAIN_ACTOR (Main_Actor_ID, First_Name, Last_Name, Birthday, Country) VALUES (8, 'George', 'Clooney', 1961, 'USA');
INSERT INTO MAIN_ACTOR (Main_Actor_ID, First_Name, Last_Name, Birthday, Country) VALUES (9, 'Micheal', 'Douglas', 1944, 'USA');

/* Fill DIRECTOR */
INSERT INTO DIRECTOR (Director_ID, Director_First_Name, Director_Last_Name, Director_BD, Country) VALUES (1, 'Ivan', 'Reitman', 1946, 'Slovakia');
INSERT INTO DIRECTOR (Director_ID, Director_First_Name, Director_Last_Name, Director_BD, Country) VALUES (2, 'Joseph', 'Mankiewiez', 1909, 'USA');
INSERT INTO DIRECTOR (Director_ID, Director_First_Name, Director_Last_Name, Director_BD, Country) VALUES (3, 'John', 'Lasseter', 1957, 'USA');
INSERT INTO DIRECTOR (Director_ID, Director_First_Name, Director_Last_Name, Director_BD, Country) VALUES (4, 'Pete', 'Doctor', NULL, 'USA');
INSERT INTO DIRECTOR (Director_ID, Director_First_Name, Director_Last_Name, Director_BD, Country) VALUES (5, 'James', 'Cameron', 1954, 'Canada');
INSERT INTO DIRECTOR (Director_ID, Director_First_Name, Director_Last_Name, Director_BD, Country) VALUES (6, 'Paul', 'Haggis', 1953, 'Canada');
INSERT INTO DIRECTOR (Director_ID, Director_First_Name, Director_Last_Name, Director_BD, Country) VALUES (7, 'Brad', 'Bird', NULL, 'USA');
INSERT INTO DIRECTOR (Director_ID, Director_First_Name, Director_Last_Name, Director_BD, Country) VALUES (8, 'Henry', 'Hobson', 1985, 'USA');
INSERT INTO DIRECTOR (Director_ID, Director_First_Name, Director_Last_Name, Director_BD, Country) VALUES (9, 'Steven', 'Soderbergh', 1963, 'USA');
INSERT INTO DIRECTOR (Director_ID, Director_First_Name, Director_Last_Name, Director_BD, Country) VALUES (10, 'Jason', 'Reitman', NULL, 'Canada');

/* Fill FILM */
INSERT INTO FILM (Film_ID, Title, Year, Language, Category, Main_Actor_ID, Company_ID, Director_ID) VALUES (1, 'Monster, Inc.', 2011, 'English', 'Animation', 2, 2, 5);
INSERT INTO FILM (Film_ID, Title, Year, Language, Category, Main_Actor_ID, Company_ID, Director_ID) VALUES (2, 'Kindergarten Cop', 1990, 'English', 'Comedy', 1, 1, 1);
INSERT INTO FILM (Film_ID, Title, Year, Language, Category, Main_Actor_ID, Company_ID, Director_ID) VALUES (3, 'Ratatouille', 2007, 'English', 'Animation', 5, 2, 7);
INSERT INTO FILM (Film_ID, Title, Year, Language, Category, Main_Actor_ID, Company_ID, Director_ID) VALUES (4, 'Cars', 2006, NULL, 'Family', 2, 2, 3);
INSERT INTO FILM (Film_ID, Title, Year, Language, Category, Main_Actor_ID, Company_ID, Director_ID) VALUES (5, 'All about Eve', 1950, 'English', 'Drama', 7, 3, 2);
INSERT INTO FILM (Film_ID, Title, Year, Language, Category, Main_Actor_ID, Company_ID, Director_ID) VALUES (6, 'Crash',2004, 'English', 'Crime', 4, 4, 6);
INSERT INTO FILM (Film_ID, Title, Year, Language, Category, Main_Actor_ID, Company_ID, Director_ID) VALUES (7, 'Terminator 2', 1991, 'English', 'Action', 1, 4, 5);
INSERT INTO FILM (Film_ID, Title, Year, Language, Category, Main_Actor_ID, Company_ID, Director_ID) VALUES (8, 'Ocean''s twelve', 2004, 'English', 'Crime', 8, 7, 9);
INSERT INTO FILM (Film_ID, Title, Year, Language, Category, Main_Actor_ID, Company_ID, Director_ID) VALUES (9, 'Avatar', 2009,'English', 'Action', 6, 3, 5);
INSERT INTO FILM (Film_ID, Title, Year, Language, Category, Main_Actor_ID, Company_ID, Director_ID) VALUES (10, 'Solaris', 2002,'English', 'Drama', 8, 3, 9);
INSERT INTO FILM (Film_ID, Title, Year, Language, Category, Main_Actor_ID, Company_ID, Director_ID) VALUES (11, 'Up in the air', 2009, NULL, 'Drama', 8, 8, 10);
INSERT INTO FILM (Film_ID, Title, Year, Language, Category, Main_Actor_ID, Company_ID, Director_ID) VALUES (12, 'Traffic', 2000, 'English', 'Crime', 9, 9, 9);
INSERT INTO FILM (Film_ID, Title, Year, Language, Category, Main_Actor_ID, Company_ID, Director_ID) VALUES (13, 'Maggie', 2015, 'English', 'Drama', 1, 6, 8);