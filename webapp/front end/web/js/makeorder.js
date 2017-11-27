var step = 1;
var chosen_driver = null;
var rating = 0;
var pick = null;
var destination = null;

function check(step) {
    if(step == 1){
        document.getElementById('step-1').style.display='block';
        document.getElementById('step-2').style.display='none';
        document.getElementById('step-3').style.display='none';
        document.getElementById('step-4').style.display='none';
    }else{
        if (step == 2 && checkLocation()){
            document.getElementById('step-1').style.display='none';
            document.getElementById('step-2').style.display='block';
            document.getElementById('step-3').style.display='none';
            document.getElementById('step-4').style.display='none';
            document.getElementById("label-step-1").classList.remove('order-step-now');
            document.getElementById("label-step-1").classList.add('order-step');
            document.getElementById("label-step-2").classList.remove('order-step');
            document.getElementById("label-step-2").classList.add('order-step-now');
        } else if (step == 3){
            document.getElementById('step-1').style.display='none';
            document.getElementById('step-2').style.display='none';
            document.getElementById('step-3').style.display='block';
            document.getElementById('step-4').style.display='none';
            document.getElementById("label-step-2").classList.remove('order-step-now');
            document.getElementById("label-step-2").classList.add('order-step');
            document.getElementById("label-step-3").classList.remove('order-step');
            document.getElementById("label-step-3").classList.add('order-step-now');
        } else if (step == 4){
            document.getElementById('step-1').style.display='none';
            document.getElementById('step-2').style.display='none';
            document.getElementById('step-3').style.display='none';
            document.getElementById('step-4').style.display='block';
            document.getElementById("label-step-3").classList.remove('order-step-now');
            document.getElementById("label-step-3").classList.add('order-step');
            document.getElementById("label-step-4").classList.remove('order-step');
            document.getElementById("label-step-4").classList.add('order-step-now');
        }
    }
}

function checkLocation() {
    if(document.getElementById('destination').value != "" && document.getElementById('pick-location').value != "") {
        pick = document.getElementById("pick-location").value;
        destination = document.getElementById('destination').value;
        return true;
    }else {
        alert("Isi destination dan pick location");
        step--;
        return false;
    }
}

function increase() {
    step++;
    check(step);
}

check(step);

function setPreferDriver(search,id,destination,pick){
    if(search != ""){
        console.log(search);
        var xmlhttp;
        if (window.XMLHttpRequest) {
            // code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        } else {
            // code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                if(this.response == -1){
                    document.getElementById("preffered-driver").innerHTML = "<div class='head-title driver-list content-font-segoe'> <p class='posisi-tengah'>Nothing to Display :(</p></div>"
                } else {
                    document.getElementById("preffered-driver").innerHTML = this.response;
                }
            }
        };
        xmlhttp.open("GET", "jsp/getpreferreddriver.jsp?search=" + search + "&username="+ id +"&destination="+destination+"&pick="+pick, true);
        xmlhttp.send();
    } else {
        document.getElementById("preffered-driver").innerHTML = "<div class='head-title driver-list content-font-segoe'> <p class='posisi-tengah'>Nothing to Display :(</p></div>"
    }
}

function setOtherDriver(search,id,destination,pick){
        var xmlhttp;
        if (window.XMLHttpRequest) {
            // code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        } else {
            // code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                if(this.response == -1){
                    document.getElementById("other-driver").innerHTML = "<div class='head-title driver-list content-font-segoe'> <p class='posisi-tengah'>Nothing to Display :(</p></div>"
                } else {
                    document.getElementById("other-driver").innerHTML = this.response;
                }
            }
        };
        xmlhttp.open("GET", "jsp/getotherdriver.jsp?search=" + search + "&username="+ id +"&destination="+destination+"&pick="+pick, true);
        xmlhttp.send();
}

function iChoose(id_driver) {
    chosen_driver = id_driver;
    var xmlhttp;
    if (window.XMLHttpRequest) {
        // code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    } else {
        // code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            var response = JSON.parse(this.response);
            document.getElementById("show-name").innerHTML = response["0"]["name"];
            document.getElementById("show-username").innerHTML = "@" + response["0"]["username"];
            document.getElementById("chosen-driver-pic").setAttribute("src", response["0"]["image"]);
            document.getElementById("chosen-driver-pic").setAttribute("alt", response["0"]["username"]);
        }
    };
    xmlhttp.open("GET", "jsp/getUserDetail.jsp?" + "username=" + id_driver, true);
    xmlhttp.send();
}

function rate(nb){
    rating = nb;
}

function order(){
    if(chosen_driver != null && rating > 0){
        var xmlhttp;
        var comment = document.getElementById("comment").value;

        if (window.XMLHttpRequest) {
            // code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        } else {
            // code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                var response = JSON.parse(this.response);
                if(response == true){
                    window.location.href = "makeorder.jsp?token=" + token + "&username=" + username;
                }else {
                    alert("Sorry we encountered an error :(");
                }
            }
        };
        xmlhttp.open("GET", "jsp/completeorder.jsp?" + "username=" + username + "&driver=" + chosen_driver +
        "&comment=" + comment + "&rating=" + rating + "&pick=" + pick + "&dest=" + destination, true);
        xmlhttp.send();
    } else {
        alert("Please give rating to our driver");
    }
}

