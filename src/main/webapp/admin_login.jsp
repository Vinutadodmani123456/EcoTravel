<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Portal - EcoTravel</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #263238; margin: 0; display:flex; justify-content:center; align-items:center; min-height:100vh;}
        .wrapper { max-width: 450px; width:100%; box-shadow: 0 10px 30px rgba(0,0,0,0.5); border-radius: 8px; overflow: hidden; background:#37474f; position:relative;}
        .pane { padding: 40px; }
        .register-pane { display: none; } /* Hidden by default */
        h2 { color: #81c784; margin-top: 0; text-align:center; border-bottom: 2px solid #546e7a; padding-bottom: 15px;}
        .form-group { margin-bottom: 20px; position:relative;}
        label { display: block; margin-bottom: 5px; color:#b0bec5; font-weight:bold;}
        input[type="text"], input[type="password"], input[type="email"] { width: 100%; padding: 12px; border: 1px solid #546e7a; border-radius: 4px; background: #263238; color: white; box-sizing:border-box; }
        .btn { padding: 12px; width: 100%; background: #4caf50; color: white; border:none; border-radius:4px; font-weight:bold; cursor:pointer;}
        .btn:hover { background: #388e3c; }
        .message { padding: 10px; border-radius: 4px; margin-bottom: 15px; text-align:center;}
        .error { background: rgba(255,82,82,0.1); color: #ff8a80; border: 1px solid #ff5252; }
        .success { background: rgba(76,175,80,0.1); color: #81c784; border: 1px solid #4caf50; }
        .toggle-pwd { position:absolute; right:15px; top:36px; cursor:pointer; filter: grayscale(100%); }
        .switch-link { text-align:center; display:block; margin-top:20px; color:#90caf9; cursor:pointer; text-decoration:underline; font-weight:bold;}
    </style>
    <script>
        function togglePwd(id, icon) {
            var el = document.getElementById(id);
            if(el.type === "password") { el.type = "text"; icon.innerText = "🙈"; } 
            else { el.type = "password"; icon.innerText = "👁️"; }
        }
        function switchForm(formName) {
            if (formName === 'register') {
                document.getElementById('loginPane').style.display = 'none';
                document.getElementById('registerPane').style.display = 'block';
            } else {
                document.getElementById('registerPane').style.display = 'none';
                document.getElementById('loginPane').style.display = 'block';
            }
        }
        window.onload = function() {
            // Keep the pre-populated username, but clear password autofill
            const pwdFields = document.querySelectorAll('input[type="password"]');
            pwdFields.forEach(function(inp) {
                inp.value = '';
            });
        };
    </script>
</head>
<body>
    <div class="wrapper">
        
        <!-- Login Form -->
        <div class="pane login-pane" id="loginPane">
            <h2>EcoTravel Core Admin</h2>
            <p style="color:#90a4ae; margin-bottom:25px; text-align:center;">Secure System Access</p>
            
            <% if (request.getParameter("error") != null) { %>
                <div class="message error"><%= request.getParameter("error") %></div>
            <% } %>
            <% if (request.getParameter("msg") != null) { %>
                <div class="message success"><%= request.getParameter("msg") %></div>
            <% } %>

            <form action="auth" method="post" autocomplete="off">
                <input type="hidden" name="action" value="login">
                <input type="hidden" name="loginType" value="admin">
                <div class="form-group">
                    <label>Administrator ID</label>
                    <input type="text" name="username" id="loginUsername" value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>" autocomplete="off" pattern="[a-zA-Z0-9]+" title="Username cannot contain @ or special characters" required>
                </div>
                <div class="form-group">
                    <label>System Password</label>
                    <input type="password" id="login-pwd" name="password" required>
                    <span class="toggle-pwd" onclick="togglePwd('login-pwd', this)">👁️</span>
                </div>
                <button type="submit" class="btn">Access Secure Portal</button>
            </form>
            
            <span class="switch-link" onclick="switchForm('register')">Register New Admin</span>
            
            <p style="margin-top:30px; text-align:center; font-size:0.9em; border-top:1px solid #546e7a; padding-top:15px;">
                <a href="index.jsp" style="color:#b0bec5; text-decoration:none;">&larr; Return to Public Website</a>
            </p>
        </div>

        <!-- Registration Form -->
        <div class="pane register-pane" id="registerPane">
            <h2>Admin Registration</h2>
            <p style="color:#90a4ae; margin-bottom:25px; text-align:center;">Create a new administrator account.</p>
            
            <form action="auth" method="post" autocomplete="off">
                <input type="hidden" name="action" value="register">
                <input type="hidden" name="role" value="admin">
                <div class="form-group">
                    <label>Administrator ID</label>
                    <input type="text" name="username" autocomplete="off" pattern="[a-zA-Z0-9]+" title="Username cannot contain @ or special characters" placeholder="e.g. admin1" required>
                </div>
                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" name="email" required>
                </div>
                <div class="form-group">
                    <label>System Password</label>
                    <input type="password" id="reg-pwd" name="password" pattern="(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[@#$%&*!.,])[A-Za-z0-9@#$%&*!.,]{6,}" title="Password must be at least 6 characters long, contain at least 1 uppercase letter, 1 lowercase letter, 1 number, and 1 special character (@#$%&*!.,). Allowed characters are restricted to these classes." placeholder="Min 6 chars, uppercase, lowercase, number, special char" required>
                    <span class="toggle-pwd" onclick="togglePwd('reg-pwd', this)">👁️</span>
                </div>
                <button type="submit" class="btn" style="background:#558b2f;">Register Admin</button>
            </form>
            
            <span class="switch-link" onclick="switchForm('login')">Already an Admin? Login Here</span>
        </div>
        
    </div>
</body>
</html>
