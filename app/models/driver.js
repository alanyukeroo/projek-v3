var mongoose = require('mongoose');
var db = require('../../config/db')

mongoose.connect(db.url);

var driverSchema = new mongoose.Schema ({
	driver_username: String,
	status: String,
});

var driver = mongoose.model('driver', driverSchema);

module.exports = driver;