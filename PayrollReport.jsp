<%@page import="java.sql.Date"%>
<%-- <%@page import="com.ibm.ws.webservices.xml.wassysapp.systemApp"%> --%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.util.Vector" %>
   <%@ page import="java.util.*" %>
    <%@ page import="com.ibm.dbconnection.DbConnection" %>
    <%@ page import="java.util.Properties" %>
    <%@ page import="java.io.*" %>
     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Payroll Report</title>
<style>
table, th, td {
    border: 1px solid black;
    border-collapse: collapse;
}
</style>
</head>
<body>
<center>
<%
        
        long millis=System.currentTimeMillis();  
        Date date=new Date(millis);
        System.out.println(date);
        
        Date cdate=new Date(millis);
        
		String curdate=date.toString();
		System.out.println(curdate);
		
		String curday=curdate.substring(8,10);
		System.out.println(curday);
		int day=Integer.parseInt(curday);
		
		String curmonth=curdate.substring(5,7);
		int month=Integer.parseInt(curmonth);
		System.out.println(curmonth);
		
		String curyear=curdate.substring(0,4);
		System.out.println(curyear);
		int year=Integer.parseInt(curyear);
		
		
		int a=0;
 		
        Connection conn=DbConnection.createConnection();
        
		Statement stmt = null;
		ResultSet rs = null;
		PreparedStatement ps=null;
		String c1="0000247134";
		String c3="0000247118";
		String c2="0000247118";
		String c4="0000247110";
		
		String cnums="";
		int x=0;
		
		stmt = conn.createStatement();
		rs=stmt.executeQuery("select distinct cnum from pbsadm.choice where cnum in(select cnum from pbsadm.benefitchange where cnum in (select cnum from pbsadm.filter_info where pemplodt is not null )and benefit_code in ('BN028','BN029') and status = 'C')");
        while(rs.next())
        {
        x++;
        }
        String [] attired=new String[x];
        System.out.println(x);
        
        
		
		
        
		if(day==4)
		{
		rs=stmt.executeQuery("select max(trxid) from pbsadm.transaction where BENEFIT_CODE='BN028' ");
		while(rs.next())
		{
		c1=rs.getString(1);
		}
		rs=stmt.executeQuery("select max(trxid) from pbsadm.transaction ");
		while(rs.next())
		{
		c3=rs.getString(1);
		}
		
 		rs=stmt.executeQuery("select distinct cnum from pbsadm.choice where cnum in(select cnum from pbsadm.benefitchange where cnum in (select cnum from pbsadm.filter_info where pemplodt is not null )and benefit_code in ('BN028','BN029') and status = 'C')");
        while(rs.next())
        {
         attired[a]=rs.getString(1);
         System.out.println(attired[a]);
         a++;
        }
        
        for(int l=0;l<attired.length;l++)
        {
        cnums+=attired[l]+"','";
        }
         System.out.println(cnums);
         System.out.println(attired.length);
         System.out.println(c1);
         System.out.println(c3);       
		}
		
		if(day==5)
		{
		rs=stmt.executeQuery("select max(trxid) from pbsadm.transaction where BENEFIT_CODE='BN028' ");
		while(rs.next())
		{
		c2=rs.getString(1);
		}
		
		rs=stmt.executeQuery("select max(trxid) from pbsadm.transaction ");
		while(rs.next())
		{
		c4=rs.getString(1);
		}
		
		File configFile = new File("./payroll.properties");
try {
    Properties props = new Properties();
    props.setProperty("id_5_1", c2);
    props.setProperty("id_5_2", c4);
    FileWriter writer = new FileWriter(configFile);
    props.store(writer, "ids of employees");
    
    
    FileReader reader = new FileReader(configFile);
    props.load(reader);
    c2 = props.getProperty("id_5_1");
    c4 = props.getProperty("id_5_2");
    System.out.println("Id on last month 5th is: " + c2);
    System.out.println("Id on last month 5th is: " + c4);
    reader.close();
      
} catch (FileNotFoundException ex) {
    // file does not exist
} catch (IOException ex) {
    // I/O error
}
		
		}
		

		
		 String [] query={"select * from pbsadm.filter_info where cnum in (select bc.cnum from pbsadm.benefitchange bc, pbsadm.choice ch where bc.cnum = ch.cnum and bc.choice_created = ch.created and bc.status = 'C' and ch.status = 'P')"
		 ,"select bc.cnum from pbsadm.benefitchange bc, pbsadm.choice ch where bc.cnum = ch.cnum and bc.choice_created = ch.created and bc.status = 'C' and ch.status = 'P'"
		 ,"select bc.cnum from pbsadm.benefitchange bc, pbsadm.choice ch where bc.cnum = ch.cnum and bc.choice_created = ch.created and bc.status = 'P' and ch.status = 'C'"
		 ,"select count(*) from pbsadm.BENEFITCHANGE where benefit_code='BN028' and end_date is null and status='C'"
		 ,"select count(*) from pbsadm.BENEFITCHANGE where end_date is null"
		 ,"select count(*) from pbsadm.transaction where benefit_code=('BN028') and trxid <=" +c1 +" and trxid >="+c2 +" AND proc_status IN('C','O') "
		 ,"select count(*) from pbsadm.transaction where trxid <="+ c3+"  and trxid >= "+c4+" AND proc_status IN('C','O') "
		 ,"select count(*) from pbsadm.transaction where proc_status ='O'"
		 ,"select * from pbsadm.transaction where proc_status ='O' and date_to_be_processed=(current date + 1 DAY - DAY(current date) DAYS) order by trxid desc"
		 ,"select * from pbsadm.transaction where proc_status ='O' and date_to_be_processed=(current date + 1 DAY - DAY(current date) DAYS - 1 MONTH) order by trxid desc"
		 ,"select * from pbsadm.transaction where proc_status ='O' and date_to_be_processed=(current date + 1 DAY - DAY(current date) DAYS - 2 MONTH) order by trxid desc"
		 ,"select * from pbsadm.transaction where proc_status ='O' and date_to_be_processed=(current date + 1 DAY - DAY(current date) DAYS) and BENEFIT_CODE='BN028' order by trxid desc"
		 ,"select * from pbsadm.transaction where proc_status ='O' and date_to_be_processed=(current date + 1 DAY - DAY(current date) DAYS - 1 MONTH) and BENEFIT_CODE='BN028' order by trxid desc"
		 ,"select * from pbsadm.transaction where proc_status ='O' and date_to_be_processed=(current date + 1 DAY - DAY(current date) DAYS - 2 MONTH) and BENEFIT_CODE='BN028' order by trxid desc"
		 ,"select * from pbsadm.benefitchange bc where bc.benefit_code = 'BN028' and bc.status='C' and bc.start_date = (current date + 1 DAY - DAY(current date) DAYS)"
		 ,"select * from pbsadm.benefitchange bc where bc.benefit_code = 'BN028' and bc.status='C' and bc.start_date = (current date + 1 DAY - DAY(current date) DAYS - 1 MONTH)"
		 ,"select * from pbsadm.benefitchange bc where bc.benefit_code = 'BN028' and bc.status='C' and bc.start_date = (current date + 1 DAY - DAY(current date) DAYS - 2 MONTH)"
		 ,"select * from pbsadm.benefitchange bc where bc.benefit_code = 'BN028' and bc.status='P' and bc.start_date = (current date + 1 DAY - DAY(current date) DAYS )"
		 ,"select * from pbsadm.benefitchange bc where bc.benefit_code = 'BN028' and bc.status='P' and bc.start_date = (current date + 1 DAY - DAY(current date) DAYS - 1 MONTH)"
		 ,"select * from pbsadm.benefitchange bc where bc.benefit_code = 'BN028' and bc.status='P' and bc.start_date = (current date + 1 DAY - DAY(current date) DAYS - 2 MONTH)"
		 ,"select * from pbsadm.benefitchange bc where bc.benefit_code = 'BN028' and bc.start_date = (current date + 1 DAY - DAY(current date) DAYS )"
		 ,"select * from pbsadm.benefitchange bc where bc.benefit_code = 'BN028' and bc.start_date = (current date + 1 DAY - DAY(current date) DAYS - 1 MONTH)"
		 ,"select * from pbsadm.benefitchange bc where bc.benefit_code = 'BN028' and bc.start_date = (current date + 1 DAY - DAY(current date) DAYS - 2 MONTH)"
		 ,"select distinct cnum from pbsadm.choice where cnum in(select cnum from pbsadm.benefitchange where cnum in (select cnum from pbsadm.filter_info where pemplodt is not null )and benefit_code in ('BN028','BN029') and status = 'C')"
		 ,"select * from pbsadm.choice where cnum in(select cnum from pbsadm.benefitchange where cnum in (select cnum from pbsadm.filter_info where pemplodt is not null )and benefit_code in ('BN028','BN029') and status = 'W')"
		 ,"select * from pbsadm.choice ch, pbsadm.benefitchange bc where ch.cnum in(select cnum from pbsadm.filter_info where pemplodt is not null )and benefit_code in ('BN028','BN029') and bc.choice_created = ch.created and bc.cnum=ch.cnum and bc.status='C'"
		 ,"select ch.cnum, ch.created, ch.name, bc.choice_created, bc.cluster_code, bc.benefit_code, bc.status, ch.status, bc.start_date, bc.end_date, bc.euro_size from pbsadm.choice ch, pbsadm.benefitchange bc where ch.cnum in(select cnum from pbsadm.filter_info where pemplodt is not null )and benefit_code in ('BN028','BN029') and bc.choice_created = ch.created and bc.cnum=ch.cnum and bc.status='C'"
		 ,"select * from pbsadm.choice ch, pbsadm.benefitchange bc where ch.cnum in( select cnum from pbsadm.filter_info where pemplodt is not null ) and benefit_code in ('BN028','BN029') and bc.choice_created = ch.created and bc.cnum=ch.cnum and bc.status in ('C','P','Y')"
		 ,"select count(*) from pbsadm.benefitchange bc, pbsadm.choice ch where bc.cnum = ch.cnum and bc.choice_created = ch.created and bc.benefit_code = 'BN028' and bc.status='C' and bc.start_date <= (current date + 1 DAY - DAY(current date) DAYS )"
		 ,"select count(*) from pbsadm.benefitchange bc, pbsadm.choice ch where bc.cnum = ch.cnum and bc.choice_created = ch.created and bc.benefit_code = 'BN028' and bc.status='C' and bc.start_date <= (current date + 1 DAY - DAY(current date) DAYS - 1 MONTH)"
		 ,"select count(*) from pbsadm.benefitchange bc, pbsadm.choice ch where bc.cnum = ch.cnum and bc.choice_created = ch.created and bc.benefit_code = 'BN028' and bc.status='C' and bc.start_date <= (current date + 1 DAY - DAY(current date) DAYS - 2 MONTH)"
		 ,"select count(*) from pbsadm.transaction where cnum in('"+cnums+"')"
		 ,"select * from pbsadm.choice where cnum in(select cnum from pbsadm.benefitchange where cnum in (select cnum from pbsadm.filter_info where pemplodt is not null )and benefit_code in ('BN028','BN029') and status = 'C')"
		 ,"select count(*) from pbsadm.choice where cnum in(select cnum from pbsadm.benefitchange where cnum in (select cnum from pbsadm.filter_info where pemplodt is not null ))"
		 ,"select * from pbsadm.benefitchange where cnum in('"+cnums+" ') and status in ('C','Y') order by cnum"
		 ,"select * from pbsadm.choice where cnum in('"+cnums+"') and status in ('C','Y')"
		 ,"select * from pbsadm.benefitchange where cnum in (select cnum from pbsadm.filter_info where pemplodt is not null )and benefit_code in ('BN028','BN029') and status = 'C'"
		 ,"select ch.cnum, ch.created, ch.name, bc.choice_created, bc.cluster_code, bc.benefit_code, bc.status, ch.status, bc.start_date, bc.end_date, bc.euro_size from pbsadm.choice ch, pbsadm.benefitchange bc where ch.cnum in(select cnum from pbsadm.filter_info where pemplodt is not null )and bc.choice_created = ch.created and bc.cnum=ch.cnum and bc.cnum in ('"+cnums+"')"
		 ,"select ch.cnum, ch.created, ch.name, bc.choice_created, bc.cluster_code, bc.benefit_code, bc.status, ch.status, bc.start_date, bc.end_date, bc.euro_size from pbsadm.choice ch, pbsadm.benefitchange bc where ch.cnum in(select cnum from pbsadm.filter_info where pemplodt is not null )and bc.choice_created = ch.created and bc.cnum=ch.cnum and bc.status=ch.status and bc.status='Y'"
		 ,"select ch.cnum, ch.created, ch.name, bc.choice_created, bc.cluster_code, bc.benefit_code, bc.status, ch.status, bc.start_date, bc.end_date, bc.euro_size from pbsadm.choice ch, pbsadm.benefitchange bc where ch.cnum in(select cnum from pbsadm.filter_info where pemplodt is not null )and benefit_code in ('BN028','BN029') and bc.choice_created = ch.created and bc.cnum=ch.cnum and bc.status='C'"
		 ,"select count(*) from pbsadm.approval where cnum in ('"+cnums+"')"
		 ,"SELECT CNUM, CREATED FROM PBSADM.CHOICE  CHOICE WHERE CNUM NOT IN (SELECT CNUM FROM PBSADM.APPROVAL) AND CHOICE.STATUS IN ('A','C','P') ORDER BY CNUM desc"
		 ,"select * from pbsadm.batch_schedule"};
		     String attquery[]=new String[x];
             for(int m=0;m<attired.length;m++)
      		 {
     	     attquery[m] = "select * from pbsadm.approval where cnum in("+attired[m]+")";
     		 }
     		 
		List<String> list = new ArrayList<String>(Arrays.asList(query));
		list.addAll(Arrays.asList(attquery));
		Object[] f = list.toArray();
		System.out.println(Arrays.toString(f)); 
		 
		 for(int k=0;k<f.length;k++)
		 {
		
		  rs = stmt.executeQuery(f[k].toString());	 
		  Vector<String> columnNames = new Vector<String>();
		  
		   if (rs != null) {
		 ResultSetMetaData columns = rs.getMetaData();
		 int i = 0;
		  %>
		  <div><%=f[k]%></div>
		  <br>
		
		 <table style="width:100%">
		   <tr>
		<% while (i < columns.getColumnCount()) 
		{i++;%>
		     <th> <%=columns.getColumnName(i)%></th>
     <%columnNames.add(columns.getColumnName(i));%> 
		     
		          <%}%>
		  		          </tr>
		          <%}%>
		                    
		           <% while (rs.next()) {%> 
		           <tr>
		            <% for (int j = 0; j < columnNames.size(); j++) {%>
		             <td> <%=rs.getString(columnNames.get(j)) %>
		             
		             </td>
		            <%} 
		           
		           }%>
		          </tr>
		         
</table>
<br><br><br>

<%}%>
    
</center>    
  
 </body>
</html>