# EcoTravel - Green Tour Planning Portal
## Setup Instructions

Thank you for choosing EcoTravel! Follow these steps to set up the project locally.

### 1. Database Configuration
1. Install [MySQL](https://dev.mysql.com/downloads/installer/) or a local stack like [XAMPP](https://www.apachefriends.org/).
2. Open your MySQL client or phpMyAdmin.
3. Import the `database/schema.sql` file. This creates the `ecotravel` database and its necessary tables: `users`, `destinations`, `hotels`, `transport`, `bookings`.
4. Import the `database/data.sql` file. This injects sample administrators, properties, and green-travel modes for testing.

### 2. Project Build and Setup
1. Open up your IDE (e.g., Eclipse IDE for Enterprise Java or IntelliJ IDEA).
2. Import the `EcoTravel` folder as an **Existing Maven Project**.
3. *Note*: If your database credentials (username/password) are not `root` and empty `""`, modify the `URL`, `USER`, and `PASSWORD` constants inside `src/main/java/com/ecotravel/util/DBConnection.java`.
4. Let Maven sync to download dependencies such as the Servlet APIs and MySQL Connector.
5. Alternatively, via command line context, run:
   ```bash
   mvn clean install
   ```
   This will generate a `target/EcoTravel-1.0-SNAPSHOT.war` executable file.

### 3. Server Deployment
1. Ensure you have [Apache Tomcat 9](https://tomcat.apache.org/download-90.cgi) (or 10, depending on Servlet spec compatibility) installed.
2. If using an IDE like Eclipse, attach your Tomcat Server within the "Server" view, add the `EcoTravel` module, and click Start.
3. If deploying manually, move the `EcoTravel-1.0-SNAPSHOT.war` file to your Tomcat `webapps` folder, rename it to `EcoTravel.war` for a cleaner URL path, and run Tomcat.

### 4. Running the Application
1. Open your web browser.
2. Navigate to `http://localhost:8080/EcoTravel/`
3. Feel free to use the pre-generated users for testing:
   - **User Mode**: Login with `john_doe` / `pass123` to test booking flows.
   - **Admin Mode**: Login with `admin` / `admin123` to view the comprehensive portal.

Enjoy your Eco-Touring platform!
