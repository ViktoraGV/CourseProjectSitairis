<#import  "parts/coomon.ftlh" as C>
<#import  "parts/formenter.ftlh" as L>
<@C.page "Страница регистрации">
    <@L.form false>
        <#if message??>
            <div class="alert alert-info">
                <h1>${message}</h1>
            </div>
        </#if>
    </@L.form>
</@C.page>