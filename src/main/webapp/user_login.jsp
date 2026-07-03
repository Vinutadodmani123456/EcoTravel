<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login / Register - EcoTravel</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Outfit', sans-serif;
            background: linear-gradient(135deg, #eef7f2 0%, #f4fcf7 50%, #ffffff 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow-x: hidden;
        }

        /* Organic decorative blobs for premium feel */
        .decor-blob-1 {
            position: absolute;
            width: 300px;
            height: 300px;
            background: radial-gradient(circle, rgba(96,173,94,0.15) 0%, rgba(255,255,255,0) 70%);
            top: -50px;
            left: -50px;
            z-index: 0;
            border-radius: 50%;
        }
        .decor-blob-2 {
            position: absolute;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(46,125,50,0.1) 0%, rgba(255,255,255,0) 70%);
            bottom: -100px;
            right: -100px;
            z-index: 0;
            border-radius: 50%;
        }

        .auth-wrapper {
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(46, 125, 50, 0.15);
            border-radius: 24px;
            padding: 45px;
            width: 100%;
            max-width: 460px;
            box-shadow: 0 20px 40px rgba(46, 125, 50, 0.08);
            z-index: 10;
        }

        /* Brand */
        .brand {
            text-align: center;
            margin-bottom: 8px;
        }
        .brand-logo {
            font-size: 2.2rem;
            margin-bottom: 6px;
            display: inline-block;
            animation: float 3s ease-in-out infinite;
        }
        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-5px); }
        }
        .brand-name {
            font-size: 1.9rem;
            font-weight: 800;
            color: #2e7d32;
            letter-spacing: -0.5px;
        }
        .brand-sub {
            color: #556b5a;
            font-size: 0.95rem;
            margin-top: 8px;
            margin-bottom: 25px;
            line-height: 1.4;
        }

        /* Tab Switcher */
        .tab-bar {
            display: flex;
            border-bottom: 2px solid #e1ebe5;
            margin-bottom: 25px;
        }
        .tab-btn {
            flex: 1;
            background: none;
            border: none;
            color: #8fa094;
            font-family: 'Outfit', sans-serif;
            font-size: 1.05rem;
            font-weight: 600;
            padding: 12px 0;
            cursor: pointer;
            position: relative;
            transition: color 0.25s;
        }
        .tab-btn.active {
            color: #2e7d32;
        }
        .tab-btn.active::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            right: 0;
            height: 3px;
            background: #2e7d32;
            border-radius: 3px 3px 0 0;
        }

        /* Form */
        .form-pane { display: none; }
        .form-pane.active { display: block; }

        .form-group { margin-bottom: 18px; }
        .form-group label {
            display: block;
            color: #2c3e50;
            font-size: 0.9rem;
            font-weight: 600;
            margin-bottom: 6px;
        }

        .input-wrap {
            position: relative;
            display: flex;
            align-items: center;
        }
        .input-wrap input {
            width: 100%;
            background: #fcfdfe;
            border: 1.5px solid #d2ded5;
            border-radius: 12px;
            padding: 14px 16px;
            color: #2c3e50;
            font-family: 'Outfit', sans-serif;
            font-size: 0.95rem;
            outline: none;
            transition: all 0.25s;
        }
        .input-wrap input::placeholder { color: #95a5a6; }
        .input-wrap input:focus { 
            border-color: #2e7d32; 
            background: #ffffff;
            box-shadow: 0 0 0 4px rgba(46,125,50,0.1);
        }

        .show-btn {
            position: absolute;
            right: 16px;
            background: none;
            border: none;
            color: #2e7d32;
            font-family: 'Outfit', sans-serif;
            font-size: 0.85rem;
            font-weight: 700;
            cursor: pointer;
            padding: 0;
            transition: color 0.2s;
        }
        .show-btn:hover { color: #60ad5e; }

        /* Messages */
        .message {
            padding: 11px 14px;
            border-radius: 10px;
            margin-bottom: 18px;
            font-size: 0.9rem;
            text-align: center;
            font-weight: 500;
        }
        .error { background: #ffebee; color: #c62828; border: 1px solid #ffcdd2; }
        .success { background: #e8f5e9; color: #2e7d32; border: 1px solid #c8e6c9; }

        /* Submit Button */
        .submit-btn {
            width: 100%;
            padding: 15px;
            background: #2e7d32;
            color: white;
            font-family: 'Outfit', sans-serif;
            font-size: 1.05rem;
            font-weight: 700;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            margin-top: 10px;
            transition: all 0.25s;
            box-shadow: 0 6px 20px rgba(46,125,50,0.25);
        }
        .submit-btn:hover { 
            background: #235e26; 
            box-shadow: 0 8px 25px rgba(46,125,50,0.35);
            transform: translateY(-1px);
        }
        .submit-btn:active { transform: translateY(0); }

        /* Footer link */
        .alt-link {
            text-align: center;
            margin-top: 22px;
            color: #556b5a;
            font-size: 0.9rem;
        }
        .alt-link a {
            color: #2e7d32;
            text-decoration: none;
            font-weight: 700;
            margin-left: 4px;
        }
        .alt-link a:hover { text-decoration: underline; }

        /* Back to Home */
        .back-home {
            display: block;
            text-align: center;
            color: #8fa094;
            font-size: 0.88rem;
            text-decoration: none;
            margin-top: 25px;
            font-weight: 600;
            transition: color 0.2s;
        }
        .back-home:hover { color: #2e7d32; }
    </style>
</head>
<body>

<div class="decor-blob-1"></div>
<div class="decor-blob-2"></div>

<div class="auth-wrapper">

    <!-- Brand -->
    <div class="brand">
        <div class="brand-logo">🌿</div>
        <div class="brand-name">EcoTravel</div>
        <p class="brand-sub">Welcome! Please login or create an account to start your green journey.</p>
    </div>

    <!-- Tab Bar -->
    <div class="tab-bar">
        <button class="tab-btn active" id="tabLogin" onclick="switchTab('login')">Login</button>
        <button class="tab-btn" id="tabSignup" onclick="switchTab('signup')">Sign Up</button>
    </div>

    <!-- LOGIN FORM -->
    <div class="form-pane active" id="loginPane">

        <% if (request.getParameter("error") != null) { %>
            <div class="message error"><%= request.getParameter("error") %></div>
        <% } %>
        <% if (request.getParameter("msg") != null) { %>
            <div class="message success"><%= request.getParameter("msg") %></div>
        <% } %>

        <form action="auth" method="post" autocomplete="off">
            <input type="hidden" name="action" value="login">
            <input type="hidden" name="loginType" value="user">
            <input type="hidden" name="redirect" value="<%= request.getParameter("redirect") != null ? request.getParameter("redirect") : "" %>">

            <div class="form-group">
                <label>Username</label>
                <div class="input-wrap">
                    <input type="text" name="username" id="loginUsername" placeholder="Enter your username" autocomplete="off" required>
                </div>
            </div>

            <div class="form-group">
                <label>Password</label>
                <div class="input-wrap">
                    <input type="password" name="password" id="loginPass" placeholder="Enter your password" autocomplete="new-password" required>
                    <button type="button" class="show-btn" onclick="togglePass('loginPass', this)">Show</button>
                </div>
            </div>

            <button type="submit" class="submit-btn">Login</button>
        </form>

        <div class="alt-link">
            Don't have an account?<a href="#" onclick="switchTab('signup'); return false;">Sign Up</a>
        </div>
    </div>

    <!-- SIGN UP FORM -->
    <div class="form-pane" id="signupPane">

        <form action="auth" method="post" autocomplete="off">
            <input type="hidden" name="action" value="register">
            <input type="hidden" name="role" value="user">

            <div class="form-group">
                <label>Username</label>
                <div class="input-wrap">
                    <input type="text" name="username" id="signupUsername" placeholder="Choose a username" autocomplete="off" required>
                </div>
            </div>

            <div class="form-group">
                <label>Email</label>
                <div class="input-wrap">
                    <input type="email" name="email" id="signupEmail" placeholder="Enter your email address" autocomplete="off" required>
                </div>
            </div>

            <div class="form-group">
                <label>Password</label>
                <div class="input-wrap">
                    <input type="password" name="password" id="signupPass" placeholder="Create password" autocomplete="new-password" pattern="(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[@#$%&*!.,])[A-Za-z0-9@#$%&*!.,]{6,}" title="Password must be at least 6 characters long, contain at least 1 uppercase letter, 1 lowercase letter, 1 number, and 1 special character (@#$%&*!.,). Allowed characters are restricted to these classes." required>
                    <button type="button" class="show-btn" onclick="togglePass('signupPass', this)">Show</button>
                </div>
            </div>

            <div class="form-group">
                <label>Confirm Password</label>
                <div class="input-wrap">
                    <input type="password" id="confirmPass" placeholder="Confirm password" autocomplete="new-password" required>
                    <button type="button" class="show-btn" onclick="togglePass('confirmPass', this)">Show</button>
                </div>
            </div>

            <button type="submit" class="submit-btn" onclick="return validateSignup()">Create Account</button>
        </form>

        <div class="alt-link">
            Already have an account?<a href="#" onclick="switchTab('login'); return false;">Login here</a>
        </div>
    </div>

    <a class="back-home" href="index.jsp">← Back to Home</a>
</div>

<script>
    function switchTab(tab) {
        const loginPane = document.getElementById('loginPane');
        const signupPane = document.getElementById('signupPane');
        const tabLogin = document.getElementById('tabLogin');
        const tabSignup = document.getElementById('tabSignup');

        if (tab === 'login') {
            loginPane.classList.add('active');
            signupPane.classList.remove('active');
            tabLogin.classList.add('active');
            tabSignup.classList.remove('active');
        } else {
            signupPane.classList.add('active');
            loginPane.classList.remove('active');
            tabSignup.classList.add('active');
            tabLogin.classList.remove('active');
        }
    }

    function togglePass(inputId, btn) {
        const input = document.getElementById(inputId);
        if (input.type === 'password') {
            input.type = 'text';
            btn.textContent = 'Hide';
        } else {
            input.type = 'password';
            btn.textContent = 'Show';
        }
    }

    function validateSignup() {
        const pass = document.getElementById('signupPass').value;
        const confirm = document.getElementById('confirmPass').value;
        if (pass !== confirm) {
            alert('Passwords do not match!');
            return false;
        }
        const pattern = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[@#$%&*!.,])[A-Za-z0-9@#$%&*!.,]{6,}$/;
        if (!pattern.test(pass)) {
            alert('Password must be at least 6 characters long and contain at least 1 uppercase letter, 1 lowercase letter, 1 number, and 1 special character (@#$%&*!.,). No other characters are allowed.');
            return false;
        }
        return true;
    }

    // Auto-switch to signup tab if URL has ?action=register
    window.onload = function () {
        const params = new URLSearchParams(window.location.search);
        if (params.get('action') === 'register') {
            switchTab('signup');
        }
        // Clear all form fields on load to prevent browser autofill on refresh, keeping pre-populated username
        const allInputs = document.querySelectorAll('input[type="text"], input[type="email"], input[type="password"]');
        allInputs.forEach(function(inp) {
            if (inp.id === 'loginUsername' && inp.value !== '') {
                // Keep the pre-populated username
            } else {
                inp.value = '';
            }
        });
    };
</script>

</body>
</html>
