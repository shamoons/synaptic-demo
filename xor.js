var synaptic = require('synaptic');
var Layer = synaptic.Layer;
var Network = synaptic.Network;

var inputLayer = new Layer(2);
var hiddenLayer = new Layer(2);
var outputLayer = new Layer(1);

inputLayer.project(hiddenLayer);
hiddenLayer.project(outputLayer);

var myNetwork = new Network({
  input: inputLayer,
  hidden: [hiddenLayer],
  output: outputLayer
});

var learningRate = 0.3;

var trainingData = [
  [0, 0, 0],
  [0, 1, 1],
  [1, 0, 1],
  [1, 1, 0]
];

var cnt = 0;

var trainingIterations = 20000;

while (cnt++ < trainingIterations) {
  trainingData.forEach(function(data) {
    myNetwork.activate([data[0], data[1]]);
    return myNetwork.propagate(learningRate, [data[2]]);
  });
}

var test1 = myNetwork.activate([0, 0]);
var test2 = myNetwork.activate([0, 1]);
var test3 = myNetwork.activate([1, 0]);
var test4 = myNetwork.activate([1, 1]);

console.log(test1);
console.log(test2);
console.log(test3);
console.log(test4);


// console.log(myNetwork.toJSON());
