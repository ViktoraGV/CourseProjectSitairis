<#import  "parts/coomon.ftlh" as C>
<@C.page "Мои статьи">
    <#if message??>
        <div class="container-fluid text-center">
            <div class="row content">
                <div class="col-sm-8 text-left">
                    <form action="/blog/user-messages/save" object="${article}" method="post">
                        <h1>Редактирование статьи</h1>
                        <div class="form-group">
                            <label for="usr">Заголовок</label>
                            <input type="text" class="form-control" value="<#if message??>${message.title}</#if>"
                                   name="title"/>
                        </div>
                        <div class="form-group">
                            <label for="comment">Содержание</label>
                            <textarea name="content" class="form-control"
                                      rows="20"><#if message??>${message.content}</#if></textarea>
                        </div>
                        <input type="hidden" name="id" value="<#if message??>${message.id}</#if>">
                        <input type="hidden" name="username" value="<#if message??>${message.username}</#if>">
                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                        <input type="submit" value="Сохранить" class="btn btn-success"/>
                    </form>
                    <hr/>
                </div>
            </div>
        </div>
    </#if>



    <div class="container-fluid text-center">
        <div class="row content">
            <div class="col-sm-8 text-left">
                <div class="well">
                    <div class="panel-body">
                        <h1>Статьи:</h1>
                    </div>
                </div>
                <#list messages as articles>
                    <h1>${articles.title}</h1>
                    <p><textarea cols="80"
                                 style="resize: none;border: lightsteelblue solid 1px; border-radius: 5px; height: auto; min-height: 30px;overflow: hidden;background-color: lightgray">${articles.content}</textarea>
                    </p>
                    <p>${articles.creationTimestamp}</p>
                    <p>Ник пользователя оставившего отзыв: ${articles.username}</p>
                    <#if access>
                        <a href="/blog/user-messages/-1?id=${articles.id}">
                            Редактировать
                        </a>
                    </#if>
                    <hr/>
                </#list>
            </div>
        </div>
    </div>
</@C.page>