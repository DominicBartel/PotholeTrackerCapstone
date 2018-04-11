<searchbar>
  
  <button onclick="myFunction()">Advanced Search</button>
  
  <div id="advancedSearch">

      </div>

      <script>
        function myFunction(){
        var x = document.getElementById("advancedSearch");
        if (x.style.display === "none") {
        x.style.display = "block";
        } else {
        x.style.display = "none";
        }
        }
        
  


        this.potholes = [];

        this.on('mount', () => {
            
            fetch('http://localhost:55900/api/potholes')
                .then(response => response.json())
                .then(json => {
                    this.potholes = json;
                })
                .then(potholes => {
                   
                    }
                })

            });
        });


 let bus = {};

        riot.observable(bus);   //makes it so our bus can send and receive messages

        // Mount the riot tags to the page here 
        
        riot.mount('movie-search', {bus: bus});
        riot.mount('movie-list', {bus: bus});

    </script>
 
</searchbar>