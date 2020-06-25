function topbarShow() {
    var x = document.getElementById("icon");
    if (x.style.display === "block") {
      x.style.display = "none";
    } else {
      x.style.display = "block";
    }
  }
function popupCart(){
    var a = document.getElementById("cart");
    if (a.style.display === "block") {
        a.style.display = "none";
      } else {
        a.style.display = "block";
      }
}
function showCart() {
  document.getElementById("cart").classList.toggle("show");
}

// Close the dropdown menu if the user clicks outside of it
window.onclick = function(event) {
  if (!event.target.matches('.cartBtn')) {
    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}