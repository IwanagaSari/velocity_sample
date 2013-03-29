# Google SpreadSheetサンプル

[google-drive-ruby](https://github.com/gimite/google-drive-ruby)を利用してアクセスするサンプルです

## Client ID、Client secret取得

OAuth2.0を利用してアクセスする準備です

[API console](https://code.google.com/apis/console)にアクセスしてClient IDとClient secretを取得する

1. 左側の「API Access」リンクをクリックして、右側の「Create an OAuth 2.0 client Id...」ボタンを押す
2. Product Nameを入力して、「Next」ボタンを押す
3. Application Typeを「Installed application」、Installed application typeを「Other」にして「Create client ID」ボタンを押す
4. Client ID for installed applicationsに「Client ID」、「Client Secret」、「Redirect URIs」が表示されている

## アクセストークン（access_token）取得

[google-drive-rubyの説明](http://gimite.net/doc/google-drive-ruby/GoogleDrive.html)をやるだけなので、これでわかる人はもうおしまいです

gemをインストールします

```bash
$ bundle install --path vendor/bundle
Fetching gem metadata from https://rubygems.org/..........
Fetching gem metadata from https://rubygems.org/..
Resolving dependencies...
Installing multipart-post (1.2.0)
Installing faraday (0.8.7)
Installing nokogiri (1.5.9)
Installing oauth (0.4.7)
Installing httpauth (0.2.0)
Installing multi_json (1.7.2)
Installing jwt (0.1.8)
Installing multi_xml (0.5.3)
Installing rack (1.5.2)
Installing oauth2 (0.9.1)
Installing google_drive (0.3.5)
Using bundler (1.3.4)
Your bundle is complete!
It was installed into ./vendor/bundle
```

認証コード（authentication_code）を取得します

以下のコードを実行して出力されたURLにブラウザでアクセスします ※client_id、client_secretは自分のを入力

```ruby
require 'google_drive'

client = OAuth2::Client.new(
  'client_id',
  'client_secret',
  :site => "https://accounts.google.com",
  :token_url => "/o/oauth2/token",
  :authorize_url => "/o/oauth2/auth")

authentication_url = client.auth_code.authorize_url(
    :redirect_uri => 'urn:ietf:wg:oauth:2.0:oob',
    :scope => 'https://spreadsheets.google.com/feeds/')

p authentication_url
```

認証画面で許可すると、認証コード（authentication_code）が表示されますのでそれをコピーします

以下のコードを実行して表示されたアクセストークン（access_token）を取得する ※client_id、client_secret、authentication_codeは自分のを入力

```ruby
# encoding: utf-8

require 'google_drive'

client = OAuth2::Client.new(
  'client_id',
  'client_secret',
  :site => "https://accounts.google.com",
  :token_url => "/o/oauth2/token",
  :authorize_url => "/o/oauth2/auth")

auth_token = client.auth_code.get_token(
  'authentication_code',
  :redirect_uri => 'urn:ietf:wg:oauth:2.0:oob')

p auth_token
```

## SpreadSheetアクセス

あとはgithubのサンプル通りアクセスしてください

spreadsheet_keyはURLに表示されているやつです

```ruby
# encoding: utf-8

require 'google_drive'

session = GoogleDrive.login_with_oauth('access_token')
ws = session.spreadsheet_by_key('spreadsheet_key').worksheets[0]

# 取得
p ws[1, 1]

# 保存
ws[1, 2] = 'いまでしょ'
ws.save
```
