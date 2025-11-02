<%@page import="com.tech.blog.dao.LikeDao" %>
    <%@page import="com.tech.blog.entities.Post" %>
        <%@page import="java.util.List" %>
            <%@page import="java.util.HashSet" %>
                <%@page import="com.tech.blog.helper.ConnectionProvider" %>
                    <%@page import="com.tech.blog.dao.PostDao" %>
                        <%@page contentType="text/html" pageEncoding="UTF-8" %>
                            <!DOCTYPE html>
                            <html>

                            <head>
                                <meta charset="UTF-8">
                                <title>TechBlog - Home</title>

                                <!-- Bootstrap / Icons / Custom CSS -->
                                <link rel="stylesheet"
                                    href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
                                <link href="css/mystyle.css" rel="stylesheet" />
                                <link rel="stylesheet"
                                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

                                <style>
                                    .banner-background {
                                        clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 91%, 63% 100%, 22% 91%, 0 99%, 0 0);
                                    }

                                    .btn-liked {
                                        pointer-events: none;
                                        opacity: 0.6;
                                    }

                                    .card {
                                        border-radius: 12px;
                                        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                                        margin-bottom: 24px;
                                    }

                                    .card-img-container {
                                        max-height: 300px;
                                        overflow: hidden;
                                        background: #f8f9fa;
                                        display: flex;
                                        justify-content: center;
                                        border-radius: 8px 8px 0 0;
                                    }

                                    .card-img-top {
                                        max-height: 300px;
                                        object-fit: contain;
                                        transition: .3s;
                                    }

                                    .card-img-top:hover {
                                        transform: scale(1.05);
                                    }

                                    .read-more-btn {
                                        color: #3563d1;
                                        cursor: pointer;
                                    }
                                </style>

                                <script>
                                    function showFullContent(id)
                                    {
                                        document.getElementById('snippet-' + id).style.display = 'none';
                                        document.getElementById('fullcontent-' + id).style.display = 'block';
                                        document.getElementById('read-more-btn-' + id).style.display = 'none';
                                    }
                                </script>
                            </head>

                            <body>

                                <%@include file="normal_navbar.jsp" %>

                                    <!-- Banner -->
                                    <div class="container-fluid p-0 m-0">
                                        <div class="jumbotron primary-background text-white banner-background">
                                            <div class="container">
                                                <h3 class="display-3">Welcome to TechBlog</h3>
                                                <p>Explore the world of programming, development and technology.</p>
                                                <a href="register_page.jsp" class="btn btn-outline-light btn-lg"><i
                                                        class="fa fa-user-plus"></i> Start Free</a>
                                                <a href="login_page.jsp" class="btn btn-outline-light btn-lg"><i
                                                        class="fa fa-user-circle"></i> Login</a>
                                            </div>
                                        </div>
                                    </div>

                                    <h1 class="text-center my-4" style="text-decoration: underline; color:#2c3e50;">See
                                        All Posts</h1>

                                    <div class="container">
                                        <div class="row">

                                            <% PostDao postDao=new PostDao(ConnectionProvider.getConnection()); LikeDao
                                                likeDao=new LikeDao(ConnectionProvider.getConnection()); List<Post>
                                                posts = postDao.getAllPosts();

                                                if (posts == null || posts.isEmpty()) {
                                                %>
                                                <div class="col-12 text-center">
                                                    <h3>No Posts Available</h3>
                                                </div>

                                                <% } else { HashSet<Integer> likedPostIds = new HashSet<>();
                                                        if (currentUser != null) {
                                                        for (Post post : posts) {
                                                        if (likeDao.isLikedByUser(post.getPid(), currentUser.getId())) {
                                                        likedPostIds.add(post.getPid());
                                                        }
                                                        }
                                                        }

                                                        for (Post post : posts) {
                                                        boolean userLiked = currentUser != null &&
                                                        likedPostIds.contains(post.getPid());
                                                        int likeCount = likeDao.countLikeOnPost(post.getPid());
                                                        %>

                                                        <div class="col-md-6 mt-2">
                                                            <div class="card">
                                                                <div class="card-img-container">
                                                                    <img class="card-img-top"
                                                                        src="blog_pics/<%= post.getpPic()%>"
                                                                        alt="Post Image">
                                                                </div>

                                                                <div class="card-body">
                                                                    <b>
                                                                        <%= post.getpTitle()%>
                                                                    </b>

                                                                    <div id="snippet-<%= post.getPid()%>">
                                                                        <%= post.getpContent().length()> 150 ?
                                                                            post.getpContent().substring(0, 150) + "..."
                                                                            : post.getpContent()%>
                                                                    </div>

                                                                    <% if (post.getpContent().length()> 150) {%>
                                                                        <div id="fullcontent-<%= post.getPid()%>"
                                                                            style="display:none;">
                                                                            <%= post.getpContent()%>
                                                                        </div>
                                                                        <span class="read-more-btn"
                                                                            id="read-more-btn-<%= post.getPid()%>"
                                                                            onclick="showFullContent(<%= post.getPid()%>)">Read
                                                                            More</span>
                                                                        <% } %>




                                                                </div>



                                                                <div class="card-footer primary-background text-center">
                                                                    <% if (currentUser !=null) {%>
                                                                        <a href="#!"
                                                                            onclick="doLike(<%= post.getPid()%>, <%= currentUser.getId()%>, this)"
                                                                            class="btn btn-outline-light btn-sm <%= userLiked ? "
                                                                            btn-liked" : "" %>"
                                                                            <%= userLiked ? "disabled" : "" %>>
                                                                                <i class="fa fa-thumbs-o-up"></i>
                                                                                <span class="like-counter">
                                                                                    <%= likeCount%>
                                                                                </span>
                                                                        </a>
                                                                        <% }%>

                                                                            <a href="show_blog_page.jsp?post_id=<%= post.getPid()%>"
                                                                                class="btn btn-outline-light btn-sm">
                                                                                View Post
                                                                            </a>

                                                                            <button
                                                                                class="btn btn-outline-light btn-sm share-btn"
                                                                                data-posturl="show_blog_page.jsp?post_id=<%= post.getPid()%>">
                                                                                <i class="fa fa-share"></i> Share
                                                                            </button>

                                                                </div>
                                                            </div>
                                                        </div>

                                                        <% } }%>

                                        </div>
                                    </div>

                                    <!-- Footer -->
                                    <footer class="text-center text-white"
                                        style="background:#232d3b; padding:20px; margin-top:40px;">
                                        <p>&copy; 2025 TechBlog | Made by <span style="color:#1abc9c;">TechBlog
                                                Team</span></p>
                                    </footer>

                                    <!-- Scripts -->
                                    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
                                    <script src="js/myjs.js"></script>

                                    <script>
                                        function doLike(pid, uid, btn)
                                        {
                                            if (btn.disabled)
                                                return;
                                            $.post('LikeServlet', { operation: 'like', pid, uid }, function (response)
                                            {
                                                if (response.trim() === 'true')
                                                {
                                                    let likeSpan = $(btn).find('.like-counter');
                                                    likeSpan.text(parseInt(likeSpan.text()) + 1);
                                                    btn.disabled = true;
                                                    $(btn).addClass('btn-liked');
                                                }
                                            });
                                        }
                                    </script>


                                    <!-- Share Modal -->
                                    <div id="shareModal" class="modal fade" tabindex="-1" role="dialog">
                                        <div class="modal-dialog modal-dialog-centered" role="document">
                                            <div class="modal-content">

                                                <div class="modal-header">
                                                    <h5 class="modal-title">Share this post</h5>
                                                    <button type="button" class="close"
                                                        data-dismiss="modal">&times;</button>
                                                </div>

                                                <div class="modal-body text-center">
                                                    <input type="text" id="shareLink" class="form-control mb-3"
                                                        readonly>

                                                    <button class="btn btn-primary mb-2" id="copyLinkBtn">
                                                        <i class="fa fa-copy"></i> Copy Link
                                                    </button>
                                                    <br>

                                                    <a id="whatsappShare" class="btn btn-success mb-2" target="_blank">
                                                        <i class="fa fa-whatsapp"></i> WhatsApp
                                                    </a>
                                                    <br>

                                                    <a id="facebookShare" class="btn btn-primary mb-2" target="_blank">
                                                        <i class="fa fa-facebook"></i> Facebook
                                                    </a>
                                                    <br>

                                                    <a id="twitterShare" class="btn btn-info mb-2" target="_blank">
                                                        <i class="fa fa-twitter"></i> Twitter
                                                    </a>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                    <script>
                                        $(document).ready(function ()
                                        {

                                            $(".share-btn").click(function ()
                                            {
                                                let baseUrl = window.location.origin + "/TechBlog/";
                                                let postUrl = $(this).data("posturl");
                                                let fullLink = baseUrl + postUrl;

                                                $("#shareLink").val(fullLink);
                                                $("#whatsappShare").attr("href", "https://api.whatsapp.com/send?text=" + encodeURIComponent(fullLink));
                                                $("#facebookShare").attr("href", "https://www.facebook.com/sharer/sharer.php?u=" + encodeURIComponent(fullLink));
                                                $("#twitterShare").attr("href", "https://twitter.com/intent/tweet?url=" + encodeURIComponent(fullLink));

                                                $("#shareModal").modal("show");
                                            });

                                            $("#copyLinkBtn").click(function ()
                                            {
                                                navigator.clipboard.writeText($("#shareLink").val());
                                                alert("Link copied!");
                                            });

                                        });


                                    </script>
                                    <!-- Popper JS -->
                                    <script
                                        src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>

                                    <!-- Bootstrap JS -->
                                    <script
                                        src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

                                    <!-- Share Modal  end here-->
                                    <script>
                                        $(document).ready(function ()
                                        {

                                            $(".share-btn").click(function ()
                                            {
                                                let baseUrl = window.location.origin + "/TechBlog/";
                                                let postUrl = $(this).data("posturl");
                                                let fullLink = baseUrl + postUrl;
                                                let pid = postUrl.split("=")[1];

                                                $("#shareLink").val(fullLink);

                                                $("#whatsappShare").off().attr("href", "https://api.whatsapp.com/send?text=" + encodeURIComponent(fullLink))
                                                    .click(function () { saveShare(pid, "whatsapp"); });

                                                $("#facebookShare").off().attr("href", "https://www.facebook.com/sharer/sharer.php?u=" + encodeURIComponent(fullLink))
                                                    .click(function () { saveShare(pid, "facebook"); });

                                                $("#twitterShare").off().attr("href", "https://twitter.com/intent/tweet?url=" + encodeURIComponent(fullLink))
                                                    .click(function () { saveShare(pid, "twitter"); });

                                                $("#copyLinkBtn").off().click(function ()
                                                {
                                                    navigator.clipboard.writeText($("#shareLink").val());
                                                    alert("Link copied!");
                                                    saveShare(pid, "copylink");
                                                });

                                                $("#shareModal").modal("show");
                                            });
                                        });

                                        function saveShare(pid, platform)
                                        {
                                            $.post("ShareServlet", { pid: pid, platform: platform });
                                        }
                                    </script>





                            </body>

                            </html>