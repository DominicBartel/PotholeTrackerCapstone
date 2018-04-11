<potholemap>
    <!--<input onclick="{deleteMarkers}" type=button value="Delete Markers">-->

    <div id="map"></div>


    <script>

        this.potholes = [];
        var markers = [];
        this.map;

        this.on('mount', () => {
            var cleve = { lat: 41.5029693, lng: -81.7173415 };

            //fetch('http://localhost:55900/api/potholes')
            //    .then(response => response.json())
            //    .then(json => {
            //        this.potholes = json;
            //        this.opts.bus.trigger('searchresult', json)
            //    })
            //    .then(potholes => {
            //        for (let i = 0; i < this.potholes.length; i++) {
            //            console.log(this.potholes[i].LocationDesc)
            //            var latlng = { lat: this.potholes[i].Latitude, lng: this.potholes[i].Longitude };
            //            var marker = new google.maps.Marker({
            //                position: latlng,
            //                map: map
            //            });
            //            markers.push(marker);
            //        }
            //    })

            this.opts.bus.on('searchresult', data => {
                this.potholes = data;
                console.log(data);
                clearMarkers();

                for (let i = 0; i < this.potholes.length; i++) {
                    console.log(this.potholes[i].LocationDesc)
                    var latlng = { lat: this.potholes[i].Latitude, lng: this.potholes[i].Longitude };
                    var marker = new google.maps.Marker({
                        position: latlng,
                        map: map
                    });
                    markers.push(marker);
                }

            });


            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 13.17,
                center: cleve
            });
        });

        function setMapOnAll(map) {
            for (var i = 0; i < markers.length; i++) {
                markers[i].setMap(map);
            }
        }

        function clearMarkers() {
            setMapOnAll(null);
        }

        //function deleteMarkers() {
        //    //console.log('deletemarkers');
        //    clearMarkers();
        //    markers = [];
        //}


    </script>

    <!--<script async defer
            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAGqdQaGfWElM-VLjnheLyKhRirymgcbPo&callback=initMap">
    </script>-->




</potholemap>

