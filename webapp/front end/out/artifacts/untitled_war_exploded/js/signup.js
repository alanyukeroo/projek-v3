var IP_ADDR = "http://localhost:7272";
var token;

function validateEmail(email) {
    var re = /^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
    if(!re.test(email)){
        document.getElementById("error-email").style.display = "block";
        return false;
    }
    else {
        document.getElementById("error-email").style.display = "none";
        return true;
    }
}

function checkName(name) {
    if (name.length > 20) {
        document.getElementById("error-name").style.display = "block";
        return false;
    } else {
        document.getElementById("error-name").style.display = "none";
        return true;
    }
}

function checkPassword(password){
    if (password != document.getElementById("user-password").value) {
        document.getElementById("error-password").style.display = "block";
        return false;
    } else {
        document.getElementById("error-password").style.display = "none";
        return true;
    }
}

function checkPhoneNumber(phone_number) {
    var isnum = /^\d+$/.test(phone_number);

    if ((phone_number.length < 9) || (phone_number.length > 14) || !isnum) {
        document.getElementById("error-phone-number").style.display = "block";
        return false;
    } else {
        document.getElementById("error-phone-number").style.display = "none";
        return true;
    }
}

function submitSignUp() {
    var statusdriver;
    var full_name = document.getElementById("full_name").value;
    var username = document.getElementById("username").value;
    var email = document.getElementById("user_email").value;
    var password = document.getElementById("user-password").value;
    var phone_number = document.getElementById("user-phone-number").value;
    if(document.getElementById("driverstatus").checked){
        statusdriver = 1;
    }
    else {
        statusdriver = 0;
    }

    // target url
    var url = IP_ADDR + "/register";

    var xhr = createCORSRequest('POST', url);
    if (!xhr) {
        alert('CORS not supported');
        return;
    }
    // console.log("masuk");
    // Response handlers.
    xhr.onload = function() {
        var response = JSON.parse(this.responseText);
        if (response.status == "success") {
            console.log("success");
            token = response.token;
            if (checkPhoneNumber(phone_number) && checkPassword(password) && checkName(full_name) && validateEmail(email)) {
                var url = "jsp/register.jsp";

                var xhr = createCORSRequest('POST', url);
                if (!xhr) {
                    alert('CORS not supported');
                    return;
                }

                // Response handlers.
                xhr.onload = function() {
                    var response = JSON.parse(this.responseText);
                    if(response.status == "success"){
                        if (statusdriver == 1) {
                            location.href = "profile.jsp?token="+response.token+"&username="+username;
                        }
                        else {
                            location.href = "makeorder.jsp?token="+response.token+"&username="+username;
                        }
                    } else {
                        console.log('failed');
                    }
                };

                xhr.onerror = function() {
                    alert('Woops, there was an error making the request.');
                };

                xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xhr.send("full_name="+full_name+"&username="+username+"&email="+email+
                    "&password="+password+"&phone_number="+phone_number+"&statusdriver="+
                    statusdriver+"&token="+token);
            } else {
                console.log("something wrong");
            }
            return true;
        }
        else {
            console.log("failed");
            return false;
        }
    };

    xhr.onerror = function() {
        alert('Woops, there was an error making the request.');
    };

    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhr.send("username="+username+"&email="+email+"&password="+password);
}