Create database Examination
on (
Name = 'Primary',
FileName = 'E:\sql\MSSQL15.MSSQLSERVER\MSSQL\Data\Primary.mdf',
Size = 6MB,
MaxSize = 64MB,
FileGrowth = 2MB
),
filegroup [Secondary]
(
    name = 'Secondary',
    filename = 'E:\sql\MSSQL15.MSSQLSERVER\MSSQL\Data\Secondary.ndf',
    size = 6MB,
    filegrowth = 2MB,
    maxsize = 64MB
)
log on
(
    name = 'Log',
    filename = 'E:\sql\MSSQL15.MSSQLSERVER\MSSQL\Data\Log.ldf',
    size = 6MB,
    maxsize = 64MB,
    filegrowth = 2MB
);
