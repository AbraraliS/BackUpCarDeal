package com.cardeal.exception;

/**
 * Custom exception class for CarDeal application
 * Provides specific error handling for business logic errors
 */
public class CarDealException extends Exception {
    
    private static final long serialVersionUID = 1L;
    
    private final String errorCode;
    private final String userMessage;
    
    /**
     * Constructor with message only
     * 
     * @param message The exception message
     */
    public CarDealException(String message) {
        super(message);
        this.errorCode = "GENERAL_ERROR";
        this.userMessage = message;
    }
    
    /**
     * Constructor with message and cause
     * 
     * @param message The exception message
     * @param cause The underlying cause
     */
    public CarDealException(String message, Throwable cause) {
        super(message, cause);
        this.errorCode = "GENERAL_ERROR";
        this.userMessage = message;
    }
    
    /**
     * Constructor with error code and messages
     * 
     * @param errorCode The specific error code
     * @param message The technical message
     * @param userMessage The user-friendly message
     */
    public CarDealException(String errorCode, String message, String userMessage) {
        super(message);
        this.errorCode = errorCode;
        this.userMessage = userMessage;
    }
    
    /**
     * Constructor with error code, messages, and cause
     * 
     * @param errorCode The specific error code
     * @param message The technical message
     * @param userMessage The user-friendly message
     * @param cause The underlying cause
     */
    public CarDealException(String errorCode, String message, String userMessage, Throwable cause) {
        super(message, cause);
        this.errorCode = errorCode;
        this.userMessage = userMessage;
    }
    
    /**
     * Get the error code
     * 
     * @return The error code
     */
    public String getErrorCode() {
        return errorCode;
    }
    
    /**
     * Get the user-friendly message
     * 
     * @return The user message
     */
    public String getUserMessage() {
        return userMessage;
    }
}

/**
 * Exception for validation errors
 */
class ValidationException extends CarDealException {
    
    private static final long serialVersionUID = 1L;
    
    public ValidationException(String field, String message) {
        super("VALIDATION_ERROR", "Validation failed for field: " + field, message);
    }
    
    public ValidationException(String field, String message, Throwable cause) {
        super("VALIDATION_ERROR", "Validation failed for field: " + field, message, cause);
    }
}

/**
 * Exception for authentication errors
 */
class AuthenticationException extends CarDealException {
    
    private static final long serialVersionUID = 1L;
    
    public AuthenticationException(String message) {
        super("AUTH_ERROR", message, "Authentication failed. Please check your credentials.");
    }
    
    public AuthenticationException(String message, Throwable cause) {
        super("AUTH_ERROR", message, "Authentication failed. Please check your credentials.", cause);
    }
}

/**
 * Exception for authorization errors
 */
class AuthorizationException extends CarDealException {
    
    private static final long serialVersionUID = 1L;
    
    public AuthorizationException(String message) {
        super("AUTHZ_ERROR", message, "You don't have permission to perform this action.");
    }
    
    public AuthorizationException(String message, Throwable cause) {
        super("AUTHZ_ERROR", message, "You don't have permission to perform this action.", cause);
    }
}

/**
 * Exception for database errors
 */
class DatabaseException extends CarDealException {
    
    private static final long serialVersionUID = 1L;
    
    public DatabaseException(String message) {
        super("DB_ERROR", message, "A database error occurred. Please try again later.");
    }
    
    public DatabaseException(String message, Throwable cause) {
        super("DB_ERROR", message, "A database error occurred. Please try again later.", cause);
    }
}
