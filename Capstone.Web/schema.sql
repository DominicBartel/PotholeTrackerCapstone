DROP TABLE WorkOrderPotholeUser
DROP TABLE PotHole
DROP TABLE WorkOrder
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

CREATE TABLE [dbo].[WorkOrder]
(
	[WorkOrderId]			int identity(1, 1)  NOT NULL PRIMARY KEY,
	[ToInspectDate]			DATETIME			NULL,
	[ToRepairDate]			DATETIME			NULL,
	[InspectionComplete]	BIT					NULL,
	[RepairComplete]		BIT				    NULL,
	[TypeOfJob]				VARCHAR(50)			NULL,
	[Notes]					VARCHAR(4000)		NULL,
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

 CREATE TABLE [dbo].[WorkOrderPotholeUser]
 (
	[RepairOrderPothole_Id] int identity(1, 1)	NOT NULL PRIMARY KEY,
	[WorkOrderId]			int	NOT NULL,
	[PotHole_Id]			int	NOT NULL,
	[UserId]				UNIQUEIDENTIFIER	NOT NULL,

	CONSTRAINT fk_RepairId FOREIGN KEY (WorkOrderId) REFERENCES WorkOrder(WorkOrderId),
	CONSTRAINT fk_PotHole_Id FOREIGN KEY (PotHole_Id) REFERENCES PotHole(PotHole_Id),
	CONSTRAINT fk_UserIdAssoc FOREIGN KEY (UserId) REFERENCES Users(UserId)

 );


--Username "citizen@pt.com" Password "Password1!" Role "citizen"
Insert Users values('E0F27DB1-A4CD-466A-9F28-075A6CE832C8', 'citizen@pt.com', 'AHmflyvZUD71Gdf/nWlp5kUkG44QQk3elY166kCEjgbY2AYYDYlt1ucdjfYrNQRcww==', '313e12d6-f379-4a8d-92c5-efa43359d4d6');
Insert UserRoles values('E0F27DB1-A4CD-466A-9F28-075A6CE832C8', 'citizen');

--Username "admin@pt.com" Password "Password1!" Role "admin"
Insert Users values('C5AF99B0-3425-41FD-8DB3-32ED13EC4494', 'admin@pt.com', 'AJ8ydLxhHQTLa+Q8JH0tiayZA2v5RNgfjcpu9eAvp7i7s9tSFnUA5a+CI4urqErF+g==', '802f0386-adf2-4bd7-a52b-b1c2a3ca9af9');
Insert UserRoles values('C5AF99B0-3425-41FD-8DB3-32ED13EC4494', 'admin');

--Username "crew_member@pt.com" Password "Password1!" Role "crew_member"
Insert Users values('1BBEBA9C-CFBF-4F64-B5FA-AEB1019FA783', 'crew_member@pt.com', 'AMi2do9/Lmzg8lOlEHudWqmh+gVwcBqUuiP8q4Q7f9E3kbLoicfv/wpSY8BUz7m7ZQ==', '15eb1082-ffbc-4791-b584-2af9b2c0ea9e');
Insert UserRoles values('1BBEBA9C-CFBF-4F64-B5FA-AEB1019FA783', 'crew_member');

--Username "crew_leader@pt.com" Password "Password1!" Role "crew_leader"
Insert Users values('1E18474B-DF8F-48C1-A668-7A520650AB37', 'crew_leader@pt.com', 'AAHTFmpj+9ecG9ON2NwKmgRklhmDmzHO/c6Y719dXrX95YvZdDPN88cvFz5kuDWDTw==', 'ce07a118-8534-43cb-976b-9b2e59bfad0d');
Insert UserRoles values('1E18474B-DF8F-48C1-A668-7A520650AB37', 'crew_leader');

--Username "god@pt.com" Password "Password1!" Role "god"
Insert Users values('2528EB34-77EE-4AE8-B906-D29563AFC7DA', 'god@pt.com', 'AGQhNDi1PEK0TFu3AKOU1brhxpiQijIHyw9B8kwKRguaHYYhJ5moeNlBC3YkmX3idA==', '377472a5-9a67-4d3e-92f2-d93171a4b01b');
Insert UserRoles values('2528EB34-77EE-4AE8-B906-D29563AFC7DA', 'god');

--Username "supergod@pt.com"
Insert Users values('10DD883C-C3D0-499C-8421-784B7F4FF7DE', 'supergod@pt.com', 'AOuiueJNVWPKaEWQNBIyW7dwPeOUzsLyr2EVpujXnYGGJD9AGlcOorw5dvDl0U44lw==', 'f28925a4-15ac-4e73-8e54-02a1fdf7dba4');
Insert UserRoles values ('10DD883C-C3D0-499C-8421-784B7F4FF7DE', 'supergod')












Insert PotHole values('E0F27DB1-A4CD-466A-9F28-075A6CE832C8', 'Just a small hole in the road', 41.519369, 81.658027, 1, 'Euclid', 'Elm', 'Its on the corner of euclid and elm', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', null, 1);
Insert PotHole values('E0F27DB1-A4CD-466A-9F28-075A6CE832C8', 'Barely there but worth mentioning', 41.515351, -81.666653, 1, 'Euclid', 'Som Center', 'By the church', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 1);
Insert PotHole values('E0F27DB1-A4CD-466A-9F28-075A6CE832C8', 'The worst pothole I have ever seen fix ASAP', 41.516560,  -81.670086, 10, 'Fairfield Avenue', '', 'As you exit the gas station', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', null, 1);
Insert PotHole values('E0F27DB1-A4CD-466A-9F28-075A6CE832C8', 'This is really bad, Cleveland!', 41.516290, -81.670046, 9, 'Saint Clair', '', 'Its almost half the road what do you mean where is it', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 1);
Insert PotHole values('E0F27DB1-A4CD-466A-9F28-075A6CE832C8', 'A terriblie Pothole', 41.516252, -81.670026, 9, 'St Peter', '', 'Next to the taco stand', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 1);
Insert PotHole values('E0F27DB1-A4CD-466A-9F28-075A6CE832C8', 'A pothole in need of repair', 41.516240, -81.670066, 8, 'Road Ln', '140th', 'by the street', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 1);
Insert PotHole values('1BBEBA9C-CFBF-4F64-B5FA-AEB1019FA783', 'Annoying', 41.516265, -81.670056, 4, 'E 152nd Street', 'High Road', 'Someone planted a tree in it Im late for work!', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 1);
Insert PotHole values('1BBEBA9C-CFBF-4F64-B5FA-AEB1019FA783', 'Not Bad', 41.515230, -81.670046, 2, 'Street St', 'Fleet St', '', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 1);
Insert PotHole values('1BBEBA9C-CFBF-4F64-B5FA-AEB1019FA783', 'The pothole Cleveland Deserved', 41.514250, -81.670456, 6,'Frank Ave', '', 'By the lake But not in the lake', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 1);
Insert PotHole values('1BBEBA9C-CFBF-4F64-B5FA-AEB1019FA783', 'Not sure if pothole or porthole', 41.516250, -81.670036, 2, 'E 24th St.', '', '', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 1);
Insert PotHole values('1BBEBA9C-CFBF-4F64-B5FA-AEB1019FA783', 'Watch out!', 41.513250, -81.670046, 7, 'Carnegie', 'Elm', 'by the sewer grate', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', null, 1);
Insert PotHole values('1BBEBA9C-CFBF-4F64-B5FA-AEB1019FA783', 'I am hit but not bad', 41.516240, -81.670066, 3, '644th st', '', 'next to the cat', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 1);
Insert PotHole values('C5AF99B0-3425-41FD-8DB3-32ED13EC4494', 'Had to repair my car after an encounter with this pothole', 41.517250, -81.670084, 6, 'Mango Ln', '', 'on the street', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 1);
Insert PotHole values('C5AF99B0-3425-41FD-8DB3-32ED13EC4494', 'Wow', 41.515250, -81.670066, 3, '123rd', 'Elm', 'In front of the house, by the stop sign', '2007-04-30 20:10:02.047', null, null, 0);
Insert PotHole values('C5AF99B0-3425-41FD-8DB3-32ED13EC4494', 'It is a hole', 41.513260, -81.670076, 8, 'St clair', '453', 'By the dogshelter, near the fire hydrant', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 1);
Insert PotHole values('C5AF99B0-3425-41FD-8DB3-32ED13EC4494', '', 41.513235, -81.670746, 10, 'Birch', '12 st', 'Corner of birch and elm', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 0);
Insert PotHole values('C5AF99B0-3425-41FD-8DB3-32ED13EC4494', '', 41.513240, -81.670776, 4, 'Twelve', '13 st', 'Next to the weird curb art', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 0);
Insert PotHole values('C5AF99B0-3425-41FD-8DB3-32ED13EC4494', '', 41.513334, -81.670386, 3, 'Bird', 'Welcome St', 'by the manhole cover', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', null, 0);
Insert PotHole values('2528EB34-77EE-4AE8-B906-D29563AFC7DA', '', 41.513235, -81.670734, 3, 'Squirrel Dr', 'Cigar Ln', 'right out the front of the house with the tire swing', '2007-04-30 20:10:02.047', null, null, 0);
Insert PotHole values('2528EB34-77EE-4AE8-B906-D29563AFC7DA', '', 41.513204, -81.670766, 5, 'Tooth', 'Lemon Ln', 'Next to the broken down car', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 0);
Insert PotHole values('2528EB34-77EE-4AE8-B906-D29563AFC7DA', '', 41.513240, -81.670744, 1, 'Moon', 'Temple', 'Corner of birch and elm', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 0);
Insert PotHole values('2528EB34-77EE-4AE8-B906-D29563AFC7DA', '', 41.513232, -81.670783, 9, 'Long Street', '', 'By the TacoYell', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 0);



select * from UserRoles;

select * from users;

select * from PotHole order by PotHole_Id desc;


Select UserId
FROM Users 
where UserName = 'dog@gmail.com';
