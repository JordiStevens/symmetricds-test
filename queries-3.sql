-- Execute on SecondApp database
insert into sym_table_reload_request
(target_node_id, source_node_id, trigger_id, router_id, delete_first, create_time, last_update_time)
values ('001','000','trigger-test-table',
        'source-2-target', 0,current_timestamp, current_timestamp);