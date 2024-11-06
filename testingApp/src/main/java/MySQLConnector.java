import java.sql.*;
import java.util.Properties;

public class MySQLConnector implements CustomConnector {

    private final String host = "localhost";
    private final int port = 3308;
    private final String dbName = "source";
    private final String user = "root";
    private final String password = "source";


    public Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://%s:%d/%s".formatted(host, port, dbName);
        Properties props = new Properties();
        props.setProperty("user", user);
        props.setProperty("password", password);
        props.setProperty("ssl", "false");
        return DriverManager.getConnection(url, props);
    }

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
            System.out.println("MYSQL ERROR");
            System.out.println(e);
        }
    }


}
