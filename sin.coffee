_ = require 'lodash'
synaptic = require 'synaptic'

{Neuron} = synaptic
{Layer} = synaptic
{Network} = synaptic

inputLayer = new Layer 1
hiddenLayer = new Layer 2
outputLayer = new Layer 1

inputLayer.project hiddenLayer
hiddenLayer.project outputLayer

myNetwork = new Network
  input: inputLayer
  hidden: [hiddenLayer]
  output: outputLayer

learningRate = 0.3

# Function to model: sin(x)
trainingData = []
while trainingData.length < 100
  x = _.random 0, 50, true
  answer = Math.sin x
  trainingData.push [x, answer]

console.log trainingData

cnt = 0
trainingIterations = 10000
while cnt++ < trainingIterations
  trainingData.forEach (data) ->
    myNetwork.activate [data[0]]
    myNetwork.propagate learningRate, [data[1]]

test1 = myNetwork.activate [0.12232]

console.log test1
