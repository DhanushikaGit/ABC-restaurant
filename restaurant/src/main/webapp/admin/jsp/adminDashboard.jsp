<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

        try {
            if (conn != null) {
                stmt = conn.createStatement();

                // Query to get total number of products
                rs = stmt.executeQuery("SELECT COUNT(*) FROM food_items");
                if (rs.next()) {
                    totalProducts = rs.getInt(1);
                }
                rs.close();

                // Query to get total sales
                rs = stmt.executeQuery("SELECT COALESCE(SUM(price), 0) FROM neworders WHERE status = 'completed'");
                if (rs.next()) {
                    totalSales = rs.getDouble(1);
                }
                rs.close();

                // Query to get total deliveries
                rs = stmt.executeQuery("SELECT COUNT(*) FROM deliveries");
                if (rs.next()) {
                    totalDeliveries = rs.getInt(1);
                }
                rs.close();

                // Query to calculate sales increase percentage
                // Assuming 'previous_sales' table contains past sales data
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
            // Close resources
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>

    <div class="container-fluid px-4">
        <div class="row g-3 my-2">
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
                        <h3 class="fs-2"><%= totalDeliveries %></h3>
                        <p class="fs-5">Deliveries</p>
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

        <div class="row my-5">
            <h3 class="fs-4 mb-3">Recent Orders</h3>
            <div class="col">
                <table class="table bg-white rounded shadow-sm table-hover">
                    <thead>
                        <tr>
                            <th scope="col" width="50">#</th>
                            <th scope="col">Product</th>
                            <th scope="col">Customer</th>
                            <th scope="col">Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Dynamically populate this section with actual recent orders -->
                        <tr>
                            <th scope="row">1</th>
                            <td>Television</td>
                            <td>Jonny</td>
                            <td>$1200</td>
                        </tr>
                        <tr>
                            <th scope="row">2</th>
                            <td>Laptop</td>
                            <td>Kenny</td>
                            <td>$750</td>
                        </tr>
                        <tr>
                            <th scope="row">3</th>
                            <td>Cell Phone</td>
                            <td>Jenny</td>
                            <td>$600</td>
                        </tr>
                        <!-- More rows here -->
                    </tbody>
                </table>
            </div>
        </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        var el = document.getElementById("wrapper");
        var toggleButton = document.getElementById("menu-toggle");

        toggleButton.onclick = function () {
            el.classList.toggle("toggled");
        };
    </script>
</body>

</html>
