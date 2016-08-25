var synaptic = require('synaptic');
var fs = require('fs');

var Architect = synaptic.Architect;
var Trainer = synaptic.Trainer;

var myNetwork = new Architect.Perceptron(13, 20, 1);
var trainer = new Trainer(myNetwork);

fs.readFile('./data/housing.csv', 'utf-8', function(err, fileData) {
  var lines = fileData.split('\r');
  var housingData = _.map(lines, function(line) {
    
  });
});
