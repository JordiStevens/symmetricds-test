insert into sym_node_group
(node_group_id)
values ('symmetricsdsTest-target');

insert into sym_node_group_link
(source_node_group_id, target_node_group_id, data_event_action)
values ('symmetricsdsTest-source', 'symmetricsdsTest-target', 'W');

insert into sym_node_group_link
(source_node_group_id, target_node_group_id, data_event_action)
values ('symmetricsdsTest-target', 'symmetricsdsTest-source', 'P');

insert into sym_router (router_id,source_node_group_id, target_node_group_id, create_time,last_update_time)
values ('source-2-target','symmetricsdsTest-source', 'symmetricsdsTest-target',
        current_timestamp, current_timestamp);

insert into sym_router (router_id,source_node_group_id, target_node_group_id, create_time,last_update_time)
values ('target-2-source','symmetricsdsTest-target', 'symmetricsdsTest-source',
        current_timestamp, current_timestamp);

insert into sym_channel
(channel_id, processing_order, max_batch_size, enabled, description)
values('eq_users_channel', 1, 100000, 1, 'user data');

insert into sym_trigger
(trigger_id,source_table_name,channel_id,last_update_time,create_time, sync_on_incoming_batch )
values('user_trigger','eq_users','eq_users_channel',current_timestamp,current_timestamp, 1),
        ('user_trigger2','eq_account','eq_users_channel',current_timestamp,current_timestamp, 1),
        ('user_trigger3','eq_personal_info','eq_users_channel',current_timestamp,current_timestamp, 1);

insert into sym_trigger_router
(trigger_id,router_id,initial_load_order,last_update_time,create_time)
values('user_trigger','source-2-target', 100, current_timestamp, current_timestamp),
        ('user_trigger2','target-2-source', 100, current_timestamp, current_timestamp),
        ('user_trigger3','target-2-source', 100, current_timestamp, current_timestamp);

-- Sync users to account and personal info tables in the target node
insert into sym_transform_table (
    transform_id, source_node_group_id, target_node_group_id, transform_point, source_table_name,
    target_table_name, update_action, delete_action, transform_order, column_policy, update_first,
    last_update_by, last_update_time, create_time
) values (
             'userInfoTransform', 'symmetricsdsTest-source', 'symmetricsdsTest-target', 'LOAD', 'eq_users',
             'eq_account', 'UPD_ROW', 'DEL_ROW', 1, 'IMPLIED', 1,
             'Documentation', current_timestamp, current_timestamp
         ),
         (
             'personalUserInfoTransform', 'symmetricsdsTest-source', 'symmetricsdsTest-target', 'LOAD', 'eq_users',
             'eq_personal_info', 'UPD_ROW', 'DEL_ROW', 2, 'IMPLIED', 1,
             'Documentation', current_timestamp, current_timestamp
         );

insert into sym_transform_column (
    transform_id, include_on, target_column_name, source_column_name, pk,
    transform_type, transform_expression, transform_order, last_update_time,
    last_update_by, create_time
) values ('userInfoTransform', '*', 'id', 'GUID', 1,'copy', '', 1, current_timestamp, 'Documentation', current_timestamp),
         ('personalUserInfoTransform', '*', 'id', 'GUID', 1,'copy', '', 2, current_timestamp, 'Documentation',current_timestamp);

-- Sync account & personal info table to users table in the source node
insert into sym_transform_table (
    transform_id, source_node_group_id, target_node_group_id, transform_point, source_table_name,
    target_table_name, update_action, delete_action, transform_order, column_policy, update_first,
    last_update_by, last_update_time, create_time
) values (
             'userInfoTransform2','symmetricsdsTest-target', 'symmetricsdsTest-source', 'EXTRACT',
             'eq_account', 'eq_users', 'UPD_ROW', 'DEL_ROW', 1, 'IMPLIED', 1,
             'Documentation', current_timestamp, current_timestamp
         ),
         (
             'personalUserInfoTransform2', 'symmetricsdsTest-target', 'symmetricsdsTest-source', 'EXTRACT',
             'eq_personal_info','eq_users', 'UPD_ROW', 'DEL_ROW', 2, 'IMPLIED', 1,
             'Documentation', current_timestamp, current_timestamp
         );

insert into sym_transform_column (
    transform_id, include_on, target_column_name, source_column_name, pk,
    transform_type, transform_expression, transform_order, last_update_time,
    last_update_by, create_time
) values ('userInfoTransform2', '*', 'GUID', 'id', 1,'copy', '', 1, current_timestamp, 'Documentation', current_timestamp),
         ('personalUserInfoTransform2', '*', 'GUID', 'id', 1,'copy', '', 1, current_timestamp, 'Documentation',current_timestamp);




