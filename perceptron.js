var synaptic = require('synaptic');
var Architect = synaptic.Architect;
var Trainer = synaptic.Trainer;

var myNetwork = new Architect.Perceptron(2, 2, 1);
var trainer = new Trainer(myNetwork);

var trainingData = [{
  input: [0, 0],
  output: [0]
}, {
  input: [0, 1],
  output: [1]
}, {
  input: [1, 0],
  output: [1]
}, {
  input: [1, 1],
  output: [0]
}];

trainer.train(trainingData, {
  rate: .3,
  iterations: 50000,
  error: .0000005,
  shuffle: true,
  log: 1000
});

console.log(myNetwork.activate([0, 0]));
console.log(myNetwork.activate([0, 1]));
console.log(myNetwork.activate([1, 0]));
console.log(myNetwork.activate([1, 1]));
