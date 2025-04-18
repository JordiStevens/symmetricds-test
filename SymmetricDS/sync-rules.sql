insert into sym_node_group_link
(source_node_group_id, target_node_group_id, data_event_action)
values ('symmetricdsTest-source', 'symmetricdsTest-target', 'W'),
       ('symmetricdsTest-target', 'symmetricdsTest-source', 'P') ON CONFLICT DO NOTHING;

insert into sym_router (router_id, source_node_group_id, target_node_group_id, create_time, last_update_time)
values ('source-2-target', 'symmetricdsTest-source', 'symmetricdsTest-target',
        current_timestamp, current_timestamp),
       ('target-2-source', 'symmetricdsTest-target', 'symmetricdsTest-source',
        current_timestamp, current_timestamp) ON CONFLICT DO NOTHING;

insert into sym_channel
(channel_id, processing_order, max_batch_size, enabled, description)
values ('extra_channel', 2, 100000, 1, 'extra data'),
       ('general_channel', 1, 100000, 1, 'General data') ON CONFLICT DO NOTHING;


insert into sym_trigger
(trigger_id, source_table_name, channel_id, last_update_time, create_time, sync_on_incoming_batch)
values ('trigger-test-table', 'test_table', 'extra_channel', current_timestamp, current_timestamp, 1) ON CONFLICT DO NOTHING;

insert into sym_trigger_router
(trigger_id, router_id, initial_load_order, last_update_time, create_time)
values ('trigger-test-table', 'source-2-target', 100, current_timestamp, current_timestamp),
       ('trigger-test-table', 'target-2-source', 100, current_timestamp, current_timestamp) ON CONFLICT DO NOTHING;

