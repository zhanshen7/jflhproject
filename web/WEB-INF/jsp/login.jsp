<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2/20/2018
  Time: 12:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <link rel="stylesheet" href="<c:url value="/css/bootstrap/bootstrapValidator.min.css"/>">
    <link rel="stylesheet" href="<c:url value="/css/login-style.css"/>">

    <script src="<c:url value="/script/bootstrap/bootstrapValidator.min.js"/>"></script>
</head>
<body>
<div id="jflh-login-box" style="display: none">
    <div id="login-mask"></div>
    <div id="login-register-box">
        <%--hd--%>
        <div id="login-box-hd" style="border-bottom: 2px solid #cccccc;">
            <a id="btn-login-box">登录</a>
            <a id="btn-register-box">注册</a>
            <div class="switch-slide"></div>
            <div class="btn-close" id="btn-close"><span></span><span></span></div>
        </div>
        <%--bd--%>
        <div id="login-box-bd " style="padding: 20px 5px 0; display: flex">
            <div id="login-box">
                <p style="color: #4d4d4d;font-size: 1.2em">账号登录</p>
                <form action="<c:url value="/login"/>" method="post" class="form-horizontal" id="form-login">
                    <div class="form-group">
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="phone" autocomplete="off"
                                   placeholder="手机号"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-10">
                            <div id="show-password"><i class="fas fa-eye-slash fa-lg" id="fa-eye"></i></div>
                            <input type="password" class="form-control" name="password" placeholder="密码"/>
                            <input type="checkbox" id="auto-login" name="auto-login" style="margin-top: 10px"/>
                            <label for="auto-login"
                                   style="color:#808080;font-size: 0.9em;cursor: pointer">&nbsp;自动登录</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-10">
                            <button type="submit" class="btn-submit" style="padding: 10px 60px">登录</button>
                        </div>
                    </div>
                </form>
                <a href="#">找回密码</a>
            </div>
            <%--register-box--%>
            <div id="register-box" style="display: none">
                <form action="<c:url value="/register"/>" method="post" class="form-horizontal" id="form-register">
                    <div class="form-group">
                        <div class="col-md-10">
                            <input type="text" class=" form-control" name="phone" autocomplete="off"
                                   placeholder="输入你的手机号"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-10">
                            <input type="password" class="form-control" name="password" placeholder="设置你账号的登录密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-10">
                            <input type="password" class="form-control" name="repassword" placeholder="再次输入密码"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="verifyCode" id="verifyCode"
                                   autocomplete="off" placeholder="输入下图所示的验证码"/>
                        </div>
                    </div>
                    <div id="canvas-verifyCode"></div>
                    <a href="#" style="margin: 15px 0 20px">《用户服务协议》</a>
                    <div class="form-group">
                        <div class="col-md-10">
                            <button type="submit" class="btn-submit" style="padding: 10px 40px;margin-bottom: 15px">
                                同意并注册账号
                            </button>
                        </div>
                    </div>
                </form>
            </div>
            <%--social-box--%>
            <div id="social-account-login-box">
                <p style="color:#808080">社交账号登录</p>
                <button id="btn-qq">
                    <i class="fab fa-qq fa-lg"></i>QQ账号登录
                </button>
                <button id="btn-wechat">
                    <i class="fab fa-weixin fa-lg"></i>微信账号登录
                </button>
            </div>
        </div>
        <label id="label-notice">使用即为同意《峻峰浪花服务协议》</label>
    </div>
</div>
<script src="<c:url value="/script/plug-in/gVerify.js"/>"></script>
<script src="<c:url value="/script/login-script.js"/>"></script>
</body>
</html>
