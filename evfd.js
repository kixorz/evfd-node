var display = require("./display.js");
var request = require("request");
var timer;

var apiUrl = "http://pigster.afraid.org/message.json";

display.writeString("*******");

require('daemon')();

function doStuff(){
	//console.log(i.toString());
	request({
		url: apiUrl,
		json: true
	}, function (error, response, body) {
		if (!error && response.statusCode === 200) {
			//console.log(body); // Print the json response
			if (typeof body.message !== 'undefined') {
			    display.writeString(body.message);
			}
		}
		clearTimeout(timer);
		timer = setTimeout(doStuff, 2000);
	});
}

timer = setTimeout(doStuff, 200);