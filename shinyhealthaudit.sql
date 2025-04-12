USE [master]
GO

CREATE DATABASE [HealthCheck]
GO

USE [HealthCheck]
GO

-- Shiny Health Audit tables

CREATE TABLE "users" (
	"id" INT Primary Key IDENTITY,
	"name" varchar(50) NOT NULL,
	"surname" varchar(50) NOT NULL,
	"job title" varchar(50),
	"email" varchar(50)
)
;

INSERT INTO "users"
values
	('Adam', 'Alpha', 'Worker', 'adam.alpha@shinyhealth.com'),
	('Billy', 'Bald', 'Worker',	'billy.bald@shinyhealth.com'),
	('Cindy', 'Centaur', 'Worker', 'cindy.centaur@shinyhealth.com'),
	('Denise', 'Dragon', 'Worker', 'denise.dragon@shinyhealth.com'),
	('Barnabas', 'Soon', 'Manager',	'barnabas.soon@shinyhealth.com'),
	('Shunnie',	'Xie', 'Manager', 'shunnie.xie@shinyhealth.com')
;

CREATE TABLE "audit_types" (
"id" INT PRIMARY KEY IDENTITY,
"name" varchar(30) NOT NULL,
"status" varchar(20) Check ("status" in ('active', 'inactive'))
)
;

CREATE TABLE "audits" (
	"id" INT PRIMARY KEY IDENTITY,
	"year" INT,
	"type" INT FOREIGN KEY REFERENCES audit_types(id), 
	"start_date" DATETIME,
	"end_date" DATETIME,
	"title" varchar(100) NOT NULL, 
	"description" varchar(1500),
	"previous_audit" INT FOREIGN KEY REFERENCES audits(id),
	"next_audit" INT FOREIGN KEY REFERENCES audits(id),
	"status" varchar(20) Check ("status" in ('Started', 'In Progress', 'Completed', 'Closed'))
		
	)
;

GO
 
