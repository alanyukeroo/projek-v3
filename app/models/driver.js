var mongoose = require('mongoose');
var db = require('../../config/db')

mongoose.connect(db.url);

var driverSchema = new mongoose.Schema ({
	driver_username: {
		type: String,
		required: true
	},
	
	status: {
		type: String,  
		required: true
    }
});

var driver = mongoose.model('driver', driverSchema);

module.exports = driver;