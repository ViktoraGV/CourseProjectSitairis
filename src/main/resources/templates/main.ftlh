<#import  "parts/coomon.ftlh" as C>
<#import "parts/pager.ftlh" as p>
<@C.page "Заглавная страница Гостевой книги">
    <@p.pager url page/>
    <div class="container-fluid text-center">
        <div class="row content">
            <div class="col-sm-8 text-left">
                <div class="well">
                    <div class="panel-body">
                        <h1>Статьи:</h1>
                    </div>
                </div>
                <#list page.content as articles>
                    <h1>${articles.title}</h1>
                    <p><textarea cols="128"
                                 style="resize: none;border: lightsteelblue solid 1px; border-radius: 5px; height: auto; min-height: 30px;overflow: hidden;background-color: lightgray">${articles.content}</textarea>
                    </p>
                    <p>${articles.creationTimestamp}</p>
                    <p>Ник пользователя оставившего статью: <a
                                href="/blog/user-messages/${articles.username}">${articles.username}</a></p>
                    <#if isAdmin><a href="/blog/delete/${articles.id}">Удалить</a></#if>
                    <hr/>
                </#list>
            </div>
        </div>
    </div>
    <@p.pager url page/>
</@C.page>