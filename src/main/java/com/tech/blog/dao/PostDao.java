package com.tech.blog.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;
import com.tech.blog.entities.User;

public class PostDao {
	Connection con;

	public PostDao(Connection con) {
		super();
		this.con = con;
	}

	// to get the category
	public ArrayList<Category> getAllCategories() {

		ArrayList<Category> list = new ArrayList<>();
		try {
			String query = "select * from categories";
			Statement st = this.con.createStatement();
			ResultSet set = st.executeQuery(query);

			while (set.next()) {
				int cid = set.getInt("cid");
				String name = set.getString("name");
				String description = set.getString("description");
				Category c = new Category(cid, name, description);
				list.add(c);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// to save the post
	public boolean savePost(Post p) {
		boolean f = false;
		try {
			String query = "insert into posts (pTitle,pContent,pCode,pPic,catId,userId) values (?,?,?,?,?,?)";
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setString(1, p.getpTitle());
			pstmt.setString(2, p.getpContent());
			pstmt.setString(3, p.getpCode());
			pstmt.setString(4, p.getpPic());
			pstmt.setInt(5, p.getCatId());
			pstmt.setInt(6, p.getUserId());
			pstmt.executeUpdate();
			f = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	// to get all the post
	public List<Post> getAllPost() {
		List<Post> list = new ArrayList<>();
		try {
			PreparedStatement p = con.prepareStatement("select * from posts order by pid desc");

			ResultSet set = p.executeQuery();

			while (set.next()) {

				int pid = set.getInt("pid");
				String pTitle = set.getString("pTitle");
				String pContent = set.getString("pContent");
				String pCode = set.getString("pCode");
				String pPic = set.getString("pPic");
				Timestamp date = set.getTimestamp("pDate");
				int catId = set.getInt("catId");
				int userId = set.getInt("userId");
				Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);

				list.add(post);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// to get post related to cid
	public List<Post> getPostByCatId(int catId) {
		List<Post> list = new ArrayList<>();
		try {
			PreparedStatement p = con.prepareStatement("select * from posts where catId=?");
            p.setInt(1, catId);
            ResultSet set = p.executeQuery();

			while (set.next()) {

				int pid = set.getInt("pid");
				String pTitle = set.getString("pTitle");
				String pContent = set.getString("pContent");
				String pCode = set.getString("pCode");
				String pPic = set.getString("pPic");
				Timestamp date = set.getTimestamp("pDate");
				int userId = set.getInt("userId");
				Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);

				list.add(post);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public Post getPostByPostId(int postId) {
		Post post =null;
		try {
			String query = "select * from posts where pid=?";
			PreparedStatement p = con.prepareStatement(query);
			p.setInt(1, postId);
			ResultSet set = p.executeQuery();
			if(set.next()) {
				String pTitle = set.getString("pTitle");
				String pContent = set.getString("pContent");
				String pCode = set.getString("pCode");
				String pPic = set.getString("pPic");
				Timestamp date = set.getTimestamp("pDate");
				int catId = set.getInt("catId");
				int userId = set.getInt("userId");
				post = new Post(postId, pTitle, pContent, pCode, pPic, date, catId, userId);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return post;
	}

	public User getUserById(int userId) {
		User user =null;
		try {
			String query = "select * from user where id=?";
			PreparedStatement p = con.prepareStatement(query);
			p.setInt(1, userId);
			ResultSet set = p.executeQuery();
			if(set.next()) {
				user = new User();
				user.setName(set.getString("name"));
				user.setEmail(set.getString("email"));
				user.setPassword(set.getString("password"));
				user.setGender(set.getString("gender"));
				user.setAbout(set.getString("about"));
				user.setDateTime(set.getTimestamp("rdate"));
				user.setProfile(set.getString("profile"));
				
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return user;
	}
}
