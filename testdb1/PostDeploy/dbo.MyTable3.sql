CREATE TABLE #MyTable3
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [Name] NVARCHAR(50) NOT NULL
)

INSERT INTO #MyTable3 (
	[Id], 
	[Name]
	)
VALUES 
	(1,'cd1'),
	(2,'cd2')

MERGE INTO [dbo].[MyTable3] AS Target
USING (
SELECT * FROM #MyTable3
)
AS Source (
	[Id], 
	[Name]
	)
ON (Target.[Id] = Source.[Id])
WHEN MATCHED 
THEN UPDATE SET
	[Name] = Source.[Name]

WHEN NOT MATCHED BY TARGET 
THEN INSERT(
	[Id],
	[Name]
	)
    VALUES(
	Source.[Id],
    Source.[Name]
	)
WHEN NOT MATCHED BY SOURCE THEN
DELETE;


DECLARE @mergeError int,
		@mergeCount int

SELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNT
IF @mergeError != 0
	BEGIN
		PRINT 'ERROR OCCURRED IN MERGE FOR [dbo].[MyTable3]. Rows affected: ' + CAST(@mergeCount AS VARCHAR(100));
	END
ELSE
	BEGIN
		PRINT '[dbo].[MyTable3] rows affected by MERGE: ' + CAST(@mergeCount AS VARCHAR(100));
	END

DROP TABLE #MyTable3