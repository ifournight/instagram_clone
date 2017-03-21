# 指定 I18n 库搜索翻译文件的路径
I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*{.rb, .yml}')]

# 手动安装zh-CN
I18n.available_locales = [:en, 'zh-CN']

# 修改默认区域配置（默认是 :en)
I18n.default_locale = :en
