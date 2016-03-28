# 要件
# ・毎日定時に天気情報を通知する
# ・通知項目：天気（概要、詳細）、天気アイコン、最高/最低気温、降水確率、湿度
# ・設定項目：通知時刻、地域
# 　設定されていない場合は設定するよう通知する

cronJob = require('cron').CronJob

config =
  appid: process.env.HUBOT_WEATHER_APPID

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

    robot.http("http://api.openweathermap.org/data/2.5/weather?units=metric&q=#{city},#{nation}&APPID=#{config.appid}")
      .get() (err, res, body) ->
        data = JSON.parse body
        envelope = room: "general"
        robot.send envelope, "【Today's Weather Forecast】(#{year}/#{month}/#{date})\nToday's weather is #{data.weather[0].main}(#{data.weather[0].description}).\nTemperature is #{data.main.temp} ℃.\n((Maximum: #{data.main.temp_max}℃, Minimum: #{data.main.temp_min}℃)\nhttp://openweathermap.org/img/w/#{data.weather[0].icon}.png"
  
  weathercron = new cronJob(
    cronTime: "00 00 06 * * *"
    onTick: ->
      informWeather()
    start: true
    timeZone: "America/New_York"
  )
  weathercron.start()
