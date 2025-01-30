--Create Logins
CREATE LOGIN TrainingManager WITH PASSWORD = '123'
CREATE LOGIN Instructor WITH PASSWORD = '123'
CREATE LOGIN Student WITH PASSWORD = '123'

USE Examination

CREATE USER TrainingManager FOR LOGIN TrainingManager
CREATE USER Instructor FOR LOGIN Instructor
CREATE USER Student FOR LOGIN Student

--Put Permission
DENY SELECT, INSERT, UPDATE, DELETE ON SCHEMA::dbo To TrainingManager
DENY SELECT, INSERT, UPDATE, DELETE ON SCHEMA::dbo To Instructor
DENY SELECT, INSERT, UPDATE, DELETE ON SCHEMA::dbo To Student
GRANT EXECUTE ON SCHEMA::dbo to TrainingManager
GRANT SELECT ON SCHEMA::dbo To TrainingManager



GRANT SELECT ON OBJECT::dbo.sp_GetStudentFinalResultForAllCourses TO Instructor
--GRANT SELECT ON OBJECT::dbo.sp_GetStdntResultInSpecificCrs TO Instructor
--GRANT SELECT ON OBJECT::dbo.GetAllowanceOptionsForSpecificExam TO Instructor
--GRANT SELECT ON OBJECT::dbo.CalculateFinal TO Instructor
GRANT SELECT ON OBJECT::dbo.GetFinalResult TO Instructor
GRANT SELECT ON OBJECT::dbo.ExamDetails TO Instructor
GRANT SELECT ON OBJECT::dbo.courseInfo_v TO Instructor
GRANT EXEC ON OBJECT::dbo.sp_CreateExam TO Instructor
GRANT EXEC ON OBJECT::dbo.sp_addQToExam TO Instructor
GRANT EXEC ON OBJECT::dbo.sp_GetStudentFinalResultForAllCourses TO Student
