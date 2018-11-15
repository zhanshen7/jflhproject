<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2/18/2018
  Time: 14:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <style>
        header {
            position: absolute;
            width: 100%;
            min-width: 1280px;
        }

        nav {
            height: 30px;
            line-height: 30px;
            background-color: #e6e6e6;
            box-shadow: 0 1px 4px #808080;
        }

        #nav-login {
            width: 100px;
            display: inline;
            float: right;
            margin-right: 5%;
            text-align: center;
        }

        #user-box:hover {
            background-color: #fff;
        }

        .nav-list {
            padding: 5% 0 0;
            display: none;
            box-shadow: 0 1px 1px #808080;
        }

        .nav-list a {
            display: inline-block;
            width: 100%;
            height: 100%;
            color: black;
        }

        .nav-list a:hover {
            background-color: #DBDBDB;
        }

        #btn-login {
            color: #000000;
            background: none;
        }

        #btn-login:hover {
            color: red;
        }
    </style>
</head>
<body>
<header>
    <nav>
        <a href="#shouye" style="margin-left: 20%">首页</a>
        <a href="#kefuzhongxin" style="float: right;margin-right: 20%">客服中心</a>
        <div id="nav-login">
            <c:choose>
                <%--@elvariable id="user" type="com.model.User"--%>
                <c:when test="${empty user}">
                    <button id="btn-login"><i class="far fa-user"></i>&nbsp;登录</button>
                </c:when>
                <c:otherwise>
                    <div id="user-box">
                        <a href="#" style="z-index: 10;color: black">我的淘宝</a>
                        <ul id="user-list" class="nav-list" style="z-index: 9">
                            <li><a href="#wodexinxi">我的信息</a></li>
                            <li><a href="#wodedingdan">我的订单</a></li>
                            <li><a href="#gouwuche">购物车</a></li>
                            <li><a href="#gouwuche">退出</a></li>
                        </ul>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>
</header>
<script>
    $("#user-box")
        .mouseover(function () {
            $("#user-list").show();
        })
        .mouseout(function () {
            $("#user-list").hide();
        });
</script>
</body>
</html>
