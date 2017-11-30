app.controller('order-controller', function($scope) {
    var msg2 = {
        "from": "self",
        "message": "message"
    }
    var msg1 = {
        "from": "other",
        "message": "message other"
    }
    
    $scope.chats = [msg2, msg1];


});