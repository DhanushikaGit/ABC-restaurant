<%@ page import="java.sql.*, com.JavaWebApplication.Model.mydb" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Messages</title>
    <style>
        :root {
            --primary: #FEA116;
            --light: #F1F8FF;
            --dark: #0F172B;
            --border: #ddd; /* Added missing border color variable */
            --danger: #dc3545; /* Added missing danger color variable */
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            color: var(--dark);
            margin: 0;
            padding: 20px;
        }

        h2 {
            color: var(--primary);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            border: 1px solid var(--border);
            text-align: left;
        }

        th {
            background-color: var(--primary);
            color: #fff;
        }

        tr:nth-child(even) {
            background-color: var(--light);
        }

        tr:nth-child(odd) {
            background-color: #fff;
        }

        textarea {
            width: 100%;
            border: 1px solid var(--border);
            border-radius: 4px;
            padding: 8px;
            resize: vertical;
        }

        .btn {
            padding: 8px 15px;
            border: none;
            cursor: pointer;
            font-size: 14px;
            border-radius: 4px;
        }

        .btn-primary {
            background-color: var(--primary);
            color: #fff;
        }

        .btn-danger {
            background-color: var(--danger);
            color: #fff;
        }

        .btn-primary:hover, .btn-danger:hover {
            opacity: 0.8;
        }
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
        <th>Action</th>
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
        <td>
            <form action="reply.jsp" method="get" style="display:inline;">
                <input type="hidden" name="message_id" value="<%= messageId %>">
                <input type="submit" value="Reply" class="btn btn-primary">
            </form>
            <form action="http://localhost:8090/restaurant/DeleteMessageServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this message?');" style="display:inline;">
                <input type="hidden" name="message_id" value="<%= messageId %>">
                <input type="submit" value="Delete" class="btn btn-danger">
            </form>
        </td>
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
    <tr>
        <td colspan="6" style="background-color: #f9f9f9;">
            <strong>Reply:</strong><br>
            <textarea readonly><%= replyRs.getString("reply_content") %></textarea>
            <form action="http://localhost:8090/restaurant/DeleteReplyServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this reply?');" style="display:inline;">
                <input type="hidden" name="reply_id" value="<%= replyId %>">
                <input type="hidden" name="message_id" value="<%= messageId %>">
                <input type="submit" value="Delete Reply" class="btn btn-danger">
            </form>
        </td>
    </tr>
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
