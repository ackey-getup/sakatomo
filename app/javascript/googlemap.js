let map
let geocoder
// 下の1行を追加 
const display = document.getElementById('display')

function initMap(){
  geocoder = new google.maps.Geocoder()

  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 35.9031054, lng:139.7175976},
    zoom: 12,
  });

  marker = new google.maps.Marker({
    position:  {lat: 35.9031054, lng:139.7175976},
    map: map
  });
}

function codeAddress(){
  let inputAddress = document.getElementById('address').value;

  geocoder.geocode( { 'address': inputAddress}, function(results, status) {
    if (status == 'OK') {
      map.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
      });
      // 下の1行を追加 
      display.textContent = "検索結果：" + results[ 0 ].geometry.location
    } else {
      alert('該当する結果がありませんでした：' + status);
    }
  });   
}