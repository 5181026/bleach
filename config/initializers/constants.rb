# coding: utf-8

# 全てfreezeするためのマジックコメント
# frozen_string_literal: true

# 定数を宣言するmodule
module Constants
    FIRESTORE_JSON_PATH = "#{Rails.root.to_s}/config/firestoreKey/firebase-auth.json"
    FIRE_COL_USERS = "users"
end