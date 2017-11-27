var mongoose = require('mongoose');

mongoose.connect('mongodb://localhost/myappdatabase');

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
