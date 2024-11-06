import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public interface CustomConnector {

    Connection getConnection() throws SQLException;

    Statement createStatement() throws SQLException;
    void executeQuery(String sql);
}
