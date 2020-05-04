//ユーザ編集画面で画像をcloud firestorageにアップロードする。
//画像を選択と表示
var files = "";
var imageDiv = document.getElementById("edit-image");
var file = document.getElementById("file-input");
var img = document.createElement("img");
var form = document.getElementsByName("edit-form");
var submitBtn = document.getElementById("submit-btn");
var reader = new FileReader();

//画像が選択されるたびにアップロードする。
function fileChange(event){
  var target = event.target;
  files = target.files;
  reader.readAsDataURL(files[0]);
  
}
//画像が読み込まれたときブラウザーに表示する。
function fileLoad(){
  img.src = reader.result
  imageDiv.appendChild(img)
}

function editFormSubmit(){
  //firestorageに画像をアップロード   
  var storageRef = storage.child("image/" + gon.id + "/userimage")
  console.log(typeof reader)
  if(reader.readyState == 2){
      storageRef.put(files[0]).then(function(snapshot){
  })
  }
}

file.addEventListener("change" , fileChange, false);
reader.addEventListener("load" , fileLoad , false);
submitBtn.addEventListener("click" , editFormSubmit , false)