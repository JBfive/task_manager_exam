<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>New Tasks Page</title>
	<link rel="stylesheet" type="text/css" href="/main.css">
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Smlep5jCw/wG7hdkwQ/Z5nLIefveQRIY9nfy6xoR1uRYBtpZgI6339F5dgvm/e9B" crossorigin="anonymous">
</head>
<body>
	<div class="full">
		<h1>Create a new task</h1>
		<p class="text text-danger"><form:errors path="tasks.*"/></p>
		<form:form class="form-group " method="POST" action="/add_task" modelAttribute="tasks">
				
				<p><form:errors path="tasks.*"/></p>
				<p>
		            <form:label path="task">Task:</form:label>
		            <form:input type="text" path="task"/>
		        </p>
				<p>
			        <form:label path="assignee">Assignee:</form:label>
			       
			        <form:select path="assignee">
			        <c:forEach items="${assigneeList}" var="list">
			        	<form:option value="${list.id}" label="${list.name}"/>
			        </c:forEach>
			        </form:select>
		    	</p>
		    	<p>
		    		<form:label path="priority">Priority:</form:label>
		    		<form:select path="priority">
		    			<form:option value="High" label="High"/>
		    			<form:option value="Medium" label="Medium"/>
		    			<form:option value="Low" label="Low"/>
	    			</form:select>
		    	</p>
		    	<input type="hidden" name="userId" value="userId"/>
		    	<input class="button" type = "submit" value="Create"/>
	   	</form:form>
   	</div>
</body>
</html>