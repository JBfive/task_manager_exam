<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Show a Task Page</title>
	<link rel="stylesheet" type="text/css" href="/main.css">
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Smlep5jCw/wG7hdkwQ/Z5nLIefveQRIY9nfy6xoR1uRYBtpZgI6339F5dgvm/e9B" crossorigin="anonymous">
</head>
<body>
	<div class="full">
		<h1>Task: <c:out value="${tasks.task}"/></h1>
		<div class="block">
			<a href="/tasks">Home</a>
		</div>
		<div class="box">
			<h2>Creator: <c:out value="${tasks.creator.name }"/></h2>
			<h2>Assignee: <c:out value="${tasks.assignee.name }"/></h2>
			<h2>Priority: <c:out value="${tasks.priority }"/></h2>
			<a href="/tasks/${tasks.id}/edit">Edit</a> <a href="/delete/${tasks.id}"> Delete</a>
			<p><a href="/completed/${tasks.id}">Completed</a></p>
		</div>
	</div>
</body>
</html>