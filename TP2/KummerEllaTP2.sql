SET SERVEROUTPUT ON;

------------------------ SEQUENCES ------------------------------- : 
/* 1 : Créer des séquences pour chaque clé primaire */
DROP SEQUENCE company_pk_seq;
CREATE SEQUENCE company_pk_seq
    MINVALUE 1
    MAXVALUE 99
    START WITH 1
    INCREMENT BY 1
    CACHE 20;


DROP SEQUENCE main_actor_pk_seq;
CREATE SEQUENCE main_actor_pk_seq
    MINVALUE 1
    MAXVALUE 99
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

DROP SEQUENCE director_pk_seq;
CREATE SEQUENCE director_pk_seq
    MINVALUE 1
    MAXVALUE 99
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

DROP SEQUENCE film_pk_seq;
CREATE SEQUENCE film_pk_seq
    MINVALUE 1
    MAXVALUE 99
    START WITH 1
    INCREMENT BY 1
    CACHE 20;
    
    --------------------------------- PROJECTION : --------------------------
    /* 2:  Afficher ‘Language et ‘Category’ des films. */
    SELECT Language, Category FROM FILM;
    
    /* 3 :  Afficher ‘First_Name’ et ‘Last_Name’ des acteurs. */
    SELECT First_Name, Last_Name FROM MAIN_ACTOR;
    
    ---------------------------------- SELECTION : --------------------
    /* 4 : Afficher toutes les information des directeurs qui sont nés au Canada */
    SELECT * FROM DIRECTOR WHERE Country = 'Canada';
    
    /* 5 :  Afficher les films ‘DRAMA’ */
    SELECT * FROM FILM WHERE Category = 'Drama';
    
    /* 6 : Afficher le film anglais le plus récent */
   SELECT 
        *
    FROM
        FILM
    WHERE Language = 'English' 
    AND Year = (
                    SELECT 
                        MAX(Year)
                    FROM 
                        FILM
                    WHERE
                        Language = 'English'
               );
        
    
    ------------------------------ JOINTURE : --------------------------------
    /* 7 :  Afficher le nom de famille de tous les directeurs ainsi que les noms de ses films. */
    SELECT DIRECTOR.Director_Last_Name, FILM.Title
    FROM DIRECTOR
    RIGHT JOIN FILM -- INNER JOIN si on veut pas afficher ceux qui n'ont pas fait de film
    ON DIRECTOR.Director_ID = FILM.Director_ID;
    
    /* 9 :  Afficher les directeurs qui sont nés au Canada et ont dirigé les films ‘ACTION’. */
    SELECT  *
    FROM DIRECTOR 
    WHERE Country = 'Canada'
    AND Director_ID IN (
                        SELECT Director_ID
                        FROM FILM
                        WHERE Category = 'Action'
                        ) ; 
    
    /* 8 :  Afficher le nom de famille de tous les acteurs qui ont travaillé plus que une fois avec un directeur spécial. */
    
    --------------------------- PAS A PAS -------------------------------
    -- on prend/compte les films avec les paires directeur-acteur 
    /*
    SELECT Director_ID, Main_Actor_ID, COUNT(*) AS total 
    FROM FILM
    GROUP BY Main_Actor_ID, Director_ID;
    */
    
    -- sélectionnes les ID des acteurs et directeurs ayant travaillé plus d'une fois ensembles 
    /*
    SELECT Director_ID, Main_Actor_ID
    FROM (
        SELECT Director_ID, Main_Actor_ID, COUNT(*) AS total 
        FROM FILM
        GROUP BY Main_Actor_ID, Director_ID
        )
    WHERE total > 1;
    */
    ---------------------------------------------------------------------------
    SELECT Last_Name 
    FROM MAIN_ACTOR 
    WHERE Main_Actor_ID IN (
        SELECT Main_Actor_ID
        FROM (
            SELECT Director_ID, Main_Actor_ID, COUNT(*) AS total 
            FROM FILM
            GROUP BY Main_Actor_ID, Director_ID
            )
        WHERE total > 1
    );


    
    ------------------------------ DIVERS : --------------------------
    /* Créez une vue (view) des directeurs ayant dirigés le plus grand nombre de films, avec : */
    /* a. director_id */
    
    DROP VIEW view_ID_Directeur_Max_Film; 
    CREATE VIEW view_ID_Directeur_Max_Film AS 
    SELECT Director_ID 
    FROM (
            SELECT Director_ID, COUNT(*) AS total -- compter le nombre de film par directeur 
            FROM FILM
            GROUP BY Director_ID
        ) query1,
        (
            SELECT MAX(query2.total) AS maximum -- on récupère le nombre max de films faits par un directeur 
            FROM
             (
                SELECT Director_ID, COUNT(*) AS total
                FROM FILM
                GROUP BY Director_ID
            ) query2
        ) query3
    WHERE query1.total = query3.maximum;
    
                


    /* b. director_last_name */
    
    DROP VIEW view_Last_Name_Max_Film; 
    CREATE VIEW view_Last_Name_Max_Film AS
    SELECT Director_Last_Name
    FROM DIRECTOR 
    WHERE Director_ID IN (
        SELECT Director_ID
        FROM 
        (
            SELECT Director_ID, COUNT(*) AS total
            FROM FILM
            GROUP BY Director_ID
        ) query1,
        (
            SELECT MAX(query2.total) AS maximum
            FROM
             (
                SELECT Director_ID, COUNT(*) AS total
                FROM FILM
                GROUP BY Director_ID
            ) query2
        ) query3
    WHERE query1.total = query3.maximum
    ) ;
    

    /* c. main_actor.last_name: le nom de famille des acteurs de leurs films */
    
    -- on va récupérer les acteurs ayant des films de ces directeurs : 
    DROP VIEW view_Last_Name_Actor; 
    CREATE VIEW view_Last_Name_Actor AS
    SELECT Last_Name 
    FROM MAIN_ACTOR 
    WHERE Main_Actor_ID IN (
        SELECT Main_Actor_ID
        FROM (
            SELECT Director_ID, Main_Actor_ID 
            FROM FILM
            GROUP BY Main_Actor_ID, Director_ID
            )
        WHERE Director_ID IN (
                            SELECT Director_ID -- on a les directeurs avec le plus de film : 
                            FROM (
                                    SELECT Director_ID, COUNT(*) AS total
                                    FROM FILM
                                    GROUP BY Director_ID
                                ) query1,
                                (
                                    SELECT MAX(query2.total) AS maximum
                                    FROM
                                     (
                                        SELECT Director_ID, COUNT(*) AS total
                                        FROM FILM
                                        GROUP BY Director_ID
                                    ) query2
                                ) query3
                            WHERE query1.total = query3.maximum
                            )
        );
        

    

    
