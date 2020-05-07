# coding: utf-8

# 全てfreezeするためのマジックコメント
# frozen_string_literal: true

# 定数を宣言するmodule
module Constants
    EMPTY = ""
    SLASH = "/"
    EQUAL = "="
    USER_ID = "user_id"
    USER_DOC_ID = "doc_id"
    USER_MAIL = "user_mail"
    DATETIME_FORMAT = "%Y-%m-%d %H:%M:%S"
    
    #ページごとのタイトルの定数
    USER_LOGIN_TITLE = "ログインページ"
    USER_ADD_TITLE = "アカウント登録"
    EDIT_TITLE = "編集ページ"
    GROUP_CREATE_TITLE = "グループ作成"
    NOT_ENTERED = "未入力"
    MESSAGE_ID_FIRST_CHAR_G = "G"
    
    # アラートメッセージの定数
    I_001 = "アカウントを作成しました"
    W_001 = "検索されたIDもしくは名前が間違っています"
    W_002 = "IDまたはパスワードが間違っています。"
    W_003 = "空欄、もしくはパスワード（再入力）で同じパスワードが入力されていません。"
    W_004 = "入力いただいたIDはすでに使用されています。"

    # 整数型の定数
    ZERO = 0
end