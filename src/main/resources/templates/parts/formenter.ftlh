<#macro form islogin>
    <div class="container-fluid text-center">
        <div class="row content">
            <div class="col-sm-4 text-left">
                <#nested>
                <form action="<#if islogin>/login<#else>/registration</#if>" method="post">
                    <fieldset>
                        <h2>Введите данные</h2>
                        <#if islogin && RequestParameters.error??>
                            <div class="alert alert-info">
                                Вы ввели неправильные данные
                            </div>
                        </#if>
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                            <input id="username" type="text" class="form-control" name="username"
                                   placeholder="Логин" required="required"/>
                        </div>
                        <br/>
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                            <input id="password" type="password" class="form-control" name="password"
                                   placeholder="Пароль" required="required"/>
                            <#if passwordError??>
                                <div style="color: red;">
                                    ${passwordError}
                                </div>
                            </#if>
                        </div>
                        <#if !islogin>
                            <div class="input-group" style="padding-top: 20px;">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                <input id="passwordRepeat" type="password" class="form-control" name="passwordRepeat"
                                       placeholder="Повторение пароля" required="required"/>
                                <#if passwordRepeatError??>
                                    <div style="color: red;">
                                        ${passwordRepeatError}
                                    </div>
                                </#if>
                            </div>
                            <div class="input-group" style="padding-top: 20px;">
                                <span class="input-group-addon">@</span>
                                <input id="email" type="email" class="form-control" name="email"
                                       placeholder="some@some.com" required="required"/>
                            </div>
                            <br/>
                        </#if>
                        <div style="padding-top: 10px;">
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                            <input type="submit" value="<#if islogin>Войти<#else >Регистрация</#if>"
                                   class="btn btn-success"/>
                        </div>
                    </fieldset>
                </form>
                <#if islogin>
                    <a href="/registration" class="btn btn-primary btn-small" style="margin-top: 5px">Регистрация</a>
                </#if>
                <hr/>
            </div>
        </div>
    </div>
</#macro>