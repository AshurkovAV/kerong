if OBJECT_ID('kerong.dbo.bu_board') is not null drop table kerong.dbo.bu_board

CREATE TABLE kerong.dbo.bu_board (
	        id                  int			    IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
			uuid                nvarchar(36)  	NOT NULL DEFAULT newid(),
			name			    nvarchar(255)	NOT NULL DEFAULT 'Зона',
			description  	    nvarchar(255)	NOT NULL DEFAULT 'Плата',
			ip   				nvarchar(36)	NULL,
			port                int             NULL,
			boardType			nvarchar(100) 	NOT NULL CHECK (boardType IN ('CU_16', 'CU_48', 'CU_48b', 'SCU')),--ТипKR-CUплаты интеграции
			zone_active			bit				NOT NULL DEFAULT 1,
			model				nvarchar(255)	NULL,--Тип BU платы
			
			/*service fields*/
			active				bit				NOT NULL DEFAULT 1,
			created_at			datetime		NOT NULL DEFAULT getdate(),
			created_by			nvarchar(64)	NOT NULL DEFAULT 'system',
			updated_at			datetime		NOT NULL DEFAULT getdate(),
			updated_by			nvarchar(64)	NOT NULL DEFAULT 'system'
	
);

if OBJECT_ID('kerong.dbo.zone') is not null drop table kerong.dbo.zone
CREATE TABLE kerong.dbo.zone (
	        id                          int				IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,			
			name			            nvarchar(255)	NOT NULL DEFAULT 'Зона', --Наименование зоны. Указывается любое наименование состоящее из букви/ илицифр
			description  	            nvarchar(255)	NOT NULL DEFAULT 'Плата',
			zone_active			        bit				NOT NULL DEFAULT 1,
			start_locks_number_index	int         	NULL,--Начало нумерации замков
			locks_count					int				NULL, -- Количество замков
			locks_set					int 			NULL, --Массив объектов наборов замков ссылка на таблицу locks_set
			access_mode					nvarchar(100) 	NOT NULL CHECK (access_mode IN ('PUBLIC', 'PRIVATE', 'CORPORATE')) DEFAULT 'PUBLIC',--Тип аренды
			
			/*service fields*/
			active				        bit				NOT NULL DEFAULT 1,
			created_at			        datetime		NOT NULL DEFAULT getdate(),
			created_by			        nvarchar(64)	NOT NULL DEFAULT 'system',
			updated_at			        datetime		NOT NULL DEFAULT getdate(),
			updated_by			        nvarchar(64)	NOT NULL DEFAULT 'system'
	
);


if OBJECT_ID('kerong.dbo.client') is not null drop table kerong.dbo.client
CREATE TABLE kerong.dbo.client (
	        id                          int				IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,			
			first_name			        nvarchar(255)	NOT NULL DEFAULT 'Фамилия',
			last_name  	            	nvarchar(255)	NOT NULL DEFAULT 'Имя',
			middle_name 	           	nvarchar(255)	NOT NULL DEFAULT 'Отчество',
			birthday 	            	datetime    	NULL,
			sex			       			nvarchar(5)		NOT NULL CHECK (sex IN ('MAN', 'WOMAN')),			
			phoneNumber					nvarchar(100) 	NOT NULL,--
			client_active			    bit				NOT NULL DEFAULT 1,
			
			/*service fields*/
			active				        bit				NOT NULL DEFAULT 1,
			created_at			        datetime		NOT NULL DEFAULT getdate(),
			created_by			        nvarchar(64)	NOT NULL DEFAULT 'system',
			updated_at			        datetime		NOT NULL DEFAULT getdate(),
			updated_by			        nvarchar(64)	NOT NULL DEFAULT 'system'
	
);