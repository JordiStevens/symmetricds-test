# SymmetricDS test
This project is for testing out SymmetricDs and looking at any problems that I encounter.

## My situation:
1. 50+ different environments that run MainApp which will have their own SecondApp and database with a SymmetricDS instance
2. New features will often be created in MainApp and SecondApp. SecondApp will probably need data from MainApp that it didn't need before.
3. SecondApp will only have the minimal needed data that are available in MainApp. So a MainApp table can contain 10 columns but SecondApp only 5.

## My problem:
When I want to add a new column in SecondApp that already exists in MainApp, it won't synchronize the existing data.

### MainApp test_table
| id  | data1 | data2 | data3 |
| ----|-------|-------|-------|
| 1   | 1     | 2     | 3     |
| 2   | 4     | 5     | 6     |
| 3   | 7     | 8     | 9     |

### SecondApp test_table
| id  | data1 |
| ----|-------|
| 1   | 1     |
| 2   | 4     |
| 3   | 7     |


### SecondApp new test_table
| id  | data1 | data2 |
| ----|-------|-------|
| 1   | 1     | NULL  |
| 2   | 4     | NULL  |
| 3   | 7     | NULL  |

### Table Reload Request
I see that I can insert a table reload request like so:
```sql
insert into sym_table_reload_request
(target_node_id, source_node_id, trigger_id, router_id, delete_first, create_time, last_update_time)
values ('001','000','trigger-test-table',
        'source-2-target', 0,current_timestamp, current_timestamp);
```
This activates a reload of the data which includes the missing column data.</br>
This is the incoming batch that I see in the tmp folder, but the rows are not updated with data2 column.<br>


```text
nodeid,000
binary,BASE64
channel,reload
batch,27
catalog,
schema,
table,test_table
keys,id
columns,id,data1,data2,data3
insert,1,1,2,3
insert,2,4,5,6
insert,3,7,8,9
commit,27
```
I expect this is because the triggers are no longer correct. In the sym_trigger_hist table I see that it specifically looks at the columns id and data1.

| trigger_id | source_table_name | table_hash | column_names |
|------------|-------------------|------------|-----------|
| trigger-test-table | test_table  | 828828295 | id,data1  |

However, when I run this command in the SymmetricDS docker it creates the new triggers but another reload request still doesn't work.
```shell
../opt/symmetric-ds/bin/symadmin sync-triggers --engine "postgres-001"
```

## What works
The only way I found to make the table reload work is restarting the SymmetricDS docker instance before inserting the reload request.</br>
This is not ideal because it requires a lot of manual work when updating our applications.</br>
The flow looks like this:
1. Create a liquibase changelog to add a column
2. Start the application to run the liquibase migration
3. Restart SymmetricDS
4. Insert a table reload request


## What I would like

1. Create a liquibase changelog to add a column.
2. Add something to the changelog in order to recreate the triggers for the changed table
3. Add the table reload request insert query to the changelog
4. Start the application to run the liquibase migration


## Steps to reproduce
1. Git checkout the repo
2. Run the compose.yml or use the Full Compose run configuration
3. Wait for all to start and SymmetricDS to sync the test_table
4. Connect to the SecondApp database on jdbc:postgresql://localhost:5434/SECOND_DATABASE
5. Look at test_table data
6. Go to SecondApp/src/main/resources/db/changelog/db.changelog-master.yaml and uncomment 18-02-changelog.xml
7. Run only the second-app compose or use the Compose Second App run configuration
8. Liquibase will add the new column and insert a record in sym_table_reload_request
9. Check test_table again and see that the column data2 is still null.