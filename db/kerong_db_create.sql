PRINT CHAR(10) + '<<Reset DB (kerong)>>'

USE master;

PRINT 'Drop DB: kerong'

-- DROP DATABASE IF EXISTS kerong
PRINT 'Create DB: kerong'
-- CREATE DATABASE kerong
;

DECLARE @base_version   nvarchar(32)   = N'2025020900'
DECLARE @result_version nvarchar(32)   = N'2025020900'
DECLARE @src            nvarchar(32)   = N'VENDOR'    /* Источник */
DECLARE @author         nvarchar(32)   = N'Developer' /* Автор */
DECLARE @dst            nvarchar(32)   = N'ANY'       /* Для всех клиентов */
DECLARE @description    nvarchar(1024) = N'Создание таблиц с данными о текущей версии базы данных и обновлениях. Базовые данные из структуры'

PRINT 'Update version: [' + @result_version + ']'

SET NOCOUNT OFF

BEGIN TRANSACTION

        -- PRINT 'Create table: ' + CHAR(10) + CHAR(9) + 'kerong'
	if OBJECT_ID('kerong.dbo.product_version') is not null drop table kerong.dbo.product_version
    CREATE TABLE kerong.dbo.product_version
        (
            entity_code             nvarchar(255)   NOT NULL,
            current_version         nvarchar(255)   NOT NULL,
            
			/*service fields*/
            active                  bit             NOT NULL DEFAULT 1,
            created_at              datetime        NOT NULL DEFAULT getdate(),
            created_by              nvarchar(64)    NOT NULL DEFAULT 'system',
            updated_at              datetime        NOT NULL DEFAULT getdate(),
            updated_by              nvarchar(64)    NOT NULL DEFAULT 'system'
        ) ON [PRIMARY]

    ALTER TABLE kerong.dbo.product_version  ADD CONSTRAINT uq__product_version   UNIQUE (entity_code, current_version)
     
     INSERT INTO kerong.dbo.product_version
        (entity_code, current_version)
    VALUES
        ('ALS',  @base_version)
    
    /**/
    -- PRINT 'Create table: ' + CHAR(10) + CHAR(9) + 'updates'
	if OBJECT_ID('kerong.dbo.updates') is not null drop table kerong.dbo.updates
    CREATE TABLE kerong.dbo.updates
        (
            id                      int IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
            src                     nvarchar(255)   NOT NULL,
            author                  nvarchar(255)   NOT NULL,
            dst                     nvarchar(255)   NOT NULL,
            [description]           nvarchar(1024)  NOT NULL,
            base_version            nvarchar(32)    NOT NULL,
            result_version          nvarchar(32)    NOT NULL,
            result_status           nvarchar(12)    NOT NULL CHECK (result_status IN ('UP', 'DOWN')),
           
		   /*service fields*/
            active                  bit             NOT NULL DEFAULT 1,
            created_at              datetime        NOT NULL DEFAULT getdate(),
            created_by              nvarchar(64)    NOT NULL DEFAULT 'system',
            updated_at              datetime        NOT NULL DEFAULT getdate(),
            updated_by              nvarchar(64)    NOT NULL DEFAULT 'system'
        ) ON [PRIMARY]

    ALTER TABLE kerong.dbo.updates    ADD CONSTRAINT pk__updates    PRIMARY KEY (id)
    ALTER TABLE kerong.dbo.updates    ADD CONSTRAINT uq__updates    UNIQUE (dst, result_version, result_status)

    INSERT INTO
        kerong.dbo.updates
        (src, author, dst, [description], base_version, result_version, result_status)
    VALUES
        (@src, @author, @dst, @description,  @base_version, @result_version, 'UP')

COMMIT TRANSACTION

SET NOCOUNT ON

;
