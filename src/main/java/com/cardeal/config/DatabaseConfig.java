package com.cardeal.config;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Database configuration and connection management with basic connection pooling
 * Provides optimized connection management for better performance
 */
public class DatabaseConfig {
    
    private static final Logger LOGGER = Logger.getLogger(DatabaseConfig.class.getName());
    private static final ConcurrentLinkedQueue<Connection> connectionPool = new ConcurrentLinkedQueue<>();
    private static Properties dbProperties;
    
    // Configuration constants
    private static final String PROPERTIES_FILE = "/db.properties";
    private static final int INITIAL_POOL_SIZE = 5;
    private static final int MAX_POOL_SIZE = 20;
    private static final long CONNECTION_TIMEOUT = 30000;
    
    static {
        initializeDatabase();
    }
    
    /**
     * Initialize the database configuration and connection pool
     */
    private static void initializeDatabase() {
        try {
            dbProperties = loadDatabaseProperties();
            
            // Load the database driver
            Class.forName(dbProperties.getProperty("db.driver", "com.mysql.cj.jdbc.Driver"));
            
            // Initialize connection pool
            initializeConnectionPool();
            
            LOGGER.info("Database connection pool initialized successfully");
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Failed to initialize database", e);
            throw new RuntimeException("Database initialization failed", e);
        }
    }
    
    /**
     * Initialize the connection pool with initial connections
     */
    private static void initializeConnectionPool() throws SQLException {
        for (int i = 0; i < INITIAL_POOL_SIZE; i++) {
            Connection connection = createNewConnection();
            if (connection != null) {
                connectionPool.offer(connection);
            }
        }
        LOGGER.info("Connection pool initialized with " + connectionPool.size() + " connections");
    }
    
    /**
     * Create a new database connection
     */
    private static Connection createNewConnection() throws SQLException {
        String url = dbProperties.getProperty("db.url");
        String username = dbProperties.getProperty("db.username");
        String password = dbProperties.getProperty("db.password");
        
        return DriverManager.getConnection(url, username, password);
    }
    
    /**
     * Load database properties from configuration file
     */
    private static Properties loadDatabaseProperties() throws IOException {
        Properties props = new Properties();
        
        try (InputStream inputStream = DatabaseConfig.class.getResourceAsStream(PROPERTIES_FILE)) {
            if (inputStream == null) {
                throw new IOException("Database properties file not found: " + PROPERTIES_FILE);
            }
            props.load(inputStream);
            
            // Validate required properties
            String[] requiredProps = {"db.url", "db.username", "db.password"};
            for (String prop : requiredProps) {
                if (props.getProperty(prop) == null || props.getProperty(prop).trim().isEmpty()) {
                    throw new IOException("Required property missing: " + prop);
                }
            }
            
            LOGGER.info("Database properties loaded successfully");
            return props;
            
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Failed to load database properties", e);
            throw e;
        }
    }
    
    /**
     * Get a database connection from the pool
     * 
     * @return Database connection
     * @throws SQLException if connection cannot be obtained
     */
    public static Connection getConnection() throws SQLException {
        Connection connection = connectionPool.poll();
        
        if (connection == null || connection.isClosed()) {
            // Create new connection if pool is empty or connection is closed
            connection = createNewConnection();
            LOGGER.fine("Created new database connection");
        } else {
            LOGGER.fine("Reused connection from pool");
        }
        
        // Validate connection
        if (connection != null && !connection.isValid(5)) {
            connection.close();
            connection = createNewConnection();
        }
        
        return connection;
    }
    
    /**
     * Return a connection to the pool
     */
    public static void returnConnection(Connection connection) {
        if (connection != null && connectionPool.size() < MAX_POOL_SIZE) {
            try {
                if (!connection.isClosed() && connection.isValid(1)) {
                    connection.setAutoCommit(true); // Reset auto-commit
                    connectionPool.offer(connection);
                    LOGGER.fine("Connection returned to pool");
                    return;
                }
            } catch (SQLException e) {
                LOGGER.log(Level.WARNING, "Error checking connection validity", e);
            }
        }
        
        // Close connection if pool is full or connection is invalid
        closeConnection(connection);
    }
    
    /**
     * Close a database connection properly
     */
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
                LOGGER.fine("Database connection closed");
            } catch (SQLException e) {
                LOGGER.log(Level.WARNING, "Error closing connection", e);
            }
        }
    }
    
    /**
     * Get connection pool statistics for monitoring
     */
    public static String getPoolStats() {
        return String.format(
            "Pool size: %d, Max pool size: %d",
            connectionPool.size(),
            MAX_POOL_SIZE
        );
    }
    
    /**
     * Close all connections in the pool (for application shutdown)
     */
    public static void closeAllConnections() {
        while (!connectionPool.isEmpty()) {
            Connection connection = connectionPool.poll();
            closeConnection(connection);
        }
        LOGGER.info("All database connections closed");
    }
    
    /**
     * Check if the database is properly initialized
     */
    public static boolean isInitialized() {
        return dbProperties != null;
    }
    
    /**
     * Test database connectivity
     */
    public static boolean testConnection() {
        try (Connection connection = getConnection()) {
            return connection != null && connection.isValid(5);
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "Database connection test failed", e);
            return false;
        }
    }
}
