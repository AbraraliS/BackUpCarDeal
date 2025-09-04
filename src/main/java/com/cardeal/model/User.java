package com.cardeal.model;

import java.time.LocalDateTime;
import java.util.Objects;

/**
 * User model class representing a user in the CarDeal application
 * Includes validation and security features
 */
public class User {
    
    private Integer userId;
    private String username;
    private String email;
    private String passwordHash;
    private String passwordSalt;
    private String firstName;
    private String lastName;
    private String address;
    private String city;
    private String state;
    private String zipCode;
    private String phone;
    private String subscriptionTypeId;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private boolean isActive;
    private boolean isEmailVerified;
    private String profileImagePath;
    
    // Constructors
    public User() {
        this.isActive = true;
        this.isEmailVerified = false;
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }
    
    public User(String username, String email, String firstName, String lastName) {
        this();
        this.username = username;
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
    }
    
    // Getters and Setters
    public Integer getUserId() {
        return userId;
    }
    
    public void setUserId(Integer userId) {
        this.userId = userId;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username != null ? username.trim() : null;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email != null ? email.trim().toLowerCase() : null;
    }
    
    public String getPasswordHash() {
        return passwordHash;
    }
    
    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }
    
    public String getPasswordSalt() {
        return passwordSalt;
    }
    
    public void setPasswordSalt(String passwordSalt) {
        this.passwordSalt = passwordSalt;
    }
    
    public String getFirstName() {
        return firstName;
    }
    
    public void setFirstName(String firstName) {
        this.firstName = firstName != null ? firstName.trim() : null;
    }
    
    public String getLastName() {
        return lastName;
    }
    
    public void setLastName(String lastName) {
        this.lastName = lastName != null ? lastName.trim() : null;
    }
    
    public String getFullName() {
        StringBuilder fullName = new StringBuilder();
        if (firstName != null && !firstName.trim().isEmpty()) {
            fullName.append(firstName.trim());
        }
        if (lastName != null && !lastName.trim().isEmpty()) {
            if (fullName.length() > 0) {
                fullName.append(" ");
            }
            fullName.append(lastName.trim());
        }
        return fullName.toString();
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address != null ? address.trim() : null;
    }
    
    public String getCity() {
        return city;
    }
    
    public void setCity(String city) {
        this.city = city != null ? city.trim() : null;
    }
    
    public String getState() {
        return state;
    }
    
    public void setState(String state) {
        this.state = state != null ? state.trim() : null;
    }
    
    public String getZipCode() {
        return zipCode;
    }
    
    public void setZipCode(String zipCode) {
        this.zipCode = zipCode != null ? zipCode.trim() : null;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone != null ? phone.trim() : null;
    }
    
    public String getSubscriptionTypeId() {
        return subscriptionTypeId;
    }
    
    public void setSubscriptionTypeId(String subscriptionTypeId) {
        this.subscriptionTypeId = subscriptionTypeId;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public boolean isActive() {
        return isActive;
    }
    
    public void setActive(boolean active) {
        isActive = active;
    }
    
    public boolean isEmailVerified() {
        return isEmailVerified;
    }
    
    public void setEmailVerified(boolean emailVerified) {
        isEmailVerified = emailVerified;
    }
    
    public String getProfileImagePath() {
        return profileImagePath;
    }
    
    public void setProfileImagePath(String profileImagePath) {
        this.profileImagePath = profileImagePath;
    }
    
    // Utility methods
    public void updateTimestamp() {
        this.updatedAt = LocalDateTime.now();
    }
    
    /**
     * Get display name for the user
     * Returns full name if available, otherwise username
     */
    public String getDisplayName() {
        String fullName = getFullName();
        return !fullName.isEmpty() ? fullName : username;
    }
    
    /**
     * Check if user profile is complete
     */
    public boolean isProfileComplete() {
        return username != null && !username.trim().isEmpty() &&
               email != null && !email.trim().isEmpty() &&
               firstName != null && !firstName.trim().isEmpty() &&
               lastName != null && !lastName.trim().isEmpty();
    }
    
    // Override methods
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return Objects.equals(userId, user.userId) &&
               Objects.equals(email, user.email);
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(userId, email);
    }
    
    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", isActive=" + isActive +
                ", isEmailVerified=" + isEmailVerified +
                ", createdAt=" + createdAt +
                '}';
    }
    
    /**
     * Create a safe copy of user for display (without sensitive data)
     */
    public User createSafeCopy() {
        User safeCopy = new User();
        safeCopy.userId = this.userId;
        safeCopy.username = this.username;
        safeCopy.email = this.email;
        safeCopy.firstName = this.firstName;
        safeCopy.lastName = this.lastName;
        safeCopy.address = this.address;
        safeCopy.city = this.city;
        safeCopy.state = this.state;
        safeCopy.zipCode = this.zipCode;
        safeCopy.phone = this.phone;
        safeCopy.subscriptionTypeId = this.subscriptionTypeId;
        safeCopy.createdAt = this.createdAt;
        safeCopy.updatedAt = this.updatedAt;
        safeCopy.isActive = this.isActive;
        safeCopy.isEmailVerified = this.isEmailVerified;
        safeCopy.profileImagePath = this.profileImagePath;
        // Note: passwordHash and passwordSalt are NOT copied for security
        return safeCopy;
    }
}
