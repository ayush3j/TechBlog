package com.tech.blog.helper;
import java.sql.*;
public class ConnectionProvider {
	private static Connection con;
	public static Connection getConnection() {
		String url="jdbc:mysql://localhost:3306/techblog";
		String uname="root";
		String pass="K@lspaghtk1";
		try {
			if(con==null) {
				Class.forName("com.mysql.cj.jdbc.Driver");  
		        con=DriverManager.getConnection(url,uname,pass); 
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return con;
	}
}
