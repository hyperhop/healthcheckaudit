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

CREATE TABLE "audits" (
"id" INT PRIMARY KEY IDENTITY,
"year" INT PRIMARY KEY NOT NULL,
"type" INT FOREIGN KEY NOT NULL,
"start_date" DATETIME,
"end_date" DATETIME,
"title" NOT NULL varchar(100), 
"description" varchar(1500),
"previous_audit" int FOREIGN KEY
next_audit: int FOREIGN KEY
status: varchar(20)
Check status = (‘Started’, ‘In Progress’, ‘Completed’, ‘Closed’)

