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
      if parseInt(data[1]) is 4 then 1 else 0   # 1 4 cylinder
      if parseInt(data[1]) is 6 then 1 else 0   # 2 6 cylinder
      if parseInt(data[1]) is 8 then 1 else 0   # 3 8 cylinder
      data[2] / 500                   # 4 Scaled Displacement with a max of 500
      data[3] / 500                   # 5 Scaled horsepower with a max of 500
      data[4] / 5000                  # 6 Scaled weight with a max of 5000
      data[5] / 25                    # 7 Scaled acceleration with a max of 25
      if parseInt(data[6]) is 70 then 1 else 0  # 8 Model Year 1970
      if parseInt(data[6]) is 71 then 1 else 0  # 9 Model Year 1971
      if parseInt(data[6]) is 72 then 1 else 0  # 10 Model Year 1972
      if parseInt(data[6]) is 73 then 1 else 0  # 11 Model Year 1973
      if parseInt(data[6]) is 74 then 1 else 0  # 12 Model Year 1974
      if parseInt(data[6]) is 75 then 1 else 0  # 13 Model Year 1975
      if parseInt(data[6]) is 76 then 1 else 0  # 14 Model Year 1976
      if parseInt(data[6]) is 77 then 1 else 0  # 15 Model Year 1977
      if parseInt(data[6]) is 78 then 1 else 0  # 16 Model Year 1978
      if parseInt(data[6]) is 79 then 1 else 0  # 19 Model Year 1979
      if parseInt(data[6]) is 80 then 1 else 0  # 20 Model Year 1980
      if parseInt(data[6]) is 81 then 1 else 0  # 21 Model Year 1981
      if parseInt(data[6]) is 82 then 1 else 0  # 22 Model Year 1982
      if parseInt(data[7]) is 1 then 1 else 0   # 23 Origin American
      if parseInt(data[7]) is 2 then 1 else 0   # 24 Origin European
      if parseInt(data[7]) is 3 then 1 else 0   # 25 Origin Asian
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
