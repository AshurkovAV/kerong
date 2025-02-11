DECLARE @build_version nvarchar(32) = '1.0.0'
-- PRINT 'Create base structure. Version: ' + @build_version;

SET NOCOUNT OFF

BEGIN TRANSACTION

/*CREATE tables*/

/*catalogs*/

	/**/
	-- PRINT 'Create table: ' + CHAR(10) + CHAR(9) + 'catalog_board_type'
	if OBJECT_ID('kerong.dbo.catalog_board_type') is not null drop table kerong.dbo.catalog_board_type
	CREATE TABLE kerong.dbo.catalog_board_type
		(
			id                  int			    NOT NULL,
			r_type_char         nvarchar(12)  	NOT NULL CHECK (r_type_char IN ('CU_16', 'CU_48', 'CU_48b', 'SCU')),
			r_name			    nvarchar(255)	NOT NULL DEFAULT '',
			
			/*service fields*/
			active				bit				NOT NULL DEFAULT 1,
			created_at			datetime		NOT NULL DEFAULT getdate(),
			created_by			nvarchar(64)	NOT NULL DEFAULT 'system',
			updated_at			datetime		NOT NULL DEFAULT getdate(),
			updated_by			nvarchar(64)	NOT NULL DEFAULT 'system'
		) ON [PRIMARY]

   

COMMIT TRANSACTION

SET NOCOUNT ON

;
