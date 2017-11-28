var mongoose = require('mongoose');
var db = require('../../config/db')

mongoose.connect(db.url);

var tokenSchema = new mongoose.Schema ({
    username: string,
    token: string,
});

var firebaseToken = mongoose.model('firebaseToken', tokenSchema);

module.exports = firebaseToken;