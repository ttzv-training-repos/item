function generate_table(data) {

  const headers = data["headers"];
  const UserData = data["users"];

  var table = document.getElementById("myTable");
  var row = table.insertRow(0);
  var cell1 = row.insertCell(0);
  var cell2 = row.insertCell(1);
  var cell3 = row.insertCell(2);

  cell1.innerHTML = headers.samaccountname;
  cell2.innerHTML = headers.name;
  cell3.innerHTML = headers.whencreated;
  
  for (var i=0; i<= 500; i++) {
    
    var row = table.insertRow(i+1);
    var cell4 = row.insertCell(0);
    var cell5 = row.insertCell(1);
    var cell6 = row.insertCell(2);
    cell4.innerHTML = UserData[i].samaccountname;
    cell5.innerHTML = UserData[i].name;
    cell6.innerHTML = UserData[i].whencreated;
  }


  table.setAttribute("border", "1");
  table.style.backgroundColor = "white";
}