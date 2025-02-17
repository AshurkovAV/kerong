-- PRINT CHAR(10) + '<<Inserting base data into DB (kerong)>>' + CHAR(10);

-- PRINT CHAR(10) + 'data:' + CHAR(10) + CHAR(9) + 'bu_board';
INSERT INTO
    kerong.dbo.bu_board
    (name,description,ip,port,boardType,zone_active,model)
VALUES
    ('Зона 1', 'Плата 1',      N'192.168.0.178', 5000, 'CU_48', 1, 'BU'),
    ('Зона 2', 'Плата 1',      N'192.168.0.179', 5000, 'CU_48', 1, 'BU'),
    ('Зона 3', 'Плата 1',      N'192.168.0.180', 5000, 'CU_48', 1, 'BU'),
    ('Зона 4', 'Плата 1',      N'192.168.0.181', 5000, 'CU_48', 1, 'BU'),
    ('Зона 5', 'Плата 1',      N'192.168.0.182', 5000, 'CU_48', 1, 'BU'),
    ('Зона 6', 'Плата 1',      N'192.168.0.183', 5000, 'CU_48', 1, 'BU')
;

-- PRINT CHAR(10) + 'data:' + CHAR(10) + CHAR(9) + 'cu_board';
INSERT INTO
    kerong.dbo.cu_board
    (chainNumber,name,description,boardType,bu_board_id)
VALUES
    (1, 'Плата 1', N'Плата 1 в СПА', 'CU_48', 1),
    (2, 'Плата 2', N'Плата 2 в СПА', 'CU_48', 1),
    (1, 'Плата 1', N'Плата 1 в общем холе', 'CU_48', 2),
    (2, 'Плата 2', N'Плата 2 в общем холе', 'CU_48', 2)    
;

-- PRINT CHAR(10) + 'data:' + CHAR(10) + CHAR(9) + 'zone';
INSERT INTO
    kerong.dbo.zone
    (name,description,zone_active,start_locks_number_index,locks_count)
VALUES
    ('СПА',  'Зона СПА Бани', 1, 1,48),
	('СПА1', 'Зона СПА Бани1',1, 1,48);
	
	
	-- PRINT CHAR(10) + 'data:' + CHAR(10) + CHAR(9) + 'client';
INSERT INTO
    kerong.dbo.client
    (first_name,last_name,middle_name,birthday,sex,phoneNumber)
VALUES
    ('Ашурков', 'Алексей',  'Васильевич', '19860729', 'MAN', '90812090023'),
	('Пузанов', 'Вячеслав', 'Михайлович', '19860729', 'MAN', '90812090023');
