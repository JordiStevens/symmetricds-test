import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.UUID;

public class Main {

    public static void main(String[] args) {
        //insertPosgres();
        insertMySQL();
    }

    private static void insertMySQL() {
        Thread mysqlThread = Thread.startVirtualThread(() -> {
            System.out.println("Running MySQL Inserts in a virtual thread: "
                    + Thread.currentThread().getName());
            insertNRecords(new MySQLConnector(), "eq_users", 500, "mysql");
        });

        try {
            mysqlThread.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    private static void insertPosgres() {
        Thread postgresThread = Thread.startVirtualThread(() -> {
            System.out.println("Running Postgres Inserts in a virtual thread: "
                    + Thread.currentThread().getName());
            insertNRecords(new PostgresConnector(), "eq_account", 10000, "postgres");
        });

        try {
            postgresThread.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    private static void insertNRecords(CustomConnector connector, String table, int amount, String prefix) {
        try(Statement statement = connector.createStatement()) {
            for(int i = 0; i < amount; i++) {
                String name = prefix + "-" + i + "-" + UUID.randomUUID();
                StringBuilder sql = new StringBuilder("INSERT INTO " + table + " (login, email) values(");
                sql.append('\'').append(name).append('\'');
                sql.append(",");
                sql.append('\'').append(name).append("@test.com'");
                sql.append(")");
                //statement.execute(sql.toString());
                statement.addBatch(sql.toString());
                if(i % 1000 == 0) {
                    System.out.println("Executing Batch on I: " + i);
                    statement.executeBatch();
                }
            }
            System.out.println("Executing final Batch");
            statement.executeBatch();
        } catch (Exception e) {
            System.out.println("error: " + e.getMessage());
        }
    }


}
