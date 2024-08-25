<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        $('form').on('submit', function(event) {
            var email = $('#email').val();
            var password = $('#password').val();
            var errorMessage = "";

            if (email === "") {
                errorMessage += "Email is required.\n";
            }
            if (password === "") {
                errorMessage += "Password is required.\n";
            }

            if (errorMessage !== "") {
                alert(errorMessage);
                event.preventDefault(); // Prevent form submission
            }
        });
    });
</script>
</head>
<body>
 
  <main class="login-form">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-md-8">
        <div class="card">
          <div class="card-header">
            Login
            <h6 style="color: red;">
                <% 
                    String errorMessage = (String) request.getAttribute("errorMessage");
                    if (errorMessage != null) {
                        out.print(errorMessage); // Display the error message
                    }
                %>
            </h6>
          </div>

          <div class="card-body">
            <form method="post" action="http://localhost:8090/restaurant/login"> <!-- Ensure action matches the servlet mapping -->

              <div class="form-group row">
                <label for="email" 
                  class="col-md-4 col-form-label text-md-right">Email<font color="red">*</font></label>
                <div class="col-md-6">
                  <input type="email" id="email" class="form-control" placeholder="Enter Email"
                    name="email" value="" required>
                </div>
              </div>

              <div class="form-group row">
                <label for="password"
                  class="col-md-4 col-form-label text-md-right">Password<font color="red">*</font></label>
                <div class="col-md-6">
                  <input type="password" id="password" class="form-control" placeholder="Enter Password"
                    name="password" value="" required>
                </div>
              </div>

              <div class="col-md-6 offset-md-4">
                <input type="submit" class="btn btn-primary" name="operation" value="Login">
                <a href="" class="btn btn-link"> Forgot Your Password? </a>
              </div>
            </form>
          </div>

        </div>
      </div>
    </div>
  </div>
  </main>
  <div style="margin-top: 170px">
 
  </div>
</body>
</html>
