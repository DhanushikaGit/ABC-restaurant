<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Search</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        :root {
            --primary: #FEA116;
            --light: #F1F8FF;
            --dark: #0F172B;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: black;
            color: var(--light);
            margin: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.5rem;
            background-color: black;
        }

        header img {
            height: 150px; /* Increase logo size */
        }

        nav {
            display: flex;
            gap: 1rem;
        }

        nav a {
            color: var(--light);
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s;
        }

        nav a:hover {
            color: var(--primary);
        }

        .sign-up-btn {
            background-color: var(--primary);
            color: var(--light);
            padding: 0.5rem 1rem;
            border-radius: 0.25rem;
            transition: background-color 0.3s, color 0.3s;
        }

        .sign-up-btn:hover {
            background-color: white;
            color: var(--primary);
        }

        main {
            flex: 1;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 2rem;
            gap: 2rem;
            flex-wrap: wrap;
        }

        .search-container {
            max-width: 500px;
            width: 100%;
            margin-right: auto;
        }

        .search-container h1 {
            margin-bottom: 0.5rem;
        }

        .search-container p {
            margin-bottom: 1rem;
        }

        .search-container input {
            width: 100%;
            padding: 1rem;
            margin-bottom: 1rem;
            border: 2px solid var(--primary);
            border-radius: 0.5rem;
            background-color: var(--light);
            color: var(--dark);
        }

        .search-container button {
            width: 100%;
            padding: 1rem;
            background-color: var(--primary);
            color: var(--light);
            border: none;
            border-radius: 0.5rem;
            cursor: pointer;
            transition: background-color 0.3s, color 0.3s;
        }

        .search-container button:hover {
            background-color: white;
            color: var(--primary);
        }

        .food-images {
            display: flex;
            flex-wrap: wrap;
            gap: 1.5rem;
            justify-content: center;
        }

        .food-images .food-item {
            border-radius: 50%;
            overflow: hidden;
            box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.3);
            width: 150px;
            height: 150px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: transform 0.3s ease-in-out;
        }

        .food-images .food-item img {
            border-radius: 50%;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .food-images .food-item:hover {
            transform: scale(1.1);
        }
    </style>
    <script>
        function searchLocation() {
            const input = document.getElementById('locationInput').value.toLowerCase();
            const cities = ['colombo', 'kandy', 'galle', 'matara', 'jaffna', 'negombo', 'anuradhapura'];

            if (cities.includes(input)) {
                alert(`Searching for food options in ${input.charAt(0).toUpperCase() + input.slice(1)}!`);
            } else {
                alert("Sorry, we couldn't find the location. Please try another city.");
            }
        }
    </script>
</head>
<body>
    <header>
        <div>
            <img src="/restaurant/customer/images/A B C (2).png" alt="Logo">
        </div>
        <nav>
            <a href="#">What we offer</a>
            <a href="/restaurant/customer/jsp/login.jsp">Login</a>
            <a href="/restaurant/customer/jsp/register.jsp" class="sign-up-btn">Sign Up</a>
        </nav>
    </header>

    <main>
        <div class="search-container">
            <h1 class="text-4xl font-bold text-[#FEA116]">Craving Something?</h1>
            <p class="text-lg text-gray-300">Let's get you started!</p>
            <input type="text" id="locationInput" placeholder="Let us know the location.">
            <button onclick="searchLocation()">Search</button>
        </div>
        <div class="food-images">
            <div class="food-item">
                <img src="/restaurant/customer/images/menu-1.jpg" alt="Food1">
            </div>
            <div class="food-item">
                <img src="/restaurant/customer/images/menu-2.jpg" alt="Food2">
            </div>
            <div class="food-item">
                <img src="/restaurant/customer/images/menu-3.jpg" alt="Food3">
            </div>
        </div>
    </main>
</body>
</html>
