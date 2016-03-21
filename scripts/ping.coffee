module.exports = (robot) ->

  robot.hear /ping/, (res) ->
    res.send "pong"
