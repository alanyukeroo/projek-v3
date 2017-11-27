var express = require('express');
var bodyParser = require('body-parser');
var app = express();
var server = require('http').createServer(app); 
var logger = require('morgan');
var firebase = require("firebase");
var router = express.Router();

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

app.get('/', function (req, res) {
  res.render('app', {});
});

server.listen(3000, function(){
    console.log('listening on *:3000');
});
