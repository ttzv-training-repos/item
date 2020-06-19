function generate_table() {

  var table = document.getElementById("myTable");
  var row = table.insertRow(0);
  var cell1 = row.insertCell(0);
  var cell2 = row.insertCell(1);
  var cell3 = row.insertCell(2);

  cell1.innerHTML = "new cell1";
  cell2.innerHTML = "new cell2";
  cell3.innerHTML = "new cell3";

  table.setAttribute("border", "1");
  table.style.backgroundColor = "lightgrey";
}