USE tp_bdd_factures;

CREATE TABLE [client] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [nom] varchar(255) NOT NULL
)
GO

CREATE TABLE [projet] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [client_id] int NOT NULL,
  [nom] varchar(255)
)
GO

CREATE TABLE [devis] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [version] int NOT NULL,
  [reference] varchar(10) NOT NULL,
  [prix] float NOT NULL,
  [projet_id] int NOT NULL
)
GO

CREATE TABLE [facture] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [reference] varchar(10) NOT NULL,
  [info] varchar(255) NOT NULL,
  [total] float NOT NULL,
  [date_crea] date NOT NULL,
  [date_paiement] date,
  [devis_id] int NOT NULL
)
GO

ALTER TABLE [projet] ADD FOREIGN KEY ([client_id]) REFERENCES [client] ([id])
GO

ALTER TABLE [devis] ADD FOREIGN KEY ([projet_id]) REFERENCES [projet] ([id])
GO

ALTER TABLE [facture] ADD FOREIGN KEY ([devis_id]) REFERENCES [devis] ([id])
GO

-- Insertion de données

-- INSERT INTO [client] ([nom]) VALUES ('Mairie de Rennes');
-- INSERT INTO [client] ([nom]) VALUES ('Neo Soft');
-- INSERT INTO [client] ([nom]) VALUES ('Sopra');
-- INSERT INTO [client] ([nom]) VALUES ('Accenture');
-- INSERT INTO [client] ([nom]) VALUES ('Amazon');

-- INSERT INTO [projet] ([client_id], [nom]) VALUES (1, 'Creation de site internet');
-- INSERT INTO [projet] ([client_id], [nom]) VALUES (2, 'Logiciel CRM');
-- INSERT INTO [projet] ([client_id], [nom]) VALUES (3, 'Logiciel de devis');
-- INSERT INTO [projet] ([client_id], [nom]) VALUES (4, 'Site internet ecommerce');
-- INSERT INTO [projet] ([client_id], [nom]) VALUES (2, 'logiciel ERP');
-- INSERT INTO [projet] ([client_id], [nom]) VALUES (5, 'logiciel Gestion de Stock');

-- INSERT INTO [devis] ([version], [reference], [prix], [projet_id]) VALUES (1, 'DEV2100A', 3000, 1);
-- INSERT INTO [devis] ([version], [reference], [prix], [projet_id]) VALUES (2, 'DEV2100B', 5000, 1);
-- INSERT INTO [devis] ([version], [reference], [prix], [projet_id]) VALUES (1, 'DEV2100C', 5000, 2);
-- INSERT INTO [devis] ([version], [reference], [prix], [projet_id]) VALUES (1, 'DEV2100D', 3000, 3);
-- INSERT INTO [devis] ([version], [reference], [prix], [projet_id]) VALUES (1, 'DEV2100E', 5000, 4);
-- INSERT INTO [devis] ([version], [reference], [prix], [projet_id]) VALUES (1, 'DEV2100F', 2000, 5);
-- INSERT INTO [devis] ([version], [reference], [prix], [projet_id]) VALUES (1, 'DEV2100G', 1000, 6);

-- INSERT INTO [facture] ([reference], [info], [total], [date_crea], [date_paiement], [devis_id])
-- VALUES ('FA001', 'Site internet partie 1', 1500, '2023-09-01', '2023-10-01', 1);
-- INSERT INTO [facture] ([reference], [info], [total], [date_crea], [devis_id])
-- VALUES ('FA002', 'Site internet partie 2', 1500, '2023-09-20', 2);
-- INSERT INTO [facture] ([reference], [info], [total], [date_crea], [devis_id])
-- VALUES ('FA003', 'Logiciel CRM', 5000, '2023-08-01', 3);
-- INSERT INTO [facture] ([reference], [info], [total], [date_crea], [date_paiement], [devis_id])
-- VALUES ('FA004', 'Logiciel devis', 3000, '2023-03-03', '2023-04-03', 4);
-- INSERT INTO [facture] ([reference], [info], [total], [date_crea], [devis_id])
-- VALUES ('FA005', 'Site internet ecommerce', 5000, '2023-04-03', 5);
-- INSERT INTO [facture] ([reference], [info], [total], [date_crea], [devis_id])
-- VALUES ('FA006', 'Logiciel ERP', 2000, '2023-05-04', 6);

/* REQUETES */

-- Afficher les factures à partir d'un client_id en utilisant des JOIN

-- SELECT [facture].[id], [facture].[reference], [facture].[info], [facture].[total], [facture].[date_crea], [facture].[date_paiement]
-- FROM [facture]
-- INNER JOIN [devis] ON [facture].[devis_id] = [devis].[id]
-- INNER JOIN [projet] ON [devis].[projet_id] = [projet].[id]
-- INNER JOIN [client] ON [projet].[client_id] = [client].[id]
-- WHERE [client].[id] = 1;

-- Afficher le client qui a le plus de factures

SELECT [client].[id], [client].[nom], COUNT([facture].[id]) AS [nb_factures]
FROM [client]
INNER JOIN [projet] ON [client].[id] = [projet].[client_id]
INNER JOIN [devis] ON [projet].[id] = [devis].[projet_id]
INNER JOIN [facture] ON [devis].[id] = [facture].[devis_id]
GROUP BY [client].[id], [client].[nom]
ORDER BY [nb_factures] DESC;

-- Calculer le montant total facturé pour un Client

-- SELECT [client].[id], [client].[nom], SUM([facture].[total]) AS [montant_total]
-- FROM [client]
-- INNER JOIN [projet] ON [client].[id] = [projet].[client_id]
-- INNER JOIN [devis] ON [projet].[id] = [devis].[projet_id]
-- INNER JOIN [facture] ON [devis].[id] = [facture].[devis_id]
-- GROUP BY [client].[id], [client].[nom]
-- ORDER BY [montant_total] DESC;

-- Afficher le nombre de devis par client

-- SELECT [client].[id], [client].[nom], COUNT([devis].[id]) AS [nb_devis]
-- FROM [client]
-- INNER JOIN [projet] ON [client].[id] = [projet].[client_id]
-- INNER JOIN [devis] ON [projet].[id] = [devis].[projet_id]
-- GROUP BY [client].[id], [client].[nom]
-- ORDER BY [nb_devis] DESC;

-- Calculer le CA 

-- SELECT SUM([facture].[total]) AS [CA]
-- FROM [facture];

-- Calculer le montant des factures en attente de paiement

-- SELECT SUM([facture].[total]) AS [montant_en_attente]
-- FROM [facture]
-- WHERE [facture].[date_paiement] IS NULL;

-- Calculer les factures en retard de paiement

