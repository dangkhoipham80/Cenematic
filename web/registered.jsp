<%--
    Shown right after a successful registration. Kept separate from
    success.jsp, which is the generic "saved" page shared by the payment and
    change-information flows.
--%>
<%@page import="Utils.Validate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
    String email = Validate.clean((String) request.getAttribute("email"));
    // False when MAIL_USER / MAIL_PASSWORD are not configured, in which case
    // telling the user to check their inbox would just be a lie.
    boolean emailSent = Boolean.TRUE.equals(request.getAttribute("emailSent"));
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Account created &middot; Cinematic</title>
        <link rel="stylesheet" href="<%=ctx%>/css/auth.css">
    </head>
    <body class="auth">
        <main class="auth-card text-center">
            <a class="auth-brand" href="<%=ctx%>/index.jsp">
                <img src="<%=ctx%>/img/bintang%20cinema.png" alt="">
                <span>Cinematic</span>
            </a>

            <div class="status-icon <%=emailSent ? "status-icon--mail" : "status-icon--ok"%>" aria-hidden="true">
                <%=emailSent ? "&#9993;" : "&#10003;"%>
            </div>

            <div class="auth-head">
                <h1><%=emailSent ? "Check your inbox" : "Account created"%></h1>
                <% if (emailSent && !email.isEmpty()) { %>
                <p>Your account is created. We sent a confirmation link to
                    <strong><%=Validate.escapeHtml(Validate.maskEmail(email))%></strong> &mdash;
                    open it to activate your account, then sign in.</p>
                <% } else { %>
                <p>Your account is created, but we could not send the confirmation email.
                    Please ask an administrator to activate your account.</p>
                <% } %>
            </div>

            <% if (emailSent) { %>
            <div class="alert alert--info">
                <p>The link is valid for 24 hours. If it isn't there, check your spam folder.</p>
            </div>
            <% } %>

            <a class="btn btn--primary" href="<%=ctx%>/login.jsp">Go to sign in</a>
            <a class="btn btn--ghost" href="<%=ctx%>/index.jsp">Back to the cinema</a>
        </main>
    </body>
</html>
