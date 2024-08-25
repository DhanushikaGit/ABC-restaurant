<%@ page import="java.sql.*, com.JavaWebApplication.Model.mydb" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Messages</title>
    <style>
        .btn { padding: 5px 10px; border: none; cursor: pointer; }
        .btn-primary { background-color: #007bff; color: #fff; }
        .btn-danger { background-color: #dc3545; color: #fff; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 10px; border: 1px solid #ddd; text-align: left; }
        th { background-color: #f2f2f2; }
        textarea { width: 100%; }
    </style>
    
</head>
<body>

<h2>Contact Messages</h2>

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
