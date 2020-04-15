//ログアウトした後にブラウザーバックできないようにする。
$(function(){
    // 自身のページを履歴に追加
    history.pushState(null, null, null);
    // ページ戻り時にも自身のページを履歴に追加
    $(window).on("popstate", function(){
        history.pushState(null, null, null);
        alert("前のページには戻れません")
    });
});