var font = require("./font-bitmap.js");

var i2c = require('i2c');
var address = 0x30;
var wire = new i2c(address, {device: '/dev/i2c-0'});


function generateString(input){
	var output = [];
	for(var i = 0; i < input.length && i < 7; i++){
		output.push(font.fontBitmap[input.charCodeAt(i)]);
	}
	return output;
}

exports.writeString = function(input){
	var data = generateString(input);
	var buf = new Buffer(4*7);
	buf.fill(0);
	for(var i = 0;i < data.length;i++){
		buf.writeUInt32LE(data[i],i*4);
	}
	wire.writeBytes(0, buf, function(err) {});
	wire.writeBytes(34, [1], function(err) {});
	//console.log(buf);
};