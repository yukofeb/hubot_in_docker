# 要件
# ・毎日定時に天気情報を通知する
# ・通知項目：天気（概要、詳細）、天気アイコン、最高/最低気温、降水確率、湿度
# ・設定項目：通知時刻、地域
# 　設定されていない場合は設定するよう通知する

cronJob = require('cron').CronJob

module.exports = (robot) ->

  informWeather = ->
    # date
    d = new Date
    year = d.getFullYear()
    month = d.getMonth() + 1
    date = d.getDate()
    # city
    city = "Atlanta"
    nation = "US"

    robot.http("http://api.openweathermap.org/data/2.5/weather?units=metric&q=#{city},#{nation}")
      .get() (err, res, body) ->
        data = JSON.parse body
        envelope = room: "general"
        robot.send envelope, "【天気予報】(#{year}/#{month}/#{date})\n今日の天気は#{data.weather[0].main}(#{data.weather[0].description})。\n気温は#{data.main.temp}度(最高#{data.main.temp_max}度、最低#{data.main.temp_min}度)。"
  
  weathercron = new cronJob(
    cronTime: "00 00 06 * * *"
    onTick: ->
      informWeather()
    start: true
    timeZone: "America/New_York"
  )
  weathercron.start()
