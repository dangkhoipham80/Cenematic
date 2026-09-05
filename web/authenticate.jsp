<%@page import="Utils.Validate"%>
<%@page import="Utils.VerificationCode"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();

    // Reached only as part of a reset started on forgotpassword.jsp. Landing
    // here directly used to throw a NullPointerException on the session user.
    String resetEmail = (String) session.getAttribute("resetEmail");
    if (resetEmail == null) {
        response.sendRedirect(ctx + "/forgotpassword.jsp");
        return;
    }

    String errorMessage = (String) request.getAttribute("errorMessage");
    String infoMessage = (String) request.getAttribute("infoMessage");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Enter your code &middot; Cinematic</title>
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
                <li class="is-current">2. Code</li>
                <li>3. New password</li>
            </ol>

            <div class="auth-head">
                <h1>Enter your code</h1>
                <p>We sent a 6-digit code to <strong><%=Validate.escapeHtml(Validate.maskEmail(resetEmail))%></strong>.
                    It expires in <%=VerificationCode.RESET_MINUTES%> minutes.</p>
            </div>

            <% if (infoMessage != null && !infoMessage.isEmpty()) { %>
            <div class="alert alert--info" role="status"><p><%=Validate.escapeHtml(infoMessage)%></p></div>
            <% } %>
            <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
            <div class="alert alert--error" role="alert"><p><%=Validate.escapeHtml(errorMessage)%></p></div>
            <% } %>

            <form action="<%=ctx%>/CheckCodeServelet" method="POST" data-busy-text="Checking...">
                <!-- Six boxes are nicer to type into, but they only work with
                     JavaScript. The plain input below is the real form control;
                     auth.js swaps them over and keeps the two in sync. -->
                <div class="otp" data-otp="Code" hidden>
                    <input type="text" inputmode="numeric" pattern="[0-9]*" maxlength="1" placeholder=" "
                           aria-label="Digit 1" autocomplete="one-time-code">
                    <input type="text" inputmode="numeric" pattern="[0-9]*" maxlength="1" placeholder=" " aria-label="Digit 2">
                    <input type="text" inputmode="numeric" pattern="[0-9]*" maxlength="1" placeholder=" " aria-label="Digit 3">
                    <input type="text" inputmode="numeric" pattern="[0-9]*" maxlength="1" placeholder=" " aria-label="Digit 4">
                    <input type="text" inputmode="numeric" pattern="[0-9]*" maxlength="1" placeholder=" " aria-label="Digit 5">
                    <input type="text" inputmode="numeric" pattern="[0-9]*" maxlength="1" placeholder=" " aria-label="Digit 6">
                </div>
                <p class="otp-hint" hidden>You can paste the whole code into any box.</p>

                <div class="field" data-otp-fallback>
                    <input type="text" id="Code" name="Code" placeholder="6-digit code"
                           inputmode="numeric" maxlength="6" autocomplete="one-time-code"
                           autofocus required>
                    <label for="Code">6-digit code</label>
                </div>

                <button type="submit" class="btn btn--primary">Verify code</button>
            </form>

            <form action="<%=ctx%>/ForgotPasswordServelet" method="POST">
                <input type="hidden" name="resend" value="1">
                <button type="submit" class="btn btn--ghost">Send a new code</button>
            </form>

            <div class="auth-foot">
                Wrong address? <a href="<%=ctx%>/forgotpassword.jsp">Start over</a>
            </div>
        </main>

        <script src="<%=ctx%>/js/auth.js"></script>
    </body>
</html>
