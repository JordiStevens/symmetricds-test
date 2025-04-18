FROM jumpmind/symmetricds:3.15.12

RUN apk add --no-cache bash gettext

COPY --chown=dev:dev engines /opt/symmetric-ds/engines/
COPY  --chown=dev:dev entrypoint.sh /app/

RUN chmod -R 770 /app && \
    chmod +x /app/entrypoint.sh

COPY --chown=dev:dev ./sync-rules.sql /opt/symmetric-ds/sync-rules.sql
CMD ["bash", "/app/entrypoint.sh"]