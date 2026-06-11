Run SQL command to update versioning
This is a little hidden step that I think trips a lot of people up.  We automate the installation of code through our devops platform of choice (e.g., Azure Devops).  As part of this setup, we always introduce assembly versioning, so each new version of the application gets an automatically assigned and incrementing version number.  These version numbers get stored within Epi’s database, and Epi will avoid updating ContentTypes which have a lower version than those found within the database.  To correct this, set the version back to 1.0.0.0 (or whatever is in your local AssemblyInfo.cs file).  Here’s the SQL script to do it (replace MySite and x.y.z.0 accordingly):

UPDATE [episerver.mysite].[dbo].[tblContentType] 
SET
  ModelType = REPLACE(ModelType, 'x.y.z.0', '1.0.0.0'),
  Version = '1.0.0.0'
WHERE ModelType like '%MySite%'

To see what version content types have
SELECT * FROM [tblContentType]

UPDATE [dbo].[tblContentType]
SET [ModelType] = REPLACE(ModelType, ', Version=2026.4.13.1,', ', Version=2023.1.0,')
WHERE ModelType like '%, Version=2026.4.13.1,%' 

UPDATE [dbo].[tblContentType]
SET [ModelType] = REPLACE(ModelType, ', Version=2026.6.1.1,', ', Version=2023.1.0,')
WHERE ModelType like '%, Version=2026.6.1.1,%' 
