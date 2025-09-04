package com.cardeal.dao;

import com.cardeal.config.DatabaseConfig;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Base Data Access Object class providing common database operations
 * All other DAO classes should extend this base class
 */
public abstract class BaseDAO {
    
    protected static final Logger LOGGER = Logger.getLogger(BaseDAO.class.getName());
    
    /**
     * Get a database connection
     * 
     * @return Database connection
     * @throws SQLException if connection cannot be obtained
     */
    protected Connection getConnection() throws SQLException {
        return DatabaseConfig.getConnection();
    }
    
    /**
     * Close database resources safely
     * 
     * @param connection Database connection
     * @param statement PreparedStatement
     * @param resultSet ResultSet
     */
    protected void closeResources(Connection connection, PreparedStatement statement, ResultSet resultSet) {
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException e) {
                LOGGER.log(Level.WARNING, "Error closing ResultSet", e);
            }
        }
        
        if (statement != null) {
            try {
                statement.close();
            } catch (SQLException e) {
                LOGGER.log(Level.WARNING, "Error closing PreparedStatement", e);
            }
        }
        
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                LOGGER.log(Level.WARNING, "Error closing Connection", e);
            }
        }
    }
    
    /**
     * Close database resources safely (without ResultSet)
     * 
     * @param connection Database connection
     * @param statement PreparedStatement
     */
    protected void closeResources(Connection connection, PreparedStatement statement) {
        closeResources(connection, statement, null);
    }
    
    /**
     * Execute a query and return the count of affected rows
     * 
     * @param sql SQL query
     * @param params Query parameters
     * @return Number of affected rows
     * @throws SQLException if database error occurs
     */
    protected int executeUpdate(String sql, Object... params) throws SQLException {
        Connection connection = null;
        PreparedStatement statement = null;
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            
            // Set parameters
            setParameters(statement, params);
            
            int result = statement.executeUpdate();
            LOGGER.fine("Executed update: " + sql + " - Rows affected: " + result);
            return result;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database update error: " + sql, e);
            throw e;
        } finally {
            closeResources(connection, statement);
        }
    }
    
    /**
     * Execute an insert and return the generated key
     * 
     * @param sql SQL insert statement
     * @param params Query parameters
     * @return Generated key (usually the auto-incremented ID)
     * @throws SQLException if database error occurs
     */
    protected int executeInsert(String sql, Object... params) throws SQLException {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            // Set parameters
            setParameters(statement, params);
            
            int rowsAffected = statement.executeUpdate();
            
            if (rowsAffected > 0) {
                resultSet = statement.getGeneratedKeys();
                if (resultSet.next()) {
                    int generatedKey = resultSet.getInt(1);
                    LOGGER.fine("Executed insert: " + sql + " - Generated key: " + generatedKey);
                    return generatedKey;
                }
            }
            
            throw new SQLException("Insert failed, no rows affected");
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database insert error: " + sql, e);
            throw e;
        } finally {
            closeResources(connection, statement, resultSet);
        }
    }
    
    /**
     * Execute a query and return a single result
     * 
     * @param sql SQL query
     * @param mapper Function to map ResultSet to object
     * @param params Query parameters
     * @return Single result object or null if not found
     * @throws SQLException if database error occurs
     */
    protected <T> T executeQuerySingle(String sql, ResultSetMapper<T> mapper, Object... params) throws SQLException {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            
            // Set parameters
            setParameters(statement, params);
            
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                T result = mapper.map(resultSet);
                LOGGER.fine("Executed query (single): " + sql);
                return result;
            }
            
            return null;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database query error: " + sql, e);
            throw e;
        } finally {
            closeResources(connection, statement, resultSet);
        }
    }
    
    /**
     * Check if a record exists
     * 
     * @param sql SQL query that should return a count
     * @param params Query parameters
     * @return true if record exists, false otherwise
     * @throws SQLException if database error occurs
     */
    protected boolean exists(String sql, Object... params) throws SQLException {
        Integer count = executeQuerySingle(sql, rs -> rs.getInt(1), params);
        return count != null && count > 0;
    }
    
    /**
     * Get the count of records
     * 
     * @param sql SQL count query
     * @param params Query parameters
     * @return Number of records
     * @throws SQLException if database error occurs
     */
    protected int getCount(String sql, Object... params) throws SQLException {
        Integer count = executeQuerySingle(sql, rs -> rs.getInt(1), params);
        return count != null ? count : 0;
    }
    
    /**
     * Set parameters for PreparedStatement
     * 
     * @param statement PreparedStatement
     * @param params Parameters to set
     * @throws SQLException if parameter setting fails
     */
    protected void setParameters(PreparedStatement statement, Object... params) throws SQLException {
        for (int i = 0; i < params.length; i++) {
            Object param = params[i];
            int paramIndex = i + 1;
            
            if (param == null) {
                statement.setNull(paramIndex, java.sql.Types.NULL);
            } else if (param instanceof String) {
                statement.setString(paramIndex, (String) param);
            } else if (param instanceof Integer) {
                statement.setInt(paramIndex, (Integer) param);
            } else if (param instanceof Long) {
                statement.setLong(paramIndex, (Long) param);
            } else if (param instanceof Double) {
                statement.setDouble(paramIndex, (Double) param);
            } else if (param instanceof Float) {
                statement.setFloat(paramIndex, (Float) param);
            } else if (param instanceof Boolean) {
                statement.setBoolean(paramIndex, (Boolean) param);
            } else if (param instanceof LocalDateTime) {
                statement.setTimestamp(paramIndex, Timestamp.valueOf((LocalDateTime) param));
            } else if (param instanceof java.util.Date) {
                statement.setTimestamp(paramIndex, new Timestamp(((java.util.Date) param).getTime()));
            } else if (param instanceof java.math.BigDecimal) {
                statement.setBigDecimal(paramIndex, (java.math.BigDecimal) param);
            } else {
                // For other types, convert to string
                statement.setString(paramIndex, param.toString());
            }
        }
    }
    
    /**
     * Convert LocalDateTime to Timestamp safely
     * 
     * @param dateTime LocalDateTime to convert
     * @return Timestamp or null if input is null
     */
    protected Timestamp toTimestamp(LocalDateTime dateTime) {
        return dateTime != null ? Timestamp.valueOf(dateTime) : null;
    }
    
    /**
     * Convert Timestamp to LocalDateTime safely
     * 
     * @param timestamp Timestamp to convert
     * @return LocalDateTime or null if input is null
     */
    protected LocalDateTime toLocalDateTime(Timestamp timestamp) {
        return timestamp != null ? timestamp.toLocalDateTime() : null;
    }
    
    /**
     * Get string value safely from ResultSet
     * 
     * @param rs ResultSet
     * @param columnName Column name
     * @return String value or null
     * @throws SQLException if column access fails
     */
    protected String getString(ResultSet rs, String columnName) throws SQLException {
        String value = rs.getString(columnName);
        return rs.wasNull() ? null : value;
    }
    
    /**
     * Get integer value safely from ResultSet
     * 
     * @param rs ResultSet
     * @param columnName Column name
     * @return Integer value or null
     * @throws SQLException if column access fails
     */
    protected Integer getInteger(ResultSet rs, String columnName) throws SQLException {
        int value = rs.getInt(columnName);
        return rs.wasNull() ? null : value;
    }
    
    /**
     * Get long value safely from ResultSet
     * 
     * @param rs ResultSet
     * @param columnName Column name
     * @return Long value or null
     * @throws SQLException if column access fails
     */
    protected Long getLong(ResultSet rs, String columnName) throws SQLException {
        long value = rs.getLong(columnName);
        return rs.wasNull() ? null : value;
    }
    
    /**
     * Get boolean value safely from ResultSet
     * 
     * @param rs ResultSet
     * @param columnName Column name
     * @return Boolean value or false if null
     * @throws SQLException if column access fails
     */
    protected Boolean getBoolean(ResultSet rs, String columnName) throws SQLException {
        boolean value = rs.getBoolean(columnName);
        return rs.wasNull() ? false : value;
    }
    
    /**
     * Interface for mapping ResultSet to objects
     */
    @FunctionalInterface
    protected interface ResultSetMapper<T> {
        T map(ResultSet rs) throws SQLException;
    }
}
