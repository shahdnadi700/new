SELECT roleID FROM Instructor WHERE Ins_ID = 3
GO
CREATE PROCEDURE sp_AddBranch (@UserID INT , @BranchName NVARCHAR(20))
AS 
BEGIN 
	DECLARE @X INT 
	SELECT @X = roleID FROM Instructor WHERE Ins_ID = @UserID
	IF (@X = 2) 
		BEGIN
			INSERT INTO Branch VALUES(@BranchName)
		END
	ELSE 
		BEGIN 
			PRINT 'You are not allowed to Add Branches'
		END
END


GO

CREATE PROCEDURE sp_DeleteBranch (@UserID INT, @BranchID INT)
AS 
BEGIN 
	DECLARE @X INT 
	SELECT @X = roleID FROM Instructor WHERE Ins_ID = @UserID
	IF (@X = 2) 
		BEGIN
			DELETE FROM Branch WHERE Brn_ID = @BranchID 
		END
	ELSE 
		BEGIN 
			PRINT 'You are not allowed to Delete Branches'
		END
END

GO

CREATE PROCEDURE sp_AddIntake (@UserID INT, @IntakeName NVARCHAR(20))
AS 
BEGIN 
	DECLARE @X INT
	SELECT @X = roleID FROM Instructor WHERE Ins_ID = @UserID
	IF (@X = 2) 
		BEGIN 
			INSERT INTO Intake VALUES (@IntakeName)
		END
	ELSE 
		PRINT 'You are not allowed to Add Intakes'
END

GO 

CREATE PROCEDURE sp_DeleteIntake (@UserID INT, @IntakeID INT)
AS 
BEGIN 
	DECLARE @X INT 
	SELECT @X = roleID FROM Instructor WHERE Ins_ID = @UserID
	IF (@X = 2) 
		BEGIN
			DELETE FROM Branch WHERE Brn_ID = @IntakeID 
		END
	ELSE 
		BEGIN 
			PRINT 'You are not allowed to Delete Intakes'
		END
END

INSERT INTO rolePermissions(roleID , permissionID) 
SELECT 1 , permissionID FROM Permission

INSERT INTO rolePermissions(roleID , permissionID) 
SELECT 2 , permissionID FROM Permission


INSERT INTO rolePermissions(roleID, permissionID)
VALUES (3 , 10) , (3, 11) , (3,12),(3,13)

INSERT INTO rolePermissions(roleID , permissionID)
VALUES (4 , 14)

