app.controller('order-controller', function($scope,$http) {

    // Initialize Firebase
    var config = {
        apiKey: "AIzaSyDZ1pnMoLxB_OpClgKiDebKdcwP1d8Zw2A",
        authDomain: "projek-3dad4.firebaseapp.com",
        databaseURL: "https://projek-3dad4.firebaseio.com",
        projectId: "projek-3dad4",
        storageBucket: "projek-3dad4.appspot.com",
        messagingSenderId: "183887873921"
    };
    firebase.initializeApp(config);

    // Retrieve Firebase Messaging object.
    const messaging = firebase.messaging();

    messaging.requestPermission()
        .then(function() {
            console.log('Notification permission granted.');
            // Get Instance ID token. Initially this makes a network call, once retrieved
            // subsequent calls to getToken will return from cache.
            messaging.getToken()
                .then(function(currentToken) {
                    $scope.token = currentToken;
                    if (currentToken) {
                        console.log(currentToken);
                    } else {
                        // Show permission request.
                        console.log('No Instance ID token available. Request permission to generate one.');
                        // Show permission UI
                    }
                })
                .catch(function(err) {
                    console.log('An error occurred while retrieving token. ', err);
                });
        })
        .catch(function(err) {
            console.log('Unable to get permission to notify.', err);
        });


    var msg2 = {
        "from": "self",
        "message": "message"
    }
    var msg1 = {
        "from": "other",
        "message": "message other"
    }

    $scope.chats = [msg2, msg1];


    $scope.sendMessage = function() {
        var msg = $scope.message;
        var JSON = {
            "message":{
            "token" : $scope.token,
                "notification" : {
                "body" : msg,
                    "title" : "FCM Message",
            }
        }
        }

        var msg1 = {
            "from": "self",
            "message": msg
        }

        var account = {

        }

        $scope.chats.push(msg1);
        $scope.message = "";

        $http.post('localhost:3000/configure_token', )
        $http.post('localhost:3000/sendmessageptod', JSON, {})
            .then(function(result) {
                console.log(result)
            })
    }
});