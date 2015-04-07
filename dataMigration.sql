-- This function is for creating a blob in pg_largeobject table for supplied input
-- Given an input, it shall create a entry in aforementioned table and shall return
-- the OID.
CREATE OR REPLACE FUNCTION blob_write(bytea)
  RETURNS oid AS
$func$
DECLARE
   loid oid := lo_create(0);
   lfd  int := lo_open(loid,131072);
BEGIN
   PERFORM lowrite(lfd, $1);
   PERFORM lo_close(lfd);
   RETURN loid;
END
$func$  LANGUAGE plpgsql VOLATILE STRICT;

-- For migrating data in columns in tables that have column type as text
-- It shall look for tables provided in the input parameters array in information 
-- schema. And then shall loop over these columns. 
-- While looping, it shall add a temporary column to the table in context,
-- shall insert its data into pg_largeobject table, shall place oid value
-- into the temp column. And once its done with the data, it shall drop the
-- original column, and rename the temp column as original column
CREATE OR REPLACE FUNCTION migrateData(VARIADIC text[]) RETURNS VOID AS
$BODY$
DECLARE
    aRecord RECORD;
    bRecord RECORD;
    _tbl text;
    _col text;
    _col_tmp text;
    _oid int;
    _record_col text;
BEGIN
    RAISE INFO 'Starting migration for % tables',$1;
    
    FOR aRecord IN
	SELECT table_name,column_name FROM information_schema.columns 
		WHERE data_type='text' and table_name = ANY ($1)
    LOOP
	RAISE INFO 'Starting migration for table %  for column %',aRecord.table_name,aRecord.column_name;
	_tbl := aRecord.table_name;
	_col := aRecord.column_name;
	-- append _tmp to column name
	_col_tmp := _col || '_tmp';

	EXECUTE format('ALTER TABLE %I ADD COLUMN %I text',_tbl,_col_tmp);

	FOR bRecord IN
		EXECUTE format('SELECT * FROM %I',_tbl)
	LOOP
		_record_col := format('bRecord.%I',_col);
				
		EXECUTE 'SELECT blob_write(decode( $1,''escape''))' INTO _oid USING _record_col;

		--RAISE INFO 'GENERATED OID value is %', _oid;
		
		EXECUTE format('UPDATE %I SET %I = %s WHERE %I=%s' , _tbl, _col_tmp,_oid,_col,_col,_record_col);
	END LOOP;

	EXECUTE format('ALTER TABLE %I DROP COLUMN %I',_tbl,_col);
	EXECUTE format('ALTER TABLE %I RENAME %I TO %I',_tbl,_col_tmp,_col);
		
    END LOOP;

    RETURN;
END
$BODY$
LANGUAGE plpgsql;

-- KINDLY PROVIDE THE TABLE NAMES for which you want to do the upgrade.
SELECT migrateData('tablename1', 'tablename2');
