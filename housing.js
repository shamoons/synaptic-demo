var _ = require('lodash');
var synaptic = require('synaptic');
var fs = require('fs');

var Architect = synaptic.Architect;
var Trainer = synaptic.Trainer;

var myNetwork = new Architect.Perceptron(12, 20, 1);
var trainer = new Trainer(myNetwork);

fs.readFile('./data/housing.csv', 'utf-8', function(err, fileData) {
  var lines = _.without(fileData.split('\r'), '');
  var housingData = _.map(lines, function(line) {
    var data = line.split(',');
    var input = [
      data[0] / 100,
      data[1] / 100,
      data[2] / 50,
      Number(data[3]),
      Number(data[4]),
      data[5] / 10,
      data[6] / 100,
      data[7] / 10,
      data[8] / 25,
      data[9] / 1000,
      data[10] / 25,
      data[11] / 50
    ];

    var output = data[12] / 50;

    return {
      input: input,
      output: [output]
    }
  });

  var trainingData = _.sampleSize(housingData, 200);

  trainer.train(trainingData, {
    rate: .3,
    iterations: 50000,
    error: .0005,
    shuffle: true,
    log: 5000
  });

  var testThis = _.sample(housingData);
  var result = myNetwork.activate(testThis.input);
  console.log("SkyNet: ", result);
  console.log("Real Life: ", testThis.output);
});
