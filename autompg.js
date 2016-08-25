var _ = require('lodash');
var synaptic = require('synaptic');
var fs = require('fs');

var Layer = synaptic.Layer;
var Network = synaptic.Network;

var inputLayer = new Layer(23);
var hiddenLayer = new Layer(46);
var outputLayer = new Layer(1);
inputLayer.project(hiddenLayer);
hiddenLayer.project(outputLayer);
var myNetwork = new Network({
  input: inputLayer,
  hidden: [hiddenLayer],
  output: outputLayer
});
var learningRate = 0.3;
var cnt = 0;
var trainingIterations = 10000;

fs.readFile('./data/autompg.txt', 'utf-8', function(err, data) {
  var lines = data.split('\n');
  var lines = _.without(lines, '');
  var autoData = _.map(lines, function(line) {
    return line.split(',');
  });

  autoData = _.map(autoData, function(data) {
    var input, output;
    output = data[0] / 100; // Scale MPG with a max of 100

    // 1 4 cylinder
    // 2 6 cylinder
    // 3 8 cylinder
    // 4 Scaled Displacement with a max of 500
    // 5 Scaled horsepower with a max of 500
    // 6 Scaled weight with a max of 5000
    // 7 Scaled acceleration with a max of 25
    // 8 Model Year 1970
    // 9 Model Year 1971
    // 10 Model Year 1972
    // 11 Model Year 1973
    // 12 Model Year 1974
    // 13 Model Year 1975
    // 14 Model Year 1976
    // 15 Model Year 1977
    // 16 Model Year 1978
    // 19 Model Year 1979
    // 20 Model Year 1980
    // 21 Model Year 1981
    // 22 Model Year 1982
    // 23 Origin American
    // 24 Origin European
    // 25 Origin Asian
    input = [parseInt(data[1]) === 4 ? 1 : 0, parseInt(data[1]) === 6 ? 1 : 0, parseInt(data[1]) === 8 ? 1 : 0, data[2] / 500, data[3] / 500, data[4] / 5000, data[5] / 25, parseInt(data[6]) === 70 ? 1 : 0, parseInt(data[6]) === 71 ? 1 : 0, parseInt(data[6]) === 72 ? 1 : 0, parseInt(data[6]) === 73 ? 1 : 0, parseInt(data[6]) === 74 ? 1 : 0, parseInt(data[6]) === 75 ? 1 : 0, parseInt(data[6]) === 76 ? 1 : 0, parseInt(data[6]) === 77 ? 1 : 0, parseInt(data[6]) === 78 ? 1 : 0, parseInt(data[6]) === 79 ? 1 : 0, parseInt(data[6]) === 80 ? 1 : 0, parseInt(data[6]) === 81 ? 1 : 0, parseInt(data[6]) === 82 ? 1 : 0, parseInt(data[7]) === 1 ? 1 : 0, parseInt(data[7]) === 2 ? 1 : 0, parseInt(data[7]) === 3 ? 1 : 0];
    return [input, output];
  });

  var trainingData = _.sampleSize(autoData, 10);
  while (cnt++ < trainingIterations) {
    trainingData.forEach(function(data) {
      myNetwork.activate(data[0]);
      return myNetwork.propagate(learningRate, [data[1]]);
    });
  }
  var testData = _.sample(autoData);
  var results = myNetwork.activate(testData[0]);

  console.log("Networks Results", results);
  console.log("Actual Results", testData[1]);
});
