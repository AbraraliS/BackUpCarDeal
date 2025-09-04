package com.cardeal.config;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Security configuration and utilities for the CarDeal application
 * Provides password hashing, validation, and security utilities
 */
public class SecurityConfig {
    
    private static final Logger LOGGER = Logger.getLogger(SecurityConfig.class.getName());
    private static final SecureRandom SECURE_RANDOM = new SecureRandom();
    
    // Security constants
    private static final String HASH_ALGORITHM = "SHA-256";
    private static final int SALT_LENGTH = 32;
    private static final int HASH_ITERATIONS = 10000;
    
    // Password requirements
    private static final int MIN_PASSWORD_LENGTH = 8;
    private static final int MAX_PASSWORD_LENGTH = 128;
    
    // Session security
    private static final int SESSION_TIMEOUT = 30 * 60; // 30 minutes in seconds
    private static final String CSRF_TOKEN_ATTRIBUTE = "csrfToken";
    private static final String USER_ID_ATTRIBUTE = "UserID";
    
    /**
     * Generate a random salt for password hashing
     * 
     * @return Base64 encoded salt string
     */
    public static String generateSalt() {
        byte[] salt = new byte[SALT_LENGTH];
        SECURE_RANDOM.nextBytes(salt);
        return Base64.getEncoder().encodeToString(salt);
    }
    
    /**
     * Hash a password with salt using SHA-256
     * 
     * @param password The plain text password
     * @param salt The salt to use for hashing
     * @return Base64 encoded hashed password
     * @throws SecurityException if hashing fails
     */
    public static String hashPassword(String password, String salt) throws SecurityException {
        try {
            MessageDigest md = MessageDigest.getInstance(HASH_ALGORITHM);
            
            // Add salt to the password
            String saltedPassword = password + salt;
            
            // Hash the salted password multiple times for security
            byte[] hashedPassword = saltedPassword.getBytes();
            for (int i = 0; i < HASH_ITERATIONS; i++) {
                hashedPassword = md.digest(hashedPassword);
                md.reset();
            }
            
            return Base64.getEncoder().encodeToString(hashedPassword);
            
        } catch (NoSuchAlgorithmException e) {
            LOGGER.log(Level.SEVERE, "Password hashing algorithm not available", e);
            throw new SecurityException("Password hashing failed", e);
        }
    }
    
    /**
     * Hash a password with automatically generated salt
     * 
     * @param password The plain text password
     * @return Array containing [hashedPassword, salt]
     * @throws SecurityException if hashing fails
     */
    public static String[] hashPasswordWithSalt(String password) throws SecurityException {
        String salt = generateSalt();
        String hashedPassword = hashPassword(password, salt);
        return new String[]{hashedPassword, salt};
    }
    
    /**
     * Verify a password against a hash and salt
     * 
     * @param password The plain text password to verify
     * @param hashedPassword The stored hashed password
     * @param salt The salt used for the stored password
     * @return true if password matches, false otherwise
     */
    public static boolean verifyPassword(String password, String hashedPassword, String salt) {
        try {
            String newHash = hashPassword(password, salt);
            return constantTimeEquals(hashedPassword, newHash);
        } catch (SecurityException e) {
            LOGGER.log(Level.WARNING, "Password verification failed", e);
            return false;
        }
    }
    
    /**
     * Constant-time string comparison to prevent timing attacks
     * 
     * @param a First string
     * @param b Second string
     * @return true if strings are equal, false otherwise
     */
    private static boolean constantTimeEquals(String a, String b) {
        if (a == null || b == null) {
            return a == b;
        }
        
        if (a.length() != b.length()) {
            return false;
        }
        
        int result = 0;
        for (int i = 0; i < a.length(); i++) {
            result |= a.charAt(i) ^ b.charAt(i);
        }
        
        return result == 0;
    }
    
    /**
     * Validate password strength
     * 
     * @param password The password to validate
     * @return true if password meets requirements, false otherwise
     */
    public static boolean isValidPassword(String password) {
        if (password == null) {
            return false;
        }
        
        // Check length
        if (password.length() < MIN_PASSWORD_LENGTH || password.length() > MAX_PASSWORD_LENGTH) {
            return false;
        }
        
        // Check for at least one uppercase letter
        boolean hasUppercase = password.chars().anyMatch(Character::isUpperCase);
        
        // Check for at least one lowercase letter
        boolean hasLowercase = password.chars().anyMatch(Character::isLowerCase);
        
        // Check for at least one digit
        boolean hasDigit = password.chars().anyMatch(Character::isDigit);
        
        // Check for at least one special character
        boolean hasSpecial = password.chars().anyMatch(ch -> !Character.isLetterOrDigit(ch));
        
        return hasUppercase && hasLowercase && hasDigit && hasSpecial;
    }
    
    /**
     * Generate a secure random token for CSRF protection
     * 
     * @return Base64 encoded random token
     */
    public static String generateCSRFToken() {
        byte[] token = new byte[32];
        SECURE_RANDOM.nextBytes(token);
        return Base64.getEncoder().encodeToString(token);
    }
    
    /**
     * Validate email format
     * 
     * @param email The email to validate
     * @return true if email format is valid, false otherwise
     */
    public static boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        
        // Basic email validation regex
        String emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
        return email.matches(emailRegex) && email.length() <= 254;
    }
    
    /**
     * Sanitize user input to prevent XSS attacks
     * 
     * @param input The input string to sanitize
     * @return Sanitized string
     */
    public static String sanitizeInput(String input) {
        if (input == null) {
            return null;
        }
        
        return input
            .replace("&", "&amp;")
            .replace("<", "&lt;")
            .replace(">", "&gt;")
            .replace("\"", "&quot;")
            .replace("'", "&#x27;")
            .replace("/", "&#x2F;");
    }
    
    /**
     * Validate phone number format
     * 
     * @param phone The phone number to validate
     * @return true if phone format is valid, false otherwise
     */
    public static boolean isValidPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return false;
        }
        
        // Remove all non-digit characters
        String cleanPhone = phone.replaceAll("[^0-9]", "");
        
        // Check if it's a valid length (10-15 digits)
        return cleanPhone.length() >= 10 && cleanPhone.length() <= 15;
    }
    
    /**
     * Validate username format
     * 
     * @param username The username to validate
     * @return true if username format is valid, false otherwise
     */
    public static boolean isValidUsername(String username) {
        if (username == null || username.trim().isEmpty()) {
            return false;
        }
        
        // Username should be 3-20 characters, alphanumeric and underscore only
        String usernameRegex = "^[a-zA-Z0-9_]{3,20}$";
        return username.matches(usernameRegex);
    }
    
    /**
     * Get password strength requirements as a string
     * 
     * @return String describing password requirements
     */
    public static String getPasswordRequirements() {
        return "Password must be " + MIN_PASSWORD_LENGTH + "-" + MAX_PASSWORD_LENGTH + 
               " characters long and contain at least one uppercase letter, " +
               "one lowercase letter, one digit, and one special character.";
    }
    
    /**
     * Get session timeout in milliseconds
     * 
     * @return Session timeout in milliseconds
     */
    public static long getSessionTimeoutMillis() {
        return SESSION_TIMEOUT * 1000L;
    }
    
    /**
     * Get CSRF token attribute name
     * 
     * @return CSRF token attribute name
     */
    public static String getCSRFTokenAttribute() {
        return CSRF_TOKEN_ATTRIBUTE;
    }
    
    /**
     * Get user ID session attribute name
     * 
     * @return User ID session attribute name
     */
    public static String getUserIdAttribute() {
        return USER_ID_ATTRIBUTE;
    }
}
