<%@page import="Utils.Validate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();

    // Only a session that has just passed the code check may be here.
    if (session.getAttribute("resetVerifiedUserId") == null) {
        response.sendRedirect(ctx + "/forgotpassword.jsp");
        return;
    }

    String errorMessage = (String) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Choose a new password &middot; Cinematic</title>
        <link rel="stylesheet" href="<%=ctx%>/css/auth.css">
    </head>
    <body class="auth">
        <main class="auth-card">
            <a class="auth-brand" href="<%=ctx%>/index.jsp">
                <img src="<%=ctx%>/img/bintang%20cinema.png" alt="">
                <span>Cinematic</span>
            </a>

            <ol class="steps">
                <li class="is-done">1. Email</li>
                <li class="is-done">2. Code</li>
                <li class="is-current">3. New password</li>
            </ol>

            <div class="auth-head">
                <h1>Choose a new password</h1>
                <p>Pick something you haven't used here before. You'll sign in with it right away.</p>
            </div>

            <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
            <div class="alert alert--error" role="alert">
                <p><%=Validate.escapeHtml(errorMessage)%></p>
            </div>
            <% } %>

            <form action="<%=ctx%>/ResetPasswordServlet" method="POST" data-validated
                  data-busy-text="Saving...">
                <div class="field field--password">
                    <input type="password" id="password" name="password" placeholder="New password"
                           autocomplete="new-password" autofocus required data-validate="password">
                    <label for="password">New password</label>
                    <button type="button" class="pw-toggle" data-pw-toggle="password"
                            aria-label="Show password">Show</button>
                    <span class="hint">At least 8 characters, with a letter and a digit.</span>
                    <span class="error"></span>
                </div>
                <div class="pw-meter" data-pw-meter="password" data-score="0" aria-hidden="true">
                    <span class="bars"><i></i><i></i><i></i><i></i></span>
                    <span class="label"></span>
                </div>

                <div class="field field--password">
                    <input type="password" id="passwordAgain" name="passwordAgain"
                           placeholder="Confirm new password" autocomplete="new-password"
                           required data-match="password">
                    <label for="passwordAgain">Confirm new password</label>
                    <button type="button" class="pw-toggle" data-pw-toggle="passwordAgain"
                            aria-label="Show password">Show</button>
                    <span class="error"></span>
                </div>

                <button type="submit" class="btn btn--primary">Save new password</button>
            </form>

            <div class="auth-foot">
                <a href="<%=ctx%>/login.jsp">Cancel and go back to sign in</a>
            </div>
        </main>

        <script src="<%=ctx%>/js/auth.js"></script>
    </body>
</html>
