var img = document.getElementById("image");
var imageDiv = document.getElementById("img-div")
 

    img.addEventListener("load" , () => {
        var mypageImg = document.getElementById("mypage-image");
        if(mypageImg != null){
            mypageImg.src = img.src
        }
    });


imageDiv.addEventListener("load" , printImage(imageDiv.getAttribute("data-userid") , img) , false);
