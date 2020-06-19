function generate_table(data) {
  var table = document.getElementById("myTable");
  if(row >0){
    const headers = data["headers"];
    const UserData = data["users"];

    
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
  }
  else{
    alert("You already requested data!"+ "\n" +"Refresh site to do it again");
  }

  table.setAttribute("border", "1");
  table.style.backgroundColor = "white";
}
/*
function betterTableGen(){
  $(document).ready( function () {
    $('myTable').DataTable({
      "ajax": "http://10.0.1.117:3000/item/ad_users/all",
      "columns" : [
        {"users":  "samacountname"},
        {"users":  "samacountname"},
        {"users":  "samacountname"}
      ]
    });
  } );
}
*/
