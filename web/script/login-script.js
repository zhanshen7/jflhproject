$(function () {
    let verifyCode = new GVerify("canvas-verifyCode");
    let formLogin = $('#form-login');
    let formRegister = $('#form-register');
    //turn login-box on/down
    $("#btn-close").click(function () {
        $("#jflh-login-box").hide();
    });
    $("#btn-login").click(function () {
        $("#jflh-login-box").show();
        let registerBox = $("#register-box");
        if (registerBox.css("display") !== "none") {
            $(".switch-slide").css("left", "30px");
            $("#login-box").show();
            registerBox.hide();
        }
    });
    //switch loginBox/registerBox
    let registerBox = $("#register-box");
    let loginBox = $("#login-box");
    let slide = $(".switch-slide");
    $("#btn-login-box").click(function () {
        if (loginBox.css("display") === "none") {
            slide.animate({left: '30px'}, "fast");
            loginBox.show();
            registerBox.hide();
        }
    });
    $("#btn-register-box").click(function () {
        if (registerBox.css("display") === "none") {
            slide.animate({left: '135px'}, "fast");
            loginBox.hide();
            registerBox.show();
        }
    });
    //show-password
    $("#show-password")
        .mousedown(function () {
            $('#fa-eye').css("color", "#4d4d4d").removeClass("fa-eye-slash").addClass("fa-eye");
            $(this).next().prop('type', 'text')
        })
        .mouseup(function () {
            $('#fa-eye').css("color", "#b3b3b3").removeClass("fa-eye").addClass("fa-eye-slash");
            $(this).next().prop('type', 'password')
        });
    //field popover
    formRegister.find('input[name="phone"]').popover({
        container: formRegister,
        animation: false,
        html: true,
        trigger: 'focus',
        content: '<span style="font-size: 0.9em">' +
        '<i class="fas fa-exclamation-circle" style="color: #84a4cd"/>使用手机号码注册</span>',
    });
    formRegister.find('input[name="password"]').popover({
        container: formRegister,
        animation: false,
        html: true,
        trigger: 'focus',
        content: '<span style="font-size: 0.9em">' +
        '<i class="fas fa-exclamation-circle" style="color: #84a4cd"/>长度为6-16个字符<br>' +
        '<i class="fas fa-exclamation-circle" style="color: #84a4cd"/>不能是纯数字<br>' +
        '<i class="fas fa-exclamation-circle" style="color: #84a4cd"/>不能包含空格和特殊字符</span>'
    });
    //form validation
    formLogin
        .bootstrapValidator({
            live: 'disabled',
            fields: {
                phone: {
                    validators: {
                        notEmpty: {
                            message: '请输入手机号码'
                        },
                        remote: {
                            enabled: false,
                            message: '账号不存在或密码错误',
                            url: '/Ajax/login',
                            type: 'POST',
                            data: function (validator) {
                                return {
                                    password: validator.getFieldElements('password').val()
                                };
                            }
                        }
                    }
                },
                password: {
                    enabled: false,
                    validators: {
                        notEmpty: {
                            message: '请输入密码'
                        }
                    }
                }
            }
        })
        .on('mouseup', ':submit', function () {
            let phoneIsEmpty = formLogin.find("input[name='phone']").val() === '';
            let passwordIsEmpty = formLogin.find("input[name='password']").val() === '';
            formLogin
                .bootstrapValidator('enableFieldValidators', 'password', !phoneIsEmpty)
                .bootstrapValidator('enableFieldValidators', 'phone', !passwordIsEmpty, 'remote');
        })
        .on('error.field.bv', function (e, data) {
            formLogin.find('span[data-field="' + data.field + '"]').remove();
            data.element
                .before(
                    $('<span/>')
                        .attr('data-field', data.field)
                        .addClass('error-feedback error-feedback-bg')
                        .wrapInner(
                            '<i class="fas fa-exclamation-circle" style="color: #ff630e"></i>' + data.bv.getMessages(data.element)
                        )
                        .delay(3000).fadeOut("fast")
                )
                .click(function () {
                    formLogin.find('span[data-field="' + data.field + '"]').remove();
                })
                .data('bv.messages')
                .find('.help-block[data-bv-for="' + data.field + '"]')
                .hide();
        })
        .on('success.field.bv', function (e, data) {
            data.element.parents('.form-group').removeClass('has-success');
            formLogin.find('span[data-field="' + data.field + '"]').remove();
        })
        .on('success.form.bv', function () {
            if ($("#auto-login").is(':checked')) {
                localStorage.phone = formLogin.find("input[name='phone']").val();
                localStorage.password = formLogin.find("input[name='password']").val();
            }
        });
    formRegister
        .bootstrapValidator({
            trigger: "blur",
            feedbackIcons: {
                valid: 'fas fa-check',
                invalid: 'fas fa-times',
                validating: 'fas fa-spinner fa-pulse'
            },
            fields: {
                phone: {
                    validators: {
                        notEmpty: {
                            message: '请输入手机号码'
                        },
                        regexp: {
                            message: '号码不正确',
                            regexp: /^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$/
                        },
                        remote: {
                            enabled: false,
                            message: '用户名已存在',
                            url: '/Ajax/register',
                            type: 'POST'
                        }
                    }
                },
                password: {
                    validators: {
                        notEmpty: {
                            message: '请输入密码'
                        },
                        stringLength: {
                            message: '长度为6-16个字符',
                            min: 6,
                            max: 16
                        },
                        regexp: {
                            message: '密码格式不正确',
                            regexp: /^[A-Za-z~!%^&*]+[0-9]|[A-Za-z~!%^&*]$/
                        },
                    }
                },
                repassword: {
                    validators: {
                        notEmpty: {
                            message: '请再次输入密码'
                        },
                        identical: {
                            message: '密码不一致',
                            field: 'password'
                        }
                    }
                },
                verifyCode: {
                    validators: {
                        notEmpty: {
                            message: '请输入验证码'
                        },
                        callback: {
                            enabled: false,
                            message: '验证码不正确',
                            callback: function (value) {
                                return verifyCode.validate(value);
                            }
                        }
                    }
                },
            }
        })
        .on('blur', 'input[name="phone"]', function () {
            let phoneIsValid = $(this).val().match(/^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$/) != null;
            formRegister
                .bootstrapValidator('enableFieldValidators', 'phone', phoneIsValid, "remote")
        })
        .on('blur', 'input[name="verifyCode"]', function () {
            let isEmpty = $(this).val() === '';
            formRegister
                .bootstrapValidator('enableFieldValidators', 'verifyCode', !isEmpty, "callback")
        })
        .on('status.field.bv', function (e, data) {
            if (data.bv.getSubmitButton()) {
                data.bv.disableSubmitButtons(false);
            }
        })
        .on('error.field.bv', function (e, data) {
            formRegister.find('span[data-field="' + data.field + '"]').remove();
            data.element
                .after(
                    $('<span/>')
                        .addClass('error-feedback')
                        .attr('data-field', data.field)
                        .wrapInner(
                            '<i class="fas fa-exclamation-circle" style="color: #ff630e"></i>' + data.bv.getMessages(data.element)[0]
                        )
                )
                .data('bv.messages')
                .find('.help-block[data-bv-for="' + data.field + '"]')
                .hide();
        })
        .on('success.field.bv', function (e, data) {
            formRegister.find('span[data-field="' + data.field + '"]').remove();
        });
});

