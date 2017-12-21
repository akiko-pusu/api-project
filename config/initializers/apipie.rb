Apipie.configure do |config|
  # ドキュメントのタイトル
  config.app_name = "API Document"
  config.api_base_url["public"] = ""
  config.doc_base_url = "/apipie"
  config.default_locale = "ja"
  # where is your API defined?
  config.api_controllers_matcher = Rails.root.join('app', 'controllers', '**', '*.rb')
  config.default_version = "public"

  # ドキュメントのlocalize
  config.languages = %w[en ja]
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

    Not implemented:

        { "errors": 
          { 
            "message": "ビジネスロジックのエラーです", 
            "code": 1001 
          }
        }
  API_DOC
end
