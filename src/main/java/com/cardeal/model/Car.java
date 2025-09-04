package com.cardeal.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * Car model class representing a car listing in the CarDeal application
 * Includes comprehensive car information and validation
 */
public class Car {
    
    // Basic car information
    private Integer carId;
    private Integer userId;
    private String title;
    private String description;
    private String make;
    private String model;
    private String variant;
    private Integer year;
    private String color;
    private BigDecimal price;
    private String currency;
    
    // Technical specifications
    private String fuelType;
    private String transmission;
    private String engineSize;
    private Integer mileage;
    private String bodyType;
    private Integer numberOfDoors;
    private Integer numberOfSeats;
    private String driveType;
    
    // Condition and history
    private String condition; // NEW, USED, CERTIFIED_PRE_OWNED
    private Integer previousOwners;
    private String accidentHistory;
    private String serviceHistory;
    private LocalDateTime registrationDate;
    
    // Location information
    private String address;
    private String city;
    private String state;
    private String zipCode;
    private String country;
    
    // Media and documentation
    private List<String> imagePaths;
    private String primaryImagePath;
    private List<String> documentPaths;
    
    // Features and options
    private List<String> features;
    private String airConditioning;
    private String powerSteering;
    private String powerWindows;
    private String musicSystem;
    
    // Listing information
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private LocalDateTime expireAt;
    private boolean isActive;
    private boolean isFeatured;
    private boolean isVerified;
    private String status; // ACTIVE, SOLD, EXPIRED, SUSPENDED
    private Integer viewCount;
    
    // Contact information
    private String contactName;
    private String contactPhone;
    private String contactEmail;
    private boolean showContactDetails;
    
    // SEO and metadata
    private String metaTitle;
    private String metaDescription;
    private String metaKeywords;
    private String slug;
    
    // Constructors
    public Car() {
        this.imagePaths = new ArrayList<>();
        this.documentPaths = new ArrayList<>();
        this.features = new ArrayList<>();
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
        this.isActive = true;
        this.isFeatured = false;
        this.isVerified = false;
        this.status = "ACTIVE";
        this.viewCount = 0;
        this.showContactDetails = true;
        this.currency = "USD";
    }
    
    public Car(String title, String make, String model, BigDecimal price) {
        this();
        this.title = title;
        this.make = make;
        this.model = model;
        this.price = price;
    }
    
    // Getters and Setters
    public Integer getCarId() {
        return carId;
    }
    
    public void setCarId(Integer carId) {
        this.carId = carId;
    }
    
    public Integer getUserId() {
        return userId;
    }
    
    public void setUserId(Integer userId) {
        this.userId = userId;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title != null ? title.trim() : null;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description != null ? description.trim() : null;
    }
    
    public String getMake() {
        return make;
    }
    
    public void setMake(String make) {
        this.make = make != null ? make.trim() : null;
    }
    
    public String getModel() {
        return model;
    }
    
    public void setModel(String model) {
        this.model = model != null ? model.trim() : null;
    }
    
    public String getVariant() {
        return variant;
    }
    
    public void setVariant(String variant) {
        this.variant = variant != null ? variant.trim() : null;
    }
    
    public Integer getYear() {
        return year;
    }
    
    public void setYear(Integer year) {
        this.year = year;
    }
    
    public String getColor() {
        return color;
    }
    
    public void setColor(String color) {
        this.color = color != null ? color.trim() : null;
    }
    
    public BigDecimal getPrice() {
        return price;
    }
    
    public void setPrice(BigDecimal price) {
        this.price = price;
    }
    
    public String getCurrency() {
        return currency;
    }
    
    public void setCurrency(String currency) {
        this.currency = currency;
    }
    
    public String getFuelType() {
        return fuelType;
    }
    
    public void setFuelType(String fuelType) {
        this.fuelType = fuelType;
    }
    
    public String getTransmission() {
        return transmission;
    }
    
    public void setTransmission(String transmission) {
        this.transmission = transmission;
    }
    
    public String getEngineSize() {
        return engineSize;
    }
    
    public void setEngineSize(String engineSize) {
        this.engineSize = engineSize;
    }
    
    public Integer getMileage() {
        return mileage;
    }
    
    public void setMileage(Integer mileage) {
        this.mileage = mileage;
    }
    
    public String getBodyType() {
        return bodyType;
    }
    
    public void setBodyType(String bodyType) {
        this.bodyType = bodyType;
    }
    
    public Integer getNumberOfDoors() {
        return numberOfDoors;
    }
    
    public void setNumberOfDoors(Integer numberOfDoors) {
        this.numberOfDoors = numberOfDoors;
    }
    
    public Integer getNumberOfSeats() {
        return numberOfSeats;
    }
    
    public void setNumberOfSeats(Integer numberOfSeats) {
        this.numberOfSeats = numberOfSeats;
    }
    
    public String getDriveType() {
        return driveType;
    }
    
    public void setDriveType(String driveType) {
        this.driveType = driveType;
    }
    
    public String getCondition() {
        return condition;
    }
    
    public void setCondition(String condition) {
        this.condition = condition;
    }
    
    public Integer getPreviousOwners() {
        return previousOwners;
    }
    
    public void setPreviousOwners(Integer previousOwners) {
        this.previousOwners = previousOwners;
    }
    
    public String getAccidentHistory() {
        return accidentHistory;
    }
    
    public void setAccidentHistory(String accidentHistory) {
        this.accidentHistory = accidentHistory;
    }
    
    public String getServiceHistory() {
        return serviceHistory;
    }
    
    public void setServiceHistory(String serviceHistory) {
        this.serviceHistory = serviceHistory;
    }
    
    public LocalDateTime getRegistrationDate() {
        return registrationDate;
    }
    
    public void setRegistrationDate(LocalDateTime registrationDate) {
        this.registrationDate = registrationDate;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public String getCity() {
        return city;
    }
    
    public void setCity(String city) {
        this.city = city;
    }
    
    public String getState() {
        return state;
    }
    
    public void setState(String state) {
        this.state = state;
    }
    
    public String getZipCode() {
        return zipCode;
    }
    
    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }
    
    public String getCountry() {
        return country;
    }
    
    public void setCountry(String country) {
        this.country = country;
    }
    
    public List<String> getImagePaths() {
        return imagePaths;
    }
    
    public void setImagePaths(List<String> imagePaths) {
        this.imagePaths = imagePaths != null ? imagePaths : new ArrayList<>();
    }
    
    public String getPrimaryImagePath() {
        return primaryImagePath;
    }
    
    public void setPrimaryImagePath(String primaryImagePath) {
        this.primaryImagePath = primaryImagePath;
    }
    
    public List<String> getDocumentPaths() {
        return documentPaths;
    }
    
    public void setDocumentPaths(List<String> documentPaths) {
        this.documentPaths = documentPaths != null ? documentPaths : new ArrayList<>();
    }
    
    public List<String> getFeatures() {
        return features;
    }
    
    public void setFeatures(List<String> features) {
        this.features = features != null ? features : new ArrayList<>();
    }
    
    public String getAirConditioning() {
        return airConditioning;
    }
    
    public void setAirConditioning(String airConditioning) {
        this.airConditioning = airConditioning;
    }
    
    public String getPowerSteering() {
        return powerSteering;
    }
    
    public void setPowerSteering(String powerSteering) {
        this.powerSteering = powerSteering;
    }
    
    public String getPowerWindows() {
        return powerWindows;
    }
    
    public void setPowerWindows(String powerWindows) {
        this.powerWindows = powerWindows;
    }
    
    public String getMusicSystem() {
        return musicSystem;
    }
    
    public void setMusicSystem(String musicSystem) {
        this.musicSystem = musicSystem;
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
    
    public LocalDateTime getExpireAt() {
        return expireAt;
    }
    
    public void setExpireAt(LocalDateTime expireAt) {
        this.expireAt = expireAt;
    }
    
    public boolean isActive() {
        return isActive;
    }
    
    public void setActive(boolean active) {
        isActive = active;
    }
    
    public boolean isFeatured() {
        return isFeatured;
    }
    
    public void setFeatured(boolean featured) {
        isFeatured = featured;
    }
    
    public boolean isVerified() {
        return isVerified;
    }
    
    public void setVerified(boolean verified) {
        isVerified = verified;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Integer getViewCount() {
        return viewCount;
    }
    
    public void setViewCount(Integer viewCount) {
        this.viewCount = viewCount;
    }
    
    public String getContactName() {
        return contactName;
    }
    
    public void setContactName(String contactName) {
        this.contactName = contactName;
    }
    
    public String getContactPhone() {
        return contactPhone;
    }
    
    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }
    
    public String getContactEmail() {
        return contactEmail;
    }
    
    public void setContactEmail(String contactEmail) {
        this.contactEmail = contactEmail;
    }
    
    public boolean isShowContactDetails() {
        return showContactDetails;
    }
    
    public void setShowContactDetails(boolean showContactDetails) {
        this.showContactDetails = showContactDetails;
    }
    
    public String getMetaTitle() {
        return metaTitle;
    }
    
    public void setMetaTitle(String metaTitle) {
        this.metaTitle = metaTitle;
    }
    
    public String getMetaDescription() {
        return metaDescription;
    }
    
    public void setMetaDescription(String metaDescription) {
        this.metaDescription = metaDescription;
    }
    
    public String getMetaKeywords() {
        return metaKeywords;
    }
    
    public void setMetaKeywords(String metaKeywords) {
        this.metaKeywords = metaKeywords;
    }
    
    public String getSlug() {
        return slug;
    }
    
    public void setSlug(String slug) {
        this.slug = slug;
    }
    
    // Utility methods
    public void updateTimestamp() {
        this.updatedAt = LocalDateTime.now();
    }
    
    public void incrementViewCount() {
        this.viewCount = (this.viewCount != null ? this.viewCount : 0) + 1;
    }
    
    public String getFullTitle() {
        StringBuilder fullTitle = new StringBuilder();
        if (year != null) {
            fullTitle.append(year).append(" ");
        }
        if (make != null) {
            fullTitle.append(make).append(" ");
        }
        if (model != null) {
            fullTitle.append(model);
        }
        if (variant != null && !variant.trim().isEmpty()) {
            fullTitle.append(" ").append(variant);
        }
        return fullTitle.toString().trim();
    }
    
    public String getFormattedPrice() {
        if (price == null) {
            return "Price on request";
        }
        return String.format("$%,.2f", price);
    }
    
    public boolean isExpired() {
        return expireAt != null && LocalDateTime.now().isAfter(expireAt);
    }
    
    public boolean hasImages() {
        return imagePaths != null && !imagePaths.isEmpty();
    }
    
    public String getDisplayImage() {
        if (primaryImagePath != null && !primaryImagePath.trim().isEmpty()) {
            return primaryImagePath;
        }
        if (hasImages()) {
            return imagePaths.get(0);
        }
        return "/images/no-image.jpg"; // Default image
    }
    
    public int getAge() {
        if (year == null) {
            return 0;
        }
        return LocalDateTime.now().getYear() - year;
    }
    
    // Override methods
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Car car = (Car) o;
        return Objects.equals(carId, car.carId);
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(carId);
    }
    
    @Override
    public String toString() {
        return "Car{" +
                "carId=" + carId +
                ", title='" + title + '\'' +
                ", make='" + make + '\'' +
                ", model='" + model + '\'' +
                ", year=" + year +
                ", price=" + price +
                ", status='" + status + '\'' +
                ", isActive=" + isActive +
                ", createdAt=" + createdAt +
                '}';
    }
}
