package com.tech.blog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;


@WebServlet(urlPatterns = {"/register"})
@MultipartConfig
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Register() {
        super();
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String check = request.getParameter("check");
		if(check == null) {
			out.print("Box not checked");
		}
		else {
			String name = request.getParameter("userName");
			String email = request.getParameter("userEmail");
			String password = request.getParameter("pass");
			String gender = request.getParameter("gender");
			String about = request.getParameter("about");
			
			User user = new User(name,email,password,gender,about);
			
			UserDao dao = new UserDao(ConnectionProvider.getConnection());
			if (dao.saveUser(user)) {
				out.print("done");
			}
			else {
				out.print("error");
			}
		}
		
	}

}
