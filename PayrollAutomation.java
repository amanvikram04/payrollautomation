package com.ibm.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ibm.dbconnection.DbConnection;
import com.ibm.dao.DisplayTable;


/**
 * Servlet implementation class PayrollAutomation
 */
//@WebServlet("/PayrollAutomation")
public class PayrollAutomation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PayrollAutomation() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
				doPost(request, response);
				
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		String user=request.getParameter("username");
		String pass=request.getParameter("pass");
		
		String dbConn=request.getParameter("connection");
		
		
HttpSession session=request.getSession();

		if(dbConn.equalsIgnoreCase("DbConnection"))
		{
			if(DbConnection.checkConnection(user, pass))
					{
				     System.out.println("DB is connected succesfully");
				     response.sendRedirect("success.jsp");
					}
			else
			{
				System.out.println("DB not connected");
				response.sendRedirect("Failure.jsp");
			}	
		}
		if(dbConn.equalsIgnoreCase("Payroll_check"))
		{
			if(DbConnection.checkConnection(user, pass))
			{
		     System.out.println("DB is connected succesfully");
		     response.sendRedirect("PayrollReport.jsp");
			}
	else
	{
		System.out.println("DB not connected");
		response.sendRedirect("Failure.jsp");
	}	
		}
		session.invalidate();
	}
	
}	
