<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.JavaWebApplication.Model.mydb" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <link rel="stylesheet" href="/restaurant/admin/css/admin.css" />
    <link href="/restaurant/customer/images/A B C (1).png" rel="icon">
    <title>ABC Restaurant</title>
</head>

<body>

    <%@ include file="adminheader.jsp" %>

    <%
        mydb db = new mydb();
        Connection conn = db.getCon();
        Statement stmt = null;
        ResultSet rs = null;
        int totalProducts = 0;
        double totalSales = 0.0;
        int totalDeliveries = 0;
        double salesIncreasePercentage = 0.0;
        int totalCustomers = 0;
        double customerSales = 0.0;
        int totalStaff = 0;
        int totalMessages = 0;
        int totalFeedback = 0;
        int totalReservations = 0;
        int totalServices = 0;
        int totalFacilities = 0;
        int totalCompletedOrders = 0; 
        int totalGallery = 0;
        
        try {
            if (conn != null) {
                stmt = conn.createStatement();
                
                rs = stmt.executeQuery("SELECT COUNT(*) FROM gallery");
                if (rs.next()) {
                	   totalGallery = rs.getInt(1);
                }
                rs.close();

                // Existing queries
                rs = stmt.executeQuery("SELECT COUNT(*) FROM food_items");
                if (rs.next()) {
                    totalProducts = rs.getInt(1);
                }
                rs.close();

                rs = stmt.executeQuery("SELECT COUNT(*) FROM staff");
                if (rs.next()) {
                    totalStaff = rs.getInt(1);
                }
                rs.close();

                rs = stmt.executeQuery("SELECT COUNT(*) FROM register");
                if (rs.next()) {
                    totalCustomers = rs.getInt(1);
                }
                rs.close();
                
                rs = stmt.executeQuery("SELECT COUNT(*) FROM reservations");
                if (rs.next()) {
                    totalReservations = rs.getInt(1);
                }
                rs.close();

                rs = stmt.executeQuery("SELECT COUNT(*) FROM feedback");
                if (rs.next()) {
                    totalFeedback  = rs.getInt(1);
                }
                rs.close();	
                
                rs.close();
                rs = stmt.executeQuery("SELECT COUNT(*) FROM contact_messages");
                if (rs.next()) {
                    totalMessages  = rs.getInt(1);
                }
                rs.close();	
                
                

                rs.close();
                rs = stmt.executeQuery("SELECT COUNT(*) FROM services");
                if (rs.next()) {
                	totalServices  = rs.getInt(1);
                }
                rs.close();	
                
                rs.close();
                rs = stmt.executeQuery("SELECT COUNT(*) FROM facilities");
                if (rs.next()) {
                	totalFacilities   = rs.getInt(1);
                }
                rs.close();	
                
                
                // Query to get the total count of completed orders
                rs = stmt.executeQuery("SELECT COUNT(*) FROM neworders WHERE status = 'completed'");
                if (rs.next()) {
                    totalCompletedOrders = rs.getInt(1);
                }
                rs.close();
                
                
                

                rs = stmt.executeQuery("SELECT COALESCE(SUM(price), 0) FROM neworders WHERE status = 'completed'");
                if (rs.next()) {
                    totalSales = rs.getDouble(1);
                }
                rs.close();

                rs = stmt.executeQuery(
                    "SELECT COALESCE((SUM(price) - (SELECT COALESCE(SUM(price), 0) FROM previous_sales)) / "
                    + "(SELECT COALESCE(SUM(price), 0) FROM previous_sales) * 100), 0) "
                    + "FROM neworders WHERE status = 'completed'");
                if (rs.next()) {
                    salesIncreasePercentage = rs.getDouble(1);
                }
                rs.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>

    <div class="container-fluid px-4">
        <div class="row g-3 my-2">
            <!-- Existing stat cards -->
            <div class="col-md-3">
                <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                    <div>
                        <h3 class="fs-2"><%= totalProducts %></h3>
                        <p class="fs-5">Products</p>
                        
                    </div>
                    <i class="fas fa-gift fs-1 primary-text border rounded-full secondary-bg p-3"></i>
                </div>
            </div>

            <div class="col-md-3">
                <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                    <div>
                        <h3 class="fs-2">$<%= String.format("%.2f", totalSales) %></h3>
                        <p class="fs-5">Sales</p>
                    </div>
                    <i class="fas fa-hand-holding-usd fs-1 primary-text border rounded-full secondary-bg p-3"></i>
                </div>
            </div>

            <div class="col-md-3">
                <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                    <div>
                        <h3 class="fs-2"><%= totalCompletedOrders %></h3>
                        <p class="fs-5"> Completed Orders</p>
                    </div>
                    <i class="fas fa-truck fs-1 primary-text border rounded-full secondary-bg p-3"></i>
                </div>
            </div>

            <div class="col-md-3">
                <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                    <div>
                        <h3 class="fs-2"><%= String.format("%.2f", salesIncreasePercentage) %>%</h3>
                        <p class="fs-5">Increase</p>
                    </div>
                    <i class="fas fa-chart-line fs-1 primary-text border rounded-full secondary-bg p-3"></i>
                </div>
            </div>
        </div>

        <div class="row g-3 my-2">
            <!-- New stat cards for customers, staff, messages, feedback, and reservations -->
            <div class="col-md-3">
                <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                    <div>
                        <h3 class="fs-2"><%= totalCustomers %></h3>
                        <p class="fs-5">Customers</p>
                    </div>
                    <i class="fas fa-users fs-1 primary-text border rounded-full secondary-bg p-3"></i>
                </div>
            </div>

            <div class="col-md-3">
                <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                    <div>
                        <h3 class="fs-2">$<%= totalCompletedOrders %></h3>
                        <p class="fs-5">Customer Sales</p>
                    </div>
                    <i class="fas fa-user-tag fs-1 primary-text border rounded-full secondary-bg p-3"></i>
                </div>
            </div>
            
            <div class="col-md-3">
                <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                    <div>
                        <h3 class="fs-2"><%= totalStaff %></h3>
                        <p class="fs-5">Staff Members</p>
                    </div>
                    <i class="fas fa-users fs-1 primary-text border rounded-full secondary-bg p-3"></i>
                </div>
            </div>

            <div class="col-md-3">
                <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                    <div>
                        <h3 class="fs-2"><%= totalMessages %></h3>
                        <p class="fs-5">Messages</p>
                    </div>
                    <i class="fas fa-envelope fs-1 primary-text border rounded-full secondary-bg p-3"></i>
                </div>
            </div>

            <div class="col-md-3">
                <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                    <div>
                        <h3 class="fs-2"><%= totalFeedback %></h3>
                        <p class="fs-5">Feedback</p>
                    </div>
                    <i class="fas fa-comment fs-1 primary-text border rounded-full secondary-bg p-3"></i>
                </div>
            </div>

            <div class="col-md-3">
                <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                    <div>
                        <h3 class="fs-2"><%= totalReservations %></h3>
                        <p class="fs-5">Reservations</p>
                    </div>
                    <i class="fas fa-calendar-check fs-1 primary-text border rounded-full secondary-bg p-3"></i>
                </div>
            </div>
        </div>

        <div class="row g-3 my-2">
            <!-- New stat cards for services, facilities, and gallery -->
            <div class="col-md-3">
                <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                    <div>
                        <h3 class="fs-2"><%= totalServices %></h3>
                        <p class="fs-5">Our Services</p>
                    </div>
                    <i class="fas fa-concierge-bell fs-1 primary-text border rounded-full secondary-bg p-3"></i>
                </div>
            </div>

            <div class="col-md-3">
                <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                    <div>
                        <h3 class="fs-2"><%= totalFacilities %></h3>
                        <p class="fs-5"> Facilities</p>
                    </div>
                    <i class="fas fa-building fs-1 primary-text border rounded-full secondary-bg p-3"></i>
                </div>
            </div>

            <div class="col-md-3">
                <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                    <div>
                        <h3 class="fs-2"><%= totalGallery %> </h3>
                        <p class="fs-5">Gallery</p>
                        
                    </div>
                    <i class="fas fa-images fs-1 primary-text border rounded-full secondary-bg p-3"></i>
                </div>
            </div>
        </div>
    </div>

</body>

</html>
