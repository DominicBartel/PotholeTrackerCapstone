<potholemap>

    <div id="map"></div>


    <script>

        this.potholes = [];

        this.on('mount', () => {
            var cleve = { lat: 41.5029693, lng: -81.7173415 };
            
            fetch('http://localhost:55900/api/potholes')
                .then(response => response.json())
                .then(json => {
                    this.potholes = json;
                })
                .then(potholes => {
                    for (let i = 0; i < this.potholes.length; i++) {
                        console.log(this.potholes[i].LocationDesc)
                        var latlng = { lat: this.potholes[i].Latitude, lng: this.potholes[i].Longitude };
                        var marker = new google.maps.Marker({
                            position: latlng,
                            map: map
                        });
                    }
                })

           

            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 13.17,
                center: cleve
            });
        });


    </script>

    <!--<script async defer
            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAGqdQaGfWElM-VLjnheLyKhRirymgcbPo&callback=initMap">
    </script>-->




</potholemap>

