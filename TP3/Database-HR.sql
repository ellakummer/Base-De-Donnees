/*
DATABASE: HR 04/03/2019
Author: M. Parhizkar 
*/


---------------------Dropping Tables-- one by oner  -------------------
DROP TABLE regions CASCADE CONSTRAINTS;
DROP TABLE countries CASCADE CONSTRAINTS;
DROP TABLE jobs CASCADE CONSTRAINTS;
DROP TABLE locations CASCADE CONSTRAINTS;
DROP TABLE employees CASCADE CONSTRAINTS; --
DROP TABLE departments CASCADE CONSTRAINTS; --
DROP TABLE job_history CASCADE CONSTRAINTS; --
DROP TABLE managers CASCADE CONSTRAINTS; 

--------------------------Tables creation------------------------------

----------------------------Table: Manager----------------------------
CREATE TABLE managers (
    manager_id           NUMBER(4) NOT NULL,
    manager_first_name   VARCHAR2(20),
    manager_last_name    VARCHAR2(25) NOT NULL,
    --/
    CONSTRAINT pk_managers PRIMARY KEY ( manager_id )
);

-------------------------- Table: Regions----------------------------

CREATE TABLE regions (
    region_id     NUMBER(4) NOT NULL,
    region_name   VARCHAR2(35),
    --/
    CONSTRAINT pk_regions PRIMARY KEY ( region_id )
);
----------------------------Table: Jobs----------------------------
CREATE TABLE jobs (
    job_id       NUMBER(4) NOT NULL,
    job_title    VARCHAR2(35),
    min_salary   NUMBER(6),
    max_salary   NUMBER(6),
    --/
    CONSTRAINT pk_jobs PRIMARY KEY ( job_id )
);


----------------------------Table: Countries----------------------------
CREATE TABLE countries (
    country_id     NUMBER(4) NOT NULL,
    country_name   VARCHAR2(35) NOT NULL,
    region_id      NUMBER(4),
    --/
    CONSTRAINT pk_countries PRIMARY KEY ( country_id ),
    CONSTRAINT fk_regions FOREIGN KEY ( region_id ) REFERENCES regions ( region_id )
);

----------------------------Table: Locations----------------------------
CREATE TABLE locations(
    location_id      NUMBER(4) NOT NULL,
    street_address   VARCHAR2(35),
    postal_code      VARCHAR2(35),
    city             VARCHAR2(30),
    state_province   VARCHAR2(35),
    country_id       NUMBER(4) NOT NULL,
    --/
    CONSTRAINT pk_locations PRIMARY KEY (location_id),
    CONSTRAINT fk_location_countries FOREIGN KEY (country_id) REFERENCES countries(country_id) );

----------------------------Table: departments----------------------------
CREATE TABLE departments(
    department_id     NUMBER(4) NOT NULL,
    department_name   VARCHAR2(30) NOT NULL,
    manager_id        NUMBER(4),
    location_id       NUMBER(4) NOT NULL,
    --/
    CONSTRAINT pk_departments PRIMARY KEY (department_id),
    CONSTRAINT fk_dept_managers FOREIGN KEY (manager_id) REFERENCES managers(manager_id) );
    
----------------------------Table: Employees----------------------------
CREATE TABLE employees(
    employee_id      NUMBER(5) NOT NULL,
    first_name       VARCHAR2(20),
    last_name        VARCHAR2(25) NOT NULL,
    email            VARCHAR2(20),
    phone_number     VARCHAR2(20),
    hire_date        DATE,
    job_id           NUMBER(4) NOT NULL,
    salary           NUMBER(8,2),
    commission_pct   NUMBER(2,2),
    manager_id       NUMBER(4) NOT NULL,
    department_id    NUMBER(4),
    --/
    CONSTRAINT pk_employees PRIMARY KEY (employee_id),
    CONSTRAINT fk_employees_jobs FOREIGN KEY (job_id) REFERENCES jobs(job_id) ,
    CONSTRAINT fk_emp_employees FOREIGN KEY (employee_id) REFERENCES employees(employee_id), 
    CONSTRAINT fk_employees_departments FOREIGN KEY (department_id) REFERENCES departments(department_id) );

----------------------------Table: Job History----------------------------
CREATE TABLE job_history(
    employee_id     NUMBER(6) NOT NULL,
    start_date      DATE NOT NULL,
    end_date        DATE NOT NULL,
    job_id          NUMBER(4) NOT NULL,
    department_id   NUMBER(4) NOT NULL,
    --/
    CONSTRAINT pk_job_history PRIMARY KEY (employee_id,job_id ,start_date),
    CONSTRAINT fk_job_hist_employees FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    CONSTRAINT fk_job_hist_jobs FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    CONSTRAINT fk_job_hist_departments FOREIGN KEY (department_id) REFERENCES departments(department_id),
    CONSTRAINT check_job_history CHECK (start_date < end_date));

----------------------------------Sequences creation-------------------------
--DROP SEQUENCE sequence_job_history;
--DROP SEQUENCE sequence_regions;
--DROP SEQUENCE sequence_country;
--DROP SEQUENCE sequence_job;
--DROP SEQUENCE sequence_location;
--DROP SEQUENCE sequence_employee;
--DROP SEQUENCE sequence_department;
--DROP SEQUENCE sequence_manager;    
--DROP SEQUENCE sequence_region;
 -------------------    -------------------   -------------------  
    
CREATE SEQUENCE sequence_job START WITH 0001 INCREMENT BY 0001 MAXVALUE 0010 NOCACHE NOCYCLE;
CREATE SEQUENCE sequence_location START WITH 0001 INCREMENT BY 0001 MAXVALUE 0010 NOCACHE NOCYCLE;
CREATE SEQUENCE sequence_employee START WITH 00001 INCREMENT BY 0001 MAXVALUE 00026 NOCACHE NOCYCLE;
CREATE SEQUENCE sequence_department START WITH 0001 INCREMENT BY 0001 MAXVALUE 0008 NOCACHE NOCYCLE;
CREATE SEQUENCE sequence_job_history START WITH 0001 INCREMENT BY 0001 MAXVALUE 0009 NOCACHE NOCYCLE;
CREATE SEQUENCE sequence_manager START WITH 0001 INCREMENT BY 0001 MAXVALUE 0008 NOCACHE NOCYCLE;
CREATE SEQUENCE sequence_region START WITH 0001 INCREMENT BY 0001 MAXVALUE 0011 NOCACHE NOCYCLE;
CREATE SEQUENCE sequence_country START WITH 0001 INCREMENT BY 0001 MAXVALUE 0015 NOCACHE NOCYCLE;


-------------------SOME data for our TABLES ----------------------
--region_id, region_name
INSERT INTO regions VALUES (sequence_region.NEXTVAL,'European Union'); --0001
INSERT INTO regions VALUES (sequence_region.NEXTVAL,'Central America');--0002
INSERT INTO regions VALUES (sequence_region.NEXTVAL,'North America');--0003
INSERT INTO regions VALUES (sequence_region.NEXTVAL,'Afrique');--0004
INSERT INTO regions VALUES (sequence_region.NEXTVAL,'South America');--0005
INSERT INTO regions VALUES (sequence_region.NEXTVAL,'Caribbean');--0006
INSERT INTO regions VALUES (sequence_region.NEXTVAL,'Central America');--0007
INSERT INTO regions VALUES (sequence_region.NEXTVAL,'Oceania');--0008
INSERT INTO regions VALUES (sequence_region.NEXTVAL,'Middle East');--0009
INSERT INTO regions VALUES (sequence_region.NEXTVAL,'Eastern Europe');--0010
INSERT INTO regions VALUES (sequence_region.NEXTVAL,'Asia');--0011

-------------------    -------------------   -------------------  
--manager_id, manager_first_name, manager_last_name
INSERT INTO managers VALUES (sequence_manager.NEXTVAL, 'Marco',' Deniera' ); --0001
INSERT INTO managers VALUES (sequence_manager.NEXTVAL, 'Alexi',' Taraman' ); --0002
INSERT INTO managers VALUES (sequence_manager.NEXTVAL, 'Philiphe','Chaupard' ); --0003
INSERT INTO managers VALUES (sequence_manager.NEXTVAL, 'Nathalie','Anderson' ); --0004
INSERT INTO managers VALUES (sequence_manager.NEXTVAL, 'Mario','Benghazi' ); --0005
INSERT INTO managers VALUES (sequence_manager.NEXTVAL, 'Anu',' Shringer' ); --0006
INSERT INTO managers VALUES (sequence_manager.NEXTVAL, 'Isabelle',' Kugnac' ); --0007
INSERT INTO managers VALUES (sequence_manager.NEXTVAL, 'Micheal',' De Kleine' ); --0008


-------------------    -------------------   -------------------  
--country_id, country_name, region_id
INSERT INTO countries VALUES (sequence_country.NEXTVAL,'Norway',0001);--0001
INSERT INTO countries VALUES (sequence_country.NEXTVAL,'France',0001);--0002
INSERT INTO countries VALUES (sequence_country.NEXTVAL,'Spain',0001);--0003
INSERT INTO countries VALUES (sequence_country.NEXTVAL,'Belgique',0001);--0004
INSERT INTO countries VALUES (sequence_country.NEXTVAL,'Japon',0011);--0005
INSERT INTO countries VALUES (sequence_country.NEXTVAL,'Namibia',0004);--0006
INSERT INTO countries VALUES (sequence_country.NEXTVAL,'Suisse',0001);--0007
INSERT INTO countries VALUES (sequence_country.NEXTVAL,'China',0011);--0008
INSERT INTO countries VALUES (sequence_country.NEXTVAL,'Senegal',0004);--0009
INSERT INTO countries VALUES (sequence_country.NEXTVAL,'Ghana',0004);--0010
INSERT INTO countries VALUES (sequence_country.NEXTVAL,'Swedeen',0001);--0011
INSERT INTO countries VALUES (sequence_country.NEXTVAL,'Sri Lanka',0011);--0012
INSERT INTO countries VALUES (sequence_country.NEXTVAL,'India',0011);--0013
INSERT INTO countries VALUES (sequence_country.NEXTVAL,'Algeria',0004);--0014
INSERT INTO countries VALUES (sequence_country.NEXTVAL,'Tunesia',0004);--0015

 -------------------    -------------------   -------------------  

INSERT INTO jobs VALUES (sequence_job.NEXTVAL,'Manager',006000,008000); --001
INSERT INTO jobs VALUES (sequence_job.NEXTVAL,'Sales agent',004000,005000); --002
INSERT INTO jobs VALUES (sequence_job.NEXTVAL,'Director',010000,012000); --003
INSERT INTO jobs VALUES (sequence_job.NEXTVAL,'Office manager',006000,007000); --004
INSERT INTO jobs VALUES (sequence_job.NEXTVAL,'Sales manager',004200,004900); --005
INSERT INTO jobs VALUES (sequence_job.NEXTVAL,'IT Head',004000,008000); --006
INSERT INTO jobs VALUES (sequence_job.NEXTVAL,'Help desk',0012000,027000); --007
INSERT INTO jobs VALUES (sequence_job.NEXTVAL,'RD head',008200,014900); --008
INSERT INTO jobs VALUES (sequence_job.NEXTVAL,'Reasercher',008000,080000); --009

 -------------------    -------------------   -------------------  
--location_id, street_adress, postal_code, city, state_province, country_id
INSERT INTO locations VALUES (sequence_location.NEXTVAL,'01  Rue Lt Maurice Lacoque','71250','Cluny','France',0002);--0001
INSERT INTO locations VALUES (sequence_location.NEXTVAL,'78 Carrer de Floridablanca','08015','Barcelona','Catalonia',0003);--0002
INSERT INTO locations VALUES (sequence_location.NEXTVAL,'3B Rue du Sierre','2803','Sion','Valais',0007);--0003
INSERT INTO locations VALUES (sequence_location.NEXTVAL,'365, Nilaveli Road  Alles Garden','33000','Trincomalee','Eastern Province',0012);--0004
INSERT INTO locations VALUES (sequence_location.NEXTVAL,'111 Rue de Neuve','1000','Bruxelles','Bruxelles',0002);--0005
INSERT INTO locations VALUES (sequence_location.NEXTVAL,'70 Chincha street','J962','Shinjuku','Tokyo',0011);--0006
INSERT INTO locations VALUES (sequence_location.NEXTVAL,'18 Rue de Jaman','1800','Vevey','Vaud',0007);--0007
INSERT INTO locations VALUES (sequence_location.NEXTVAL,'207 National Rd, Daoxian',NULL,'Yongzhou Shi','Hunan Sheng',0008);--0008
INSERT INTO locations VALUES (sequence_location.NEXTVAL,'420 Old Paarl road','64400','Paarl','Ghana',0010);--0009
INSERT INTO locations VALUES (sequence_location.NEXTVAL,'112 Avenue de Marc Poulin','','Dakar','Senegal',0004);--0010
 -------------------    -------------------   -------------------  
--department_id, departement-name, manager_id, location_id
INSERT INTO departments VALUES (sequence_department.NEXTVAL,'Sales',0003,0002); --0001
INSERT INTO departments VALUES (sequence_department.NEXTVAL,'Management',0006,0008);--0002
INSERT INTO departments VALUES (sequence_department.NEXTVAL,'IT',0007,0006);--0003
INSERT INTO departments VALUES (sequence_department.NEXTVAL,'Finance',0005,0010);--0004
INSERT INTO departments VALUES (sequence_department.NEXTVAL,'Production',0002,0002);--0005
INSERT INTO departments VALUES (sequence_department.NEXTVAL,'Marketing',0001,0008);--0006
INSERT INTO departments VALUES (sequence_department.NEXTVAL,'HR',008,0006);--0007
INSERT INTO departments VALUES (sequence_department.NEXTVAL,'Purchasing',0004,0010);--0008 
 -------------------    -------------------   -------------------  
--id, first name, last name, email, phone, hire_date, job_id, salary, commission, manager_id, departement_id
INSERT INTO employees VALUES (sequence_employee.NEXTVAL,'John','Lee','jl@yahoo.com','143159200',Date '1999-08-08',0001,008000.00,0.8,0007,0003);--0001
INSERT INTO employees VALUES (sequence_employee.NEXTVAL,'Marc','Kingston','mlk@green.com','236282958',Date '1998-02-01',0003,015000.00,.06,0002,0002);--0002
INSERT INTO employees VALUES (sequence_employee.NEXTVAL,'Anna','Tallman','at@upc.com','308874562',Date '2015-12-11',0006,008550.00,0.5,0002,0005);--0003
INSERT INTO employees VALUES (sequence_employee.NEXTVAL,'Kian','Hanson','kh2@rito.com','8651107',Date '2010-01-12',0005,008900.00,.10,0003,0006);--0004
INSERT INTO employees VALUES (sequence_employee.NEXTVAL,'Edward','Smit','es22@yahoo.com','20384546',Date '2011-05-23',0002,006800.00,0.5,0003,0001);--0005
INSERT INTO employees VALUES (sequence_employee.NEXTVAL,'Francois','Radolman','frs@msn.com','4223450',Date '1995-10-11',0004,007500.00,NULL,0002,0002);--0006
INSERT INTO employees VALUES (sequence_employee.NEXTVAL,'Han','Chomy','hc21@gmail.com','2000162342',Date '1980-07-25',0007,008000.00,0.1,0001,0008);--0007
INSERT INTO employees VALUES (sequence_employee.NEXTVAL,'Mark','Stromae','mss45@line.com','69076543',Date '1989-01-10',0006,007800.00,0.05,0003,0007);--0008
INSERT INTO employees VALUES (sequence_employee.NEXTVAL,'Chen','Tun','ct5@top.com','205178232',Date '2011-02-14',0007,005500.00,.10,0003,0001);--0009
INSERT INTO employees VALUES (sequence_employee.NEXTVAL,'Elis','Woody','ew@yahoo.com','205721673',Date '2013-09-19',0009,009800.00,0.3,0002,0003);--0010
INSERT INTO employees VALUES (sequence_employee.NEXTVAL,'Mehdi','Ben Solman','mb@fb.com','255721673',Date '2013-11-19',0003,006900.00,0.8,0004,0002);--0011
INSERT INTO employees VALUES (sequence_employee.NEXTVAL,'Arianna','De Anglis','ad@insta.com','121721673',Date '2013-03-11',0001,007800.00,NULL,0005,0001);--0012
INSERT INTO employees VALUES (sequence_employee.NEXTVAL,'Francesco','Heriti','ffh@uni.com','580221673',Date '2013-08-10',0002,008200.00,0.2,0004,0003);--0013
INSERT INTO employees VALUES (sequence_employee.NEXTVAL,'William','Eggleston','wef@un.com','810021673',Date '2013-09-08',0006,007700.00,NULL,0001,0008);--0014
INSERT INTO employees VALUES (sequence_employee.NEXTVAL,'Pasquale','De Fabiani','padee@goody.com','603721626',Date '2013-01-10',0005,008500.00,0.1,0004,0007);--0015
INSERT INTO employees VALUES (sequence_employee.NEXTVAL,'Elio','Artale','era@msn.com','500703673',Date '2013-08-29',0004,005800.00,NULL,0002,0003);--0016
INSERT INTO employees VALUES (sequence_employee.NEXTVAL,'Vincenzo','Di Rella','vd@upc.com','185221600',Date '2013-05-28',0003,009600.00,0.6,0007,0001);--0017
INSERT INTO employees VALUES (sequence_employee.NEXTVAL,'Robert','Prager','rp9@data.com','118721873',Date '2013-04-27',0005,009800.00,0.1,0003,0004);--0018
INSERT INTO employees VALUES (sequence_employee.NEXTVAL,'Alex','Codeau','jaco@service.com','811721169',Date '2013-03-21',0008,011000.00,0.5,0006,0001);--0019
INSERT INTO employees VALUES (sequence_employee.NEXTVAL,'Riccardo ','Olaf','ro9@tab.com','591721698',Date '2013-02-26',0002,011100.00,0.5,0008,0005);--0020
INSERT INTO employees VALUES (sequence_employee.NEXTVAL,'Rene','Savelli','rse@re.com','233721658',Date '2013-01-28',0001,007300.00,0.4,0003,0002);--0021



 -------------------    -------------------   -------------------  
--employee_id, start_date, end_date, job_id, departement_id
INSERT INTO job_history VALUES (0005,Date '2004-05-12',Date '2018-08-20',0003,0002);
INSERT INTO job_history VALUES (0012,Date '2012-12-01',Date '2013-12-21',0005,0001);
INSERT INTO job_history VALUES (0002,Date '1998-01-06',Date '1999-12-01',0002,0006);
INSERT INTO job_history VALUES (0013,Date '2015-12-01',Date '2017-02-04',0004,0005);
INSERT INTO job_history VALUES (0003,Date '1998-01-01',Date '2018-09-20',0001,0007);
INSERT INTO job_history VALUES (0010,Date '1992-01-01',Date '2018-09-20',0009,0007);
INSERT INTO job_history VALUES (0007,Date '2007-05-01',Date '2019-07-17',0005,0004);
INSERT INTO job_history VALUES (0020,Date '2017-01-01',Date '2019-07-17',0003,0003);