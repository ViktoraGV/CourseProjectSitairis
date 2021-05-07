<#import  "parts/coomon.ftlh" as C>
<@C.page "Страница редактора">
    <div class="container-fluid text-center">
        <div class="row content">
            <div class="col-sm-8 text-left">
                <form action="/blog/editor/submit" object="${article}" method="post">
                    <h1>Создание статьи</h1>
                    <div class="form-group">
                        <label for="usr">Заголовок</label>
                        <input type="text" class="form-control" value="<#if message??>${message.title}</#if>"
                               name="title"/>
                        <#if titleError??>
                            <div style="color: red;">
                                ${titleError}
                            </div>
                        </#if>
                    </div>
                    <div class="form-group">
                        <label for="comment">Содержание</label>
                        <textarea name="content" value="<#if message??>${message.content}</#if>"
                                  class="form-control" rows="20"></textarea>
                        <#if contentError??>
                            <div style="color: red;">
                                ${contentError}
                            </div>
                        </#if>
                    </div>
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                    <input type="submit" value="Сохранить" class="btn btn-success"/>
                </form>
                <hr/>
            </div>
        </div>
    </div>
</@C.page>