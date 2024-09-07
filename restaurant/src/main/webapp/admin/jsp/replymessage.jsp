<%@ page import="java.sql.*, com.JavaWebApplication.Model.mydb" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Messages</title>
     <link href="/restaurant/customer/images/A B C (1).png" rel="icon">
    <style>
      /* General button styling */
.btn {
    padding: 8px 15px; /* Add more padding */
    border: none; /* Remove default border */
    border-radius: 4px; /* Rounded corners */
    cursor: pointer; /* Pointer cursor on hover */
    font-size: 14px; /* Font size */
    font-weight: bold; /* Bold text */
    text-align: center; /* Center-align text */
    transition: background-color 0.3s ease, transform 0.2s ease; /* Smooth transition */
}

/* Primary button styling */
.btn-primary {
    background-color: #007bff; /* Blue background */
    color: #fff; /* White text color */
}

.btn-primary:hover {
    background-color: #0056b3; /* Darker blue on hover */
    transform: scale(1.05); /* Slightly enlarge button on hover */
}

/* Danger button styling */
.btn-danger {
    background-color: #dc3545; /* Red background */
    color: #fff; /* White text color */
}

.btn-danger:hover {
    background-color: #c82333; /* Darker red on hover */
    transform: scale(1.05); /* Slightly enlarge button on hover */
}

/* Table styling */
table {
    width: 100%; /* Full width of container */
    border-collapse: collapse; /* Collapse borders */
    margin: 20px 0; /* Space above and below table */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
    border-radius: 8px; /* Rounded corners */
    overflow: hidden; /* Ensure no overflow */
}

th, td {
    padding: 12px; /* Padding inside cells */
    border: 1px solid #ddd; /* Light border around cells */
    text-align: left; /* Align text to the left */
}

th {
    background-color: #f2f2f2; /* Light gray background for headers */
    font-weight: bold; /* Bold text */
}

tr {
    background-color: #f9f9f9; /* Alternate row color */
}

tr:hover {
    background-color: #f1f1f1; /* Highlight row on hover */
}

/* Styling for textareas */
textarea {
    width: 100%; /* Full width of container */
    padding: 10px; /* Padding inside textarea */
    border: 1px solid #ddd; /* Light border */
    border-radius: 4px; /* Rounded corners */
    box-sizing: border-box; /* Include padding and border in total width and height */
    font-size: 16px; /* Font size */
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
/* Search form container */
.search-container {
    margin-bottom: 20px; /* Space below the search form */
    display: flex; /* Align items horizontally */
    justify-content: center; /* Center the search form */
}

/* Search input styling */
.search-container input[type="text"] {
    padding: 10px 15px; /* Padding inside the input field */
    border: 1px solid #ddd; /* Light border around the input */
    border-radius: 4px 0 0 4px; /* Rounded corners (left side only) */
    font-size: 16px; /* Font size */
    width: 300px; /* Set a fixed width */
    box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1); /* Inner shadow for depth */
}

/* Search button styling */
.search-container button {
    padding: 10px 15px; /* Padding inside the button */
    border: 1px solid #007bff; /* Border matching the primary button color */
    background-color: red; /* Blue background */
    color: #fff; /* White text color */
    font-size: 16px; /* Font size */
    font-weight: bold; /* Bold text */
    border-radius: 0 4px 4px 0; /* Rounded corners (right side only) */
    cursor: pointer; /* Pointer cursor on hover */
    transition: background-color 0.3s ease, transform 0.2s ease; /* Smooth transition */
}

.search-container button:hover {
    background-color: #FEA116; /* Darker blue on hover */
    transform: scale(1.05); /* Slightly enlarge button on hover */
}

/* Responsive adjustments */
@media (max-width: 600px) {
    .search-container input[type="text"] {
        width: 100%; /* Full width on small screens */
        border-radius: 4px 4px 0 0; /* Rounded corners (top side only) */
    }
    .search-container button {
        width: 100%; /* Full width on small screens */
        border-radius: 0 0 4px 4px; /* Rounded corners (bottom side only) */
    }
    .search-container {
        flex-direction: column; /* Stack input and button vertically */
        align-items: stretch; /* Stretch items to fill the container */
    }
}

    
    </style>
    
</head>
<body>
  <%@ include file="adminheader.jsp" %>
  <div class="page-header">
                <h1>View Messages</h1>
                <small>Home / View Messages </small>
            </div>
<div class="search-container">
    <form method="get" action="http://localhost:8090/restaurant/admin/jsp/replymessage.jsp">
        <input type="text" name="searchQuery" placeholder="Search by Name, Email, or Subject" value="<%= request.getParameter("searchQuery") != null ? request.getParameter("searchQuery") : "" %>">
        <button type="submit" class="btn btn-primary">Search</button>
    </form>
</div>


<table>
    <tr>
        <th>Name</th>
        <th>Email</th>
        <th>Subject</th>
        <th>Message</th>
        <th>Received Date</th>
        <th>Replies</th> <!-- New column for Replies -->
    </tr>

<%
    mydb db = new mydb();
    Connection conn = db.getCon();
    String searchQuery = request.getParameter("searchQuery");
    String sql = "SELECT * FROM contact_messages";
    
    if (searchQuery != null && !searchQuery.trim().isEmpty()) {
        sql += " WHERE name LIKE ? OR email LIKE ? OR subject LIKE ?";
    }
    
    sql += " ORDER BY created_at DESC";
    
    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            String searchPattern = "%" + searchQuery + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            pstmt.setString(3, searchPattern);
        }
        
        try (ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                int messageId = rs.getInt("id");
%>
    <tr>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("email") %></td>
        <td><%= rs.getString("subject") %></td>
        <td><%= rs.getString("message") %></td>
        <td><%= rs.getTimestamp("created_at") %></td>
        <td>
            <table> <!-- Nested table for replies -->
                <tr>
                    <th>Reply</th>
                    <th>Replied At</th>
                </tr>
                <%
                    // Fetch replies for the current message
                    String replySql = "SELECT * FROM replies WHERE message_id = ? ORDER BY replied_at DESC";
                    try (PreparedStatement replyPstmt = conn.prepareStatement(replySql)) {
                        replyPstmt.setInt(1, messageId);
                        try (ResultSet replyRs = replyPstmt.executeQuery()) {
                            while (replyRs.next()) {
                %>
                <tr>
                    <td><%= replyRs.getString("reply_content") %></td>
                    <td><%= replyRs.getTimestamp("replied_at") %></td>
                </tr>
                <%
                            }
                        }
                    }
                %>
            </table>
        </td>
    </tr>
<%
            }
        }
    } catch (SQLException e) {
        out.println("Error retrieving messages: " + e.getMessage());
    } finally {
        try {
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

</table>


</body>
  <%@ include file="adminfooter.jsp" %>
</html>
