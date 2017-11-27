function editLocation(location_name, username) {
    if(document.getElementById('loc'+ location_name).disabled) {
        document.getElementById('loc' + location_name).disabled = false;
        document.getElementById('loc' + location_name).focus();
        document.getElementById('edit' + location_name).innerHTML = "&#10004;";
        document.getElementById('edit' + location_name).style.color = "green";
        document.getElementById('delete' + location_name).setAttribute("onClick", "deleteLocation(" + username + "," + location_name + ")");
    }
    else {
        document.getElementById('loc' + location_name).disabled = true;
        document.getElementById('edit' + location_name).innerHTML = "&#10000;";
        document.getElementById('delete' + location_name).setAttribute("onClick", "resetLocation()");

        var new_location = document.getElementById('loc' + location_name).value;
        var locUpdate = "jsp/updateLocation.jsp?username=" + username + "&location_name=" + location_name + "&new_location=" + new_location;

        if (window.XMLHttpRequest) {
            // code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        } else {
            // code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                if (this.responseText === "1") {
                    location.reload();
                }
                else {
                    console.log("gagal update");
                }
            }
        };
        xmlhttp.open("GET", locUpdate, true);
        xmlhttp.send();
    }
}

function deleteLocation(location_name,username) {
    var locDelete = "jsp/deleteLocation.jsp?location_name=" + location_name+ "&username=" + username;

    if (window.XMLHttpRequest) {
        // code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    } else {
        // code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            if (this.responseText == 1) {
                location.reload();
            }
            else {
                console.log("gagal delete");
            }
        }
    };
    xmlhttp.open("GET", locDelete, true);
    xmlhttp.send();
}

function addLocation(username) {
    var location = document.getElementById('location').value;
    var locAdd = "jsp/addLocation.jsp?username=" + username + "&location=" + location;

    if (window.XMLHttpRequest) {
        // code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    } else {
        // code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            if (this.response == 1) {
                window.location.reload();
            }
            else {
                console.log("gagal add");
            }
        }
    };
    xmlhttp.open("GET", locAdd, true);
    xmlhttp.send();
}

function resetLocation() {
    location.reload();
    console.log("reset");
}