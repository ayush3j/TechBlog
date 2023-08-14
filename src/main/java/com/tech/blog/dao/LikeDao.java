package com.tech.blog.dao;
import java.sql.*;
public class LikeDao {
	Connection con;

	public LikeDao(Connection con) {
		super();
		this.con = con;
	}
	
	public boolean insertLike(int pid,int uid) {
		boolean f =false;
		try {
			String query ="insert into likecount (pid,uid) values (?,?)";
			PreparedStatement p = con.prepareStatement(query);
			p.setInt(1, pid);
			p.setInt(2, uid);
			p.executeUpdate();
			f=true;
		}
		catch(Exception e) {
			
		}
		return f;
	}
	
	 public int countLikeOnPost(int pid) {
	        int count = 0;

	        String q = "select count(*) from likecount where pid=?";
	        try {
	            PreparedStatement p = this.con.prepareStatement(q);
	            p.setInt(1, pid);
	            ResultSet set = p.executeQuery();
	            if (set.next()) {
	                count = set.getInt("count(*)");
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        return count;
	    }
	public boolean likedByUser(int pid,int uid) {
		boolean f = false;
		try {
			String query = "select * from likecount where pid=? and uid=?";
			PreparedStatement p = con.prepareStatement(query);
			p.setInt(1, pid);
			p.setInt(2, uid);
			ResultSet set = p.executeQuery();
			if(set.next()) {
				f=true;
			}
		}
		catch(Exception e) {
			
		}
		return f;
	}
	
	public boolean deleteLiked(int pid,int uid) {
		boolean f = false;
		try {
			String query = "delete from likecount where pid=? and uid=?";
			PreparedStatement p = con.prepareStatement(query);
			p.setInt(1, pid);
			p.setInt(2, uid);
			p.executeUpdate();
			f=true;
		}
		catch(Exception e) {
			
		}
		return f;
	}
}
