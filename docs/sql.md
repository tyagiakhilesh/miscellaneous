# MSSQL 

### Finding number of different types of objects in your database
```
SELECT 
    CASE TYPE 
        WHEN 'U' 
            THEN 'User Defined Tables' 
        WHEN 'S'
            THEN 'System Tables'
        WHEN 'IT'
            THEN 'Internal Tables'
        WHEN 'P'
            THEN 'Stored Procedures'
        WHEN 'PC'
            THEN 'CLR Stored Procedures'
        WHEN 'X'
            THEN 'Extended Stored Procedures'
    END, 
    COUNT(*)     
FROM SYS.OBJECTS
WHERE TYPE IN ('U', 'P', 'PC', 'S', 'IT', 'X')
GROUP BY TYPE
```

### Find all procedures/tables
```
select count(*) as TablesCount from sys.tables
select count(*) as ProceduresCount from sys.procedures
```

# References
## [object counts](http://stackoverflow.com/questions/19314370/how-to-count-total-number-of-stored-procedure-and-tables-in-sql-server-2008)
