-- Drop tables for previous exercises

DROP TABLE IF EXISTS MobileObject;
DROP TABLE IF EXISTS PlayerData;
DROP TABLE IF EXISTS ReverseExits;
DROP TABLE IF EXISTS Item;
DROP TABLE IF EXISTS LocationExit;
DROP TABLE IF EXISTS Location;
DROP TABLE IF EXISTS Description;




-- Create new tables

SELECT 'Creating Descriptions data...';

CREATE TABLE Description (
    descID INT NOT NULL,
    description VARCHAR(255) NOT NULL,	
    CONSTRAINT pk_desc PRIMARY KEY (descID) 
) ENGINE = InnoDB;
	
INSERT INTO Description (descID,description) VALUES 
(1,'North'),
(2,'South'),
(3,'East'),
(4,'West'),
(5,'Up'),
(6,'Down'),
(10,'A door'),
(11,'A passageway'),
(12,'A possibility to move'),
(13,'The Front Door'),
(14,'The Back Door'),
(15,'The stairs'),
(100,'In the NE corner of the Living Room'),
(101,'In the NW corner of the Living Room'),
(102,'On the East side of the Living Room'),
(103,'On the West side of the Living Room'),
(104,'In the SE corner of the Living Room'),
(105,'In the SW corner of the Living Room'),
(106,'In the Kitchen'),
(107,'At the south end of the Hallway'),
(108,'At the north end of the Hallway'),
(109,'In the garden'),
(110,'On the landing'),
(111,'In the master bedroom'),
(112,'In the bathroom'),
(113,'Outside the front door'),
(114,'Lost somewhere'),
(1000,'Television'),
(1001,'Ornate Vase'),
(1002,'Coffee Table'),
(1003,'Mobile Phone'),
(1004,'Garden Spade'),
(1005,'Garden Fork'),
(1006,'Newspaper'),
(1007,'Magazine'),
(1008,'Dinner Plate'),
(1009,'Dining Table'),
(1010,'Front Door Key'),
(1011,'Back Door Key'),
(1012,'Thin Duvet'),
(1013,'Thick Duvet'),
(1014,'Blanket Duvet'),
(1015,'Pillow'),
(1016,'Thick Pillow'),
(1017,'Thin Pillow'),
(1018,'Soap'),
(1019,'Shampoo'),
(1020,'Toothpaste'),
(1021,'Toothbrush'),
(1022,'Cup'),
(1023,'Knife'),
(1024,'Fork'),
(1025,'Spoon'),
(1026,'Teaspoon'),
(2000,'The gardener'),
(2001,'Your brother'),
(2002,'Your sister'),
(2003,'Your mother'),
(2004,'Your father'),
(2005,'Your friend'),
(2006,'Your best friend')
;

SELECT * FROM Description;

SELECT 'Creating Locations data...';

CREATE TABLE Location (
    locID INT NOT NULL AUTO_INCREMENT,
    locDescID INT NOT NULL,
    CONSTRAINT pk_loc PRIMARY KEY (locID),
    CONSTRAINT fk_loc_desc FOREIGN KEY (locDescID) REFERENCES Description (descID)
) ENGINE = InnoDB;
	
INSERT INTO Location (locID,locDescID) VALUES 
(100,100), 
(101,101), 
(102,102), 
(103,103), 
(104,104), 
(105,105), 
(106,106), 
(107,107), 
(108,108), 
(109,109), 
(110,110), 
(111,111), 
(112,112),
(113,113),
(114,109),
(115,109),
(116,109),
(117,109),
(118,109),
(119,114)
;

SELECT * FROM Location;

SELECT 'Creating LocationExits data...';

CREATE TABLE LocationExit (
    locIDCurrent INT NOT NULL,
    exitDirectionDescID  INT NOT NULL,
    locIDNew INT NOT NULL,
    exitDescID INT NOT NULL,
    CONSTRAINT pk_locexit PRIMARY KEY ( locIDCurrent, exitDirectionDescID ),
    CONSTRAINT fk_locexit_desc1 FOREIGN KEY (exitDirectionDescID) REFERENCES Description (descID),
    CONSTRAINT fk_locexit_desc2 FOREIGN KEY (exitDescID) REFERENCES Description (descID),
    CONSTRAINT fk_locexit_loc1 FOREIGN KEY (locIDCurrent) REFERENCES Location(locID),
    CONSTRAINT fk_locexit_loc2 FOREIGN KEY (locIDNew) REFERENCES Location(locID)
) ENGINE = InnoDB;

INSERT INTO LocationExit (locIDCurrent, exitDirectionDescID, locIDNew, exitDescID ) VALUES 
(101,3,100,12), 
(103,3,102,12), 
(105,3,104,12), 
(100,3,108,10), 
(104,3,106,10), 
(101,2,103,12), 
(103,2,105,12), 
(100,2,102,12), 
(102,2,104,12), 
(113,2,108,13), 
(108,2,107,12), 
(107,2,106,10), 
(106,2,109,14), 
(108,5,110,15), 
(111,2,110,10), 
(110,2,112,10),
(115,3,109,12), 
(109,3,118,12), 
(116,3,117,12), 
(117,3,114,12), 
(115,2,116,12), 
(109,2,117,12), 
(118,2,114,12)
;

SELECT * FROM LocationExit;

SELECT 'Creating Items data...';

CREATE TABLE Item (
    itemID INT NOT NULL,
    itemLocID  INT,
    itemInitialLoc INT,
    itemDescID INT NOT NULL,
    CONSTRAINT pk_item PRIMARY KEY ( itemID ),
    CONSTRAINT fk_item_desc FOREIGN KEY (itemDescID) REFERENCES Description (descID),
    CONSTRAINT fk_item_loc FOREIGN KEY (itemLocID) REFERENCES Location(locID),
    CONSTRAINT fk_item_initloc FOREIGN KEY (itemInitialLoc ) REFERENCES Location(locID)
) ENGINE = InnoDB;

INSERT INTO Item (itemID, itemLocID, itemInitialLoc, itemDescID ) VALUES 
(1,100,100,1000), 
(2,100,100,1001), 
(3,100,100,1002),
(4,101,101,1002),
(5,null,null,1003),
(6,116,116,1004),
(7,114,114,1005),
(8,103,103,1006),
(9,102,102,1006),
(10,104,104,1007),
(11,102,102,1007),
(12,102,102,1007),
(13,105,105,1009),
(14,105,105,1008),
(15,105,105,1008),
(16,105,105,1008),
(17,105,105,1008),
(18,105,105,1008),
(19,105,105,1008),
(20,106,106,1010),
(21,106,106,1011),
(22,111,111,1012),
(23,111,111,1013),
(24,111,111,1014),
(25,111,111,1015),
(26,111,111,1016),
(27,111,111,1017),
(28,111,111,1017),
(29,112,112,1018),
(30,112,112,1019),
(31,112,112,1020),
(32,112,112,1021),
(33,106,106,1022),
(34,106,106,1022),
(35,106,106,1022),
(36,106,106,1022),
(37,106,106,1023),
(38,106,106,1023),
(39,106,106,1023),
(40,106,106,1023),
(41,106,106,1024),
(42,106,106,1024),
(43,106,106,1024),
(44,106,106,1024),
(45,106,106,1025),
(46,106,106,1025),
(47,106,106,1025),
(48,106,106,1025),
(49,106,106,1026),
(50,106,106,1026),
(51,106,106,1026),
(52,106,106,1026),
(53,113,113,1005);

SELECT * FROM Item;

SELECT 'Creating MobileObjects data...';

CREATE TABLE MobileObject (
    mobID INT NOT NULL,
    mobLocID  INT,
    mobInitialLocID  INT,
    mobDescID INT NOT NULL,
    mobHealth INT NOT NULL,
    CONSTRAINT pk_item PRIMARY KEY ( mobID ),
    CONSTRAINT fk_mob_desc FOREIGN KEY (mobDescID) REFERENCES Description (descID),
    CONSTRAINT fk_mob_loc FOREIGN KEY (mobLocID) REFERENCES Location(locID),
    CONSTRAINT fk_mob_initloc FOREIGN KEY (mobInitialLocID) REFERENCES Location(locID)
) ENGINE = InnoDB;

INSERT INTO MobileObject (mobID, mobLocID, mobInitialLocID, mobDescID, mobHealth ) VALUES 
(1, 115, 115, 2000, 500),
(2, 106, 106, 2001, 200),
(3, 116, 116, 2002, 300),
(4, 112, 112, 2002, 100),
(5, 100, 100, 2003, 200),
(6, 111, 111, 2004, 200),
(7, 103, 103, 2005, 150),
(8, 105, 105, 2005, 250),
(9, 102, 102, 2005, 200),
(10, 101, 101, 2006, 300);

SELECT * FROM MobileObject;

SELECT 'Creating player data...';

CREATE TABLE PlayerData (
    dataID VARCHAR(20) NOT NULL,
    dataValue INT NOT NULL,
    dataInitial INT NOT NULL,
    CONSTRAINT pk_loc PRIMARY KEY ( dataID )
) ENGINE = InnoDB;

-- 1 is current location
INSERT INTO PlayerData (dataID,dataValue,dataInitial) VALUES 
('Position', 100, 100),
('Health', 200, 200),
('CurrentTurn', 2, 2)
;

SELECT * FROM PlayerData;

SELECT 'Creating ReverseExits data...';


CREATE TABLE ReverseExits (
    reverseDescID1 INT NOT NULL,
    reverseDescID2 VARCHAR(255) NOT NULL,	
    CONSTRAINT pk_desc1 PRIMARY KEY (reverseDescID1),
    CONSTRAINT pk_desc2 UNIQUE (reverseDescID2) 
) ENGINE = InnoDB;

INSERT INTO ReverseExits VALUES 
(1,2),
(2,1),
(3,4),
(4,3),
(5,6),
(6,5)
;

SELECT * FROM ReverseExits;

SELECT 'Using ReverseExits data...';

-- Can you work out what this does?
INSERT INTO LocationExit (SELECT locIDNew, reverseDescID2, locIDCurrent, exitDescID FROM LocationExit L INNER JOIN ReverseExits ON L.exitDirectionDescID = ReverseExits.reverseDescID1);

