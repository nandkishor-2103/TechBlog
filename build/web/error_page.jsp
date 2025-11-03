<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@page isErrorPage="true" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Sorry ! something went wrong...</title>

            <!--CSS-->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
                integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
                crossorigin="anonymous">
            <link href="css/mystyle.css" rel="stylesheet" type="text/css" />
            <link rel="stylesheet"
                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
            <!-- Font Awesome 4.7 CDN -->
            <link rel="stylesheet"
                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

            <style>
                .icon {
                    margin: 10px;
                    font-size: 24px;
                    /* default size */
                }

                .banner-background {
                    clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 96%, 71% 93%, 32% 97%, 0 89%, 0 0);
                }

                body {
                    padding-top: 70px;
                }
            </style>

        </head>

        <body>
            <div class="container text-center">
                <img src="img/error.png" class="img-fluid">
                <h3 class="display-3">Sorry ! Something went wrong...</h3>
                <%= exception %>
                    <a href="index.jsp" class="btn primary-background btn-lg text-white mt-3">Home </a>
            </div>


        </body>

        </html>