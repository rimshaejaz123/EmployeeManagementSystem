<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - EMS</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="img-box">
             <img src="images/login_image.png" alt="Login Illustration">
        </div>
        <div class="form-box">
            <h2>Sign in to your account PLEASE</h2>
            
            <% String error = request.getParameter("error");
               if(error != null) { %>
               <p style="color:red; font-size: 14px; margin-bottom: 10px;"><%= error %></p>
            <% } %>

            <form action="auth" method="POST">
                <input type="hidden" name="action" value="login">
                
                <div class="input-group">
                    <label>Email address</label>
                    <input type="email" name="email" required>
                </div>
                
                <div class="input-group">
                    <label>Password</label>
                    <input type="password" name="password" required>
                </div>
                
                <div style="text-align: right; margin-bottom: 15px;">
                    <a href="#" style="font-size: 12px; color: #6c63ff;">Forgot password?</a>
                </div>

                <button type="submit" class="btn">Sign in</button>
            </form>
            
            <div class="links">
                Don't have an account? <a href="signup.jsp">Sign up</a>
            </div>
        </div>
    </div>
</body>
</html>