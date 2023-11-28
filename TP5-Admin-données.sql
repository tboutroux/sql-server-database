CREATE DATABASE [TP5-Admin-données]
GO

USE [TP5-Admin-données]

DROP TABLE IF EXISTS [Team]
DROP TABLE IF EXISTS [Personne]
DROP TABLE IF EXISTS [Personne_Team]

CREATE TABLE [Team] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [nom] varchar(30),
  [projet] varchar(50) NOT NULL,
  [id_personne] int
)
GO

CREATE TABLE [Personne] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [nom] varchar(30) NOT NULL,
  [prenom] varchar(30) NOT NULL
)
GO

CREATE TABLE [Personne_Team] (
  [id_personne] int NOT NULL,
  [id_team] int NOT NULL
)
GO

ALTER TABLE [Personne_Team] ADD FOREIGN KEY ([id_personne]) REFERENCES [Personne] ([id])
GO

ALTER TABLE [Personne_Team] ADD FOREIGN KEY ([id_team]) REFERENCES [Team] ([id])
GO

ALTER TABLE [Team] ADD FOREIGN KEY ([id_personne]) REFERENCES [Personne] ([id])
GO


/* Insertion des données */

INSERT INTO [Team] ([nom], [projet], [id_personne]) VALUES 
('Team A','Projet site Mairie',1),
('Team B','Projet CRM',4),
('Team C','Projet ERP',7);
GO

INSERT INTO [Personne] ([nom], [prenom]) VALUES 
('Brad','Pitt'),
('Bruce','Willis'),
('Nicolas','Cage'),
('Angelie','Jolie'),
('Tom','Cruise'),
('Tom','Hanks'),
('Bob','Dylan'),
('Johnny','Cash'),
('Jimmy','Hendrix');
GO

INSERT INTO [Personne_Team] ([id_personne], [id_team]) VALUES 
(1,2),
(1,3),
(2,5),
(2,6),
(3,8),
(3,9);

/* Requêtes */

-- Affichage des Personnes de la Team A

SELECT Personne.nom, Personne.prenom FROM Personne_Team
INNER JOIN Personne ON Personne_Team.id_personne = Personne.id
INNER JOIN Team ON Personne_Team.id_team = Team.id
-- WHERE Team.nom = 'Team A'

-- Affichage de toutes les équipes

-- SELECT Team.nom, Personne.nom, Personne.prenom, Personne.poste FROM Personne 
-- INNER JOIN Team 
-- ON Personne.id_team = Team.id
-- ORDER BY Team.nom