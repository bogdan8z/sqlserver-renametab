CREATE TABLE #MyTable2
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [Code] NVARCHAR(50) NOT NULL
)

INSERT INTO #MyTable2 (
	[Id], 
	[Code]
	)
VALUES 
	(1,'cd1'),
	(2,'cd2')

MERGE INTO [dbo].[MyTable2] AS Target
USING (
SELECT * FROM #MyTable2
)
AS Source (
	[Id], 
	[Code]
	)
ON (Target.[Id] = Source.[Id])
WHEN MATCHED 
THEN UPDATE SET
	[Code] = Source.[Code]

WHEN NOT MATCHED BY TARGET 
THEN INSERT(
	[Id],
	[Code]
	)
    VALUES(
	Source.[Id],
    Source.[Code]
	)
WHEN NOT MATCHED BY SOURCE THEN
DELETE;


DECLARE @mergeError int,
		@mergeCount int

SELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNT
IF @mergeError != 0
	BEGIN
		PRINT 'ERROR OCCURRED IN MERGE FOR [dbo].[MyTable2]. Rows affected: ' + CAST(@mergeCount AS VARCHAR(100));
	END
ELSE
	BEGIN
		PRINT '[dbo].[MyTable2] rows affected by MERGE: ' + CAST(@mergeCount AS VARCHAR(100));
	END

DROP TABLE #MyTable2