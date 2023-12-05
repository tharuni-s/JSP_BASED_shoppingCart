<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%!ResultSet resultset;%>
<%!PreparedStatement pst;%>
<%!Connection con;%>
<%!int sta; %>

<%


String id=(String)session.getAttribute("myValue");
out.println(id);
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/shopdetails", "root", "root");
pst=con.prepareStatement("select * from cart join userdetails on cart.cid=userdetails.cid;");


//create table billing(billno int primary key auto_increment,cid int,cname varchar(30),pid int,pname varchar(30),category varchar(30),quantity int, sprice double,total double)
resultset=pst.executeQuery();
while (resultset.next()) {
    // Retrieve data from the result set
    String customerId = resultset.getString("cid");
    String customerName = resultset.getString("cname");
    String orderId = resultset.getString("pid");
    String orderDate = resultset.getString("pname");
    String cat=resultset.getString("category");
    int quantity=resultset.getInt("quantity");
    Double price=resultset.getDouble("price");
    Double total=resultset.getDouble("total");


    // Step 4: Insert data into the third table
    PreparedStatement pstmt = con.prepareStatement("INSERT INTO billing (cid,cname ,pid ,pname,category,quantity,sprice,total ) VALUES (?, ?, ?, ?,?,?,?,?)");
    pstmt.setString(1,customerId );
    pstmt.setString(2,customerName );
    pstmt.setString(3,orderId );
    pstmt.setString(4,orderDate );
    pstmt.setString(5,cat );
    pstmt.setInt(6,quantity );
    pstmt.setDouble(7, price);
    pstmt.setDouble(8,total);
    int stat=pstmt.executeUpdate();
    sta=stat;
    pst=con.prepareStatement("select * from stock where pid=?");
    pst.setString(1,orderId);
    ResultSet rs = pst.executeQuery();
    int currentInstock = 0;
    if (rs.next()) {
       currentInstock = rs.getInt("instock");
    }
    
    // Step 3: Calculate the new instock value
    int quantitySold = quantity; // Provide the quantity of the item sold
    int newInstock = currentInstock - quantitySold;
    
    // Step 4: Update the instock value
    PreparedStatement pstmtUpdate = con.prepareStatement("UPDATE stock SET instock = ? WHERE pid = ?");
    pstmtUpdate.setInt(1, newInstock);
    pstmtUpdate.setString(2, orderId);
    pstmtUpdate.executeUpdate();


 }
out.println(sta);

if(sta>0){
	String sql = "DELETE FROM cart WHERE cid = ?";

	pst = con.prepareStatement(sql);

	pst.setString(1, id);
	int status=pst.executeUpdate();
	out.print("deleted");
	
	
}

%>
</body>
</html>