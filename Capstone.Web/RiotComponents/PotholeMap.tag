<potholemap>

    <p>Potato</p>


    <div id="map"></div>


    <style>
        #map {
            width: 400px;
            height: 400px;
            background-color: grey;
        }
    </style>


    <script>

        this.on('mount', () => {
            var uluru = { lat: -25.363, lng: 131.044 };
            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 4,
                center: uluru
            });
            var marker = new google.maps.Marker({
                position: uluru,
                map: map
            });
        });

        
    </script>

    <!--<script async defer
            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAGqdQaGfWElM-VLjnheLyKhRirymgcbPo&callback=initMap">
    </script>-->
    



</potholemap>

