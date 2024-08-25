<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Customer</title>
    <link rel="stylesheet" href="/restaurant/admin/css/admin.css">
</head>
<body>




    <div class="main-content">
        <header>
            <h1>Edit Customer Details</h1>
        </header>
        <main>
            <%
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                int uid = Integer.parseInt(request.getParameter("uid"));

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");
                    String sql = "SELECT uid, name, email, password FROM register WHERE uid = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, uid);
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
            %>
            <form action="http://localhost:8090/restaurant/NewCustomerEditServlet" method="post">
                <input type="hidden" name="uid" value="<%= rs.getInt("uid") %>">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="<%= rs.getString("name") %>" required>
                <br>
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= rs.getString("email") %>" required>
                <br>
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" value="<%= rs.getString("password") %>" required>
                <br>
                <button type="submit">Update</button>
                <a href="http://localhost:8090/restaurant/admin/jsp/manage-customers.jsp">Cancel</a>
            </form>
            <%
                    } else {
                        out.println("Customer not found.");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </main>
    </div>
</body>
</html>
