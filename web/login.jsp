<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">
    <link rel="stylesheet" href="css/magnific-popup.css">
    <link rel="stylesheet" href="css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="css/jquery.timepicker.css">
    <link rel="stylesheet" href="css/flaticon.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .login-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 30px;
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }
        .login-container h2 {
            margin-bottom: 20px;
        }
        .login-container .alert {
            margin-bottom: 20px;
        }
        .password-toggle {
            position: relative;
        }
        .password-toggle .fa-eye, .password-toggle .fa-eye-slash {
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-50%);
            cursor: pointer;
        }
        body {
      background-image: url('images/bg_2.jpg'); /* Đường dẫn đến hình nền */
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      background-attachment: fixed;
      height: 100vh;
        
    }
    </style>
</head>
<body>
    <div class="login-container">
        <h2 class="text-center">Login</h2>
        
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-danger text-center"><%= request.getAttribute("errorMessage") %></div>
        <% } %>

        <form action="LoginServlet" method="post">
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fa fa-user"></i></span>
                    </div>
                    <input type="text" class="form-control" id="username" name="username" placeholder="Enter username" required>
                </div>
            </div>
            <div class="mb-3 password-toggle">
                <label for="password" class="form-label">Password</label>
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fa fa-lock"></i></span>
                    </div>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required>
                    <div class="input-group-append">
                        <span class="input-group-text">
                            <i class="fa fa-eye" id="togglePassword" style="cursor: pointer;"></i>
                        </span>
                    </div>
                </div>
            </div>
            <button type="submit" class="btn btn-primary w-100">Login</button>
        </form>

        <a href="register.jsp" class="register-link">Don't have an account? Sign up</a><br>
        <a href="forgot-password.jsp" class="register-link">Forgot password</a>
        <a href="index.jsp" class="btn btn-secondary w-100 mt-3">Back to home page</a>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#togglePassword').on('click', function() {
                const passwordField = $('#password');
                const passwordFieldType = passwordField.attr('type');
                if (passwordFieldType === 'password') {
                    passwordField.attr('type', 'text');
                    $(this).removeClass('fa-eye').addClass('fa-eye-slash');
                } else {
                    passwordField.attr('type', 'password');
                    $(this).removeClass('fa-eye-slash').addClass('fa-eye');
                }
            });
        });
    </script>
</body>
</html>