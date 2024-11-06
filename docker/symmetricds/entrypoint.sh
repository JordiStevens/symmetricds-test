cd ../opt/symmetric-ds/ || exit

# Create sym tables & add initial routing
./bin/symadmin --engine "mysql-000" create-sym-tables
./bin/dbimport --engine "mysql-000" "sync-rules.sql"

# Add some seed data
#./bin/dbfill -e mysql-000 eq_users --count 50

# Start SymmetricDS
echo "Starting SymmetricDS..."
exec "./bin/sym"