 DBCC CHECKIDENT (USERS, RESEED, 6);
  DBCC CHECKIDENT (USER_ROLES, RESEED, 7);

  ALTER TABLE USERS
ALTER COLUMN OTP nvarchar(200);

CREATE TABLE USER_ROLES(
ID INT PRIMARY KEY IDENTITY NOT NULL ,
USER_ID INT REFERENCES USERS(ID) NOT NULL,
ROLE_ID INT REFERENCES ROLES(ID) NOT NULL
)
GO
GRANT INSERT, SELECT, UPDATE ON dbo.USER_ROLES TO [SHR_Main]