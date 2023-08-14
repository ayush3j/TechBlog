package com.tech.blog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import com.tech.blog.dao.UserDao;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;

@WebServlet(urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public LoginServlet() {
        super();
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String email = request.getParameter("enteredEmail");
			String password = request.getParameter("enteredPassword");
			UserDao dao = new UserDao(ConnectionProvider.getConnection());
			User u = dao.getUserByEmailAndPassword(email, password);
			if(u==null) {
				Message msg = new Message("Invalid Details ! Try Again","error","alert-danger");
				HttpSession session = request.getSession();
				session.setAttribute("msg", msg);
				response.sendRedirect("loginPage.jsp");
			}
			else {
				HttpSession s = request.getSession();
				s.setAttribute("currentUser", u);
				response.sendRedirect("profile.jsp");
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
