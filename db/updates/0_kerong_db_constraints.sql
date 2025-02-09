DECLARE @build_version nvarchar(32) = '1.0.0'
-- PRINT 'Create base structure. Version: ' + @build_version;

SET NOCOUNT OFF

BEGIN TRANSACTION

-- /db/struct/
   		    ALTER TABLE kerong.dbo.bu_board ADD CONSTRAINT pk__bu_board PRIMARY KEY (id) 
			ALTER TABLE kerong.dbo.zone     ADD CONSTRAINT pk__zone PRIMARY KEY (id)
			ALTER TABLE kerong.dbo.client     ADD CONSTRAINT pk__client PRIMARY KEY (id)			
     
       
COMMIT TRANSACTION

SET NOCOUNT ON

;
