<%@page import="com.tech.blog.entities.User" %>
    <%@page import="com.tech.blog.dao.LikeDao" %>
        <%@page import="com.tech.blog.entities.Post" %>
            <%@page import="java.util.List" %>
                <%@page import="java.util.HashSet" %>
                    <%@page import="com.tech.blog.helper.ConnectionProvider" %>
                        <%@page import="com.tech.blog.dao.PostDao" %>

                            <style>
                                /* Distinct disabled button style */
                                .btn-liked {
                                    pointer-events: none;
                                    /* disable clicks */
                                    opacity: 0.6;
                                    color: #ccc !important;
                                    border-color: #ccc !important;
                                    background-color: #f8f9fa !important;
                                }

                                .post-card {
                                    background: #ffffff;
                                    border-radius: 14px;
                                    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.08);
                                    margin-bottom: 40px;
                                    padding: 28px;
                                    max-width: 720px;
                                    margin-left: auto;
                                    margin-right: auto;
                                    transition: all 0.3s ease;
                                    border: 1px solid #eaeaea;
                                    /height: 520px;/ min-height: 520px;
                                    display: flex;
                                    flex-direction: column;
                                    justify-content: space-between;
                                }

                                .post-card img {
                                    max-height: 170px;
                                    min-height: 170px;
                                    object-fit: cover;
                                    margin-bottom: 15px;
                                    width: 100%;
                                }

                                .card-footer {
                                    margin-top: auto;
                                }
                            </style>

                            <div class="row">
                                <% User currentUser=(User) session.getAttribute("currentUser"); if (currentUser==null) {
                                    out.println("<h3 class='text-center'>Please login to see posts.</h3>");
                                    return;
                                    }

                                    PostDao postDao = new PostDao(ConnectionProvider.getConnection());
                                    LikeDao likeDao = new LikeDao(ConnectionProvider.getConnection());

                                    int cid = Integer.parseInt(request.getParameter("cid"));
                                    List<Post> posts = (cid == 0) ? postDao.getAllPosts() : postDao.getPostByCatId(cid);
                                        if (posts.size() == 0) {
                                        out.println("<h3 class='display-3 text-center'>No Posts in this category..</h3>
                                        ");
                                        return;
                                        }

                                        // Cache liked post ids for this user
                                        HashSet<Integer> likedPostIds = new HashSet<>();
                                                for (Post p : posts) {
                                                if (likeDao.isLikedByUser(p.getPid(), currentUser.getId())) {
                                                likedPostIds.add(p.getPid());
                                                }
                                                }

                                                for (Post p : posts) {
                                                boolean userLiked = likedPostIds.contains(p.getPid());
                                                %>

                                                <div class="col-md-6 mt-2">
                                                    <div class="card post-card">
                                                        <img src="blog_pics/<%= p.getpPic()%>" alt="Card image" />
                                                        <div class="card-body">
                                                            <div class="post-title">
                                                                <%= p.getpTitle()%>
                                                            </div>
                                                            <div id="snippet-<%= p.getPid()%>" class="post-snippet">
                                                                <% String content=p.getpContent(); if (content.length()>
                                                                    150) {
                                                                    out.print(content.substring(0, 150) + "...");
                                                                    } else {
                                                                    out.print(content);
                                                                    }
                                                                    %>
                                                            </div>
                                                            <div id="full-<%= p.getPid()%>" class="post-full-content">
                                                                <%= p.getpContent()%>
                                                            </div>

                                                        </div>
                                                        <div class="card-footer primary-background text-center">
                                                            <a href="#!"
                                                                onclick="doLike(<%= p.getPid()%>, <%= currentUser.getId()%>, this)"
                                                                class="btn btn-outline-light btn-sm <%= userLiked ? "
                                                                btn-liked" : "" %>"
                                                                <%= userLiked ? "disabled" : "" %>>
                                                                    <i class="fa fa-thumbs-o-up"></i>
                                                                    <span class="like-counter">
                                                                        <%= likeDao.countLikeOnPost(p.getPid())%>
                                                                    </span>
                                                            </a>
                                                            <a href="show_blog_page.jsp?post_id=<%= p.getPid()%>"
                                                                class="btn btn-outline-light btn-sm">Read More...</a>
                                                        </div>
                                                    </div>

                                                </div>

                                                <% } %>
                            </div>

                            <script src="https://code.jquery.com/jquery-3.4.1.min.js"
                                integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
                                crossorigin="anonymous"></script>

                            <script>
                                function doLike(pid, uid, btn) {
                                    if (btn.disabled)
                                        return;

                                    $.ajax({
                                        url: 'LikeServlet',
                                        method: 'POST',
                                        data: { operation: 'like', pid: pid, uid: uid },
                                        success: function (response) {
                                            if (response.trim() === 'true') {
                                                let likeSpan = $(btn).find('.like-counter');
                                                let currentCount = parseInt(likeSpan.text());
                                                likeSpan.text(currentCount + 1);

                                                btn.disabled = true;
                                                $(btn).addClass('btn-liked');
                                            } else {
                                                alert("You already liked this post.");
                                                btn.disabled = true;
                                                $(btn).addClass('btn-liked');
                                            }
                                        },
                                        error: function () {
                                            alert("Error in liking the post. Please try again.");
                                        }
                                    });
                                }
                            </script>