<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"
	rel="stylesheet">
</head>
<body>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%!ResultSet resultset;%>
<%!PreparedStatement pst;%>
<%!Connection con;%>
<h2 align="center"><font><strong>Stock Table</strong></font></h2>
<table align="center" cellpadding="5" cellspacing="5" border="1">
<tr bgcolor="yellow">
<td><b>Product id</b></td>
<td><b>Price</b></td>
<td><b>Instock</b></td>
<td><b>Invent</b></td>


</tr>
<%
//create table stock(pid int primary key ,sprice double,instock int,invent int);

Class.forName("com.mysql.cj.jdbc.Driver");
con=DriverManager.getConnection("jdbc:mysql://localhost:3306/shopdetails", "root", "root");
pst=con.prepareStatement("select * from stock;");
resultset=pst.executeQuery();
while(resultset.next()){
%>
<tr bgcolor="cyan">
<td><%=resultset.getString(1) %></td>
<td><%=resultset.getString(2) %></td>
<td><%=resultset.getString(3) %></td>
<td><%=resultset.getString(4) %></td>

</tr>
<%
}
//create table pricing(pid int primary key auto_increment,pname varchar(30),category varchar(30),cprice double,margin int,sprice double);

%>

</table><br><br>
<h2 align="center"><font><strong>Pricing Table</strong></font></h2>
<table align="center" cellpadding="5" cellspacing="5" border="1">
<tr bgcolor="yellow">
<td><b>Product id</b></td>
<td><b>Product name</b></td>
<td><b>Category</b></td>
<td><b>Cost price</b></td>
<td><b>Margin</b></td>
<td><b>Selling price</b></td>


</tr>
<%
//create table stock(pid int primary key ,sprice double,instock int,invent int);

Class.forName("com.mysql.cj.jdbc.Driver");
con=DriverManager.getConnection("jdbc:mysql://localhost:3306/shopdetails", "root", "root");
pst=con.prepareStatement("select * from pricing;");
resultset=pst.executeQuery();
while(resultset.next()){
%>
<tr bgcolor="cyan">
<td><%=resultset.getString(1) %></td>
<td><%=resultset.getString(2) %></td>
<td><%=resultset.getString(3) %></td>
<td><%=resultset.getString(4) %></td>
<td><%=resultset.getString(5) %></td>
<td><%=resultset.getString(6) %></td>

</tr>
<%
}
%>

</table>



</body>
</html>