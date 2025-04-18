#!/bin/bash
echo "entered entrypoint.sh and chaning directory to symmetric-ds"
cd ../opt/symmetric-ds/ || exit

# Create sym tables & add initial routing
./bin/symadmin --engine "postgres-000" create-sym-tables
./bin/symadmin --engine "postgres-001" create-sym-tables
./bin/symadmin open-registration --engine "postgres-000" 'symmetricdsTest-target' 001
./bin/dbimport --engine "postgres-000" "sync-rules.sql"
#./bin/symadmin --engine "postgres-000" reload-node 001

# Start SymmetricDS
echo "Starting SymmetricDS..."
exec "./bin/sym"