package com.tech.blog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;

@WebServlet(urlPatterns = {"/EditServlet"})
@MultipartConfig
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public EditServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userName = request.getParameter("userName");
		String userEmail = request.getParameter("userEmail");
		String userPassword = request.getParameter("userPassword");
		String userAbout = request.getParameter("userAbout");
		String userGender = request.getParameter("userGender");
		Part userImage = request.getPart("userImage");
		String imageName = userImage.getSubmittedFileName();
		
		HttpSession s = request.getSession();
		User user = (User) s.getAttribute("currentUser");
		
		user.setName(userName);
		user.setEmail(userEmail);
		user.setPassword(userPassword);
		user.setAbout(userAbout);
		user.setGender(userGender);
		String oldFile = user.getProfile();
		user.setProfile(imageName);
		
		//user update on Dao
		UserDao dao = new UserDao(ConnectionProvider.getConnection());
		boolean b = dao.updateUser(user);
		if(b) {
			
			String path = request.getServletContext().getRealPath("/")+"pics" + File.separator + user.getProfile();
			String pathold = request.getServletContext().getRealPath("/")+"pics" + File.separator + oldFile;
			if(!oldFile.equals("default.png"))
			{
				Helper.deleteFie(pathold);
			}
				Helper.saveFile(userImage.getInputStream(), path);
					
					Message msg = new Message("Profile details updated ","success","alert-success");
					s.setAttribute("msg", msg);
		}
		else {
			Message msg = new Message("Something went wrong !","error","alert-danger");
			s.setAttribute("msg", msg);
		}
		response.sendRedirect("loginPage.jsp");
	}

}
