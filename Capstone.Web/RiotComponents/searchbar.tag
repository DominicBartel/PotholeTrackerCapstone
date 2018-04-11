<searchbar>

    <!--<button onclick="{myFunction}">Advanced Search</button>

    <div id="advancedSearch">
      <p>DO SOMETHING NOW YOU SOMETHING SOMETHING SOMETHING!!!!!!</p>
        </div>-->

    <input id="isvalidated" type="hidden" name="IsValidated" value="true" />
    <input id="username" type="text" name="UserName" placeholder="Submitter Username" />
    <input id="street1" type="text" name="Street1" placeholder="On Street" />
    <input id="street2" type="text" name="Street2" placeholder="Neighboring Street" />
    <input id="locationdesc" type="text" name="LocationDesc" placeholder="Location Keyword"  />
    <input id="potholedesc" type="text" name="PotholeDesc" placeholder="Description Keyword"  />
    <input type="button" onclick="{search}" value="SEARCH" />



    <script>


                        //this.myFunction = function(){
                        //var x = document.getElementById("advancedSearch");
                        //if (x.style.display === "none") {
                        //x.style.display = "block";
                        //} else {
                        //x.style.display = "none";
                        //}
                        //}


                        //<!--this.potholes = [];

                        //this.on('mount', () => {

                        //    fetch('http://localhost:55900/api/potholes')
                        //        .then(response => response.json())
                        //        .then(json => {
                        //            this.potholes = json;
                        //        })
                        //        .then(potholes => {
                        //            for (i = 0; i < this.potholes.length; i++) {
                        //                console.log(this.potholes[i].UserName)

                        //    });-->

        this.search = function () {

            const isvalidated = this.root.querySelector('#isvalidated');
            const username = this.root.querySelector('#username');
            const street1 = this.root.querySelector('#street1');
            const street2 = this.root.querySelector('#street2');
            const locationdesc = this.root.querySelector('#locationdesc');
            const potholedesc = this.root.querySelector('#potholedesc');

            console.log(isvalidated);

            const url = `http://localhost:55900/api/potholessearch?IsValidated=${isvalidated}&UserName=${username}&Street1=${street1}&Street2=${street2}&LocationDesc=&PotholeDesc=&Severity=`



        }




    </script>

</searchbar>