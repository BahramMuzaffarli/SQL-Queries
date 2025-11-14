-- PROCEDURE: public.backup_table(text, date, text)

-- DROP PROCEDURE IF EXISTS public.backup_table(text, date, text);

CREATE OR REPLACE PROCEDURE public.backup_table(
	IN table_name text,
	IN cutoff_date date,
	IN date_column text)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    backup_table_name TEXT;
    record_count_backup BIGINT;
    record_count_delete BIGINT;
BEGIN
    -- Generate the backup table name dynamically
    backup_table_name := table_name || '_' || TO_CHAR(cutoff_date, 'YYMMDD');

    -- Use a subtransaction block to handle exceptions
    BEGIN
        -- Create the backup table
        EXECUTE format('CREATE TABLE %I AS SELECT * FROM %I', backup_table_name, table_name);

        -- Count records in the backup table
        EXECUTE format('SELECT COUNT(*) FROM %I', backup_table_name) INTO record_count_backup;
        RAISE NOTICE 'Backup table % created with % records.', backup_table_name, record_count_backup;

        -- Count records to delete from the original table dynamically
        EXECUTE format('SELECT COUNT(*) FROM %I WHERE %I < $1', table_name, date_column) 
        INTO record_count_delete USING cutoff_date;
        
        RAISE NOTICE 'Number of records to be deleted from %: %', table_name, record_count_delete;

        -- Delete old records from the original table dynamically
        EXECUTE format('DELETE FROM %I WHERE %I < $1', table_name, date_column) 
        USING cutoff_date;

        RAISE NOTICE 'Old records deleted from % successfully.', table_name;

    EXCEPTION
        WHEN OTHERS THEN
            -- Propagate the exception to roll back the entire transaction
            RAISE EXCEPTION 'An error occurred: %. Rolling back changes.', SQLERRM;
    END;
END;
$BODY$;
ALTER PROCEDURE public.backup_table(text, date, text)
    OWNER TO postgres;

---Run etmek
CALL backup_table(
    table_name := 'CallLogs',
    date_column := 'Date',
    cutoff_date := '2025-11-14'
);

