-- author: Barnabas Forgo //bxf03u //4211949


DROP TABLE IF EXISTS Task;
DROP TABLE IF EXISTS Requirement;
DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS EmployeeSkill;
DROP TABLE IF EXISTS Skill;
DROP TABLE IF EXISTS Employee;


CREATE TABLE Employee (
    eID INT NOT NULL AUTO_INCREMENT,
    eFirstName VARCHAR(255) NOT NULL,
    eLastName VARCHAR(255) NOT NULL,
    eJobTitle VARCHAR(255) NOT NULL,
    eManagerID INT NOT NULL,
    CONSTRAINT pk_employee PRIMARY KEY (eID)
) ENGINE = InnoDB;

CREATE TABLE Skill (
    sID INT NOT NULL AUTO_INCREMENT,
    sName VARCHAR(255) NOT NULL,
    CONSTRAINT pk_skill PRIMARY KEY (sID),
    CONSTRAINT ck_skill UNIQUE (sName)
) ENGINE = InnoDB;

CREATE TABLE EmployeeSkill (
    eID INT NOT NULL,
    sID INT NOT NULL,
    esLevel INT NOT NULL,
    CONSTRAINT fk_es_employee FOREIGN KEY (eID) REFERENCES Employee (eID),
    CONSTRAINT fk_es_skill FOREIGN KEY (sID) REFERENCES Skill (sID)
) ENGINE = InnoDB;

CREATE TABLE Project (
    pID INT NOT NULL AUTO_INCREMENT,
    pName VARCHAR(255) NOT NULL,
    CONSTRAINT pk_project PRIMARY KEY (pID)
) ENGINE = InnoDB;

CREATE TABLE Requirement (
    rID INT NOT NULL AUTO_INCREMENT,
    pID INT NOT NULL,
    rDuration INT NOT NULL,
    rStart DATE NOT NULL,
    sID INT NOT NULL,
    rSkillLevel INT NOT NULL,
    rNumberOfPeople INT NOT NULL,
    CONSTRAINT pk_requirement PRIMARY KEY (rID),
    CONSTRAINT fk_project FOREIGN KEY (pID) REFERENCES Project (pID),
    CONSTRAINT fk_r_skill FOREIGN KEY (sID) REFERENCES Skill (sID)
) ENGINE = InnoDB;

CREATE TABLE Task (
    rID INT NOT NULL,
    eID INT NOT NULL,
    tDuration INT NOT NULL,
    CONSTRAINT fk_requirement FOREIGN KEY (rID) REFERENCES Requirement (rID),
    CONSTRAINT fk_t_employee FOREIGN KEY (eID) REFERENCES Employee (eID)
) ENGINE = InnoDB;


INSERT INTO Employee (eFirstName, eLastName, eJobTitle, eManagerID) VALUES 
    ('Adam', 'Smith', 'Managing director', 1), 
    ('Beryl', 'Jones', 'IT Manager', 1), 
    ('Cyril', 'Green', 'Personnel manager', 1), 
    ('Dennis', 'Brown', 'Developer', 2), 
    ('Edward', 'White', 'Intern', 2);

INSERT INTO Skill (sName) VALUES
    ('Management'),
    ('Leadership'),
    ('SQL query'),
    ('Communication'),
    ('SQL admin'),
    ('Database design'),
    ('Database Testing'),
    ('Advertising'),
    ('User Interface Programming');

INSERT INTO EmployeeSkill (eID,sID,esLevel) VALUES
    ((SELECT eID FROM Employee WHERE eFirstName = 'Adam'),
     (SELECT sID FROM Skill    WHERE sName      = 'Management'),
                                                   3),
    ((SELECT eID FROM Employee WHERE eFirstName = 'Adam'),
     (SELECT sID FROM Skill    WHERE sName      = 'Leadership'),
                                                   3),
    ((SELECT eID FROM Employee WHERE eFirstName = 'Beryl'),
     (SELECT sID FROM Skill    WHERE sName      = 'Management'),
                                                   2),
    ((SELECT eID FROM Employee WHERE eFirstName = 'Beryl'),
     (SELECT sID FROM Skill    WHERE sName      = 'SQL query'),
                                                   3),
    ((SELECT eID FROM Employee WHERE eFirstName = 'Cyril'),
     (SELECT sID FROM Skill    WHERE sName      = 'Management'),
                                                   3),
    ((SELECT eID FROM Employee WHERE eFirstName = 'Cyril'),
     (SELECT sID FROM Skill    WHERE sName      = 'Communication'),
                                                   1),
    ((SELECT eID FROM Employee WHERE eFirstName = 'Dennis'),
     (SELECT sID FROM Skill    WHERE sName      = 'SQL admin'),
                                                   2),
    ((SELECT eID FROM Employee WHERE eFirstName = 'Dennis'),
     (SELECT sID FROM Skill    WHERE sName      = 'SQL query'),
                                                   3),
    ((SELECT eID FROM Employee WHERE eFirstName = 'Dennis'),
     (SELECT sID FROM Skill    WHERE sName      = 'Database design'),
                                                   3);

INSERT INTO Project (pName) VALUES
    ('Design the project management system'),
    ('Advertise the project management system');

INSERT INTO Requirement (pID, rDuration, rStart, sID, rSkillLevel, rNumberOfPeople) VALUES
    ((SELECT pID FROM Project WHERE pName = 'Design the project management system'),
                                            3,
                                            '2014-08-12',
     (SELECT sID FROM Skill   WHERE sName = 'Database design'),
                                            2,
                                            1),

    ((SELECT pID FROM Project WHERE pName = 'Design the project management system'),
                                            2,
                                            '2014-11-1',
     (SELECT sID FROM Skill   WHERE sName = 'SQL admin'),
                                            3,
                                            1),

    ((SELECT pID FROM Project WHERE pName = 'Design the project management system'),
                                            5,
                                            '2014-12-5',
     (SELECT sID FROM Skill   WHERE sName = 'Database Testing'),
                                            1,
                                            1),

    ((SELECT pID FROM Project WHERE pName = 'Advertise the project management system'),
                                            35,
                                            '2015-01-5',
     (SELECT sID FROM Skill   WHERE sName = 'Advertising'),
                                            1,
                                            1);

INSERT INTO Task (rID, eID, tDuration) VALUES
    ((SELECT rID FROM Requirement WHERE rStart     = '2014-08-12'),
     (SELECT eID FROM Employee    WHERE eFirstName = 'Dennis'),
                                                      3),
    ((SELECT rID FROM Requirement WHERE rStart     = '2014-11-1'),
     (SELECT eID FROM Employee    WHERE eFirstName = 'Dennis'),
                                                      1);