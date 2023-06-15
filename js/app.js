var check=document.querySelector(".check");
check.addEventListener("click", idioma);
let signUp= document.getElementById("signUp");
let signIn=document.getElementById("signIn");
let nombresImput=document.getElementById("nombresImput");
let botons=document.getElementById("botons");

signIp.onclick = function(){
    nombresImput.style.maxHeight = "0";
    botons.innerHTML = "Login";
    signUp.classList.add("disable");
    signIn.classList.remove("disable");
}
signUp.onclick = function(){
    nombresImput.style.maxHeight = "0";
    botons.innerHTML = "Registro";
    signUp.classList.remove("disable");
    signIn.classList.add("disable");
}
function idioma() {
    let id=check.checked;
    if (id==true) {
        location.href="es/index.html";
    }

    else {
        location.href="../index.html";
        }
   
}


