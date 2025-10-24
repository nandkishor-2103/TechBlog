<%@page import="com.tech.blog.entities.User"%>
<%
    // Only declare this ONCE, here in the navbar include
    User currentUser = (User) session.getAttribute("currentUser");
%>
<nav class="navbar navbar-expand-lg navbar-dark primary-background fixed-top">
    <a class="navbar-brand" href="index.jsp"> <span class="fa fa-laptop icon"></span> TechBlog</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" 
            data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" 
            aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="profile.jsp"> <span class="fa fa-book icon"></span> Read Blog <span class="sr-only">(current)</span></a>
            </li>
        </ul>

        <ul class="navbar-nav ml-auto">
            <%
                if (currentUser != null) {
            %>
            <li class="nav-item ">
                <a class="nav-link text-white" href="#!">Welcome, <%= currentUser.getName()%></a>
            </li>


            <li class="nav-item">
                <a class="nav-link text-white" href="LogoutServlet"> <span class="fa fa-user-plus "></span> Logout</a>
            </li>
            <%
            } else {
            %>
            <li class="nav-item">
                <a class="nav-link" href="login_page.jsp"> <span class="fa fa-user icon "></span> Login</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="register_page.jsp"> <span class="fa fa-user-plus icon"></span> Sign up</a>
            </li>
            <%
                }
            %>
        </ul>

        <!-- Search form -->
        <form action="SearchServlet" method="get" class="d-flex" role="search" style="margin-left: 20px;">
            <input class="form-control me-2" type="search" name="query" placeholder="Search blogs" aria-label="Search" required>
            <button class="btn btn-outline-success btn " type="submit" style="margin-left: 20px; background-color: green; color: white;">Search</button>
        </form>


    </div>
</nav>