<%@page import="com.tech.blog.entities.User"%>
<%
    // Only declare this ONCE, here in the navbar include
    User currentUser = (User) session.getAttribute("currentUser");
%>
<nav class="navbar navbar-expand-lg navbar-dark primary-background fixed-top">
    <a class="navbar-brand" href="index.jsp"> <span class="fa fa-laptop icon"></span> Tech Blog</a>
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
           if(currentUser != null) {
        %>
          <li class="nav-item ">
              <a class="nav-link text-white" href="#!">Welcome, <%= currentUser.getName() %></a>
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
<!--      <form class="form-inline my-2 my-lg-0">
        <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-light my-2 my-sm-0" type="submit">Search</button>
      </form>-->
    </div>
</nav>