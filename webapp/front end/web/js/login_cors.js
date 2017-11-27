document.getElementById('error-password').style.display = "none";

var IP_ADDR = "http://localhost:7272";

// Make the actual CORS request.
function login() {
    var username = document.getElementById('username').value;
    var password = document.getElementById('password').value;
    // target url
    var url = IP_ADDR + "/login";

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
            location.href = "profile.jsp?token="+token;
        }
        else {
            document.getElementById('error-password').style.display = "block";
        }
    };

    xhr.onerror = function() {
        alert('Woops, there was an error making the request.');
    };

    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhr.send("username="+username+"&password="+password);
}