# EcoTravel - Green Tour Planning Portal
## Setup Instructions

Thank you for choosing EcoTravel! Follow these steps to set up the project locally.

### 1. Database Configuration
1. Install [MySQL](https://dev.mysql.com/downloads/installer/) or a local stack like [XAMPP](https://www.apachefriends.org/).
2. Open your MySQL client or phpMyAdmin.
3. Import `database/schema.sql` once. This creates the `ecotravel` database and its tables: `users`, `destinations`, `hotels`, and `bookings`.
4. On startup, the application initializes the schema and loads the sample users, destinations, and hotels from `database/data.sql`. The sample inserts are idempotent and do not delete existing hotels.
5. If the listings are still empty, check the Tomcat startup log for a database connection or initialization error and verify the database settings below.

### 2. Project Build and Setup
1. Open up your IDE (e.g., Eclipse IDE for Enterprise Java or IntelliJ IDEA).
2. Import the `EcoTravel` folder as an **Existing Maven Project**.
3. Set the database environment variables before starting Tomcat:
   - `DB_URL=jdbc:mysql://localhost:3306/ecotravel?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true`
   - `DB_USER=<your MySQL username>`
   - `DB_PASSWORD=<your MySQL password>`
   Set email delivery for booking confirmations too:
   - `MAIL_USERNAME=<your SMTP account email>`
   - `MAIL_PASSWORD=<your SMTP app password>`
   - Optional: `MAIL_FROM=<sender email>`, `MAIL_SMTP_HOST=smtp.gmail.com`, `MAIL_SMTP_PORT=465`
   The default SMTP settings use SSL on port 465. Keep all credentials in your local `.env` file and do not commit that file. Restart Tomcat after changing `.env`.
4. Booking confirmation emails are sent to the email address on the registered user account after payment is confirmed. The SMTP account must allow SMTP/app-password access.
5. Let Maven sync to download dependencies such as the Servlet APIs and MySQL Connector.
6. Alternatively, via command line context, run:
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
