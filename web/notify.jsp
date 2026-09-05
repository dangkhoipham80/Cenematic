<%--
    Result of an account confirmation link. Reached from AuthenticateSevelet.
--%>
<%@page import="Utils.Validate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
    boolean ok = Boolean.TRUE.equals(request.getAttribute("statusOk"));
    String title = Validate.clean((String) request.getAttribute("statusTitle"));
    String message = Validate.clean((String) request.getAttribute("statusMessage"));
    if (title.isEmpty()) {
        title = ok ? "Done" : "Something went wrong";
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title><%=Validate.escapeHtml(title)%> &middot; Cinematic</title>
        <link rel="stylesheet" href="<%=ctx%>/css/auth.css">
    </head>
    <body class="auth">
        <main class="auth-card text-center">
            <a class="auth-brand" href="<%=ctx%>/index.jsp">
                <img src="<%=ctx%>/img/bintang%20cinema.png" alt="">
                <span>Cinematic</span>
            </a>

            <div class="status-icon <%=ok ? "status-icon--ok" : "status-icon--error"%>" aria-hidden="true">
                <%=ok ? "&#10003;" : "&#33;"%>
            </div>

            <div class="auth-head">
                <h1><%=Validate.escapeHtml(title)%></h1>
                <p><%=Validate.escapeHtml(message)%></p>
            </div>

            <% if (ok) { %>
            <a class="btn btn--primary" href="<%=ctx%>/login.jsp">Sign in</a>
            <a class="btn btn--ghost" href="<%=ctx%>/index.jsp">Back to the cinema</a>
            <% } else { %>
            <a class="btn btn--primary" href="<%=ctx%>/register.jsp">Register again</a>
            <a class="btn btn--ghost" href="<%=ctx%>/index.jsp">Back to the cinema</a>
            <% } %>
        </main>
    </body>
</html>
