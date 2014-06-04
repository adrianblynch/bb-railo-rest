<script src="jquery-2.0.2.min.js"></script>
<script src="underscore.js"></script>
<script src="backbone.js"></script>
<script>

	User = Backbone.Model.extend({
		url: "backbone.cfc?method=user&returnFormat=json"
	});

	// 1. Defined a Backbone user collection
	Users = Backbone.Collection.extend({
		model: User,
		url: "backbone.cfc?method=users&returnFormat=json",
		initialize: function() {

			// 2. When we initialise the collection, we'll populate it with a call to the above URL
			this.fetch({success: function(res) {
				console.log("Populated the collection with:", res);
			}});
			
		}
	});

	UsersTable = Backbone.View.extend({
		el: "table tbody",
		initialize: function() {
			var self = this;
			this.collection.on("sync", function() {
				self.render();
			});
			this.collection.on("add", function() {
				self.render();
			});
		},
		render: function(e) {
			var compiledTemplate = _.template($("#usersTable").html());
			var x = compiledTemplate({items: this.collection.toJSON()});
			this.$el.html(x);
			return this;
		}
	});

	$(function() {

		users = new Users();
		usersTable = new UsersTable({collection: users});

		$("input[type='submit']").click(function(e) {

			e.preventDefault();

			var userAttributes = {
				firstName: $("input[name='firstName']").val(),
				lastName: $("input[name='lastName']").val()
			};

			user = new User(userAttributes);

			user.save({}, {success: function(res) {
				console.log("Saved user:", res);
				users.add([res]);
			}});

		});

	});

</script>

<form>
	<label>First name</label>
	<input name="firstName" />
	<br />
	<label>Last name</label>
	<input name="lastName" />
	<br />
	<input type="submit" />
</form>

<table>
	<thead>
		<tr>
			<th>First name</th>
			<th>Last name</th>
			<th>DOB</th>
		</tr>
	</thead>
	<tbody>
		<tr><td colspan="3">Loading users...</td></tr>
	</tbody>
</table>

<script type="text/html" id="usersTable">
	<% _.each(items, function(i) { %>
		<tr>
			<td><%= i.firstName %></td>
			<td><%= i.lastName %></td>
			<td><%= i.dob %></td>
		</tr>
	<% }); %>
</script>