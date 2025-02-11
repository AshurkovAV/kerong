-- PRINT CHAR(10) + '<<Inserting base data into DB (kerong)>>' + CHAR(10);

-- PRINT CHAR(10) + 'data:' + CHAR(10) + CHAR(9) + 'catalog_board_type';
INSERT INTO
    kerong.dbo.catalog_board_type
    ([id],[r_type_char],[r_name])
VALUES
    (1,   'CU_16'),
    (2,   'CU_48'),
    (3,   'CU_48b'),
    (4,   'SCU')    
;