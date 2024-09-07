<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Facilities</title>
    <link href="/restaurant/customer/images/A B C (1).png" rel="icon">
    <link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
    <style>
    
      :root {
        --primary: #FEA116; /* Primary color */
        --light: #F1F8FF;   /* Light color */
        --dark: #0F172B;    /* Dark color */
    }

    body {
        font-family: Arial, sans-serif; /* Basic font family */
        margin: 0; /* Remove default margin */
        padding: 0; /* Remove default padding */
        background-color: #f4f4f4; /* Light gray background */
    }

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

    form {
        background-color: var(--light); /* Light background for the form */
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        max-width: 600px;
        margin: 20px auto;
    }

    form input[type="text"], form textarea, form select, form input[type="file"] {
        width: 100%;
        border: 1px solid var(--dark);
        padding: 10px;
        border-radius: 4px;
        background-color: #fff;
        color: var(--dark);
        margin-bottom: 15px;
    }

    form textarea {
        height: 100px;
        resize: vertical;
    }

    form input[type="submit"] {
        background-color: var(--primary); /* Primary color for the submit button */
        color: #fff;
        border: none;
        padding: 10px 20px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
    }

    form input[type="submit"]:hover {
        background-color: #e68900; /* Slightly darker shade for hover effect */
    }

    @media (max-width: 768px) {
        form {
            padding: 15px;
        }

        form input[type="text"], form textarea, form select, form input[type="file"] {
            font-size: 14px;
        }

        form input[type="submit"] {
            font-size: 14px;
        }
    }

    .search-form {
        display: flex; /* Use flexbox to align items horizontally */
        align-items: center; /* Align items vertically center */
        gap: 10px; /* Space between items */
        background-color: var(--light); /* Background color for the search form */
        padding: 10px; /* Padding for better spacing */
        border-radius: 8px; /* Rounded corners */
        box-shadow: 0 0 5px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
        max-width: 600px; /* Limit the width of the search form */
        margin: 20px auto; /* Center the form horizontally */
    }

    .search-form input[type="search"],
    .search-form select,
    .search-form button {
        padding: 10px;
        border: 1px solid var(--dark);
        border-radius: 4px;
        font-size: 16px; /* Adjust font size */
    }

    .search-form input[type="search"] {
        flex: 1; /* Allow the search input to take up available space */
    }

    .search-form select,
    .search-form button {
        background-color: #fff;
        color: var(--dark);
    }

    .search-form button {
        background-color: var(--primary); /* Primary color for the button */
        color: #fff;
        border: none;
    }

    .search-form button:hover {
        background-color: #e68900; /* Slightly darker shade for hover effect */
    }
/* Table styling */
table {
    width: 100%; /* Full width of the container */
    border-collapse: collapse; /* Collapse borders */
    background-color: #fff; /* White background for the table */
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Light shadow for depth */
    margin: 20px auto; /* Center the table horizontally */
}

th, td {
    padding: 12px; /* Padding inside table cells */
    border-bottom: 1px solid #ddd; /* Light border at the bottom of cells */
    text-align: left; /* Align text to the left */
}

th {
    background-color: #f1f1f1; /* Light gray background for headers */
}

tr:hover {
    background-color: #f9f9f9; /* Light gray background on hover */
}

/* Image styling */
.facility-image {
    max-width: 100px; /* Limit image width */
    max-height: 100px; /* Limit image height */
    object-fit: cover; /* Cover the object area */
}

/* Buttons styling */
.edit-button, .delete-button {
    padding: 5px 10px; /* Padding inside buttons */
    border: none; /* Remove border */
    color: #fff; /* White text */
    cursor: pointer; /* Pointer cursor on hover */
    border-radius: 4px; /* Rounded corners */
    font-size: 14px; /* Font size */
}

.edit-button {
    background-color: var(--primary); /* Primary color for edit button */
}

.edit-button:hover {
    background-color: #e68900; /* Slightly darker shade on hover */
}

.delete-button {
    background-color: #f44336; /* Red background for delete button */
}

.delete-button:hover {
    background-color: #e53935; /* Darker red on hover */
}

/* Error message styling */
table td[colspan='7'] {
    color: #f44336; /* Red text for error */
    text-align: center; /* Center align text */
    padding: 20px; /* Padding around text */
}

    tr:hover {
        background-color: #f9f9f9; /* Light gray background on hover */
    }

    .food-image {
        max-width: 100px; /* Limit image width */
        max-height: 100px; /* Limit image height */
        object-fit: cover; /* Cover the object area */
    }

    .edit-button, .delete-button {
        padding: 5px 10px; /* Padding inside buttons */
        border: none; /* Remove border */
        color: #fff; /* White text */
        cursor: pointer; /* Pointer cursor on hover */
        border-radius: 4px; /* Rounded corners */
        font-size: 14px; /* Font size */
    }

    .edit-button {
        background-color: var(--primary); /* Primary color for edit button */
    }

    .edit-button:hover {
        background-color: #e68900; /* Slightly darker shade on hover */
    }

    .delete-button {
        background-color: #f44336; /* Red background for delete button */
    }

    .delete-button:hover {
        background-color: #e53935; /* Darker red on hover */
    }

    table td[colspan='7'] {
        color: #f44336; /* Red text for error */
        text-align: center; /* Center align text */
        padding: 20px; /* Padding around text */
    }
    </style>
    <script>
        function confirmDelete() {
            return confirm('Are you sure you want to delete this food item?');
        }
    </script>
</head>
<body>
    <%@ include file="adminheader.jsp" %>
    <div class="page-header">
        <h1>Manage Facilities</h1>
        <small>Home / Manage Facilities</small>
    </div>

    <!-- Search Form -->
    <div class="search-form">
        <form action="ManageFacilities.jsp" method="get">
            <input type="search" name="search" placeholder="Search facilities..." value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
            <button type="submit">Search</button>
        </form>
    </div>

    <!-- Form to Add a New Facility -->
    <form action="http://localhost:8090/restaurant/AddFacilityServlet" method="post" enctype="multipart/form-data">
        <label for="name">Facility Name:</label>
        <input type="text" id="name" name="name" required><br><br>

        <label for="description">Description:</label>
        <textarea id="description" name="description" required></textarea><br><br>

        <label for="status">Status:</label>
        <select id="status" name="status" required>
            <option value="Available">Available</option>
            <option value="Unavailable">Unavailable</option>
        </select><br><br>

        <label for="image">Image:</label>
        <input type="file" id="image" name="image" accept="image/*"><br><br>

        <input type="submit" value="Add Facility">
    </form>

    <!-- Display List of Existing Facilities -->
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Status</th>
            <th>Image</th>
            <th>Actions</th>
        </tr>
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            String searchQuery = request.getParameter("search");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

                String sql = "SELECT id, name, description, status, image FROM facilities";
                if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                    sql += " WHERE name LIKE ? OR description LIKE ?";
                }
                pstmt = conn.prepareStatement(sql);

                if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                    pstmt.setString(1, "%" + searchQuery + "%");
                    pstmt.setString(2, "%" + searchQuery + "%");
                }
                
                rs = pstmt.executeQuery();

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("description") %></td>
            <td><%= rs.getString("status") %></td>
            <td>
                <% 
                    String imagePath = rs.getString("image");
                    String imageUrl = (imagePath != null && !imagePath.isEmpty()) 
                        ? request.getContextPath() + "/uploads/" + imagePath 
                        : ""; 
                %>
                <% if (!imageUrl.isEmpty()) { %>
                    <img src="<%= imageUrl %>" alt="Facility Image" class="facility-image">
                <% } else { %>
                    No Image
                <% } %>
            </td>
            <td>
                <form action="http://localhost:8090/restaurant/admin/jsp/EditFacility.jsp" method="get" style="display:inline;">
                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                    <button type="submit" class="edit-button"><i class="las la-edit"></i></button>
                </form>
                <form action="http://localhost:8090/restaurant/DeleteFacilityServlet" method="post" style="display:inline;" onsubmit="return confirmDelete();">
                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                    <button type="submit" class="delete-button"><i class="las la-trash"></i></button>
                </form>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </table>
</body>
  <%@ include file="adminfooter.jsp" %>
</html>
