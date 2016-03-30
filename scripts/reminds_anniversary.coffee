# 要件
# ・記念日の当日と前日にその情報を通知する
# ・通知項目：記念日、日付、コメント
# ・通知項目のリストは別ファイルにまとめてそれを読み込む

cronJob = require('cron').CronJob

config =
  file_name: anniversaries.json

module.exports = (robot) ->

  remindsAnniversary = ->
    # date
    d = new Date
    year = d.getFullYear()
    month = d.getMonth() + 1
    date = d.getDate()
    envelope = room: "general"
    robot.send envelope, "${month}/${date}"

#    jQuery ->
#      $.get("${config.file_name}"), null, (data)=>
#        for obj in data
#          envelope = room: "general"
#          robot.send envelope, "#{obj}['name']"

  anniversarycron = new cronJob(
    cronTime: "00 * * * * *"
    onTick: ->
      remindsAnniversary()
    start: true
    timeZone: "America/New_York"
  )
  anniversarycron.start()
