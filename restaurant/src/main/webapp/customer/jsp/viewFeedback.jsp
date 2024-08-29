<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Feedback - ABC Restaurant</title>
    <link href="/restaurant/customer/images/A B C (1).png" rel="icon">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        :root {
            --primary: #FEA116;
            --light: #F1F8FF;
            --dark: #0F172B;
        }
        .container {
            margin-top: 20px;
        }
        h1 {
            color: var(--primary);
        }
        .feedback-table th {
            background-color: var(--dark);
            color: var(--light);
        }
        .feedback-table td {
            vertical-align: middle;
        }
        .star-rating {
            color: #F1F8FF;
            font-size: 1.5rem;
        }
        .star-rating .fas {
            color: #FEA116;
        }
    </style>
</head>
<body>

    <%@ include file="header.jsp" %>

    <div class="container">
        <h1 class="text-center">View Feedback</h1>
        <table class="table table-bordered feedback-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Feedback</th>
                    <th>Rating</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

                        String sql = "SELECT id, name, email, feedback, rating FROM feedback";
                        pstmt = conn.prepareStatement(sql);
                        rs = pstmt.executeQuery();

                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String name = rs.getString("name");
                            String email = rs.getString("email");
                            String feedback = rs.getString("feedback");
                            int rating = rs.getInt("rating");
                %>
                <tr>
                    <td><%= id %></td>
                    <td><%= name %></td>
                    <td><%= email %></td>
                    <td><%= feedback %></td>
                    <td>
                        <div class="star-rating">
                            <% for (int i = 1; i <= 5; i++) { %>
                                <% if (i <= rating) { %>
                                    <i class="fas fa-star"></i>
                                <% } else { %>
                                    <i class="far fa-star"></i>
                                <% } %>
                            <% } %>
                        </div>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>
            </tbody>
        </table>
    </div>

    <%@ include file="footer.jsp" %>

    <!-- Font Awesome for star icons -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
</body>
</html>
