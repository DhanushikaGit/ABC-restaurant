<%@ page import="java.sql.*" %>
<%
    String query = request.getParameter("query");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String dbURL = "jdbc:mysql://localhost:3306/restaurant";
    String dbUser = "root";
    String dbPass = "1234";
    
    // SQL queries for facilities and services
    String searchSQLFacilities = "SELECT * FROM facilities WHERE name LIKE ?";
    String searchSQLServices = "SELECT * FROM services WHERE name LIKE ?";

    try {
        // Establish database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // Prepare and execute search query for facilities
        pstmt = conn.prepareStatement(searchSQLFacilities);
        pstmt.setString(1, "%" + query + "%");
        rs = pstmt.executeQuery();

        // Generate HTML for search results from facilities
        boolean hasResults = false;
        while (rs.next()) {
            hasResults = true;
            out.print("<div class='result-item'>");
            out.print("<h3>" + rs.getString("name") + "</h3>");
            out.print("<p>" + rs.getString("description") + "</p>");
           
            out.print("<p>Status: " + rs.getString("status") + "</p>");
            out.print("</div>");
        }

        // Prepare and execute search query for services
        pstmt = conn.prepareStatement(searchSQLServices);
        pstmt.setString(1, "%" + query + "%");
        rs = pstmt.executeQuery();

        // Generate HTML for search results from services
        while (rs.next()) {
            hasResults = true;
            out.print("<div class='result-item'>");
            out.print("<h3>" + rs.getString("name") + "</h3>");
            out.print("<p>" + rs.getString("description") + "</p>");
            
            out.print("</div>");
        }

        if (!hasResults) {
            out.print("<p>No results found.</p>");
        }
        
    } catch (Exception e) {
        e.printStackTrace();
        out.print("<p>Error retrieving results.</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
