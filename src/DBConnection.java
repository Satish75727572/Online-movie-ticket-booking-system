import java.sql.*;

public class DBConnection {

    private static String getDbPath() {
        // Try to resolve path relative to webapp root for Tomcat
        String catalinaBase = System.getProperty("catalina.base");
        if (catalinaBase != null) {
            return catalinaBase + "/webapps/Project/data/movie.db";
        }
        return "data/movie.db";
    }

    public static Connection connect() {
        try {
            Class.forName("org.sqlite.JDBC");
            Connection conn = DriverManager.getConnection("jdbc:sqlite:" + getDbPath());
            return conn;
        } catch (Exception e) {
            System.out.println("Database Connection Failed!");
            e.printStackTrace();
            return null;
        }
    }

    public static void initialize() {
        try {
            Connection conn = connect();
            if (conn == null) return;

            Statement stmt = conn.createStatement();

            // Users table
            stmt.execute("CREATE TABLE IF NOT EXISTS users (" +
                    "id INTEGER PRIMARY KEY AUTOINCREMENT," +
                    "username TEXT UNIQUE," +
                    "password TEXT)");

            // Movies table (enhanced)
            stmt.execute("CREATE TABLE IF NOT EXISTS movies (" +
                    "id INTEGER PRIMARY KEY AUTOINCREMENT," +
                    "name TEXT," +
                    "price INTEGER," +
                    "image TEXT DEFAULT ''," +
                    "genre TEXT DEFAULT 'Action'," +
                    "rating REAL DEFAULT 8.0," +
                    "duration TEXT DEFAULT '2h 30m'," +
                    "description TEXT DEFAULT 'An amazing movie experience!')");

            // Bookings table (enhanced)
            stmt.execute("CREATE TABLE IF NOT EXISTS bookings (" +
                    "id INTEGER PRIMARY KEY AUTOINCREMENT," +
                    "username TEXT," +
                    "movie TEXT," +
                    "seats TEXT," +
                    "total INTEGER," +
                    "showtime TEXT DEFAULT ''," +
                    "booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");

            // Add columns if they don't exist (for migration)
            try { stmt.execute("ALTER TABLE movies ADD COLUMN genre TEXT DEFAULT 'Action'"); } catch(Exception e) {}
            try { stmt.execute("ALTER TABLE movies ADD COLUMN rating REAL DEFAULT 8.0"); } catch(Exception e) {}
            try { stmt.execute("ALTER TABLE movies ADD COLUMN duration TEXT DEFAULT '2h 30m'"); } catch(Exception e) {}
            try { stmt.execute("ALTER TABLE movies ADD COLUMN description TEXT DEFAULT 'An amazing movie experience!'"); } catch(Exception e) {}
            try { stmt.execute("ALTER TABLE movies ADD COLUMN image TEXT DEFAULT ''"); } catch(Exception e) {}
            try { stmt.execute("ALTER TABLE bookings ADD COLUMN showtime TEXT DEFAULT ''"); } catch(Exception e) {}
            try { stmt.execute("ALTER TABLE bookings ADD COLUMN booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP"); } catch(Exception e) {}

            // Insert default movies
            stmt.execute("INSERT INTO movies(name,price,image,genre,rating,duration,description) " +
                    "SELECT 'Avengers',200,'images/avengers.png','Action/Sci-Fi',9.2,'2h 45m','Earth''s mightiest heroes must come together to stop an alien invasion.' " +
                    "WHERE NOT EXISTS(SELECT 1 FROM movies WHERE name='Avengers')");

            stmt.execute("INSERT INTO movies(name,price,image,genre,rating,duration,description) " +
                    "SELECT 'Pushpa 2',250,'images/pushpa2.png','Action/Drama',8.8,'3h 10m','The rise continues as Pushpa takes on new challenges in the smuggling world.' " +
                    "WHERE NOT EXISTS(SELECT 1 FROM movies WHERE name='Pushpa 2')");

            stmt.execute("INSERT INTO movies(name,price,image,genre,rating,duration,description) " +
                    "SELECT 'KGF 3',300,'images/kgf3.png','Action/Thriller',9.0,'2h 55m','Rocky returns for the ultimate showdown in the gold mines of Kolar.' " +
                    "WHERE NOT EXISTS(SELECT 1 FROM movies WHERE name='KGF 3')");

            // 2026 Movies
            stmt.execute("INSERT INTO movies(name,price,image,genre,rating,duration,description) " +
                    "SELECT 'Avengers: Doomsday',250,'images/doomsday.png','Action/Sci-Fi',9.5,'2h 45m','The Avengers reassemble to face a new universal threat.' " +
                    "WHERE NOT EXISTS(SELECT 1 FROM movies WHERE name='Avengers: Doomsday')");

            stmt.execute("INSERT INTO movies(name,price,image,genre,rating,duration,description) " +
                    "SELECT 'The Batman - Part II',220,'images/batman2.png','Action/Crime',9.0,'2h 50m','The Dark Knight faces a new, mysterious serial killer in Gotham City.' " +
                    "WHERE NOT EXISTS(SELECT 1 FROM movies WHERE name='The Batman - Part II')");
            
            stmt.execute("INSERT INTO movies(name,price,image,genre,rating,duration,description) " +
                    "SELECT 'Toy Story 5',180,'images/toystory5.png','Animation/Comedy',8.5,'1h 45m','Woody, Buzz, and the gang embark on an unexpected new adventure.' " +
                    "WHERE NOT EXISTS(SELECT 1 FROM movies WHERE name='Toy Story 5')");

            stmt.execute("INSERT INTO movies(name,price,image,genre,rating,duration,description) " +
                    "SELECT 'Supergirl: Woman of Tomorrow',200,'images/supergirl.png','Action/Sci-Fi',8.7,'2h 20m','Kara Zor-El sets off on an epic journey across the cosmos.' " +
                    "WHERE NOT EXISTS(SELECT 1 FROM movies WHERE name='Supergirl: Woman of Tomorrow')");

            stmt.execute("INSERT INTO movies(name,price,image,genre,rating,duration,description) " +
                    "SELECT 'The Mandalorian & Grogu',240,'images/mandalorian.png','Action/Sci-Fi',9.1,'2h 15m','Din Djarin and Grogu embark on a new cinematic adventure.' " +
                    "WHERE NOT EXISTS(SELECT 1 FROM movies WHERE name='The Mandalorian & Grogu')");

            // Update existing movies with images if missing
            stmt.execute("UPDATE movies SET image='images/avengers.png', genre='Action/Sci-Fi', rating=9.2, duration='2h 45m', " +
                    "description='Earth''s mightiest heroes must come together to stop an alien invasion.' " +
                    "WHERE name='Avengers' AND (image IS NULL OR image='')");

            stmt.execute("UPDATE movies SET image='images/pushpa2.png', genre='Action/Drama', rating=8.8, duration='3h 10m', " +
                    "description='The rise continues as Pushpa takes on new challenges in the smuggling world.' " +
                    "WHERE name='Pushpa 2' AND (image IS NULL OR image='')");

            stmt.execute("UPDATE movies SET image='images/kgf3.png', genre='Action/Thriller', rating=9.0, duration='2h 55m', " +
                    "description='Rocky returns for the ultimate showdown in the gold mines of Kolar.' " +
                    "WHERE name='KGF 3' AND (image IS NULL OR image='')");

            System.out.println("Database Initialized Successfully!");
            conn.close();

        } catch (Exception e) {
            System.out.println("Database Initialization Failed!");
            e.printStackTrace();
        }
    }
}