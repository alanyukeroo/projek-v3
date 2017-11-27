var mongoose = require('mongoose');

mongoose.connect('mongodb://localhost/myappdatabase');

var tokenSchema = new mongoose.Schema ({
    username: string,
    token: string,
});

var firebaseToken = mongoose.model('firebaseToken', tokenSchema);

module.exports = firebaseToken;