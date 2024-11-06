FROM jumpmind/symmetricds:latest

COPY engines/ /opt/symmetric-ds/engines/
COPY entrypoint.sh /app/
#COPY sync-rules/two-way-sync-one-table.sql /opt/symmetric-ds/sync-rules.sql
#COPY sync-rules/one-way-sync-transform-table.sql /opt/symmetric-ds/sync-rules.sql
COPY sync-rules/two-way-sync-transform-table.sql /opt/symmetric-ds/sync-rules.sql
CMD ["./entrypoint.sh"]