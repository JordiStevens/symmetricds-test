cd ../opt/symmetric-ds/ || exit

# Create sym tables & add initial routing
./bin/symadmin --engine "mysql-000" create-sym-tables
#./bin/symadmin --engine "postgres-001" create-sym-tables
./bin/dbimport --engine "mysql-000" "initial_routing.sql"
#
##echo "Opening registration for postgres-001..."
#./bin/symadmin --engine "mysql-000" open-registration "symmetricsdsTest-001" "symmetricsdsTest-001"
##echo "Setting up initial load for postgres-001..."
#./bin/symadmin --engine "mysql-000" reload-node "postgres-001"

# Start SymmetricDS
echo "Starting SymmetricDS..."
exec "./bin/sym"