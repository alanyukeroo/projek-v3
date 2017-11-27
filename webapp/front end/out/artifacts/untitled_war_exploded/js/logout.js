function logout(token) {
    var url = IP_ADDR + "/logout";

    var xhr = createCORSRequest('POST', url);
    if (!xhr) {
        alert('CORS not supported');
        return;
    }

    // Response handlers.
    xhr.onload = function() {
        var response = JSON.parse(this.responseText);
        if (response.status == "success") {
            var token = response.token;
            location.href = "login.jsp";
        }
    };

    xhr.onerror = function() {
        alert('Woops, there was an error making the request.');
    };

    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhr.send("token="+token);
}