var mongoose = require('mongoose');
var db = require('../../config/db')

mongoose.connect(db.url);

var ChatSchema = new mongoose.Schema({  
  user_passenger: {
    type: String,
    required: true
  },
  user_driver: {
    type: String,
    required: true
  },
  message_body: [{ from: String, to: String, msg: String }]
});

var chat = mongoose.model('chat', ChatSchema);

module.exports = chat;
