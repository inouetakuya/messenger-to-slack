Messenger to Slack
==================

[![CircleCI](https://circleci.com/gh/inouetakuya/messenger-to-slack.svg?style=svg)](https://circleci.com/gh/inouetakuya/messenger-to-slack)

Convert message.json of Facebook Messenger to CSV file to import to Slack

## Requirements

* Ruby 2.5.1

## Setup

```
bundle install --path vendor/bundle
```

## Usage

### Step 1. Export message.json from Facebook

### English

TODO ...

### Japanese

* 「設定」>「あなたの Facebook 情報」>「個人データをダウンロード」
* 「メッセージ / Messenger 上で他の人と送受信したメッセージ」にチェック
* フォーマット「JSON」を選択して「ファイルを作成」
* ファイルをダウンロード（ZIP）
* 解凍したディレクトリの中に `message.json` が入っている

### Step 2. Add message.json

* Add message.json to tmp/

### Step 3. Convert to CSV

```
bundle exec thor task:message:convert
```

### Step 4. Import CSV to Slack

Access to [https://my.slack.com/services/import/csv](https://my.slack.com/services/import/csv)

## Debugging

```
bundle exec pry
```

## Testing

```
bundle exec rspec
```
