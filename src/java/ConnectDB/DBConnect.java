package ConnectDB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Database connection utility class.
 */
public class DBConnect {

    // Method to establish a connection
    public static Connection getConnection() throws SQLException {
        Connection connection = null;

        try {
            // Register JDBC driver for SQL Server
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            // Connection string, username, and password
            String url = "jdbc:sqlserver://localhost:1433;databaseName=PetiqueSpa;encrypt=false";
            String user = "sa";
            String password = "123";

            // Open a connection to the database
            connection = DriverManager.getConnection(url, user, password);
            System.out.println("Database connection successful!");
        } catch (ClassNotFoundException e) {
            System.err.println("JDBC Driver not found!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Database connection failed!");
            e.printStackTrace();
        }

        return connection;
    }

    // Method to close the connection
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("Database connection closed.");
            } catch (SQLException e) {
                System.err.println("Failed to close connection!");
                e.printStackTrace();
            }
        }
    }
}
