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
(trigger_id,source_table_name,channel_id,last_update_time,create_time)
values('user_trigger','eq_users','eq_users_channel',current_timestamp,current_timestamp);

insert into sym_trigger_router
(trigger_id,router_id,initial_load_order,last_update_time,create_time)
values('user_trigger','source-2-target', 100, current_timestamp, current_timestamp);

insert into sym_trigger_router
(trigger_id,router_id,initial_load_order,last_update_time,create_time)
values('user_trigger','target-2-source', 100, current_timestamp, current_timestamp);

insert into sym_table_reload_request (target_node_id, source_node_id, trigger_id, router_id, create_time, last_update_time)
values ('symmetricsdsTest-target', 'symmetricsdsTest-source', 'user_trigger', 'source-2-target', current_timestamp, current_timestamp);