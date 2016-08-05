package com.ibm.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import com.ibm.dbconnection.DbConnection;
public class DisplayTable {
	
	public static  void Display(String sql)
	{
		Connection conn=DbConnection.createConnection();
		Statement stmt = null;
		ResultSet rs = null;
		Vector<String> columnNames = new Vector<String>();
		
		    try {
		        stmt = conn.createStatement();
		        rs = stmt.executeQuery(sql);
		        if (rs != null) {
		          ResultSetMetaData columns = rs.getMetaData();
		        
		          int i = 0;
		          while (i < columns.getColumnCount()) {
		            i++;
		            System.out.print(columns.getColumnName(i) + "\t");
		            columnNames.add(columns.getColumnName(i));
		          }
		          System.out.print("\n");

		          while (rs.next()) {
		            for (i = 0; i < columnNames.size(); i++) {
		              System.out.print(rs.getString(columnNames.get(i))
		                  + "\t");

		            }
		            System.out.print("\n");
		          }

		        }
		      } catch (Exception e) {
		        System.out.println("Exception: " + e.toString());
		      }

		      finally {
		        try {
		          if (rs != null) {
		            rs.close();
		          }
		          if (stmt != null) {
		            stmt.close();
		          }
		          if (conn != null) {
		            conn.close();
		          }
		        } catch (Exception mysqlEx) {
		          System.out.println(mysqlEx.toString());
		        }
		    
	}
}}