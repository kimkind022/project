var mapContainer = document.getElementById('map'), // 지도를 표시할 div
mapOption = {
	center : new kakao.maps.LatLng(37.5666805, 126.9784147),
	level : 13
};

var map = new kakao.maps.Map(mapContainer, mapOption);

	
// 위치 select 변경 시 지도 좌표+줌 변경
$(document).ready(function() {
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	var clusterer = new kakao.maps.MarkerClusterer({
        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
        minLevel: 10 // 클러스터 할 최소 지도 레벨 
    });
	// hidden에 저장된 값으로 마커 찍기
	$('input[name=marker]').each(function(index,item){
		geocoder.addressSearch(this.value, function(result, status) {
		     if (status === kakao.maps.services.Status.OK) {
	
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords,
		        });
		        clusterer.addMarker(marker);
		    } 
		});
	});    
	
	
	$('#sido_code').change(function() {
		var sidoVal = $("#sido_code option:checked").text();

		// 주소로 좌표 검색
		geocoder.addressSearch(sidoVal, function(result, status) {
			if (status === kakao.maps.services.Status.OK) {
				var coords = new kakao.maps.LatLng(result[0].y, result[0].x); //좌표값
				map.setCenter(coords); //지도 중심 이동
				map.setLevel(10);	// 지도 확대
				
			}
		});
	});
	$('#sigoon_code').change(function() {
		var sidoVal = $("#sido_code option:checked").text();
		var sigoonVal = $("#sigoon_code option:checked").text();

		geocoder.addressSearch(sidoVal+" "+sigoonVal, function(result, status) {
			if (status === kakao.maps.services.Status.OK) {
				var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
				map.setCenter(coords);
				map.setLevel(7);
			}
		});
	});
	$('#dong_code').change(function() {
		var sidoVal = $("#sido_code option:checked").text();
		var sigoonVal = $("#sigoon_code option:checked").text();
		var dongVal = $("#dong_code option:checked").text();

		geocoder.addressSearch(sidoVal+" "+sigoonVal+" "+dongVal, function(result, status) {
			if (status === kakao.maps.services.Status.OK) {
				var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
				map.setCenter(coords);
				map.setLevel(5);
			}
		});
	});
	
	
});

