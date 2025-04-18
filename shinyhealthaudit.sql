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

CREATE TABLE "checklist_template" (
	"id" INT PRIMARY KEY,
	"version" INT NOT NULL,
	"code" varchar(50) NOT NULL,
	"name" varchar(100) NOT NULL,
	"created" datetime NOT NULL,
	"active" bit NOT NULL
)
;

CREATE TABLE "scoring_method" (
	"id" INT PRIMARY Key IDENTITY,
	"score" varchar(30) NOT NULL
)
;

INSERT INTO "scoring_method"
	values
	('Yes'),
	('No'),
	('1'),
	('2'),
	('3'),
	('4'),
	('5'),
	('Pass'),
	('Fail'),
	('Accepted'),
	('Rejected'),
	('Complies') ,
	('Does not comply')
	;

CREATE TABLE "checklist_item" (
	"id" INT PRIMARY KEY,
	"checklist_template_id" INT FOREIGN KEY REFERENCES checklist_template(id),
	"numbering" varchar(15) NOT NULL,
	"description" varchar(1000) NOT NULL,
	"references" varchar(300),
	"scoring" INT FOREIGN KEY references scoring_method(id)
)
;


CREATE TABLE "audits" (
	"id" INT PRIMARY KEY IDENTITY,
	"year" INT NOT NULL,
	"type" INT FOREIGN KEY REFERENCES audit_types(id), 
	"start_date" DATETIME NOT NULL,
	"end_date" DATETIME,
	"title" varchar(100) NOT NULL, 
	"description" varchar(1500),
	"previous_audit" INT FOREIGN KEY REFERENCES audits(id),
	"next_audit" INT FOREIGN KEY REFERENCES audits(id),
	"status" varchar(20) Check ("status" in ('Started', 'In Progress', 'Completed', 'Closed'))
	)
;

CREATE TABLE "audit_users" (
"user_id" INT FOREIGN KEY REFERENCES users(id),
"role" varchar(20)
)
;

CREATE TABLE "audit_checklists" (
	"id" INT PRIMARY KEY IDENTITY,
	"checklist_template_id" INT
	)
;

CREATE TABLE "audit_checklist_scores" (
	"checklist_id" INT FOREIGN KEY REFERENCES audit_checklists(id),
	"checklist_item" INT FOREIGN KEY REFERENCES checklist_item(id),
	"score" INT FOREIGN KEY REFERENCES scoring_method(id),
	"scorer_id" INT FOREIGN KEY REFERENCES users(id),
	"comments" varchar(1000)
	)
;

CREATE TABLE "audit_attachments" (
	"id" INT,
	"audit_id" INT FOREIGN KEY REFERENCES audits(id),
	"attachments" varbinary(max)
)
;
GO
 
