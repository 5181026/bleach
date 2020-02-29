# coding: utf-8

# 全てfreezeするためのマジックコメント
# frozen_string_literal: true

# 定数を宣言するmodule
module FireConst
    FIRESTORE_JSON_PATH = "#{Rails.root.to_s}/config/firestoreKey/firebase-auth.json"
    FIRE_ID = "project_id"
    FIRE_COL_USERS = "users"
    FIRE_COL_FIRENDS = "friends"
    FIRE_COL_MYGROUP = "myGroup"
    FIRE_COL_GROUP = "group"
    FIRE_COL_TIMELINE = "timeline"
    FIRE_DOC_NAME = "name"
end