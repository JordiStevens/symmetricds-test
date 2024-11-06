import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class PostgresConnector implements CustomConnector {

    private final String host = "localhost";
    private final int port = 5433;
    private final String dbName = "target";
    private final String user = "target";
    private final String password = "target";


    public Connection getConnection() throws SQLException {
        String url = "jdbc:postgresql://%s:%d/%s".formatted(host, port, dbName);
        Properties props = new Properties();
        props.setProperty("user", user);
        props.setProperty("password", password);
        props.setProperty("ssl", "false");
        return DriverManager.getConnection(url, props);
    }

    @Override
    public Statement createStatement() throws SQLException {
        return getConnection().createStatement();
    }

    public void executeQuery(String sql) {
        try{
            Connection connection = getConnection();
            Statement stmt=connection.createStatement();
            stmt.execute(sql);
            connection.close();
        }catch(Exception e){
            System.out.println(e);
        }
    }
}
