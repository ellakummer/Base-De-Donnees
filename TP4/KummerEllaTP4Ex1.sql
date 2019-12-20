-- 1. Ecrire un bloc PL / SQL avec une procédure "getEmployeeDetails" qui accepte un numéro
-- d'employé/ée et retourne son nom et son salaire.

SET SERVEROUTPUT ON;
DECLARE
    var_las employees.last_name%TYPE;
    var_sal employees.salary%TYPE;
    
    var_first_name employees.first_name%TYPE;
    var_email employees.email%TYPE;
    var_phone_number employees.phone_number%TYPE;
    var_hire_date employees.hire_date%TYPE;

PROCEDURE getEmployeeDetails(var_employee_id IN employees.employee_id%TYPE, var_last_name OUT employees.last_name%TYPE, var_salary OUT employees.salary%TYPE) IS
BEGIN
    SELECT last_name, salary
    INTO var_last_name, var_salary
    FROM employees
    WHERE employee_id = var_employee_id;
    
    var_salary := var_salary + (var_salary * 0.1);
    
END;

BEGIN
    getEmployeeDetails(12,var_las, var_sal);
    -- on récupère le reste des infos de l'employé : 
    SELECT first_name, email, phone_number, hire_date
    INTO var_first_name, var_email, var_phone_number, var_hire_date
    FROM employees
    WHERE employees.last_name = var_las;
    dbms_output.put_line('Employees last name : ' || var_las); 
    dbms_output.put_line('Employees first name : ' || var_first_name); 
    dbms_output.put_line('Employees email : ' || var_email); 
    dbms_output.put_line('Employees phone number : ' || var_phone_number); 
    dbms_output.put_line('Employees lhire date : ' || var_hire_date); 
    dbms_output.put_line('Employees salary (augmented by 10%) : ' || var_sal); 


END;
