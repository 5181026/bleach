var firebaseConfig = {
    apiKey: "AIzaSyCT7Ty0fCd-HVxPChBRXuohUibMaIwKXXQ",
    authDomain: "railssample5181026.firebaseapp.com",
    databaseURL: "https://railssample5181026.firebaseio.com",
    projectId: "railssample5181026",
    storageBucket: "railssample5181026.appspot.com",
    messagingSenderId: "892558366428",
    appId: "1:892558366428:web:b5acf0eb51722f0b388619"
  };

if (!firebase.apps.length) {
  firebase.initializeApp(firebaseConfig);
}

var db = firebase.firestore();
var storage = firebase.storage().ref();