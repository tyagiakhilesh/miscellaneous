DROP FUNCTION IF EXISTS blob_write(bytea);
DROP FUNCTION IF EXISTS migratedata(text[]);

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
CREATE OR REPLACE FUNCTION migratedata(VARIADIC text[]) RETURNS VOID AS
$BODY$
DECLARE
    arecord RECORD;
    brecord RECORD;
    _tbl text;
    _col text;
    _col_tmp text;
    _oid int;
    _record_col text;
    _update_query text;
    _value_json json;
BEGIN

    RAISE INFO '';
    RAISE INFO '';
    RAISE INFO 'Dropping aun_language_type table as its structure has been changed. Don''t worry, its shall not harm you';
    
    DROP TABLE IF EXISTS aun_language_type;

    RAISE INFO 'Drop complete.';

    RAISE INFO '';
    RAISE INFO '';
    RAISE INFO 'Starting migration for % tables',$1;
    
    FOR arecord IN
	SELECT table_name,column_name FROM information_schema.columns 
		WHERE data_type='text' and table_name = ANY ($1)
    LOOP
	RAISE INFO 'Starting migration for table %  for column %',arecord.table_name,arecord.column_name;
	_tbl := arecord.table_name;
	_col := arecord.column_name;
	-- append _tmp to column name
	_col_tmp := _col || '_tmp';

	EXECUTE format('ALTER TABLE %I ADD COLUMN %I text',_tbl,_col_tmp);

	FOR brecord IN
		EXECUTE format('SELECT * FROM %I',_tbl)
	LOOP
		-- extract the columns into the json
		_value_json = row_to_json(brecord);
		--RAISE INFO 'json is %', _value_json;
		_record_col = format('%L',_value_json->>_col);

		RAISE INFO 'Value going to be replaced is %', _record_col;

		EXECUTE 'SELECT blob_write(decode( $1,''escape''))' INTO _oid USING _record_col;

		RAISE INFO 'GENERATED OID is % for text %', _oid, _record_col;
		
		_update_query := format('UPDATE %I SET %I = %s WHERE %I=%s' , _tbl, _col_tmp,_oid,_col,_record_col);

		RAISE INFO 'Update Query is %',_update_query;
		
		EXECUTE _update_query;
		
	END LOOP;

	EXECUTE format('ALTER TABLE %I DROP COLUMN %I',_tbl,_col);
	EXECUTE format('ALTER TABLE %I RENAME %I TO %I',_tbl,_col_tmp,_col);
		
    END LOOP;

    RETURN;
END
$BODY$
LANGUAGE plpgsql;
-- provide tables names as below
SELECT migratedata('tablename1', 'tablename2');
