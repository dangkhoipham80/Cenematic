<%@page import="Utils.Validate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();

    // Flash messages are set on the session because the login servlet
    // redirects; a request attribute would not survive that.
    String flashError = (String) session.getAttribute("flashError");
    session.removeAttribute("flashError");
    String flashMessage = (String) session.getAttribute("flashMessage");
    session.removeAttribute("flashMessage");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Sign in &middot; Cinematic</title>
        <link rel="stylesheet" href="<%=ctx%>/css/auth.css">
    </head>
    <body class="auth">
        <main class="auth-card">
            <a class="auth-brand" href="<%=ctx%>/index.jsp">
                <img src="<%=ctx%>/img/bintang%20cinema.png" alt="">
                <span>Cinematic</span>
            </a>

            <div class="auth-head">
                <h1>Welcome back</h1>
                <p>Sign in to book seats and see your ticket history.</p>
            </div>

            <% if (flashMessage != null) { %>
            <div class="alert alert--ok" role="status"><p><%=Validate.escapeHtml(flashMessage)%></p></div>
            <% } %>
            <% if (flashError != null) { %>
            <div class="alert alert--error" role="alert"><p><%=Validate.escapeHtml(flashError)%></p></div>
            <% } %>

            <form action="<%=ctx%>/UserController" method="POST" data-validated data-busy-text="Signing in...">
                <input type="hidden" name="btAction" value="login">

                <div class="field">
                    <input type="text" id="UserName" name="UserName" placeholder="Username"
                           autocomplete="username" autofocus required data-validate="required">
                    <label for="UserName">Username</label>
                    <span class="error"></span>
                </div>

                <div class="field field--password">
                    <input type="password" id="Password" name="Password" placeholder="Password"
                           autocomplete="current-password" required data-validate="required">
                    <label for="Password">Password</label>
                    <button type="button" class="pw-toggle" data-pw-toggle="Password"
                            aria-label="Show password">Show</button>
                    <span class="error"></span>
                </div>

                <div class="row-between">
                    <label class="check">
                        <input type="checkbox" name="rememberMe" value="true">
                        <span>Remember me</span>
                    </label>
                    <a class="link-quiet" href="<%=ctx%>/forgotpassword.jsp">Forgot password?</a>
                </div>

                <button type="submit" class="btn btn--primary">Sign in</button>
            </form>

            <div class="auth-foot">
                New here? <a href="<%=ctx%>/register.jsp">Create an account</a>
                <span class="copyright">&copy; 2024-2025 Cinematic</span>
            </div>
        </main>

        <script src="<%=ctx%>/js/auth.js"></script>
    </body>
</html>
