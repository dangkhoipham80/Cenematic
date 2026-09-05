/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Connection factory for the CENEMATIC database.
 *
 * Settings are read from the environment so the same build runs against a local
 * SQL Server, a Docker container, or a lab machine. The defaults match the
 * docker-compose setup documented in the README.
 */
public class DBUtil {

    public static final String HOST = env("DB_HOST", "localhost");
    public static final String PORT = env("DB_PORT", "1433");
    public static final String DB_NAME = env("DB_NAME", "CENEMATIC");
    public static final String USER_NAME = env("DB_USER", "sa");
    public static final String PASSWORD = env("DB_PASSWORD", "Cenematic@2024");

    private static String env(String key, String fallback) {
        String value = System.getenv(key);
        if (value == null || value.isEmpty()) {
            value = System.getProperty(key);
        }
        return (value == null || value.isEmpty()) ? fallback : value;
    }

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        // encrypt=false + trustServerCertificate: the mssql-jdbc 12.x driver
        // encrypts by default, which fails against a dev server with a self-signed cert.
        String url = "jdbc:sqlserver://" + HOST + ":" + PORT
                + ";databaseName=" + DB_NAME
                + ";encrypt=false;trustServerCertificate=true";
        return DriverManager.getConnection(url, USER_NAME, PASSWORD);
    }
}
