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
	[LeaderId]				UNIQUEIDENTIFIER	NULL,

	CONSTRAINT fk_LeaderId_UserId FOREIGN KEY (LeaderId) REFERENCES Users(UserId) 
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
Insert Users values('3D51E04F-2874-443B-BDE0-F1F072BAAA91', 'wozthetechwiz@gmail.com','ALqbmGC/RKl4pju4OlFfOC32CV/htteSeeAI6OnDJYA8JxRKuIrJEGEgcifDY26cmg==', '50983e0b-3f2e-49bf-81e7-c99e4cd5b713');
Insert UserRoles values('3D51E04F-2874-443B-BDE0-F1F072BAAA91', 'god');
--Username "supergod@pt.com"
Insert Users values('10DD883C-C3D0-499C-8421-784B7F4FF7DE', 'supergod@pt.com', 'AOuiueJNVWPKaEWQNBIyW7dwPeOUzsLyr2EVpujXnYGGJD9AGlcOorw5dvDl0U44lw==', 'f28925a4-15ac-4e73-8e54-02a1fdf7dba4');
Insert UserRoles values ('10DD883C-C3D0-499C-8421-784B7F4FF7DE', 'supergod')

--Additional CrewMembers to populate WorkOrder
Insert Users values('1BBEBA9C-CFBF-4F44-B5FA-AEB1019FA783', 'Bob_Builder@pt.com', 'AMi2do9/Lmzg8lOlEHudWqmh+gVwcBqUuiP8q4Q7f9E3kbLoicfv/wpSY8BUz7m7ZQ==', '15eb1082-ffbc-4791-b584-2af9b2c0ea9e');
Insert UserRoles values('1BBEBA9C-CFBF-4F44-B5FA-AEB1019FA783', 'crew_member');
Insert Users values('1BEEBA9C-CFBF-4F44-B5FA-AEB1019FA783', 'Tom_Builder@pt.com', 'AMi2do9/Lmzg8lOlEHudWqmh+gVwcBqUuiP8q4Q7f9E3kbLoicfv/wpSY8BUz7m7ZQ==', '15eb1082-ffbc-4791-b584-2af9b2c0ea9e');
Insert UserRoles values('1BEEBA9C-CFBF-4F44-B5FA-AEB1019FA783', 'crew_member');
Insert Users values('1BBEEA9C-CFBF-4F44-B5FA-AEB1019FA783', 'Roger_Builder@pt.com', 'AMi2do9/Lmzg8lOlEHudWqmh+gVwcBqUuiP8q4Q7f9E3kbLoicfv/wpSY8BUz7m7ZQ==', '15eb1082-ffbc-4791-b584-2af9b2c0ea9e');
Insert UserRoles values('1BBEEA9C-CFBF-4F44-B5FA-AEB1019FA783', 'crew_member');
Insert Users values('1B9EEA9C-CFBF-4F44-B5FA-AEB1019FA783', 'Daniel_Driver@pt.com', 'AMi2do9/Lmzg8lOlEHudWqmh+gVwcBqUuiP8q4Q7f9E3kbLoicfv/wpSY8BUz7m7ZQ==', '15eb1082-ffbc-4791-b584-2af9b2c0ea9e');
Insert UserRoles values('1B9EEA9C-CFBF-4F44-B5FA-AEB1019FA783', 'crew_member');


--Potholes for demo
Insert PotHole values('1BBEBA9C-CFBF-4F64-B5FA-AEB1019FA783', 'The pothole Cleveland Deserved', 41.514250, -81.670456, 6,'Frank Ave', '', 'By the lake But not in the lake', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', '2007-04-30 20:10:02.047', 1);
Insert PotHole values('10DD883C-C3D0-499C-8421-784B7F4FF7DE', 'not as bad as some but could easily become worse after another winter', 41.5039896225187, -81.6389301786537, 4, 'Euclid', '71st', 'Outside of Baker Electric Building', '2018-04-19 00:00:00.000', null,null,1);
Insert PotHole values('10DD883C-C3D0-499C-8421-784B7F4FF7DE', 'Really bad. I think theres a family of squirrels living in it.', 41.5114833058694, -81.5800114887002, 8, 'Coventry', 'Mayfield', 'Outside of Pacific East', '2018-04-19 00:00:00.000', null, null, 1);
Insert PotHole values('E0F27DB1-A4CD-466A-9F28-075A6CE832C8', 'not bad, still quite a bump', 41.4408675939493, -81.7378555469651, 3, 'Southfield', 'North Amber And Memphis', '', '2018-04-19 00:00:00.000', null, null, 1);                       
Insert PotHole values('E0F27DB1-A4CD-466A-9F28-075A6CE832C8', 'BENT MY AXEL!!1! YOU OWE ME MOENY', 41.4959064883019, -81.7064731314611, 9, 'Elm', 'Main', 'outside of mcarhtys bart', '2018-04-19 00:00:00.000', null, null, 1); 
Insert PotHole values('E0F27DB1-A4CD-466A-9F28-075A6CE832C8','BIG HOLE JUST LIKE THE HOLE IN BROWNS LEADERSHIP. ZING.', 41.5056179974269, -81.6979469416711, 10, 'Alfred Lerner Way', 'Erieside Ave', 'Outside of Browns Stadium.', '2018-04-19 00:00:00.000', '2018-04-19 00:00:00.000', '', 1);            
Insert PotHole values('E0F27DB1-A4CD-466A-9F28-075A6CE832C8','pretty good bump. near my hipster friend and his girls house', 41.4868333743881, -81.7158519263448, 5, 'Clinton', 'W38th', '', '2018-04-19 00:00:00.000', null, null, 1);                        
Insert PotHole values('E0F27DB1-A4CD-466A-9F28-075A6CE832C8','Youll shoot yer eye out', 41.4687276531672, -81.6876047702729, 7,'West 11th', 'Rowley', 'Near Bumpus house and his freaking dogs', '2018-04-19 00:00:00.000', '2018-04-19 00:00:00.000', '2018-04-19 00:00:00.000', 1);               
Insert PotHole values('E0F27DB1-A4CD-466A-9F28-075A6CE832C8','This is huge. About the size of a baby orengatan, orangetan, .... monkey',41.4469686570236, -81.7115220356563, 6, 'Zoo Drive', 'Wildlife Way', 'Zoo parkinglot', '2018-04-19 00:00:00.000', null, null, 1);                       


select * from UserRoles;

select * from users;

select * from PotHole order by PotHole_Id desc;



