
<script src="jquery-2.0.2.min.js"></script>
<script src="underscore.js"></script>
<script src="backbone.js"></script>
<script>

	// 1. Defined a Backbone user model ////////////////////
	User = Backbone.Model.extend({                        //
		url: "backbone.cfc?method=user&returnFormat=json" //
	});                                                   //
	////////////////////////////////////////////////////////

	function save() {

		// 2. Collect user info /////////////////////////////
		var userAttributes = {                             //
			firstName: $("input[name='firstName']").val(), //
			lastName: $("input[name='lastName']").val()    //
		};                                                 //
		/////////////////////////////////////////////////////

		// 3. Create a new user model /////
		user = new User(userAttributes); //
		///////////////////////////////////

		// 4. Save (to the server) ///////////////
		user.save({}, {success: function(res) { //
			refresh();                          //
		}});                                    //
		//////////////////////////////////////////

	}

	function reset() {
		$.ajax({
			url: "backbone.cfc?method=resetUsers&returnFormat=json"
		}).done(function(res) {
			$("textarea").val("");
		});
	}

	function refresh() {
		$.ajax({
			url: "backbone.cfc?method=users&returnFormat=json"
		}).done(function(res) {
			// Format things a bit better
			var json = JSON.stringify(res);
			$("textarea").val($.trim(json).replace("[", "[\n").replace("]", "\n]").replace("},{", "},\n{"));
		});
	}

	$(function() {
		$("input[type='submit']").click(function(e) {
			e.preventDefault();
			window[this.value.toLowerCase()].call();
		});
	});

</script>

<form>
	<fieldset>
		<legend>User</legend>
		<label>First name</label>
		<input name="firstName" />
		<br />
		<label>Last name</label>
		<input name="lastName" />
		<br />
		<input type="submit" value="Save" />
	</fieldset>
	<fieldset>
		<legend>Current users database</legend>
		<textarea style="width: 600px; height: 250px"></textarea>
		<br />
		<input type="submit" value="Refresh" />
		<input type="submit" value="Reset" />
	</fieldset>
</form>