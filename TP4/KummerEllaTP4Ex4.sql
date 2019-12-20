-- 4. Ecrire un bloc PL / SQL avec deux « FOR-LOOP curseurs»: Le curseur parent appellera le
-- ‘director_id’, ‘director_first_name’ et ‘director_last_name’ à partir de la table des directeurs, en
-- considérant la condition (WHERE director_id >2 AND director_id <=5) et sortie une ligne avec cette
-- information: pour chaque directeur, le curseur enfant fera une boucle à travers tous les films que le
-- directeur dirige, en produisant ‘main_actor’ et la compagnie.

SET SERVEROUTPUT ON;

DECLARE
    v_film_dir_id film.director_id%TYPE; 

    CURSOR c_director IS 
        SELECT director_id, director_first_name, director_last_name
        FROM director
        WHERE director_id >2 AND director_id <=5;
    CURSOR c_film IS
        SELECT title, main_actor_id, company_id
        FROM film
        WHERE director_id = v_film_dir_id;
        
    v_company company.company_name%TYPE;
    v_last_name main_actor.last_name%TYPE;
    
    compteur number(2);

BEGIN

    FOR r_director IN c_director
    LOOP 
        compteur := 1;
        v_film_dir_id := r_director.director_id; -- on récupère l'id du directeur (de cette étape dans la boucle)
        DBMS_OUTPUT.PUT_LINE('The Director ' || r_director.director_id ||': ' || r_director.director_first_name || ' ' || r_director.director_last_name);
        DBMS_OUTPUT.PUT_LINE('  directed the following films:');
        FOR r_film IN c_film -- on prend tous les films du directeur  -> id de l'acteur et la company å
        LOOP
            SELECT last_name
            INTO v_last_name
            FROM main_actor
            WHERE main_actor_id = r_film.main_actor_id;
            SELECT company_name
            INTO v_company
            FROM company
            WHERE company_id = r_film.company_id;
            
            DBMS_OUTPUT.PUT_LINE(compteur || '. '|| r_film.title ||'        Main Actor:'|| v_last_name ||'--Company:' || v_company);
            
            compteur := compteur + 1;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('  ');
    END LOOP;
END;
/