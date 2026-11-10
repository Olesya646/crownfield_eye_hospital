Crownfield Eye Hospital Database Management System
1. Project Overview
The Crownfield Eye Hospital Database Management System is a relational database project developed using MySQL. It is designed to manage hospital information, including patient records, appointments, clinicians, diagnoses, prescriptions and follow-up appointments.
The project demonstrates relational database design, SQL implementation, data management, database security and testing.
2. Technologies Used
Database Management System: MySQL 8.0
Database Tool: MySQL Workbench
Database Engine: InnoDB
Query Language: SQL
Database Design: Entity Relationship Diagram (ERD)
3. Repository Structure
crownfield_eye_hospital/
│
├── 01_database_schema.sql
├── 02_data_insertion.sql
├── 02_individual_queries.sql
├── 04_security.sql
├── ERD.png
└── README.md
4. Project Files
File	Description
01_database_schema.sql	Creates the database tables, primary keys, foreign keys and relationships.
02_data_insertion.sql	Inserts sample records into the database tables.
02_individual_queries.sql	Contains SQL queries used to retrieve and analyse database information.
04_security.sql	Demonstrates database security features, user roles, permissions and encryption.
ERD.png	Illustrates the database entities and their relationships.
README.md	Provides an overview and documentation of the project.
5. Database Features
The database covers the following areas:
Patient information management.
Appointment scheduling and management.
Clinician and speciality records.
Diagnosis management.
Prescription and medicine records.
Follow-up appointment management.
Relational database constraints and relationships.
Database security and access control.
SQL queries, stored procedures and triggers.
6. Database Security
Security features are included to demonstrate how sensitive hospital information can be protected. These include database user roles, access permissions and AES-256 encryption for patient email data as part of the implementation demonstration.
7. How to Run the Project
Install MySQL Server and MySQL Workbench.
Download or clone this repository.
Open MySQL Workbench and connect to your MySQL server.
Execute 01_database_schema.sql to create the database structure.
Execute 02_data_insertion.sql to insert the sample data.
Execute 02_individual_queries.sql to test the SQL queries.
Execute 04_security.sql to examine the database security implementation.
Note: Run the SQL scripts in the recommended order. Some security operations may require appropriate MySQL administrative privileges.
8. Entity Relationship Diagram
The Entity Relationship Diagram (ERD) illustrates the database structure, including the main entities, primary keys, foreign keys and relationships.
The diagram is available in the repository as ERD.png.
9. Project Purpose
This project demonstrates the practical application of relational database development principles through the design, implementation and testing of a hospital database system.
It provides an example of how SQL, relational structures and security controls can support the management of hospital information.
Project: Crownfield Eye Hospital Database Management System
Database: MySQL
Repository: crownfield_eye_hospital
 
