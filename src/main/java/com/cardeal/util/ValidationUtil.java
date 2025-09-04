package com.cardeal.util;

import com.cardeal.config.SecurityConfig;
import com.cardeal.exception.CarDealException;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

/**
 * Validation utility class for input validation
 * Provides comprehensive validation methods for user inputs
 */
public class ValidationUtil {
    
    // Email validation pattern
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
        "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
    );
    
    // Phone validation pattern (supports various formats)
    private static final Pattern PHONE_PATTERN = Pattern.compile(
        "^[+]?[1-9]?[0-9]{7,15}$"
    );
    
    // Username validation pattern
    private static final Pattern USERNAME_PATTERN = Pattern.compile(
        "^[a-zA-Z0-9_]{3,20}$"
    );
    
    // Name validation pattern (letters, spaces, apostrophes, hyphens)
    private static final Pattern NAME_PATTERN = Pattern.compile(
        "^[a-zA-Z\\s'.-]{2,50}$"
    );
    
    // Price validation pattern
    private static final Pattern PRICE_PATTERN = Pattern.compile(
        "^\\d+(\\.\\d{1,2})?$"
    );
    
    // Year validation pattern
    private static final Pattern YEAR_PATTERN = Pattern.compile(
        "^(19|20)\\d{2}$"
    );
    
    /**
     * Validate user registration data
     * 
     * @param userData Map containing user data to validate
     * @return ValidationResult with validation status and errors
     */
    public static ValidationResult validateUserRegistration(Map<String, String> userData) {
        ValidationResult result = new ValidationResult();
        
        // Validate username
        String username = userData.get("username");
        if (!isValidUsername(username)) {
            result.addError("username", "Username must be 3-20 characters long and contain only letters, numbers, and underscores");
        }
        
        // Validate email
        String email = userData.get("email");
        if (!isValidEmail(email)) {
            result.addError("email", "Please enter a valid email address");
        }
        
        // Validate password
        String password = userData.get("password");
        if (!SecurityConfig.isValidPassword(password)) {
            result.addError("password", SecurityConfig.getPasswordRequirements());
        }
        
        // Validate password confirmation
        String confirmPassword = userData.get("confirmPassword");
        if (!password.equals(confirmPassword)) {
            result.addError("confirmPassword", "Passwords do not match");
        }
        
        // Validate first name
        String firstName = userData.get("firstName");
        if (!isValidName(firstName)) {
            result.addError("firstName", "First name must be 2-50 characters long and contain only letters");
        }
        
        // Validate last name
        String lastName = userData.get("lastName");
        if (!isValidName(lastName)) {
            result.addError("lastName", "Last name must be 2-50 characters long and contain only letters");
        }
        
        // Validate phone (optional)
        String phone = userData.get("phone");
        if (phone != null && !phone.trim().isEmpty() && !isValidPhone(phone)) {
            result.addError("phone", "Please enter a valid phone number");
        }
        
        return result;
    }
    
    /**
     * Validate user login data
     * 
     * @param email User email
     * @param password User password
     * @return ValidationResult with validation status and errors
     */
    public static ValidationResult validateUserLogin(String email, String password) {
        ValidationResult result = new ValidationResult();
        
        if (isEmpty(email)) {
            result.addError("email", "Email is required");
        } else if (!isValidEmail(email)) {
            result.addError("email", "Please enter a valid email address");
        }
        
        if (isEmpty(password)) {
            result.addError("password", "Password is required");
        }
        
        return result;
    }
    
    /**
     * Validate car listing data
     * 
     * @param carData Map containing car data to validate
     * @return ValidationResult with validation status and errors
     */
    public static ValidationResult validateCarListing(Map<String, String> carData) {
        ValidationResult result = new ValidationResult();
        
        // Validate title
        String title = carData.get("title");
        if (isEmpty(title)) {
            result.addError("title", "Car title is required");
        } else if (title.length() > 100) {
            result.addError("title", "Car title must not exceed 100 characters");
        }
        
        // Validate make
        String make = carData.get("make");
        if (isEmpty(make)) {
            result.addError("make", "Car make is required");
        }
        
        // Validate model
        String model = carData.get("model");
        if (isEmpty(model)) {
            result.addError("model", "Car model is required");
        }
        
        // Validate year
        String year = carData.get("year");
        if (isEmpty(year)) {
            result.addError("year", "Year is required");
        } else if (!isValidYear(year)) {
            result.addError("year", "Please enter a valid year (1950-2030)");
        }
        
        // Validate price
        String price = carData.get("price");
        if (isEmpty(price)) {
            result.addError("price", "Price is required");
        } else if (!isValidPrice(price)) {
            result.addError("price", "Please enter a valid price (numbers only, max 2 decimal places)");
        }
        
        // Validate mileage (optional)
        String mileage = carData.get("mileage");
        if (!isEmpty(mileage) && !isValidNumber(mileage)) {
            result.addError("mileage", "Mileage must be a valid number");
        }
        
        // Validate description
        String description = carData.get("description");
        if (!isEmpty(description) && description.length() > 2000) {
            result.addError("description", "Description must not exceed 2000 characters");
        }
        
        // Validate contact phone
        String contactPhone = carData.get("contactPhone");
        if (!isEmpty(contactPhone) && !isValidPhone(contactPhone)) {
            result.addError("contactPhone", "Please enter a valid contact phone number");
        }
        
        // Validate contact email
        String contactEmail = carData.get("contactEmail");
        if (!isEmpty(contactEmail) && !isValidEmail(contactEmail)) {
            result.addError("contactEmail", "Please enter a valid contact email");
        }
        
        return result;
    }
    
    /**
     * Validate email format
     */
    public static boolean isValidEmail(String email) {
        return !isEmpty(email) && EMAIL_PATTERN.matcher(email.trim()).matches();
    }
    
    /**
     * Validate phone number format
     */
    public static boolean isValidPhone(String phone) {
        if (isEmpty(phone)) {
            return false;
        }
        String cleanPhone = phone.replaceAll("[^0-9+]", "");
        return PHONE_PATTERN.matcher(cleanPhone).matches();
    }
    
    /**
     * Validate username format
     */
    public static boolean isValidUsername(String username) {
        return !isEmpty(username) && USERNAME_PATTERN.matcher(username.trim()).matches();
    }
    
    /**
     * Validate name format
     */
    public static boolean isValidName(String name) {
        return !isEmpty(name) && NAME_PATTERN.matcher(name.trim()).matches();
    }
    
    /**
     * Validate price format
     */
    public static boolean isValidPrice(String price) {
        if (isEmpty(price)) {
            return false;
        }
        try {
            double priceValue = Double.parseDouble(price);
            return priceValue > 0 && priceValue <= 999999999.99;
        } catch (NumberFormatException e) {
            return false;
        }
    }
    
    /**
     * Validate year format
     */
    public static boolean isValidYear(String year) {
        if (isEmpty(year)) {
            return false;
        }
        try {
            int yearValue = Integer.parseInt(year);
            int currentYear = java.time.LocalDate.now().getYear();
            return yearValue >= 1950 && yearValue <= currentYear + 1;
        } catch (NumberFormatException e) {
            return false;
        }
    }
    
    /**
     * Validate number format
     */
    public static boolean isValidNumber(String number) {
        if (isEmpty(number)) {
            return false;
        }
        try {
            Integer.parseInt(number);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }
    
    /**
     * Check if string is empty or null
     */
    public static boolean isEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }
    
    /**
     * Check if string is not empty
     */
    public static boolean isNotEmpty(String str) {
        return !isEmpty(str);
    }
    
    /**
     * Sanitize string input to prevent XSS
     */
    public static String sanitizeInput(String input) {
        return SecurityConfig.sanitizeInput(input);
    }
    
    /**
     * Validation result class to hold validation status and errors
     */
    public static class ValidationResult {
        private boolean valid;
        private Map<String, String> errors;
        
        public ValidationResult() {
            this.valid = true;
            this.errors = new HashMap<>();
        }
        
        public void addError(String field, String message) {
            this.valid = false;
            this.errors.put(field, message);
        }
        
        public boolean isValid() {
            return valid;
        }
        
        public Map<String, String> getErrors() {
            return errors;
        }
        
        public String getError(String field) {
            return errors.get(field);
        }
        
        public boolean hasError(String field) {
            return errors.containsKey(field);
        }
        
        public String getErrorsAsString() {
            if (errors.isEmpty()) {
                return "";
            }
            StringBuilder sb = new StringBuilder();
            for (Map.Entry<String, String> entry : errors.entrySet()) {
                if (sb.length() > 0) {
                    sb.append("; ");
                }
                sb.append(entry.getValue());
            }
            return sb.toString();
        }
        
        /**
         * Throw CarDealException if validation failed
         */
        public void throwIfInvalid() throws CarDealException {
            if (!valid) {
                throw new CarDealException("VALIDATION_ERROR", 
                    "Validation failed", getErrorsAsString());
            }
        }
    }
}
