#https://archive.ics.uci.edu/ml/machine-learning-databases/auto-mpg/

_ = require 'lodash'
synaptic = require 'synaptic'
fs = require 'fs'

{Neuron} = synaptic
{Layer} = synaptic
{Network} = synaptic

fs.readFile './data/autompg.txt', 'utf-8', (err, data) ->
  lines = data.split '\n'
  lines = _.without lines, ''
  autoData = _.map lines, (line) ->
    dataPoints = line.split ','

  autoData = _.map autoData, (data) ->
    output = data[0] / 100                   # 0 Scale MPG with a max of 100
    input = [
1 4 cylinder
2 6 cylinder
3 8 cylinder
4 Scaled Displacement with a max of 500
5 Scaled horsepower with a max of 500
6 Scaled weight with a max of 5000
7 Scaled acceleration with a max of 25
8 Model Year 1970
9 Model Year 1971
10 Model Year 1972
11 Model Year 1973
12 Model Year 1974
13 Model Year 1975
14 Model Year 1976
15 Model Year 1977
16 Model Year 1978
19 Model Year 1979
20 Model Year 1980
21 Model Year 1981
22 Model Year 1982
23 Origin American
24 Origin European
25 Origin Asian
    ]

    [input, output]

  # console.log autoData
  trainingData = _.sampleSize autoData, 10

    # 1. mpg:           continuous
    # 2. cylinders:     multi-valued discrete
    # 3. displacement:  continuous
    # 4. horsepower:    continuous
    # 5. weight:        continuous
    # 6. acceleration:  continuous
    # 7. model year:    multi-valued discrete
    # 8. origin:        multi-valued discrete
    # 9. car name:      string (unique for each instance)

  inputLayer = new Layer 23
  hiddenLayer = new Layer 46
  outputLayer = new Layer 1

  inputLayer.project hiddenLayer
  hiddenLayer.project outputLayer

  myNetwork = new Network
    input: inputLayer
    hidden: [hiddenLayer]
    output: outputLayer

  learningRate = 0.3

  cnt = 0
  trainingIterations = 10000
  while cnt++ < trainingIterations
    trainingData.forEach (data) ->
      myNetwork.activate data[0]
      myNetwork.propagate learningRate, [data[1]]

  testData = _.sample autoData

  results = myNetwork.activate testData[0]
  console.log "Networks Results", results
  console.log "Actual Results", testData[1]
