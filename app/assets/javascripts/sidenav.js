function navHandler(){
  if(!x.matches){
    openNav();
  }
  else{
    openNavOnCondition();
  }
}

function openNav() {
  var e = document.getElementById("mySidenav")
  var d = document.getElementById("main")
  var c = document.getElementById("icon")

  //  Instead originaly changing the width value we change the left property of the sidebar to be positioned outside of the canvas leaving its original width
  if (e.style.left == '0%')
  {
      e.style.left = '-23%';
      d.style.marginLeft = "2%";
      c.innerHTML = "&#xf067;";   //here we change the icon displayed on the button  
  }
  else 
  {
    e.style.left = '0%';
    d.style.marginLeft = "25%";
    c.innerHTML = "&#xf00d;";
  }

}
function openNavOnCondition(){
  var e = document.getElementById("mySidenav")
  var d = document.getElementById("main")
  var c = document.getElementById("icon")

  if (e.style.left == '0%')
  {
    e.style.left = '-25%';
    d.style.marginLeft = "0%";
    c.innerHTML = "&#xf067;";
  }
  else 
  {
    e.style.left = '0%';
    d.style.marginLeft = "25%";
    c.innerHTML = "&#xf00d;";  
  }
}
function hideNav(){
  var e = document.getElementById("mySidenav")
  var d = document.getElementById("main")
  
  if(x.matches){
      e.style.left = '-25%';
      d.style.marginLeft = "0%";
  }
  else{
    e.style.left = '-23%';
    d.style.marginLeft = "2%";
  }
}

var x = window.matchMedia("(max-width: 1200px)")
x.addListener(hideNav)