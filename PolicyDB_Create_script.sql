/*Policy */

Use PolicyDB;

DROP TABLE IF EXISTS customeraddress;
DROP TABLE IF EXISTS productanswers;
DROP TABLE IF EXISTS nominee;
DROP TABLE IF EXISTS productquestions;
DROP TABLE IF EXISTS beneficiary_info;
DROP TABLE IF EXISTS policystatus;
DROP TABLE IF EXISTS policydetails;
DROP TABLE IF EXISTS planbreakup;
DROP TABLE IF EXISTS agerange;
DROP TABLE IF EXISTS plantype;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS nominee;


CREATE TABLE product (
    Productid INT AUTO_INCREMENT,
    Productname VARCHAR(150),
    Lobid INT,
    ShortProductname VARCHAR(20),
    Startdate DATE,
    Enddate DATE,
    Lastupdateddate DATE,
    Effectivedate DATE,
    Riskstartdaterange INT,
    Backdatedinception BIT,
    Backdatedinceptionrange INT,
    Policynumberingformat VARCHAR(30),
    PRIMARY KEY (Productid)
);
CREATE TABLE customers (
    Customerid INT AUTO_INCREMENT,
    Name VARCHAR(100),
    PRIMARY KEY (Customerid)
);
CREATE TABLE policystatus (
    Policystatusid INT AUTO_INCREMENT,
    status VARCHAR(100),
    PRIMARY KEY (Policystatusid)
);
CREATE TABLE relationship (
    relationid INT AUTO_INCREMENT,
    Type VARCHAR(100),
    PRIMARY KEY (relationid)
);
CREATE TABLE nominee (
    nomineeid INT AUTO_INCREMENT,
    type VARCHAR(20),
    PRIMARY KEY (nomineeid)
);
CREATE TABLE policydetails (
    Policyid INT AUTO_INCREMENT,
    PlanID INT NOT NULL,
    PolicyStartDate DATE NOT NULL,
    PolicyEndDate DATE NOT NULL,
    ProductID INT NOT NULL,
    Affinityid INT NOT NULL,
    PolicyStatusID INT NOT NULL,
    BranchId INT NOT NULL,
    Certificateno VARCHAR(50),
    LastUpdatedDate DATE NOT NULL,
    LastUpdatedBy INT NOT NULL,
    Customerid INT,
    Employeecode VARCHAR(50),
    Policyterm INT NOT NULL,
    Masterpolicyno INT,
    Covernoteno INT,
    PRIMARY KEY (policyid),
    FOREIGN KEY (ProductID)
        REFERENCES product (Productid),
    FOREIGN KEY (PolicyStatusID)
        REFERENCES policystatus (Policystatusid),
    FOREIGN KEY (Customerid)
        REFERENCES customers (Customerid)
);
CREATE TABLE customeraddress (
    Policyid INT,
    Customerid INT,
    Address1 VARCHAR(100),
    Address2 VARCHAR(100),
    Address3 VARCHAR(100),
    State VARCHAR(50),
    District VARCHAR(50),
    City VARCHAR(50),
    Pincode VARCHAR(50),
    EmailID VARCHAR(50),
    Mobile VARCHAR(50),
    Telephone VARCHAR(50),
    PRIMARY KEY (Policyid),
    FOREIGN KEY (Customerid)
        REFERENCES customers (Customerid)
);


CREATE TABLE beneficiary_info (
    Policyid INT,
    Name VARCHAR(100),
    Dob DATE,
    Gender VARCHAR(2),
    Relation_proposer INT,
    nomineename VARCHAR(100),
    Relation_nominee INT,
    Nominee_type INT,
    FOREIGN KEY (Policyid)
        REFERENCES policydetails (Policyid),
    FOREIGN KEY (Relation_proposer)
        REFERENCES relationship (relationid),
    FOREIGN KEY (Relation_nominee)
        REFERENCES relationship (relationid),
    FOREIGN KEY (Nominee_type)
        REFERENCES nominee (Nomineeid)
);


Create Table productquestions	
(
Questionid	Int auto_increment,
Question	Varchar(300),
Productid	Int,
PRIMARY KEY(Questionid),
choices varchar(30),
FOREIGN KEY(Productid) REFERENCES product(Productid))
;

CREATE TABLE productanswers (
    Policyid INT,
    Questionid INT,
    Ans BIT,
    FOREIGN KEY (Questionid)
        REFERENCES productquestions (Questionid),
    FOREIGN KEY (Policyid)
        REFERENCES policydetails (Policyid)
);

CREATE TABLE plantype (
    Planid INTEGER AUTO_INCREMENT,
    policytype VARCHAR(50) NOT NULL,
    Productid INTEGER NOT NULL,
    PRIMARY KEY (Planid),
    FOREIGN KEY (Productid)
        REFERENCES product (Productid)
);

CREATE TABLE agerange (
    Agerangeid INTEGER AUTO_INCREMENT,
    AgeRange VARCHAR(50) NOT NULL,
    PRIMARY KEY (Agerangeid)
);


CREATE TABLE planbreakup (
    Planid INTEGER NOT NULL,
    SI NUMERIC NOT NULL,
    Agerange INTEGER NOT NULL,
    Premium NUMERIC NOT NULL,
    CGST NUMERIC,
    SGST NUMERIC,
    IGST NUMERIC,
    GP NUMERIC NOT NULL,
    FOREIGN KEY (Planid)
        REFERENCES plantype (Planid),
    FOREIGN KEY (Agerange)
        REFERENCES agerange (Agerangeid)
);

CREATE TABLE choices (
    Choiceid INT AUTO_INCREMENT,
    choicevalue VARCHAR(30),
    PRIMARY KEY (Choiceid)
);
 
CREATE TABLE productquestion_choice (
    Questionid INT,
    Choiceid INT,
    FOREIGN KEY (Questionid)
        REFERENCES productquestions (Questionid),
    FOREIGN KEY (Choiceid)
        REFERENCES choices (Choiceid)
);
