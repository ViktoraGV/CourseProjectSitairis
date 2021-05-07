<#import  "parts/coomon.ftlh" as C>
<@C.page "Страница смены пароля">
    <h3>Смена пароля пользователя: ${username}</h3>
    <form method="post">
        <fieldset>
            <h2>Введите данные</h2>
            <#if passwordError??>
                <div class="alert alert-info">
                    ${passwordError}
                </div>
            </#if>
            <div class="input-group">
                <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                <input id="passwordOld" type="password" class="form-control" name="passwordOld"
                       placeholder="Старый пароль" required="required"/>
            </div>
            <div class="input-group" style="padding-top: 20px;">
                <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                <input type="hidden" name="username" value="${username}">
                <input type="hidden" name="email" value="null@null.null">
                <input id="password" type="password" class="form-control" name="password"
                       placeholder="Новый пароль" required="required"/>
            </div>
            <div class="input-group" style="padding-top: 20px;">
                <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                <input id="passwordRepeat" type="password" class="form-control" name="passwordRepeat"
                       placeholder="Повторение нового пароля" required="required"/>
            </div>
            <div style="padding-top: 10px;">
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <input type="submit" value="Войти"
                       class="btn btn-success"/>
            </div>
        </fieldset>
    </form>
</@C.page>