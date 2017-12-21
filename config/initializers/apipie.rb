Apipie.configure do |config|

  # ドユメントのコピーライト（画面左下に表示されます）
  config.copyright = '&copy; 2017 Sample Copyright'

  # ドキュメントのタイトル
  config.app_name = 'API Document'
  config.api_base_url['public'] = ''
  config.doc_base_url = '/apipie'
  config.default_locale = 'ja'

  # apiに該当するコントローラーのソースの場所
  config.api_controllers_matcher = Rails.root.join('app', 'controllers', '**', '*.rb')
  config.default_version = 'public'

  # ドキュメントのローカライズ
  # /apipie/public/users.ja.html, /apipie/public/users.en.html といった
  # URLでドキュメントが提示されます
  config.languages = %w[en ja]

  # ローカライズの必要がない場合は、コメントインします
  # config.translate = false

  # マークアップの形式 (Markdown, RDoc, Textileが利用できます)
  # http://www.rubydoc.info/github/Apipie/apipie-rails/Apipie/Markup
  config.markup = Apipie::Markup::Markdown.new
  config.app_info['public'] = <<-API_DOC
    ### APIエンドポイント

    * http://localhost:3000/

    ### データフォーマット

    * json形式

    ### エラーレスポンス

    * まだ実装していませんので、サンプル。

        { "errors":
          {
            "message": "ビジネスロジックのエラーです",
            "code": 1001
          }
        }
  API_DOC
end
