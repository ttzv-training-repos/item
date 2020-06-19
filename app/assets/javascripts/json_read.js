function requestUserData(){
  
   $.get( "http://10.0.1.117:3000/item/ad_users/all", function( data ) {generate_table(data); console.log(data)}, "json")
}