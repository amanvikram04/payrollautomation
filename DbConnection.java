package com.ibm.dbconnection;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.SQLInvalidAuthorizationSpecException;

public class DbConnection {
	
	public  static Connection createConnection()
	{	
       String className="COM.ibm.db2os390.sqlj.jdbc.DB2SQLJDriver";
		try {
			Class.forName(className);
			System.out.println("Driver Loaded & registered (Driver Manager)");
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			// TODO: handle exception
		}
	    String url="jdbc:db2://IBMNLYC02.NL.IBM.COM:50000/pbs3db";
		String user="inavh3aa";
		String password="ibm2016-Q3";
		Connection conn=null;
		try {
			 conn=DriverManager.getConnection(url,user,password);
			System.out.println("connection established.....>");
			return conn;
			
		}
		
		
		catch (SQLException e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return conn;
		
	}
	
	public  static boolean checkConnection(String user, String password)
	{	
       String className="COM.ibm.db2os390.sqlj.jdbc.DB2SQLJDriver";
		try {
			Class.forName(className);
			System.out.println("Driver Loaded & registered (Driver Manager)");
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			// TODO: handle exception
		}
	    String url="jdbc:db2://IBMNLYC02.NL.IBM.COM:50000/pbs3db";
		/*String user="aman";
		String password="welcome2ibm";*/
		Connection conn=null;
		try {
			 conn=DriverManager.getConnection(url,user,password);
			System.out.println("connection established.....>");
			return true;
			
		}
		
		catch (SQLException e) {
			e.printStackTrace();
			
			// TODO: handle exception
		}
		return false;
		
	}
}

