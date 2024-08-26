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
    
    </style>
    
</head>
<body>
  <%@ include file="adminheader.jsp" %>
  <div class="page-header">
                <h1>View Messages</h1>
                <small>Home / View Messages </small>
            </div>


<table>
    <tr>
        <th>Name</th>
        <th>Email</th>
        <th>Subject</th>
        <th>Message</th>
        <th>Received Date</th>
     
    </tr>

    <%
        mydb db = new mydb();
        Connection conn = db.getCon();
        if (conn != null) {
            String sql = "SELECT * FROM contact_messages ORDER BY created_at DESC";
            try (PreparedStatement pstmt = conn.prepareStatement(sql);
                 ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    int messageId = rs.getInt("id");
    %>
    <tr>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("email") %></td>
        <td><%= rs.getString("subject") %></td>
        <td><%= rs.getString("message") %></td>
        <td><%= rs.getTimestamp("created_at") %></td>
        
    </tr>
    <%
                    // Fetch replies for the current message
                    String replySql = "SELECT * FROM replies WHERE message_id = ? ORDER BY replied_at DESC";
                    try (PreparedStatement replyPstmt = conn.prepareStatement(replySql)) {
                        replyPstmt.setInt(1, messageId);
                        try (ResultSet replyRs = replyPstmt.executeQuery()) {
                            while (replyRs.next()) {
                                int replyId = replyRs.getInt("id");
    %>
    
    <%
                            }
                        }
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
        }
    %>
</table>

</body>
</html>
