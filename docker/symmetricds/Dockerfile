FROM jumpmind/symmetricds:latest

COPY engines/ /opt/symmetric-ds/engines/
COPY entrypoint.sh /app/
COPY initial_routing.sql /opt/symmetric-ds/
CMD ["./entrypoint.sh"]