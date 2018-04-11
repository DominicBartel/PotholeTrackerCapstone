<searchbar>
  
  <button onclick="{myFunction}">Advanced Search</button>
  
  <div id="advancedSearch">
    <p>DO SOMETHING NOW YOU SOMETHING SOMETHING SOMETHING!!!!!!</p>
      </div>

      <script>
        
        this.myFunction = function(){
        var x = document.getElementById("advancedSearch");
        if (x.style.display === "none") {
        x.style.display = "block";
        } else {
        x.style.display = "none";
        }
        }
        
  
        <!--this.potholes = [];

        this.on('mount', () => {
            
            fetch('http://localhost:55900/api/potholes')
                .then(response => response.json())
                .then(json => {
                    this.potholes = json;
                })
                .then(potholes => {
                    for (i = 0; i < this.potholes.length; i++) {
                        console.log(this.potholes[i].UserName)
               
            });-->
       
    </script>
 
</searchbar>