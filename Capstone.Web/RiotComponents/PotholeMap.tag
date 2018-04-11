<potholemap>
    <!--<input onclick="{deleteMarkers}" type=button value="Delete Markers">-->

    <div id="map"></div>


    <script>

        this.potholes = [];
        var markers = [];
        this.map;
        var centerLocation = { lat: 41.504745, lng: -81.677486};

        this.on('mount', () => {
            

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
                getCenter();
                //map.center = centerLocation;
            });
            
            

            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 13.17,
                center: centerLocation
            });

        });

        function getCenter() {
            var lattitude = 0;
            var longattitude = 0;
            for (i = 0; i > markers.length; i++) {
                lat += markers[i].Longitude;
                lng += markers[i].Latitude;
            }
            centerLocation = { lat: lattitude / markers.length, lng: longattitude / markers.length };
        }

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

