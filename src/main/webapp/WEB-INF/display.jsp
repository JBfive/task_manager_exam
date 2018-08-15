<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Display All Tasks</title>
	<link rel="stylesheet" type="text/css" href="/main.css">
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Smlep5jCw/wG7hdkwQ/Z5nLIefveQRIY9nfy6xoR1uRYBtpZgI6339F5dgvm/e9B" crossorigin="anonymous">
</head>
<body>
	<div class="full">
		<h1>Welcome, <c:out value="${name.name}"/></h1>
			<a class="a" href="/logout">Logout</a>
			<table class="table table-striped">
				<thead>
					<tr>
						<th>Task</th>
						<th>Creator</th>
						<th>Assignee</th>
						<th>Priority</th>
						
					</tr>
				</thead>
				<tbody>
						<c:forEach items="${tasks}" var="t">
					<tr>
							<td><a href="tasks/${t.id}">${t.task}</a></td>
							<td>${t.creator.name}</td>
							<td>${t.assignee.name}</td>
							<td>${t.priority}</td>
							
					</tr>
						</c:forEach>
				</tbody>
			</table>
			<a class="a" href="/tasks/new">Create Task</a>
	</div>
</body>
</html>