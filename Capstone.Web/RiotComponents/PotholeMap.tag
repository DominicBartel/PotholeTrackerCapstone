<potholemap>

    <div id="map"></div>


    <script>

        this.on('mount', () => {
            var cleve = { lat: 41.5029693, lng: -81.7173415 };
            var place = { lat: 41.509669, lng: -81.679414 };
            var place2 = { lat: 41.511709, lng: -81.677612 };


            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 13.17,
                center: cleve
            });
            var marker = new google.maps.Marker({
                position: place,
                map: map
            });
            var marker = new google.maps.Marker({
                position: place2,
                map: map
            });
        });

        
    </script>

    <!--<script async defer
            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAGqdQaGfWElM-VLjnheLyKhRirymgcbPo&callback=initMap">
    </script>-->
    



</potholemap>

