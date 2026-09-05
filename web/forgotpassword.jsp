<%@page import="Utils.Validate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
    String errorMessage = (String) request.getAttribute("errorMessage");
    String email = Validate.escapeHtml((String) request.getAttribute("email"));
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Reset your password &middot; Cinematic</title>
        <link rel="stylesheet" href="<%=ctx%>/css/auth.css">
    </head>
    <body class="auth">
        <main class="auth-card">
            <a class="auth-brand" href="<%=ctx%>/index.jsp">
                <img src="<%=ctx%>/img/bintang%20cinema.png" alt="">
                <span>Cinematic</span>
            </a>

            <ol class="steps">
                <li class="is-current">1. Email</li>
                <li>2. Code</li>
                <li>3. New password</li>
            </ol>

            <div class="auth-head">
                <h1>Reset your password</h1>
                <p>Tell us the email address on your account and we'll send a 6-digit code.</p>
            </div>

            <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
            <div class="alert alert--error" role="alert">
                <p><%=Validate.escapeHtml(errorMessage)%></p>
            </div>
            <% } %>

            <form action="<%=ctx%>/ForgotPasswordServelet" method="POST" data-validated
                  data-busy-text="Sending code...">
                <div class="field">
                    <input type="email" id="Email" name="Email" placeholder="Email"
                           value="<%=email%>" autocomplete="email" maxlength="50"
                           autofocus required data-validate="email">
                    <label for="Email">Email address</label>
                    <span class="error"></span>
                </div>

                <button type="submit" class="btn btn--primary">Send me a code</button>
            </form>

            <div class="auth-foot">
                Remembered it? <a href="<%=ctx%>/login.jsp">Back to sign in</a>
            </div>
        </main>

        <script src="<%=ctx%>/js/auth.js"></script>
    </body>
</html>
