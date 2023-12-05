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
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%!ResultSet resultset;%>
<%!PreparedStatement pst;%>
<%!Connection con;%>
<%! String pname; %>
<%! String id; %>
<h2 align="center"><font><strong>Cart</strong></font></h2>
<table align="center" cellpadding="5" cellspacing="5" border="1">
<tr bgcolor="yellow">
<td><b>Product id</b></td>
<td><b>Product name</b></td>
<td><b>Category</b></td>
<td><b>Price</b></td>
<td><b>Quantity</b></td>
<td><b>Total Amount</b></td>

</tr>

<%

    double price = Double.parseDouble(request.getParameter("price"));
    int quantity = Integer.parseInt(request.getParameter("quantity"));
    String ad=request.getParameter("obt");
    String id=(String)session.getAttribute("myValue");
    
    if(ad.equals("no")){
    	pname="Blue T-Shirt";
    }
    else if(ad.equals("ob")){
    	pname="Yellow T-Shirt";
    }
    else if(ad.equals("rst")){
    	pname="Kiddy T-Shirt";
    	
    }
 else if(ad.equals("bwt")){
	 pname="Printed White T-Shirt";
    }
 else if(ad.equals("qt")){
	 pname="Plain black T-Shirt";
 }
 else if(ad.equals("bbt")){
	 pname="Stylish blue T-Shirt";
 }

    double billingAmount = price * quantity;

    // Formatting the billing amount with two decimal places
    NumberFormat nf = NumberFormat.getCurrencyInstance(Locale.US);
    DecimalFormat df = (DecimalFormat) nf;
    df.applyPattern("0.00");
    String formattedBillingAmount = df.format(billingAmount);
    Class.forName("com.mysql.cj.jdbc.Driver");
    con=DriverManager.getConnection("jdbc:mysql://localhost:3306/shopdetails", "root", "root");
    pst=con.prepareStatement("select pid,pname,category,sprice from pricing where pname=?;");
    pst.setString(1,pname);
    resultset=pst.executeQuery();

    



if(resultset.next()){
%>
<tr bgcolor="pink">
<td><%=resultset.getString(1) %></td>
<td><%=resultset.getString(2) %></td>
<td><%=resultset.getString(3) %></td>
<td><%=resultset.getString(4) %></td>
<td><%=quantity %></td>
<td><%= formattedBillingAmount%></td>
</tr>
<%
}

pst=con.prepareStatement("insert into cart(cid,pid,pname,category,price,quantity,total)values(?,?,?,?,?,?,?);");
pst.setString(1,id);
pst.setString(2,resultset.getString(1));
pst.setString(3,resultset.getString(2));
pst.setString(4,resultset.getString(3));
pst.setString(5,resultset.getString(4));
pst.setInt(6,quantity);
pst.setString(7,formattedBillingAmount );


int status=pst.executeUpdate();



%>


</table>
<div align="center">
<h1>Billing Amount</h1>
<p>Quantity: <%= quantity %></p>

    <p>Billing Amount: <%= formattedBillingAmount %></p>
    </div>
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
pst.setString(1,id);


resultset=pst.executeQuery();

while(resultset.next()){
	 
%>
<tr bgcolor="cyan">
<td>

                    <form action="delete.jsp" method="post">

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

</table>
<div align="center">
    <form action="bill.jsp" method="post">
    <button  class="btn btn-primary" name="out" value="check" >Check out</button>
    
    </form>
    
</div>

</body>
</html>