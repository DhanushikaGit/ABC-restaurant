<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1">
    <title>Manage Customers</title>
    <link rel="stylesheet" href="/restaurant/admin/css/admin.css">
    <link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
    <script>
        function confirmDelete() {
            return confirm('Are you sure you want to delete this record?');
        }
    </script>
</head>
<body>
  <jsp:include page="header.jsp"></jsp:include>
  
        
        
        <main>
            
            <div class="page-header">
                <h1>Manage Customers</h1>
                <small>Home / Manage Customers</small>
            </div>
            
            <div class="page-content">
            
                <div class="records table-responsive">

                    <div class="record-header">
                        <div class="add">
                            <span>Entries</span>
                            <select name="entries" id="entries">
                                <option value="10">10</option>
                                <option value="25">25</option>
                                <option value="50">50</option>
                                <option value="100">100</option>
                            </select>
                            <button>Add record</button>
                        </div>

                        <div class="browse">
                            <form action="manage-customers.jsp" method="get">
                                <input type="search" name="searchQuery" placeholder="Search" class="record-search">
                                <select name="searchField">
                                    <option value="name">Name</option>
                                    <option value="email">Email</option>
                                    <option value="uid">ID</option>
                                </select>
                                <button type="submit">Search</button>
                            </form>
                        </div>
                    </div>

                    <div>
                        <table width="100%">
                            <thead>
                                <tr>
                                    <th>UID</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Password</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
    <%
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String searchQuery = request.getParameter("searchQuery");
        String searchField = request.getParameter("searchField");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");
            stmt = conn.createStatement();
            
            String sql = "SELECT uid, name, email, password FROM register";
            
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                if (searchField.equals("uid")) {
                    sql += " WHERE uid LIKE '%" + searchQuery + "%'";
                } else if (searchField.equals("name")) {
                    sql += " WHERE name LIKE '%" + searchQuery + "%'";
                } else if (searchField.equals("email")) {
                    sql += " WHERE email LIKE '%" + searchQuery + "%'";
                }
            }
            
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
    %>
    <tr>
        <td><%= rs.getInt("uid") %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("email") %></td>
        <td><%= rs.getString("password") %></td>
        <td>
            <form action="http://localhost:8090/restaurant/admin/jsp/edit-customer.jsp" method="post" style="display:inline;">
                <input type="hidden" name="uid" value="<%= rs.getInt("uid") %>">
                <input type="submit" value="Edit" class="action-button edit-button">
            </form>
            <form action="http://localhost:8090/restaurant/DeleteCustomerServlet" method="post" style="display:inline;" onsubmit="return confirmDelete();">
                <input type="hidden" name="uid" value="<%= rs.getInt("uid") %>">
                <input type="submit" value="Delete" class="action-button delete-button">
            </form>
            <form action="http://localhost:8090/restaurant/ContactCustomerServlet" method="post" style="display:inline;">
                <input type="hidden" name="email" value="<%= rs.getString("email") %>">
                <input type="submit" value="Contact" class="action-button contact-button">
            </form>
        </td>
    </tr>
    <%
            }
        } catch (Exception e) {
            out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
</tbody>
                    
                        </table>
                    </div>

                </div>
            
            </div>
            
        </main>
        
    </div>
</body>
</html>
