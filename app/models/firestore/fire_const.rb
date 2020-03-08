# coding: utf-8

# 全てfreezeするためのマジックコメント
# frozen_string_literal: true

# 定数を宣言するmodule
module FireConst
    FIRESTORE_JSON_PATH = "#{Rails.root.to_s}/config/firestoreKey/firebase-auth.json"
    FIRE_ID = "project_id"
    FIRE_COL_USERS = "users"
    FIRE_COL_FIRENDS = "friends"
    FIRE_COL_MYGROUP = "mygroup"
    FIRE_COL_GROUP = "groups"
    FIRE_COL_TIMELINE = "timeline"
    FIRE_COL_MEMBER = "members"
    FIRE_DOC_NAME = "name"
    FIRE_DOC_USER_ID = "userid"
    FIRE_DOC_USER_PASS = "password"
    FIRE_DOC_USER_NAME = "username"
    FIRE_DOC_USER_FRIEND_ID = "friendid"
    FIRE_DOC_USER_FRIEND_NAME = "friendname"
    FIRE_DOC_GROUP_ID = "groupid"
    FIRE_DOC_GROUP_NAME = "groupname"
    FIRE_DOC_GROUP_MEMBER_ID = "memberid"
end