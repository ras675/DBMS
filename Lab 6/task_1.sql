CREATE USER dbms_210041255 IDENTIFIED BY cse4308 ;
GRANT ALL PRIVILEGES TO dbms_210041255;
CONNECT dbms_210041255 / cse4308 ;
CREATE VIEW Advisor_Selection AS
SELECT
    Instructor.ID,
    Instructor.Name,
    Department.Name AS DepartmentName
FROM
    Instructor
JOIN
    Department ON Instructor.Dept_ID = Department.ID;
CREATE VIEW Student_Count AS
SELECT
    Advisor_Selection.Name AS InstructorName,
    COUNT(Student.ID) AS StudentCount
FROM
    Advisor_Selection
LEFT JOIN
    Student ON Advisor_Selection.ID = Student.Advisor;
CREATE ROLE Students;
GRANT SELECT ON Advisor_Selection TO Students;
GRANT SELECT ON Course TO Students;
CREATE ROLE Course_Teachers;
GRANT SELECT ON Student_Count TO Course_Teachers;
GRANT SELECT ON Course TO Course_Teachers;
CREATE ROLE Heads_of_Departments;
GRANT SELECT ON Student_Count TO Heads_of_Departments;
GRANT SELECT ON Course TO Heads_of_Departments;
GRANT INSERT, UPDATE, DELETE ON Instructor TO Heads_of_Departments;
CREATE ROLE Administrator;
GRANT SELECT ON Department TO Administrator;
GRANT SELECT ON Instructor TO Administrator;
GRANT UPDATE ON Department TO Administrator;
CREATE USER student_user IDENTIFIED BY 'student_password';
GRANT Students TO student_user;

CREATE USER teacher_user IDENTIFIED BY 'teacher_password';
GRANT Course_Teachers TO teacher_user;

CREATE USER hod_user IDENTIFIED BY 'hod_password';
GRANT Heads_of_Departments TO hod_user;

CREATE USER admin_user IDENTIFIED BY 'admin_password';
GRANT Administrator TO admin_user;