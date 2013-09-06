<%@page import="com.hannonhill.cascade.model.service.ServiceProviderHolderBean" %>

<%@ page import="com.hannonhill.cascade.view.beans.security.LoginInformationBean" %>

<%@ page import="com.hannonhill.cascade.view.struts.security.StrutsPerformLogin" %>

<%
	String err = null;

	LoginInformationBean login = (LoginInformationBean)session.getAttribute("user");

	if (login != null && !ServiceProviderHolderBean.getServiceProvider().getRoleService().userHasRoleByRolename(login.getUsername(), "Administrator"))
	{
		err = "Only Administrators can do that!";
	}

	String wannabe = request.getParameter("wannabe");
	if (wannabe == null)
	{
		response.sendRedirect("index.jsp");
	}
	// dunno what happens if you try to log in as !@$#!''%%\\--!#$.  Let's not find out.
	// i guess a hypen could be in a username?
	wannabe = wannabe.replaceAll("[^\\-\\w]", "");

	if (err == null)
	{

		org.springframework.context.ApplicationContext appCtx = org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
		StrutsPerformLogin performLogin = (StrutsPerformLogin)appCtx.getBean("performLogin");
		try
		{
			performLogin.login(request, response, wannabe);
		}
		catch (Exception e)
		{
			err = "<p>A problem occurred logging you in!  Did you enter an incorrect username?</p><a href=\"index.jsp\">Try again</a>";
		}
	}
	// still good?
	if (err == null)
	{
		// to CMS home with you
		response.sendRedirect("/");
	}
	else
	{
%>
	<html>
		<head>
			<style>
				body, td
				{
					font-size: 12px;
					font-family: sans-serif;
				}
			</style>
			<title>User switcher - error!</title>
		</head>
		<body>
			<h1>User switcher - error!</h1>
			<%= err %>
		</body>
	</html>
<%
	}
%>

