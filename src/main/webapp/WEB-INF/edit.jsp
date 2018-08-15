<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Edit Page</title>
	<link rel="stylesheet" type="text/css" href="/main.css">
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Smlep5jCw/wG7hdkwQ/Z5nLIefveQRIY9nfy6xoR1uRYBtpZgI6339F5dgvm/e9B" crossorigin="anonymous">
</head>
<body>
	<div class="full">
		<h1>Edit <c:out value="${tasks.task}"/></h1>
		<div class="box">
			<p class="text text-danger"><c:out value="${error}" /></p>
			<form class="form-group " method="POST" action="/edit_task/${tasks.id}" >
					
					
					<p>
			            Task:
			            <input type="text" name="task" value="${tasks.task}"/>
			        </p>
					<p>
				        Assignee:
				       
				        <select name="assignee">
				        <c:forEach items="${assigneeList}" var="list">
				        	<option value="${list.id}" label="${list.name}"/>
				        </c:forEach>
				        </select>
			    	</p>
			    	<p>
			    		Priority:
			    		<select name="priority">
			    			<option value="High" label="High"/>
			    			<option value="Medium" label="Medium"/>
			    			<option value="Low" label="Low"/>
		    			</select>
			    	</p>
			    	<input type="hidden" name="userId" value="userId"/>
			    	<input class="button" type = "submit" value="Edit"/>
		   	</form>
			
		</div>
	</div>
</body>
</html>