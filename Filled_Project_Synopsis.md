# Shri Swami Samarth Institute of Management And Technology, Malwadi, Bota
## MCA I SEM II
## SPPU EXTERNAL MINI PROJECT

### 1. Title Page
* **Project Title:** Web-Based Movie Ticket Booking System (Migration from Java Desktop to Web)
* **Student Name:** [Your Name]
* **Roll Number:** [Your Roll Number]
* **Branch:** Master of Computer Applications (MCA)
* **Batch:** [Your Batch/Year]
* **Supervisor Details:** [Guide/Supervisor Name]
* **Institution Name:** Shri Swami Samarth Institute of Management And Technology, Malwadi, Bota
* **Date of Submission:** [Date]

### 2. Introduction
* **Brief Description:** This project is a comprehensive online movie ticket booking platform, inspired by standard platforms like BookMyShow. It involves upgrading and migrating an existing standalone Java Swing desktop application into a modern web-based format.
* **Background Information:** Traditionally, desktop-based systems are restricted to local machines. To increase accessibility and modernize the user interface, this project moves the booking logic, administration, and database over to a web server capable of handling multiple remote users concurrently.
* **Key Terms/Technologies:** Java Servlets, JSP (JavaServer Pages), Apache Tomcat 9, SQLite Database, HTML, CSS, JavaScript.

### 3. Problem Statement
* **Define the Issue:** The existing legacy Java Swing movie booking application is constrained to local access and relies on a desktop environment, making it inaccessible over the internet and unable to support simultaneous, distributed user access.
* **Significance:** In today's digital era, accessibility and remote booking are fundamental requirements for any ticketing business. Solving this issue bridges a technological gap by adopting a web-based architecture.
* **Objectives and Scope:** 
  - To migrate desktop application logic to Java Servlets.
  - To implement user registration, login, online booking, and payment mockups via JSP pages.
  - To implement an administrative dashboard to manage movies and view all bookings.

### 4. Rationale / Significance
* **Why the Project is Important:** By moving to the web, the system offers 24/7 access to users from any internet-connected device. It provides real-time updates on seat availability and streamlines the ticket purchasing process.
* **Contributions/Benefits:** The migration drastically improves the system's usability, scalability, and maintainability. Users benefit from a seamless online booking experience, while administrators can centrally manage the theater's operations in real time.

### 5. Methodology
* **Approach, Tools, and Techniques:** 
  - **Architecture:** Client-Server architecture following the MVC (Model-View-Controller) design pattern (Servlets handling controllers, JSP handling views).
  - **Platform:** Apache Tomcat Web Server.
  - **Database Integration:** JDBC (Java Database Connectivity) connected with a SQLite database.
* **Diagrams:** Use-case diagrams (e.g., User can View Movies, Book Ticket, View Bookings; Admin can Add Movie, View All Bookings).
* **Requirements:** Local web server configuration (`web.xml` servlet mapping), front-end designing (HTML/JS), backend logic processing (Servlets).

### 6. Resources and Limitations
* **Hardware/Software Resources:**
  - **Hardware:** standard Intel/AMD PC with at least 4GB RAM.
  - **Software:** Java Development Kit (JDK) 8+, Apache Tomcat 9.0+, IDE (VS Code or Eclipse), SQLite Studio, Modern Web Browser.
* **Limitations:**
  - The payment gateway functionality will be a simulated mock-up.
  - SQLite database is file-based and may not support thousands of concurrent high-scale database writes similar to enterprise databases like MySQL/Oracle.

### 7. Expected Outcomes / Contribution
* **Anticipated Results:** A fully functional, fully deployed web application hosted on Apache Tomcat that successfully mirrors the core functionalities of the previous desktop application but with a polished, browser-accessible user interface.
* **Benefits:** Demonstrates hands-on knowledge in upgrading legacy software to web platforms, handling session management, structuring application security (Admin vs. User roles), and mastering web deployments.

### 8. Project Schedule
* **Phase 1 (Week 1):** Requirement Analysis & Code Refactoring (Studying existing desktop code).
* **Phase 2 (Week 2):** UI/UX Design (Creating JSP pages for booking, login, dashboard, adding movies).
* **Phase 3 (Week 3):** Backend Migration (Connecting Servlets via `web.xml`, integrating SQLite queries).
* **Phase 4 (Week 4):** Integration, Bug Fixing & Testing (Testing application on Apache Tomcat, final submission).

### 9. References / Bibliography
* **Books:** *Head First Servlets and JSP* by Bryan Basham, Kathy Sierra, and Bert Bates.
* **Websites:** 
  - Apache Tomcat Documentation (http://tomcat.apache.org/)
  - Oracle Java Docs (https://docs.oracle.com/en/java/)
  - Web UI references: W3Schools, MDN Web Docs.
* **Citation Style:** IEEE or APA style as recommended by the institution.
