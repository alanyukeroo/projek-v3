var mongoose = require('mongoose');

mongoose.connect('mongodb://localhost/myappdatabase');

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