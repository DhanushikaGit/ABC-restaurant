<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title><%= request.getAttribute("pageTitle") != null ? request.getAttribute("pageTitle") : "Modern Admin Dashboard" %></title>
    <link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
</head>
<style>
/* General styles */
/* General styles */
body {
    font-family: 'Poppins', sans-serif;
    background-color: #f1f8ff;
    margin: 0;
    padding: 0;
    display: flex;
    height: 100vh;
}

/* Sidebar styles */
.sidebar {
    width: 250px;
    height: 100vh;
    background-color: #0f172b;
    color: #ffffff;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    position: fixed;
    left: 0;
    top: 0;
}

.side-header {
    padding: 20px;
    text-align: center;
    background-color: #fea116;
    font-size: 22px;
    font-weight: bold;
    color: #ffffff;
}

.side-header span {
    color: #ffffff;
}

.side-content {
    padding: 20px;
}

.profile {
    text-align: center;
    margin-bottom: 20px;
}

.profile-img {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    background-color: #ffffff;
    background-size: cover;
    background-position: center;
    margin: 0 auto 10px;
}

.profile h4 {
    margin: 0;
    font-size: 18px;
    font-weight: bold;
}

.profile small {
    color: #fea116;
}

.side-menu ul {
    list-style: none;
    padding: 0;
}

.side-menu ul li {
    margin: 20px 0;
}

.side-menu ul li a {
    color: #ffffff;
    text-decoration: none;
    display: flex;
    align-items: center;
    padding: 10px;
    border-radius: 8px;
    transition: background-color 0.3s;
}

.side-menu ul li a.active,
.side-menu ul li a:hover {
    background-color: #fea116;
}

.side-menu ul li a span {
    margin-right: 10px;
    font-size: 20px;
}

/* Main content styles */
.main-content {
    margin-left: 250px;
    padding: 20px;
    width: calc(100% - 250px);
    background-color: #ffffff;
    display: flex;
    flex-direction: column;
}

header {
    width: 100%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #f1f8ff;
    padding: 10px 20px;
    border-bottom: 1px solid #fea116;
    position: fixed;
    top: 0;
    z-index: 1000;
}

.header-content {
    display: flex;
    align-items: center;
    width: 100%;
    justify-content: space-between;
}

.header-content label {
    margin-right: 20px;
    font-size: 24px;
    cursor: pointer;
    color: #fea116;
}

.header-menu {
    display: flex;
    align-items: rignt;
}

.header-menu .search-box {
    display: flex;
    align-items: left;
    margin-right: 50px;
}

.header-menu .search-box span {
    font-size: 20px;
    color: #fea116;
    margin-right: 20px;
}

.header-menu .search-box input {
    padding: 5px;
    border: 1px solid #fea116;
    border-radius: 4px;
    outline: none;
}

.header-menu .notify-icon {
    position: relative;
    margin-right: 80px;
    font-size: 24px;
    color: #fea116;
    cursor: pointer;
}

.header-menu .notify-icon .notify {
    position: absolute;
       margin-right: 15px;
    background-color: #fea116;
    color: #ffffff;
    font-size: 12px;
    border-radius: 50%;
    padding: 2px 5px;
}

.header-menu .user {
    display: flex;
    align-items: center;
    cursor: pointer;
}

.header-menu .user .bg-img {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background-color: #fea116;
    background-size: cover;
    background-position: center;
    margin-right: 300px;
}

.header-menu .user span {
    font-size: 18px;
    color: #fea116;
}

</style>
<body>

    <input type="checkbox" id="menu-toggle">
    <div class="sidebar">
        <div class="side-header">
            <h3>M<span>odern</span></h3>
        </div>
        
        <div class="side-content">
            <div class="profile">
                <div class="profile-img bg-img" style="background-image: url('img/3.jpeg')"></div>
                <h4>David Green</h4>
                <small>Art Director</small>
            </div>

            <div class="side-menu">
                <ul>
                    <li>
                        <a href="dashboard.jsp" class="active">
                            <span class="las la-home"></span>
                            <small>Dashboard</small>
                        </a>
                    </li>
                    <li>
                        <a href="profile.jsp">
                            <span class="las la-user-alt"></span>
                            <small>Profile</small>
                        </a>
                    </li>
                    <li>
                        <a href="mailbox.jsp">
                            <span class="las la-envelope"></span>
                            <small>Mailbox</small>
                        </a>
                    </li>
                    <li>
                        <a href="projects.jsp">
                            <span class="las la-clipboard-list"></span>
                            <small>Projects</small>
                        </a>
                    </li>
                    <li>
                        <a href="orders.jsp">
                            <span class="las la-shopping-cart"></span>
                            <small>Orders</small>
                        </a>
                    </li>
                    <li>
                        <a href="tasks.jsp">
                            <span class="las la-tasks"></span>
                            <small>Tasks</small>
                        </a>
                    </li>
                    <li>
                        <a href="manage-customers.jsp">
                            <span class="las la-users"></span>
                            <small>Manage Customers</small>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    
    <div class="main-content">
        <header>
            <div class="header-content">
                <label for="menu-toggle">
                    <span class="las la-bars"></span>
                </label>
                
                <div class="header-menu">
                    <div class="search-box">
                        <span class="las la-search"></span>
                        <input type="text" placeholder="Search...">
                    </div>
                    
                    <div class="notify-icon">
                        <span class="las la-envelope"></span>
                        <span class="notify">4</span>
                    </div>
                    
                    <div class="notify-icon">
                        <span class="las la-bell"></span>
                        <span class="notify">3</span>
                    </div>
                    
                    <div class="user">
                        <div class="bg-img" style="background-image: url('img/1.jpeg')"></div>
                        <span class="las la-power-off"></span>
                        <span>Logout</span>
                    </div>
                </div>
            </div>
        </header>
        
        <!-- Main content goes here -->
        
    </div>
</body>
</html>
