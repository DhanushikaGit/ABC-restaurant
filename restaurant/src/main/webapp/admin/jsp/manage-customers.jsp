<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1">
    <title>Manage Customers</title>
    <link rel="stylesheet" href="/restaurant/admin/css/admin.css">
     <link href="/restaurant/customer/images/A B C (1).png" rel="icon">
    <link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
   <script>
        function confirmDelete() {
            return confirm('Are you sure you want to delete this record?');
        }

        // Show alert based on the session message
        window.onload = function() {
            const message = "<%= session.getAttribute("message") %>";
            if (message) {
                alert(message);
                session.removeAttribute("message"); // Clear the message after showing it
            }
        };
    </script>
    <style>
    /* General body styles */
body {
    font-family: Arial, sans-serif; /* Basic font family */
    margin: 0; /* Remove default margin */
    padding: 0; /* Remove default padding */
    background-color: #f4f4f4; /* Light gray background */
}

main {
    padding: 20px; /* Padding around the main content */
}

/* Page header styling */
.page-header {
    background-color: #ffffff; /* White background for the header */
    padding: 20px; /* Padding inside the header */
    border-bottom: 1px solid #ddd; /* Light border at the bottom */
    margin-bottom: 20px; /* Space below the header */
}

.page-header h1 {
    margin: 0; /* Remove default margin */
    font-size: 1.5rem; /* Larger font size for the title */
    color: #333; /* Dark gray color */
}

.page-header small {
    color: #888; /* Light gray color for the breadcrumb */
}

/* Record header styles */
.record-header {
    display: flex; /* Use flexbox for layout */
    justify-content: space-between; /* Space between elements */
    margin-bottom: 20px; /* Space below the record header */
}

.record-header .add,
.record-header .browse {
    display: flex; /* Use flexbox for layout */
    align-items: center; /* Align items vertically */
}

.record-header select,
.record-header input[type="search"],
.record-header button {
    margin-right: 10px; /* Space between elements */
    padding: 10px; /* Padding inside the elements */
    border-radius: 4px; /* Rounded corners */
    border: 1px solid #ddd; /* Light border */
}

.record-header button {
    background-color: #007bff; /* Blue background color */
    color: #fff; /* White text color */
    border: none; /* Remove default border */
    cursor: pointer; /* Pointer cursor on hover */
    transition: background-color 0.3s; /* Smooth background color transition */
}

.record-header button:hover {
    background-color: #0056b3; /* Darker blue on hover */
}

/* Table styles */
.records table {
    width: 100%; /* Full width of the container */
    border-collapse: collapse; /* Collapse borders */
    background-color: #fff; /* White background for the table */
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Light shadow for depth */
}

.records th, .records td {
    padding: 12px; /* Padding inside table cells */
    border-bottom: 1px solid #ddd; /* Light border at the bottom of cells */
    text-align: left; /* Align text to the left */
}

.records th {
    background-color: #f1f1f1; /* Light gray background for headers */
}

.records tr:hover {
    background-color: #f9f9f9; /* Light gray background on hover */
}

/* Action button styles */
.action-button {
    padding: 8px 12px; /* Padding inside buttons */
    border: none; /* Remove default border */
    border-radius: 4px; /* Rounded corners */
    color: #fff; /* White text color */
    cursor: pointer; /* Pointer cursor on hover */
    font-size: 14px; /* Font size for buttons */
    margin-right: 5px; /* Space between buttons */
}

.edit-button {
    background-color: #28a745; /* Green background for edit button */
}

.delete-button {
    background-color: #dc3545; /* Red background for delete button */
}

.contact-button {
    background-color: #007bff; /* Blue background for contact button */
}

.edit-button:hover {
    background-color: #218838; /* Darker green on hover */
}

.delete-button:hover {
    background-color: #c82333; /* Darker red on hover */
}

.contact-button:hover {
    background-color: #0056b3; /* Darker blue on hover */
}

/* Responsive design for smaller screens */
@media (max-width: 768px) {
    .record-header {
        flex-direction: column; /* Stack items vertically */
        align-items: flex-start; /* Align items to the start */
    }

    .record-header select,
    .record-header input[type="search"],
    .record-header button {
        margin-bottom: 10px; /* Space below elements */
        width: 100%; /* Full width on smaller screens */
    }
}
    
    </style>
</head>
<body>
   <%@ include file="adminheader.jsp" %>
  
        
        
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
