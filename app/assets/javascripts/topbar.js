function topbarShow() {
  var x = document.getElementById("myTopnav");
  if (x.className === "topnav") {
    x.className += " responsive";
  } else {
    x.className = "topnav";
  }
}

function showCart() {
  let cart = document.getElementById("cart");
  cart.classList.toggle("show");
}

// Close the dropdown menu if the user clicks outside of it
/*
window.onclick = function(event) {
  if (!event.target.matches('.cartBtn')) {
    var dropdowns = document.getElementsByClassName("cart-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}
*/