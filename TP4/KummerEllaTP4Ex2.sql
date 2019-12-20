-- 2. Créer un script qui donne une liste des noms de département de la table de département en considérant
-- la condition (WHERE manager_id<=200) en utilisant d'un curseur ‘FOR-LOOP’.

SET SERVEROUTPUT ON;

DECLARE
    CURSOR cursor_dep IS 
        SELECT department_name 
        FROM departments 
        WHERE manager_id <= 200;

BEGIN
    DBMS_OUTPUT.PUT_LINE(' Départements ou le manager_id est <= 200');
    FOR v_dep IN cursor_dep LOOP
        DBMS_OUTPUT.PUT_LINE(v_dep.department_name);
    END LOOP;
END;