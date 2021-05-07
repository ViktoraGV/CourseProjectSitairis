<#macro page title>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

        <style>
            .navbar {
                margin-bottom: 0;
                border-radius: 0;
            }

            footer {
                background-color: #555;
                color: white;
                padding: 15px;
            }

            @media screen and (max-width: 767px) {
                .row.content {
                    height: auto;
                }
            }
        </style>
        <title>${title}</title>
    </head>
    <body>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
            integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
            integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
            crossorigin="anonymous"></script>
    <nav class="navbar navbar-inverse">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>
            <div class="collapse navbar-collapse" id="myNavbar">
                <ul class="nav navbar-nav">
                    <li><a href="/blog">Статьи</a></li>
                    <li><a href="/blog/editor" class="active">Добавить свою статью</a></li>
                    <#if __user??>
                        <li><a href="/user/profile" class="active">Профиль</a></li>
                        <li><a href="/blog/user-messages/-1" class="active">Мои статьи</a></li>
                    </#if>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <form action="<#if __user??>/logout<#else>/blog/editor</#if>" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                            <button type="submit"
                                    style="background: transparent;border: 0px; color: beige;padding: 15px">
                                <span class="glyphicon glyphicon-log-in">
                                    <#if __user??>SignOut<#else>Login</#if></span>
                            </button>
                        </form>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <#nested>
    </body>
    </html>
</#macro>