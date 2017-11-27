var true_name = true;
var true_phone = true;

function checkName(name) {
    if (name.length > 20) {
        document.getElementById("error-name").style.display = "block";
        true_name = false;
        return false;
    } else {
        document.getElementById("error-name").style.display = "none";
        true_name = true;
        return true;
    }
}

function checkPhoneNumber(phone_number) {
    var isnum = /^\d+$/.test(phone_number);

    if ((phone_number.length < 9) || (phone_number.length > 14) || !isnum) {
        document.getElementById("error-phone-number").style.display = "block";
        true_phone = false;
        return false;
    } else {
        document.getElementById("error-phone-number").style.display = "none";
        true_phone = true;
        return true;
    }
}

function validateForm(){
    if (true_name && true_phone){
        return true;
    } else {
        alert("Please fill right value")
        return false;
    }
}