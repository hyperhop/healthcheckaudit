CREATE DATABASE [HealthCheck]
GO

USE [HealthCheck]
GO

CREATE TABLE "users" (
	"id" INT Primary Key IDENTITY,
	"name" varchar(50) NOT NULL,
	"surname" varchar(50) NOT NULL,
	"job title" varchar(50),
	"email" varchar(50)
)
;
--Inserts dummy users into the database

INSERT INTO "users"
values
	('Adam', 'Alpha', 'Worker', 'adam.alpha@shinyhealth.com'),
	('Billy', 'Bald', 'Worker',	'billy.bald@shinyhealth.com'),
	('Cindy', 'Centaur', 'Worker', 'cindy.centaur@shinyhealth.com'),
	('Denise', 'Dragon', 'Worker', 'denise.dragon@shinyhealth.com'),
	('Barnabas', 'Soon', 'Manager',	'barnabas.soon@shinyhealth.com')
;

-- Admin section


CREATE TABLE "audit_types" (
	"id" INT PRIMARY KEY IDENTITY,
	"name" varchar(30) NOT NULL,
	"status" varchar(20) Check ("status" in ('Active', 'Inactive')),
	"description" varchar(200)
)
;


--Creates dummy audit type
INSERT INTO "audit_types"
values
	('Basic', 'active', 'Basic audit type')

-- Checklist templates
CREATE TABLE "checklist_templates" (
	"id" INT PRIMARY KEY IDENTITY,
	"version" INT NOT NULL,
	"code" varchar(50) NOT NULL,
	"name" varchar(100) NOT NULL,
	"created" datetime NOT NULL,
	"status" varchar(20) Check ("status" in ('Active', 'Inactive')),
	"description" varchar(200)
)
;

--Creates a dummy checklist
INSERT INTO "checklist_templates"
VALUES
	(1, 'Basic', 'Basic Checklist', CURRENT_TIMESTAMP, 'Active', 'Basic Checklist pulled from Manual XYZ')
	;

--Scoring for checklists
CREATE TABLE "scoring_method" (
	"id" INT PRIMARY Key IDENTITY,
	"score" varchar(30) NOT NULL
)
;

--Scoring values

INSERT INTO "scoring_method"
	values
	('Yes/No'),
	('1,2,3,4,5'),
	('Pass/Fail'),
	('Accepted/Rejected'),
	('Complies/Does not comply')
	;
	
--Checklist items
CREATE TABLE "checklist_item" (
	"id" INT PRIMARY KEY IDENTITY,
	"checklist_template_id" INT FOREIGN KEY REFERENCES checklist_templates(id),
	"numbering" varchar(15) NOT NULL,
	"description" varchar(1000) NOT NULL,
	"references" varchar(300),
	"scoring" INT FOREIGN KEY references scoring_method(id)
)
;

INSERT INTO "checklist_item"
VAlUES
	(1, 1, 'Has procedure been documented', 'Checklist 1, Item 1', '1'),
	(1, 2, 'Has relevant medical professional all been assigned?', 'Checklist 1, Item 2', '1')

-- Audit tables
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

-- Ability to assign users and roles to the audit.
CREATE TABLE "audit_users" (
	"user_id" INT FOREIGN KEY REFERENCES users(id),
	"audit_id" INT FOREIGN KEY REFERENCES audits(id),
	"role" varchar(20)
)
;

-- Assigns checklists templates to an audit
CREATE TABLE "audit_checklists" (
	"id" INT PRIMARY KEY IDENTITY,
	"audit_id" INT FOREIGN KEY REFERENCES audits(id),
	"checklist_templates_id" INT FOREIGN KEY REFERENCES checklist_templates(id)
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
 
