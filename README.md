# hubot_in_docker
Amazon ECSを利用して、Hubotが動いているdockerコンテナをEC2にデプロイするためのスクリプト群。  

## How to use

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
```
