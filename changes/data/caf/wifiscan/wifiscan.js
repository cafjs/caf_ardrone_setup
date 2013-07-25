#!/usr/bin/env node
var carrier = require('carrier')
var spawn = require('child_process').spawn;
var scan = spawn(__dirname + '/scan.sh')
var output = {};
carrier.carry(scan.stdout, function(line) {
    var tuple = line.split(' ');
    output[tuple[0]] = parseInt(tuple[1]);
//console.log(JSON.stringify(output));
 });
        
scan.stdout.on('end', function() {
           console.log(JSON.stringify(output));
});
