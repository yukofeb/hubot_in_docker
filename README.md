# hubot_in_docker
Amazon ECSを利用して、Hubotが動いているdockerコンテナをEC2にデプロイするためのスクリプト群。  

## How to use
[Amazon ECSを使ってhubotが動いているdockerコンテナをEC2へ自動デプロイする - yukofebの日記](http://yukofeb.hatenablog.com/entry/2016/03/26/120732)  

## Tools
[CircleCI](https://circleci.com/gh/yukofeb/hubot_in_docker)  
[dockerhub](https://hub.docker.com/r/yukofeb/hubot_in_docker/)  

## References
[Weather API](http://openweathermap.org/api)  

## Memo

### Required environment variables in CircleCI
利用の際にはあらかじめ以下の環境変数をCircleCIの設定画面で入力する必要がある。  

```
AWS_ACCESS_KEY_ID : AWSのアクセスキーID
AWS_REGION : AWSのリージョン
AWS_SECRET_ACCESS_KEY : AWSのシークレットアクセスキー
DOCKER_EMAIL : dockerhubのemail
DOCKER_PASS : dockerhubのパスワード
DOCKER_USER : dockerhubのユーザー名
HUBOT_SLACK_TOKEN : SlackとHubotを連携するためのトークン(Slack Integration設定画面から取得可能)
HUBOT_WEATHER_APPID : OpenWeatherMap(http://openweathermap.org/api)のAppID
```

