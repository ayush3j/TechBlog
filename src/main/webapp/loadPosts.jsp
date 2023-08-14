
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="java.util.*"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="com.tech.blog.entities.User"%>
<div class=row>
	<%
	User user = (User) session.getAttribute("currentUser");
	
	Thread.sleep(200);
	PostDao d = new PostDao(ConnectionProvider.getConnection());
	int cid = Integer.parseInt(request.getParameter("cid"));
	List<Post> list = null;
	
	if(cid==0){
    	list=d.getAllPost();
	}
	else{
		list=d.getPostByCatId(cid);
	}
	if(list.size()==0)
	{
		response.getWriter().println("<h3 class='display-3 text-center'>No posts in this category...</h3>");
	}
    for(Post p:list)
    {
%>
<div class="col-md-6 mt-2">
	<div class="card">
		<div class="card-body">
			<img src="blog_pics/<%=p.getpPic()%>" class="card-img-top" alt="..." style="height:200px;">
			<b><%=p.getpTitle() %></b>
			<p><%=p.getpContent() %></p>
		</div>
		<div class="card-footer primary-background">
			<% LikeDao ld = new LikeDao(ConnectionProvider.getConnection());%>
			<a href="showBlogPage.jsp?postId=<%=p.getPid()  %>" class="btn btn-outline-light btn-sm">Read More..</a>
			<a href="#!" onClick=doLike(<%= p.getPid() %>,<%=user.getId() %>) class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"><span class="like-counter"><%=ld.countLikeOnPost(p.getPid())%></span></i></a>
			<a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"><span>10</span></i></a>
		</div>
	</div>
</div>
	<% 
    }
    %>


</div>