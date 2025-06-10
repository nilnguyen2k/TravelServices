
# Travel Services Application

This repository contains the source code and setup instructions for the Travel Services application, consisting of a Spring Boot backend and a Flutter frontend. The application allows users to browse, book, and manage travel services, with distinct features for customers and organizers.

## Prerequisites

### Software Requirements
- **Visual Studio**: [Download](https://code.visualstudio.com/download)
- **Eclipse**: [Download](https://www.eclipse.org/downloads/)
- **MySQL Workbench** (version 8.0.29): [Download](https://dev.mysql.com/downloads/installer/)
- **Postman**: [Download](https://www.postman.com/downloads/)
- **Android Studio**: [Download](https://developer.android.com/studio) for Android Emulator (Pixel 3a XL API 26)
- **Elasticsearch** (version 7.16.3): Available in the `elasticsearch 7.16.3` folder (MSI file)
- **Cloudinary Account**: Sign up at [Cloudinary](https://cloudinary.com/)
- **Google Cloud Account**: Sign up at [Google Cloud](https://cloud.google.com/) for Google Maps API
- **Firebase**: For Android project integration

## Setup Instructions

### 1. Database Configuration
1. **Install MySQL Workbench** and open the application.
2. Create a database named `travelservice` using the command:
   ```sql
   CREATE DATABASE travelservice;
   ```
3. Configure the database in the backend:
   - Path: `services/travel-services/src/main/resources/application.properties`
   - Update database credentials (e.g., URL, username, password) as needed.
4. (Optional) Adjust other properties in `application.properties` for additional configurations.

### 2. Cloudinary Setup
1. Create a [Cloudinary account](https://cloudinary.com/).
2. Upload images from `populating_data/images/Default` (including `Area` and `Category` subfolders) to Cloudinary.
3. Update `populating_data/tourism_service.sql` with the Cloudinary URLs for the `Area` and `Category` tables:
   - Replace existing URLs in the SQL file with the new Cloudinary URLs.

### 3. Google Cloud Setup
1. Create a [Google Cloud account](https://cloud.google.com/).
2. Generate a Google Maps API key: [Guide](https://developers.google.com/maps/documentation/javascript/get-api-key).
3. Replace the existing API key in the Flutter frontend:
   - Path: `application/travelservices/android/app/src/main/AndroidManifest.xml`

### 4. Elasticsearch Installation
1. Install Elasticsearch (version 7.16.3) using the MSI file in the `elasticsearch 7.16.3` folder.
2. Ensure Elasticsearch is running before starting the backend.

### 5. Firebase Configuration
1. Create a Firebase project and link it to the Android app in Android Studio.
2. Follow Firebase setup instructions to integrate with the Flutter frontend.

### 6. Backend Setup (Spring Boot)
1. Open `services/travel-services` folder in Eclipse.
2. Run the application:
   - Select `Run Application` in Eclipse.
   - The server will create necessary database tables in the `travelservice` database.

### 7. Frontend Setup (Flutter)
1. Open `application/travelservices` folder in Visual Studio.
2. Open the Android Emulator (Pixel 3a XL API 26) in Visual Studio.
3. Run the application:
   - Select `Run -> Run Without Debugging` or `Run -> Start Debugging`.

### 8. Populating Data
1. **Import Postman Collection**:
   - Import `populating_data/postman_collection.json` into Postman.
2. **Upload Images for Services**:
   - Navigate to `populating_data/images/Tourism Services`.
   - Use the `Upload Galleries` API in Postman to upload images for each travel service (each service has its own folder).
3. **Create Services**:
   - Use the response from `Upload Galleries` to form requests for the `Create Service` API.
   - Refer to `populating_data/to_add_data_json.txt` for the request format.

## Features

### Customer
1. Log in with a customer account.
2. Search for travel services.
3. Add services to favorites.
4. Update personal information.
5. Change password.
6. View travel service details.
7. Add services to the cart.
8. Book a travel service.
9. Log out.

### Organizer
1. Log in with an organizer account.
2. Add a new travel service.
3. Update existing travel service details.
4. Update order status.
5. Use the chat feature.

## Contact
- Email: nqnil2412@gmail.com