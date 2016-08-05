<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script type="text/javascript">
function validateForm() {
	
    var x = document.forms["myForm"]["username"].value;
    var y = document.forms["myForm"]["pass"].value;
    if( x == null || x =="") {
        alert("Name must be filled out");
        return false;
}
    if( y == null || y =="") {
        alert("Password must be filled out");
        return false;
}
    
}


</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Payroll Automation</title>

</head>
<body>
<center>
<form  name="myForm" action="PayrollAutomation" method="post" onsubmit="return validateForm()">
  User name:
  <input type="text" name="username"><br><br>
  Password :
  <input type="password" name="pass"><br><br>
  
 
  
  <input type="submit" name="connection" value="DbConnection"  ><br><br>
  
  <input type="submit" name="connection" value="Payroll_check"  ><br>
  
</form>
</center>
</body>
</html>