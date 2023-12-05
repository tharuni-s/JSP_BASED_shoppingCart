<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" >
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" rel="stylesheet">
</head>
<body>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%!ResultSet resultset;%>
<%!PreparedStatement pst;%>
<%!Connection con;%>
<%


int id = Integer.parseInt(request.getParameter("id"));
String cid=(String)session.getAttribute("myValue");
out.print(cid);
Class.forName("com.mysql.cj.jdbc.Driver");
con=DriverManager.getConnection("jdbc:mysql://localhost:3306/shopdetails", "root", "root");
String sql = "DELETE FROM cart WHERE caid = ?";

pst = con.prepareStatement(sql);

pst.setInt(1, id);
int status=pst.executeUpdate();
//out.print("Deleted");
//response.sendRedirect("grey.jsp");

%>
<h2 align="center"><font><strong>Total Cart</strong></font></h2>
<table align="center" cellpadding="5" cellspacing="5" border="1">
<tr bgcolor="yellow">
<td><b>Action</b></td>

<td><b>Product id</b></td>
<td><b>Product name</b></td>
<td><b>Category</b></td>
<td><b>Price</b></td>
<td><b>Quantity</b></td>
<td><b>Total Amount</b></td>

</tr>
            

<%

pst=con.prepareStatement("select * from cart where cid=?;");
pst.setString(1,cid);


resultset=pst.executeQuery();

while(resultset.next()){
	 
%>
<tr bgcolor="cyan">
<td>

                    <form  method="post">

                        <input type="hidden" name="id" value="<%= resultset.getInt(1) %>">

                        <button class="btn btn-danger" type="submit">Delete</button>

                    </form>

                </td>

<td><%=resultset.getString(2) %></td>
<td><%=resultset.getString(3) %></td>
<td><%=resultset.getString(4) %></td>
<td><%=resultset.getString(5) %></td>
<td><%=resultset.getString(6) %></td>
<td><%=resultset.getString(7) %></td>


</tr>
<%
}

%>

</table><br><br>
<div align="center"><form action="bill.jsp" method="post">
    <button  class="btn btn-primary" name="out" value="check" >Check out</button>
    
    </form>
    </div>
    

</body>
</html>