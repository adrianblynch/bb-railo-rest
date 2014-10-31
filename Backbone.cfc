component {

	APPLICATION.users = APPLICATION.users ?: [
		{id = 1, firstName = "Adrian", lastName = "Lynch", dob: "1901-12-12"},
		{id = 2, firstName = "Anthony", lastName = "Cull", dob: null}
	];

	function init() {
		return THIS;
	}

	remote function resetUsers() {
		APPLICATION.delete("users");
	}

	function getUsers() {
		return APPLICATION.users;
	}

	function getUser(id) {

		requestedUser = null;

		APPLICATION.users.each(function(user) {
			if (user.id EQ id) {
				requestedUser = user;
				break;
			}
		});

		return requestedUser;

	}

	function insertUser(user) {

		user.id = APPLICATION.users.len() + 1;
		APPLICATION.users.append(user);

		return getUser(user.id);

	}

	function updateUser(user) {

		// Apply the passed user attributes to the existing user

		APPLICATION.users.each(function(u) {
			if (u.id EQ user.id) {
				userToModify = u;
				break;
			}
		});

		user.each(function(key, value) {
			userToModify[key] = value;
		});

		return getUser(user.id);

	}

	function deleteUser(user) {

		APPLICATION.users.each(function(u) {
			if (u.id EQ user.id) {
				u = null;
				break;
			}
		});

	}

	remote function users() {
		return getUsers();
	}

	remote function user() {

		/*
			An end-point for a user on the server.
			A GET request with an ID returns the given user
			A PUT request with and ID will update the given user with the supplied data
			A POST request will insert a new user with the supplied data and return the new user
			A DELETE request will delete the given user
		*/

		verb = GetHTTPRequestData().method;
		user = DeserializeJSON(GetHTTPRequestData().content);

		if (verb EQ "GET") {

			rtn = getUser();

		} else if (verb EQ "POST") {

			rtn = insertUser(user);

		} else if (verb EQ "PUT") {

			rtn = updateUser(user);

		} else if (verb EQ "DELETE") {

			rtn = deleteUser(user);

		} else {

			throw "No valid method found in request";

		}

		return rtn;

	}

}

/*
	NOTES:
	- All script, no tags
	- New elvis operator ?: acts as: if IsDefined("xxx") [evaluate this] else [evaluate this] - Removed
	- Case of structure keys are now maintained by setting a flag in Railo Admin. This stops myStruct.myKey from ending up as myStruct.MYKEY when it gets serialised
	- Array.filter() takes a function which returns a boolean. If true, the current array item is returned
*/
