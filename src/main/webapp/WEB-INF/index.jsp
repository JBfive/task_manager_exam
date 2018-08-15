<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Login and Registration Page</title>
	<link rel="stylesheet" type="text/css" href="/main.css">
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Smlep5jCw/wG7hdkwQ/Z5nLIefveQRIY9nfy6xoR1uRYBtpZgI6339F5dgvm/e9B" crossorigin="anonymous">
</head>
<body>
	<div class="full">
		<h1>Welcome</h1>
		<div class = "box">
			<h1>Register</h1>
		    
		    <p class="text text-danger"><form:errors path="users.*"/></p>
		    
		    <form:form class="form-group" method="POST" action="/registration" modelAttribute="users">
		        <p>
		            <form:label path="name">Name:</form:label>
		            <form:input type="text" path="name"/>
		        </p>
		       
		        <p>
		            <form:label path="email">Email:</form:label>
		            <form:input type="email" path="email"/>
		        </p>
		        
		        
		        <p>
		            <form:label path="password">Password:</form:label>
		            <form:password path="password"/>
		        </p>
		        <p>
		            <form:label path="passwordConfirmation">Password Confirmation:</form:label>
		            <form:password path="passwordConfirmation"/>
		        </p>
		        <input class="button" type="submit" value="Register!"/>
		    </form:form>
	    </div>
	    <div class = "box">
	    	<h1>Login</h1>
		    <p class="text text-danger"><c:out value="${error}" /></p>
		    <form class="form-group " method="post" action="/login">
		        <p>
		            <label type="email" for="email">Email</label>
		            <input type="text" id="email" name="email"/>
		        </p>
		        <p>
		            <label for="password">Password</label>
		            <input type="password" id="password" name="password"/>
		        </p>
		        <input class="button" type="submit" value="Login!"/>
		    </form>    
	    </div>
    </div>
</body>
</html>