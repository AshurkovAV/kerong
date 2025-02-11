PRINT CHAR(10) + '<<Drop constraints in DB (kerong)>>'

USE kerong

DECLARE @sSql            NVARCHAR(4000) SET @sSql = ''
DECLARE @sTypeDesc       sysname        SET @sTypeDesc = ''
DECLARE @sTableName      sysname        SET @sTableName = ''
DECLARE @sConstraintName sysname        SET @sConstraintName = ''

DECLARE cur CURSOR DYNAMIC FOR
   SELECT name,
          type_desc,
          OBJECT_NAME(parent_object_id)
     FROM sys.objects
    WHERE is_ms_shipped = 0
      AND type_desc LIKE '%_CONSTRAINT'
    ORDER BY type_desc, name

WHILE 1 = 1
BEGIN
   OPEN cur   
   FETCH FIRST FROM cur INTO @sConstraintName, @sTypeDesc, @sTableName

   IF @@FETCH_STATUS != 0
   BEGIN
      CLOSE cur
      BREAK
   END

   WHILE @@FETCH_STATUS = 0
   BEGIN
      BEGIN TRY
         SET @sSql = 'ALTER TABLE ' + QUOTENAME(@sTableName) + ' DROP CONSTRAINT ' + QUOTENAME(@sConstraintName)
         RAISERROR('%s', 10, 1, @sSql) WITH NOWAIT   
         EXEC sp_executesql @sSql
      END TRY
      BEGIN CATCH
         DECLARE @ENumber      INT            SET @ENumber      = ISNULL(ERROR_NUMBER(),          -1)
         DECLARE @ESeverity    INT            SET @ESeverity    = ISNULL(ERROR_SEVERITY(),        -1)
         DECLARE @EState       INT            SET @EState       = ISNULL(ERROR_STATE(),            0) IF @EState = 0 SET @EState = 42
         DECLARE @EProcedure   NVARCHAR(126)  SET @EProcedure   = ISNULL(ERROR_PROCEDURE(), N'{N/A}')
         DECLARE @ELine        INT            SET @ELine        = ISNULL(ERROR_LINE(),            -1)
         DECLARE @EMessageRecv NVARCHAR(2048) SET @EMessageRecv = ISNULL(ERROR_MESSAGE(),        N'')
         DECLARE @EMessageSent NVARCHAR(440)  SET @EMessageSent = N''

         IF ERROR_PROCEDURE() IS NOT NULL   SET @EMessageSent = N'Error %d, Level %d, State %d, Procedure %s, Line %d, Message: '
         SET @EMessageSent = @EMessageSent + ERROR_MESSAGE()
         RAISERROR(@EMessageSent, 10 /* @ESeverity */ , @EState, @ENumber, @ESeverity, @EState, @EProcedure, @ELine) WITH LOG
      END CATCH

      FETCH NEXT FROM cur INTO @sConstraintName, @sTypeDesc, @sTableName
   END

   CLOSE cur
END

DEALLOCATE cur
;