
<cfset bb = new Backbone()>

<cfset allUsers = bb.getUsers()>
<cfdump var="#allUsers#" label="All users in the DB - Start">

<!--- <cfset adrian = bb.getUser(1)>
<cfdump var="#adrian#"> --->

<!--- <cfset newUser = {firstName = "FN", lastName = "LN"}>
<cfset bb.insertUser(newUser)> --->

<cfset updatedUser = {id = 1, firstName = "Adrian (Updated)"}>
<cfset bb.updateUser(updatedUser)>

<cfset allUsers = bb.getUsers()>
<cfdump var="#allUsers#" label="All users in the DB - End">

<cfset bb.resetUsers()>

<!---
	NOTES:
	- [new] keyword takes the place of CreateObject("component", "myComponent").init() - Notice that init() is now called implicitly
--->