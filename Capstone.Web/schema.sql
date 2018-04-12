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


Insert Users values('C2CD529E-B0D7-466E-8ADE-E8A973E79ECE', 'ghats@gmail.com', 'ALWXUIKG/DKKsPAe9Hr84/PsWclCPL5GREpj2uNUwDcqqrerxe9fB+GnoyZcv0UPLw==', 'c5b8bff4-2453-4ba9-91b7-6b385abe8909');
Insert Users values('DCBCB23C-93E2-488C-A293-0D1389946C4D', 'AuntDebbie121@aol.com', 'ALWXUIKG/DKKsPAe9Hr84/PsWclCPL5GREpj2uNUwDcqqrerxe9fB+GnoyZcv0UPLw==', 'c5b8bff4-2453-4ba9-91b7-6b385abe8909');
Insert Users values('C34E0B32-DDBB-4629-A233-ABEECF196FB7', 'MrFixer@hotmail.com', 'ALWXUIKG/DKKsPAe9Hr84/PsWclCPL5GREpj2uNUwDcqqrerxe9fB+GnoyZcv0UPLw==', 'c5b8bff4-2453-4ba9-91b7-6b385abe8909');

insert UserRoles values('C2CD529E-B0D7-466E-8ADE-E8A973E79ECE', 'citizen');
insert UserRoles values('DCBCB23C-93E2-488C-A293-0D1389946C4D', 'citizen');
insert UserRoles values('C34E0B32-DDBB-4629-A233-ABEECF196FB7', 'citizen');

Insert PotHole values('C34E0B32-DDBB-4629-A233-ABEECF196FB7', 'Just a small hole in the road', 41.519369, 81.658027, 1, 'Euclid', 'Elm', 'Its on the corner of euclid and elm', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 1);
Insert PotHole values('C34E0B32-DDBB-4629-A233-ABEECF196FB7', 'Barely there but worth mentioning', 41.515351, -81.666653, 1, 'Euclid', 'Som Center', 'By the church', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 1);
Insert PotHole values('C34E0B32-DDBB-4629-A233-ABEECF196FB7', 'The worst pothole I have ever seen fix ASAP', 41.516560,  -81.670086, 10, 'Fairfield Avenue', '', 'As you exit the gas station', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 1);
Insert PotHole values('C34E0B32-DDBB-4629-A233-ABEECF196FB7', 'This is really bad, Cleveland!', 41.516290, -81.670046, 9, 'Saint Clair', '', 'Its almost half the road what do you mean where is it', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 1);
Insert PotHole values('C2CD529E-B0D7-466E-8ADE-E8A973E79ECE', 'A terriblie Pothole', 41.516252, -81.670026, 9, 'St Peter', '', 'Next to the taco stand', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 1);
Insert PotHole values('C2CD529E-B0D7-466E-8ADE-E8A973E79ECE', 'A pothole in need of repair', 41.516240, -81.670066, 8, 'Road Ln', '140th', 'by the street', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 1);
Insert PotHole values('C2CD529E-B0D7-466E-8ADE-E8A973E79ECE', 'Annoying', 41.516265, -81.670056, 4, 'E 152nd Street', 'High Road', 'Someone planted a tree in it Im late for work!', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 1);
Insert PotHole values('C2CD529E-B0D7-466E-8ADE-E8A973E79ECE', 'Not Bad', 41.515230, -81.670046, 2, 'Street St', 'Fleet St', '', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 1);
Insert PotHole values('C2CD529E-B0D7-466E-8ADE-E8A973E79ECE', 'The pothole Cleveland Deserved', 41.514250, -81.670456, 6,'Frank Ave', '', 'By the lake But not in the lake', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 1);
Insert PotHole values('C2CD529E-B0D7-466E-8ADE-E8A973E79ECE', 'Not sure if pothole or porthole', 41.516250, -81.670036, 2, 'E 24th St.', '', '', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 1);
Insert PotHole values('DCBCB23C-93E2-488C-A293-0D1389946C4D', 'Watch out!', 41.513250, -81.670046, 7, 'Carnegie', 'Elm', 'by the sewer grate', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 1);
Insert PotHole values('DCBCB23C-93E2-488C-A293-0D1389946C4D', 'I am hit but not bad', 41.516240, -81.670066, 3, '644th st', '', 'next to the cat', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 1);
Insert PotHole values('DCBCB23C-93E2-488C-A293-0D1389946C4D', 'Had to repair my car after an encounter with this pothole', 41.517250, -81.670084, 6, 'Mango Ln', '', 'on the street', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 1);
Insert PotHole values('DCBCB23C-93E2-488C-A293-0D1389946C4D', 'Wow', 41.515250, -81.670066, 3, '123rd', 'Elm', 'In front of the house, by the stop sign', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 0);
Insert PotHole values('DCBCB23C-93E2-488C-A293-0D1389946C4D', 'It is a hole', 41.513260, -81.670076, 8, 'St clair', '453', 'By the dogshelter, near the fire hydrant', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 1);
Insert PotHole values('DCBCB23C-93E2-488C-A293-0D1389946C4D', '', 41.513235, -81.670746, 10, 'Birch', '12 st', 'Corner of birch and elm', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 0);
Insert PotHole values('DCBCB23C-93E2-488C-A293-0D1389946C4D', '', 41.513240, -81.670776, 4, 'Twelve', '13 st', 'Next to the weird curb art', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 0);
Insert PotHole values('DCBCB23C-93E2-488C-A293-0D1389946C4D', '', 41.513334, -81.670386, 3, 'Bird', 'Welcome St', 'by the manhole cover', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 0);
Insert PotHole values('DCBCB23C-93E2-488C-A293-0D1389946C4D', '', 41.513235, -81.670734, 3, 'Squirrel Dr', 'Cigar Ln', 'right out the front of the house with the tire swing', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 0);
Insert PotHole values('DCBCB23C-93E2-488C-A293-0D1389946C4D', '', 41.513204, -81.670766, 5, 'Tooth', 'Lemon Ln', 'Next to the broken down car', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 0);
Insert PotHole values('DCBCB23C-93E2-488C-A293-0D1389946C4D', '', 41.513240, -81.670744, 1, 'Moon', 'Temple', 'Corner of birch and elm', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 0);
Insert PotHole values('DCBCB23C-93E2-488C-A293-0D1389946C4D', '', 41.513232, -81.670783, 9, 'Long Street', '', 'By the TacoYell', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 0);

select * from RepairOrderPothole;



select * from users;

select * from PotHole order by PotHole_Id desc;

delete from PotHole where PotHole_Id = 23;

INSERT INTO PotHole (UserId, PotHoleDesc, Lat, Long, Severity, Street1, Street2, LocationDesc, DateReported, InspectedDate, RepairDate, IsValidated) VALUES ('DCBCB23C-93E2-488C-A293-0D1389946C4D', null, null, null, null, null, null, null, null, null, null, null)