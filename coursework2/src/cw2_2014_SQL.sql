/* 
G51DBS Database Systems, Coursework 2

Note: If you have done this correctly, you should be able to execute this file from within mysql and it will work correctly. Please test this before submitting since that is the way that we will test this for marking.
*/


/*
Name: Barnabas Forgo
Username: bxf03u
Student ID: 4211949
*/


/*
Example answer for a question, to show you the format:
*/




/*
Question 1: Provide your answer for Q1 below.
*/

SELECT D1.description AS Description, mobID AS ID, D2.description AS Location
    FROM MobileObject INNER JOIN Location ON mobLocID = locID
                      INNER JOIN Description D1 ON mobDescID = D1.descID
                      INNER JOIN Description D2 ON locDescID = D2.descID
    ORDER BY Description;


/*
Question 2: Provide your answer for Q2 below.
*/

SELECT D1.description AS description, D2.description AS description, mobID, itemID
         FROM MobileObject INNER JOIN Item           ON mobLocID   = itemLocID
                           INNER JOIN Description D1 ON mobDescID  = D1.descID
                           INNER JOIN Description D2 ON itemDescID = D2.descID;


/*
Question 3: Provide your answer for Q3 below.
*/

SELECT mobID, D1.description AS Name, D2.description AS 'Exit', exitDirectionDescID, locIDNew
    FROM MobileObject INNER JOIN LocationExit   ON mobLocID            = locIDCurrent
                      INNER JOIN Description D1 ON mobDescID           = D1.descID
                      INNER JOIN Description D2 ON exitDirectionDescID = D2.descID;


/*
Question 4: Provide your answer for Q4 below.
*/
SELECT mobID, D1.description AS Name, mobLocID, locIDNew
    FROM MobileObject INNER JOIN LocationExit   ON mobLocID = locIDCurrent AND exitDirectionDescID = 1
                      INNER JOIN Description D1 ON mobDescID           = D1.descID
                      INNER JOIN Description D2 ON exitDirectionDescID = D2.descID;

UPDATE MobileObject INNER JOIN LocationExit ON mobLocID = locIDCurrent
    SET mobLocID = locIDNew
    WHERE exitDirectionDescID = 1;

SELECT mobID, D1.description AS Name, mobInitialLocID AS oldLocID, mobLocID AS newLocID FROM MobileObject
    INNER JOIN Description D1 ON mobDescID = D1.descID
    WHERE mobLocID != mobInitialLocID;

/*
Question 5: Provide your answer for Q5 below.
*/

SELECT D1.description AS Person, mobID AS ID, D2.description AS Item
/*SELECT mobDescID, mobID AS ID, itemDescID*/
    FROM MobileObject LEFT OUTER JOIN Item           ON mobLocID   = itemLocID
                      LEFT OUTER JOIN Description D1 ON mobDescID  = D1.descID
                      LEFT OUTER JOIN Description D2 ON itemDescID = D2.descID;

/*
Question 6: Provide your answer for Q6 below.
*/
SELECT A.* FROM (SELECT D1.description AS Item, MIN(itemLocID) AS minLoc, MAX(itemLocID) AS maxLoc, COUNT(D1.description) AS Number FROM Item
        INNER JOIN Description D1 ON itemDescID = descID
        WHERE itemLocID IS NOT NULL
        GROUP BY D1.description)A
    WHERE Number != 2;


/*
Question 7: Provide your answer for Q7 below.
*/

UPDATE MobileObject SET mobLocID = 105 WHERE mobID IN (2,4,6,8);

SELECT D1.description, mobID FROM MobileObject INNER JOIN Description D1 ON mobDescID = D1.descID
    WHERE mobLocID IN (SELECT itemLocID FROM Item INNER JOIN Description D2 ON itemDescID = D2.descID
        WHERE D2.description = 'Dinner Plate');


/*
Question 8: Provide your answer for Q8 below.
*/

SELECT D1.description, D2.description, M1.mobID, M2.mobID, locIDNew, M2.mobLocID 
    FROM MobileObject M1 INNER JOIN LocationExit    ON M1.mobLocID  = locIDCurrent
                         INNER JOIN Description D1  ON M1.mobDescID = D1.descID
                         CROSS JOIN MobileObject M2 ON M2.mobLocID  = locIDNew
                         INNER JOIN Description D2  ON M2.mobDescID = D2.descID;

/*
Question 9: Provide your answer for Q9 below.
*/

SELECT mobID AS ID, D1.description AS Description, D2.description AS Location, mobLocID AS locID
    FROM MobileObject INNER JOIN Location ON mobLocID = locID
                      INNER JOIN Description D1 ON mobDescID = D1.descID
                      INNER JOIN Description D2 ON locDescID = D2.descID
UNION
SELECT itemID, D3.description, IF(itemLocID IS NULL, 'Carried', D4.description), itemLocID
    FROM Item    LEFT OUTER JOIN Location       ON itemLocID  = locID
                 LEFT OUTER JOIN Description D3 ON itemDescID = D3.descID
                 LEFT OUTER JOIN Description D4 ON locDescID  = D4.descID;
