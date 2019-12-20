/* 1. Ecrire un programme qui interchange les salaires des employées 4 et 6.  */

SET SERVEROUTPUT ON;

DECLARE
    /* emplyés dont on va échanger les salaires */ 
    var_id_1 employees.employee_id%TYPE := 10;
    var_id_2 employees.employee_id%TYPE := 11;
    /* variable intermédiaire : */
    var_sal employees.salary%TYPE;

BEGIN

/* sauvegarder le salaire du premier */
    SELECT salary
    INTO var_sal
    FROM employees
    WHERE employee_id = var_id_1;

/* mettre celui du deuxième dans le premier */
    UPDATE employees 
    SET salary = (
        SELECT salary
        FROM employees
        WHERE employee_id = var_id_2 )
    WHERE employee_id = var_id_1;
/* mettre celui du premier dans le deuxième */
    UPDATE employees 
    SET salary = var_sal
    WHERE employee_id = var_id_2;

END;/

SET SERVEROUTPUT ON;

/* 2. Ecrire un bloc PL/SQL qui change le pourcentage de commission d’un employé selon les étapes
suivante :*/

/* a) Afficher une invite pour demander le numéro de l’employé. */
-- test sur employés avec id = 2, 6, 21
DECLARE     
    n_employee_id employees.employee_id%TYPE := &employee_id1;
    n_sal employees.salary%TYPE;
    n_date employees.hire_date%TYPE;
BEGIN
    SELECT salary, hire_date
    into n_sal, n_date
    FROM employees
    WHERE employee_id = n_employee_id;
    /* Après si l’employé : */ 
    IF (n_sal > 10000) -- a un salaire supérieur à 10000 on lui accorde une commission de 0.4% 
    THEN 
        UPDATE employees 
        SET commission_pct = 0.8
        WHERE employee_id = n_employee_id;
    ELSIF (n_date < Date '2008-03-11') -- si le salaire est inférieur à 10000 mais il a une expérience de plus de 10 ans on lui accorde une commission de 0.35%
    THEN
        UPDATE employees
        SET commission_pct = 0.35
        WHERE employee_id = n_employee_id;
    ELSIF (n_sal > 3000) -- s’il a un salaire de moins de 3000 on lui accorde une commission de 0.25%
    THEN
        UPDATE employees
        SET commission_pct = 0.25
        WHERE employee_id = n_employee_id;
    ELSE  -- Dans tous les autres cas on lui donne une commission de 0.15%
        UPDATE employees
        SET commission_pct = 0.15
        WHERE employee_id = n_employee_id;
    END IF;
END;
/

/*  3. Ecrivez un bloc PL/SQL pour ajouter un nouvel employé:  */ 
--ALTER TABLE employees 
SET SERVEROUTPUT ON;
DECLARE
/* Affichez une invite à saisir le nom de famille d’un nouvel EMPLOYEES */
    n_last_name employees.last_name%TYPE := &last_name1;
/* b. Affichez une invite à saisir le prénom d’un nouvel EMPLOYEES. */
    n_first_name employees.first_name%TYPE := &first_name1;
    -- flag qui servira à dire si existe déjà
    flag number(2) := 0; 
    -- variables de stockage : 
    var_last_name employees.last_name%TYPE;
    var_first_name employees.first_name%TYPE;
    var_id employees.employee_id%TYPE;
    var_job employees.job_id%TYPE;
    var_salary employees.salary%TYPE;
    var_start_date job_history.start_date%TYPE;
    var_end_date job_history.end_date%TYPE;
    var_department_id job_history.department_id%TYPE;
    var_job_title jobs.job_title%TYPE;
    
BEGIN
/* c. Vérifiez que ce nom n’existe pas déjà dans la table EMPLOYEES. */ 
    FOR ind IN 1..11
    LOOP
        SELECT last_name, first_name
        INTO var_last_name, var_first_name
        FROM employees
        WHERE employees.employee_id = ind;
        IF (var_last_name = n_last_name AND var_first_name = n_first_name)
        THEN 
            flag := 1; var_id := ind;
        END IF;
    END LOOP;
/* d. Si oui, affichez une phrase comme suit : ‘Cet employé existe déjà’ et affichez toutes les informations de son job et son salaire actuel ; */
    IF flag = 1
    THEN
        SELECT job_id, salary
        INTO var_job, var_salary
        FROM employees
        WHERE employee_id = var_id;
        SELECT start_date, end_date, department_id
        INTO var_start_date, var_end_date, var_department_id
        FROM job_history
        WHERE job_id = var_job;
        SELECT job_title
        INTO var_job_title
        FROM jobs
        WHERE job_id = var_job;
        DBMS_OUTPUT.PUT_LINE('Cet employé existe déjà, son job_id est le  ' || var_job || ' et qui correspond à ' || var_job_title||'. Son salaire est de : ' || var_salary || ' francs, et il travaille au départmement : ' || var_department_id ||'. Il a commencé le : ' || var_start_date ||', et finira le : ' || var_end_date );
    ELSE 
/* sinon on ajoute cet employé */
        INSERT INTO employees(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (22, n_first_name, n_last_name, NULL, NUlL, NULL, 1, NULL, NULL, 1, NULL  );
    END IF;

END;
/



/*  4. Affichez l’année où il y a eu le plus grand nombre de recrues et le nombre de recrues par mois
durant cette année. */

SET SERVEROUTPUT ON;
DECLARE
var_year int;
var_TotalInMonth int;

BEGIN  
        
    SELECT EXTRACT(YEAR FROM hire_date)
    INTO var_year
    FROM employees 
    GROUP BY EXTRACT(YEAR FROM hire_date) -- groupe les employés par leur année 
    HAVING count(*) = (
                        SELECT MAX(count(*)) 
                        FROM employees 
                        GROUP BY EXTRACT(YEAR FROM hire_date));

    dbms_output.put_line('L''année avec le plus grand nombre de recrutement est : ' || var_year);
    
    FOR i_month IN 1..12 
    LOOP
        SELECT COUNT(*) 
        INTO var_TotalInMonth
        FROM employees
        WHERE EXTRACT(YEAR FROM hire_date) = var_year AND EXTRACT(MONTH FROM hire_date) = i_month;
        dbms_output.put_line('Mois:  ' || i_month || ', nombre de recrues : ' || var_TotalInMonth );
    END LOOP;
END;
/
