<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2/20/2018
  Time: 17:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>峻峰浪花</title>
    <link rel="icon" href="<c:url value="/img/favicon.ico"/>" type="image/icon"/>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="<c:url value="/css/homepage-style.css"/>">

    <script src="<c:url value="/script/jquery/jquery.min.js"/>"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"
            integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
            crossorigin="anonymous"></script>
    <script src="<c:url value="/script/plug-in/fontawesome-all.min.js"/>"></script>
    <script src="<c:url value="/script/homepage-script.js"/>"></script>
</head>
<body>

<c:choose>
    <%--@elvariable id="user" type="com.model.User"--%>
    <c:when test="${empty user}">
        <script>
            $(document).ready(function () {
                if (localStorage.phone !== null) {
                    $.post("/login",
                        {
                            phone: localStorage.phone,
                            password: localStorage.password
                        }
                    )
                }
            })
        </script>
        <jsp:include page="login.jsp"/>
    </c:when>
</c:choose>
<%@include file="top.jsp" %>
<%@include file="foot.jsp" %>
</body>
</html>
