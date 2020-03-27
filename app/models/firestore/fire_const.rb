# coding: utf-8

# 全てfreezeするためのマジックコメント
# frozen_string_literal: true

# 定数を宣言するmodule
module FireConst
    FIRESTORE_JSON_PATH = "#{Rails.root.to_s}/config/firestoreKey/firebase-auth.json"
    FIRE_ID = "project_id"
    FIRE_COL_USERS = "users"
    FIRE_COL_GROUP = "groups"
    FIRE_COL_MESSAGE = "message"
    FIRE_COL_FIRENDS = "friends"
    FIRE_COL_MYGROUP = "mygroup"
    FIRE_COL_NOTIFICATION = "notification"
    FIRE_COL_TIMELINE = "timeline"
    FIRE_COL_MEMBER = "members"
    FIRE_DOC_NAME = "name"
    FIRE_DOC_USER_ID = "userid"
    FIRE_DOC_USER_PASS = "password"
    FIRE_DOC_USER_NAME = "name"
    FIRE_DOC_USER_FRIEND_ID = "friendid"
    FIRE_DOC_USER_FRIEND_NAME = "friendname"
    FIRE_DOC_NOTIFICATION_POST_ID = "postuserid"
    FIRE_DOC_GROUP_ID = "groupid"
    FIRE_DOC_GROUP_NAME = "groupname"
    FIRE_DOC_GROUP_MEMBER_ID = "memberid"
    FIRE_DOC_MESSAGE_ID = "messageid"
    FIRE_DOC_MESSAGE_CONTENT = "content"

    # 通知を識別するID最初の数字により式罰する
    # フレンド関連は0
    # グループ関連は1
    NOTIFICATION_FRIEND_REQUEST_ID = "001"
    NOTIFICATION_GROUP_JOIN_ID = "101"
end