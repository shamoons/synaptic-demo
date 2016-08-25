synaptic = require 'synaptic'

{Neuron} = synaptic
{Layer} = synaptic
{Network} = synaptic

inputLayer = new Layer 2
hiddenLayer = new Layer 2
outputLayer = new Layer 1

myNetwork = new Network
  input: inputLayer
  hidden: [hiddenLayer]
  output: outputLayer


inputLayer.project hiddenLayer
hiddenLayer.project outputLayer

learningRate = 0.3

trainingData = [
  [0, 0, 0]
,
  [0, 1, 1]
,
  [1, 0, 1]
,
  [1, 1, 0]
]

cnt = 0
trainingIterations = 1000
while cnt++ < trainingIterations
  trainingData.forEach (data) ->
    myNetwork.activate [data[0], data[1]]
    myNetwork.propagate learningRate, [data[2]]

test1 = myNetwork.activate [0, 0]
test2 = myNetwork.activate [0, 1]
test3 = myNetwork.activate [1, 0]
test4 = myNetwork.activate [1, 1]

console.log test1
console.log test2
console.log test3
console.log test4