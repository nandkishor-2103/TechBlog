<%@page import="com.tech.blog.dao.*" %>
    <%@page import="com.tech.blog.entities.*" %>
        <%@page import="com.tech.blog.helper.ConnectionProvider" %>
            <%@page import="java.util.*" %>
                <%@page contentType="text/html" pageEncoding="UTF-8" %>

                    <% User currentUser=(User) session.getAttribute("currentUser"); if (currentUser==null) {
                        out.println("<h3 class='text-center text-danger'>Please login to view posts.</h3>");
                        return;
                        }

                        PostDao postDao = new PostDao(ConnectionProvider.getConnection());
                        LikeDao likeDao = new LikeDao(ConnectionProvider.getConnection());
                        CommentDao commentDao = new CommentDao(ConnectionProvider.getConnection());

                        int cid = 0;
                        if (request.getParameter("cid") != null) {
                        cid = Integer.parseInt(request.getParameter("cid"));
                        }

                        List<Post> posts = (cid == 0) ? postDao.getAllPosts() : postDao.getPostByCatId(cid);
                            %>

                            <!DOCTYPE html>
                            <html>

                            <head>
                                <title>All Posts</title>
                                <link rel="stylesheet"
                                    href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
                                <link rel="stylesheet"
                                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

                                <style>
                                    .card {
                                        border-radius: 14px;
                                        box-shadow: 0 6px 16px rgba(0, 0, 0, 0.08);
                                        margin-bottom: 35px;
                                    }

                                    .btn-liked {
                                        color: red !important;
                                    }

                                    .comment-box {
                                        border-top: 1px solid #ddd;
                                        padding-top: 10px;
                                        display: none;
                                    }

                                    .comment-item {
                                        padding: 4px 0;
                                        border-bottom: 1px solid #eee;
                                    }

                                    .comment-item:last-child {
                                        border-bottom: none;
                                    }

                                    .read-more {
                                        color: #007bff;
                                        cursor: pointer;
                                    }

                                    .read-more:hover {
                                        text-decoration: underline;
                                    }
                                </style>
                            </head>

                            <body>
                                <div class="container mt-4">
                                    <div class="row">
                                        <% if (posts.isEmpty()) { %>
                                            <div class="col-12 text-center">
                                                <h4>No posts found.</h4>
                                            </div>
                                            <% } else { for (Post post : posts) { int
                                                likeCount=likeDao.countLikeOnPost(post.getPid()); boolean
                                                userLiked=likeDao.isLikedByUser(post.getPid(), currentUser.getId());
                                                List<Comment> comments = commentDao.getCommentsByPostId(post.getPid());

                                                String content = post.getpContent();
                                                boolean isLong = content.length() > 150;
                                                %>

                                                <div class="col-md-6 offset-md-3">
                                                    <div class="card">
                                                        <% if (post.getpPic() !=null && !post.getpPic().isEmpty()) {%>
                                                            <img src="blog_pics/<%= post.getpPic()%>"
                                                                class="card-img-top" alt="Post Image">
                                                            <% }%>

                                                                <div class="card-body">
                                                                    <h5>
                                                                        <%= post.getpTitle()%>
                                                                    </h5>

                                                                    <p class="post-content"
                                                                        id="content-<%= post.getPid()%>">
                                                                        <span class="short-text">
                                                                            <%= isLong ? content.substring(0, 150)
                                                                                + "..." : content%>
                                                                        </span>
                                                                        <span class="full-text d-none">
                                                                            <%= content%>
                                                                        </span>
                                                                    </p>

                                                                    <% if (isLong) {%>
                                                                        <a href="javascript:void(0)" class="read-more"
                                                                            data-pid="<%= post.getPid()%>">Read More</a>
                                                                        <% }%>
                                                                </div>

                                                                <div
                                                                    class="card-footer d-flex justify-content-between align-items-center">
                                                                    <!-- LIKE BUTTON -->
                                                                    <button class="btn btn-sm <%= userLiked ? "
                                                                        btn-danger btn-liked" : "btn-outline-danger" %>"
                                                                        onclick="toggleLike(<%= post.getPid()%>, <%=
                                                                                currentUser.getId()%>, this)">
                                                                                <i class="fa fa-heart"></i> <span
                                                                                    class="like-count">
                                                                                    <%= likeCount%>
                                                                                </span>
                                                                    </button>

                                                                    <!-- COMMENT BUTTON -->
                                                                    <button class="btn btn-outline-secondary btn-sm"
                                                                        onclick="toggleComments(<%= post.getPid()%>)">
                                                                        <i class="fa fa-comment"></i> Comments (<%=
                                                                            comments.size()%>)
                                                                    </button>

                                                                    <!-- SHARE BUTTON -->
                                                                    <button class="btn btn-outline-info btn-sm"
                                                                        onclick="sharePost(<%= post.getPid()%>)">
                                                                        <i class="fa fa-share-alt"></i> Share
                                                                    </button>
                                                                    <!-- SAVE BUTTON -->
                                                                    <button class="btn btn-outline-success btn-sm"
                                                                        onclick="toggleSave(<%= post.getPid()%>, <%= currentUser.getId()%>, this)">
                                                                        <i class="fa fa-bookmark"></i> Save
                                                                    </button>

                                                                </div>

                                                                <!-- COMMENT SECTION -->
                                                                <div id="comments-<%= post.getPid()%>"
                                                                    class="comment-box p-3">
                                                                    <div id="comment-list-<%= post.getPid()%>">
                                                                        <% for (Comment c : comments) {%>
                                                                            <div class="comment-item">
                                                                                <strong>
                                                                                    <%= c.getUserName()%>:
                                                                                </strong>
                                                                                <%= c.getContent()%>
                                                                            </div>
                                                                            <% }%>
                                                                    </div>

                                                                    <div class="input-group mt-2">
                                                                        <input type="text"
                                                                            id="comment-input-<%= post.getPid()%>"
                                                                            class="form-control"
                                                                            placeholder="Write a comment...">
                                                                        <div class="input-group-append">
                                                                            <button class="btn btn-primary"
                                                                                type="button"
                                                                                onclick="addComment(<%= post.getPid()%>)">Post</button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                    </div>
                                                </div>

                                                <% } }%>
                                    </div>
                                </div>

                                <!-- jQuery -->
                                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                                <script>
                                    // LIKE SYSTEM
                                    function toggleLike(pid, uid, btn)
                                    {
                                        let isLiked = $(btn).hasClass('btn-liked');
                                        let operation = isLiked ? 'dislike' : 'like';

                                        $.ajax({
                                            url: 'LikeServlet',
                                            method: 'POST',
                                            data: { operation: operation, pid: pid, uid: uid },
                                            success: function (response)
                                            {
                                                response = response.trim();
                                                let countSpan = $(btn).find('.like-count');
                                                let count = parseInt(countSpan.text());

                                                if (response === 'liked')
                                                {
                                                    $(btn).removeClass('btn-outline-danger').addClass('btn-danger btn-liked');
                                                    countSpan.text(count + 1);
                                                } else if (response === 'disliked')
                                                {
                                                    $(btn).removeClass('btn-danger btn-liked').addClass('btn-outline-danger');
                                                    countSpan.text(count - 1);
                                                }
                                            },
                                            error: function ()
                                            {
                                                alert("Error processing like action.");
                                            }
                                        });
                                    }

                                    // COMMENT TOGGLE
                                    function toggleComments(pid)
                                    {
                                        $("#comments-" + pid).slideToggle(200);
                                    }

                                    // ADD COMMENT
                                    function addComment(pid)
                                    {
                                        let input = $("#comment-input-" + pid);
                                        let content = input.val().trim();

                                        if (content === "")
                                            return;

                                        $.ajax({
                                            url: 'AddCommentServlet',
                                            method: 'POST',
                                            data: { postId: pid, content: content },
                                            success: function (response)
                                            {
                                                response = response.trim();
                                                if (response === "done")
                                                {
                                                    $("#comment-list-" + pid).append(
                                                        <div class='comment-item'><strong>You:</strong> ${content}</div>
                                                    );
                                                    input.val("");
                                                } else
                                                {
                                                    alert("Failed to post comment.");
                                                }
                                            },
                                            error: function ()
                                            {
                                                alert("Error posting comment.");
                                            }
                                        });
                                    }

                                    // SHARE BUTTON
                                    function sharePost(pid)
                                    {
                                        const link = ${ window.location.origin }/show_blog_page.jsp?post_id=${pid};
                                        if (navigator.share)
                                        {
                                            navigator.share({ title: "Check this post!", url: link });
                                        } else
                                        {
                                            navigator.clipboard.writeText(link);
                                            alert("Post link copied to clipboard!");
                                        }
                                    }

                                    // READ MORE / READ LESS
                                    $(document).on("click", ".read-more", function ()
                                    {
                                        const pid = $(this).data("pid");
                                        const shortText = $("#content-" + pid + " .short-text");
                                        const fullText = $("#content-" + pid + " .full-text");
                                        const link = $(this);

                                        if (link.text() === "Read More")
                                        {
                                            shortText.addClass("d-none");
                                            fullText.removeClass("d-none");
                                            link.text("Read Less");
                                        } else
                                        {
                                            shortText.removeClass("d-none");
                                            fullText.addClass("d-none");
                                            link.text("Read More");
                                        }
                                    });
                                    // SAVE SYSTEM
                                    function toggleSave(pid, uid, btn)
                                    {
                                        let isSaved = $(btn).hasClass('btn-success');
                                        let operation = isSaved ? 'unsave' : 'save';

                                        $.ajax({
                                            url: 'SavePostServlet',
                                            method: 'POST',
                                            data: { operation: operation, pid: pid, uid: uid },
                                            success: function (response)
                                            {
                                                response = response.trim();
                                                if (response === "done")
                                                {
                                                    if (operation === 'save')
                                                    {
                                                        $(btn).removeClass('btn-outline-success').addClass('btn-success');
                                                        $(btn).html('<i class="fa fa-bookmark"></i> Saved');
                                                    } else
                                                    {
                                                        $(btn).removeClass('btn-success').addClass('btn-outline-success');
                                                        $(btn).html('<i class="fa fa-bookmark"></i> Save');
                                                    }
                                                } else
                                                {
                                                    alert("Failed to update save status.");
                                                }
                                            },
                                            error: function ()
                                            {
                                                alert("Error saving post.");
                                            }
                                        });
                                    }

                                </script>
                            </body>

                            </html>