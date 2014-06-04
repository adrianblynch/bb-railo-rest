
<cfparam name="what" default="">

<h1>Backbone > Railo Demo</h1>

<ul>
	<li><a href="?what=model">Model</a></li>
	<li><a href="?what=collection">Collection</a></li>
</ul>

<cfif ListFind("model,collection", what)>
	<cfmodule template="#what#.cfm">
</cfif>