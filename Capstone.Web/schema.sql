DROP TABLE RepairOrderPothole
DROP TABLE PotHole
DROP TABLE RepairOrder
DROP TABLE UserRoles
DROP TABLE Users




--CREATE DATABASE PotHoleDB

--GO

--USE PotHoleDB;

--GO

CREATE TABLE [dbo].[Users]
(
    [UserId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY, 
    [UserName] VARCHAR(MAX) NOT NULL, 
    [PasswordHash] VARCHAR(MAX) NULL, 
    [SecurityStamp] VARCHAR(MAX) NULL
);

CREATE TABLE [dbo].[UserRoles]
(
	[UserId] UNIQUEIDENTIFIER NOT NULL,
	[Role] VARCHAR(100) NOT NULL,

	CONSTRAINT pk_UserRoles PRIMARY KEY (UserId, Role),
	CONSTRAINT fk_UserRoles_Users FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

CREATE TABLE [dbo].[RepairOrder]
(
	[RepairId]	UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
	[Complete]	BIT				 NULL

);
 
 CREATE TABLE [dbo].[PotHole]
 (
   [PotHole_Id]		int identity(1, 1)	NOT NULL PRIMARY KEY,
   [UserId]			UNIQUEIDENTIFIER	NOT NULL,
   [PotHoleDesc]	VARCHAR(100)		NULL,
   [Lat]			FLOAT(50)			NULL,
   [Long]			FLOAT(50)			NULL,
   [Severity]		TINYINT				NULL,
   [Street1]		VARCHAR(50)			NULL,
   [Street2]		VARCHAR(50)			NULL,
   [LocationDesc]	VARCHAR(250)		NULL,
   [DateReported]	DATETIME			NULL,
   [InspectedDate]	DATETIME			NULL,
   [RepairDate]		DATETIME			NULL,
   [IsValidated]	BIT					NULL,

   CONSTRAINT fk_UserId FOREIGN KEY (UserId) REFERENCES Users(UserId),
 );

 CREATE TABLE [dbo].[RepairOrderPothole]
 (
	[RepairOrderPothole_Id] int identity(1, 1)	NOT NULL PRIMARY KEY,
	[RepairId]				UNIQUEIDENTIFIER	NOT NULL,
	[PotHole_Id]			int	NOT NULL,

	CONSTRAINT fk_RepairId FOREIGN KEY (RepairId) REFERENCES RepairOrder(RepairId),
	CONSTRAINT fk_PotHole_Id FOREIGN KEY (PotHole_Id) REFERENCES PotHole(PotHole_Id)

 );


Insert Users values('C2CD529E-B0D7-466E-8ADE-E8A973E79ECE', 'potato@potato.com', 'ALWXUIKG/DKKsPAe9Hr84/PsWclCPL5GREpj2uNUwDcqqrerxe9fB+GnoyZcv0UPLw==', 'c5b8bff4-2453-4ba9-91b7-6b385abe8909');

insert UserRoles values('C2CD529E-B0D7-466E-8ADE-E8A973E79ECE', 'citizen');

Insert PotHole values('C2CD529E-B0D7-466E-8ADE-E8A973E79ECE', 'Description', 50, 50, 11, 'Euclid', 'Elm', 'Its on the corner of what kathy said', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 0);
Insert PotHole values('C2CD529E-B0D7-466E-8ADE-E8A973E79ECE', 'This one is different', 50, 50, 11, 'Euclid', 'Elm', 'Its on the corner of what kathy said', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 0);
Insert PotHole values('C2CD529E-B0D7-466E-8ADE-E8A973E79ECE', 'Description', 50, 50, 11, 'Waffle', 'HoeseMask', 'Its on the corner of what kathy said', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 0);
Insert PotHole values('C2CD529E-B0D7-466E-8ADE-E8A973E79ECE', 'Description', 50, 50, 11, 'SaintClair', 'Elm', 'Its on the corner of what kathy said', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 0);
Insert PotHole values('C2CD529E-B0D7-466E-8ADE-E8A973E79ECE', 'Description', 50, 50, 11, 'Euclid', 'Elm', 'Its on the corner of what kathy said', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 0);
Insert PotHole values('C2CD529E-B0D7-466E-8ADE-E8A973E79ECE', 'Hello Jonathan', 50, 50, 11, 'Euclid', 'Elm', 'Its on the corner of what kathy said', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 0);
Insert PotHole values('C2CD529E-B0D7-466E-8ADE-E8A973E79ECE', 'Description', 50, 50, 11, 'Euclid', 'Elm', 'Its on the corner of what kathy said', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 0);
Insert PotHole values('C2CD529E-B0D7-466E-8ADE-E8A973E79ECE', 'Description', 50, 50, 11, 'Euclid', 'Elm', 'Its on the corner of what kathy said', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 0);
Insert PotHole values('C2CD529E-B0D7-466E-8ADE-E8A973E79ECE', 'Description', 50, 50, 11, 'Euclid', 'Elm', 'Its on the corner of what kathy said', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 0);
Insert PotHole values('C2CD529E-B0D7-466E-8ADE-E8A973E79ECE', 'Watch out for tacos', 50, 50, 11, 'Euclid', 'Elm', 'Its on the corner of what kathy said', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 0);

select * from RepairOrderPothole;