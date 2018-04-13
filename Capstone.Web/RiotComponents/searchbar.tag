<searchbar>

    <!--<button onclick="{myFunction}">Advanced Search</button>

    <div id="advancedSearch">
      <p>DO SOMETHING NOW YOU SOMETHING SOMETHING SOMETHING!!!!!!</p>
        </div>-->
    <div>
        <p>Search Pothole Database:</p>
        <input id="isvalidated" type="hidden" name="IsValidated" value="true" />
        <input id="street1" type="text" name="Street1" placeholder="On Street" />
        <input id="street2" type="text" name="Street2" placeholder="Neighboring Street" />
        <input id="locationdesc" type="text" name="LocationDesc" placeholder="Location Keyword" />
        <input id="potholedesc" type="text" name="PotholeDesc" placeholder="Description Keyword" />
        <input id="username" type="text" name="UserName" placeholder="Submitter Username" />
        <input id="latitude" type="text" name="latitude" placeholder="Submitter Username" />
        <input id="longitude" type="text" name="longitude" placeholder="Submitter Username" />
        <input id="potholeId" type="text" name="potholeId" placeholder="Submitter Username" />
        <input id="reportedDate" type="text" name="reportedDate" placeholder="Submitter Username" />
        <input id="inspectedDate" type="text" name="inspectedDate" placeholder="Submitter Username" />
        <input id="repairedDate" type="text" name="repairedDate" placeholder="Submitter Username" />

        <select id="severity">
            <option value="">Severity Level</option>
            <option value="-1">ANY</option>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
            <option value="6">6</option>
            <option value="7">7</option>
            <option value="8">8</option>
            <option value="9">9</option>
            <option value="10">10</option>
        </select>
        <input type="button" onclick="{search}" value="SEARCH" />
    </div>


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

        this.on('mount', () => {
            
            const isvalidatedE = this.root.querySelector('#isvalidated');
            const isvalidated = isvalidatedE.value;
            const usernameE = this.root.querySelector('#username');
            const username = usernameE.value;
            const street1E = this.root.querySelector('#street1');
            const street1 = street1E.value;
            const street2E = this.root.querySelector('#street2');
            const street2 = street2E.value
            const locationdescE = this.root.querySelector('#locationdesc');
            const locationdesc = locationdescE.value
            const potholedescE = this.root.querySelector('#potholedesc');
            const potholedesc = potholedescE.value;
            const severityO = this.root.querySelector('#severity');
            const severityE = severityO.options[severityO.selectedIndex];
            const latitude = this.root.querySelector('#latitude').value;
            const longitude = this.root.querySelector('#longitude').value
            const potholeId = this.root.querySelector('#potholeId').value
            const reportedDate = this.root.querySelector('#reportedDate').value
            const inspectedDate = this.root.querySelector('#inspectedDate').value
            const repairedDate = this.root.querySelector('#repairedDate').value
            

            console.log(isvalidated);
            console.log(username);

            const url = `http://localhost:55900/api/advancedpotholessearch?isValidated=${isvalidated}&userName=${username}&street1=${street1}&street2=${street2}&locationDesc=${locationdesc}&potholeDesc=${potholedesc}&severity=${severity}&potholeId=${potholeId}&latitude=${latitude}&longitude=${longitude}&reportedDate=${reportedDate}&inspectedDate=${inspectedDate}&repairedDate=${repairedDate}`;

            fetch(url)
                .then(response => response.json())
                .then(json => {
                    this.opts.bus.trigger('searchresult', json);
                    console.log(json);
                });
        });

        this.search = function () {

            const isvalidatedE = this.root.querySelector('#isvalidated');
            const isvalidated = isvalidatedE.value;
            const usernameE = this.root.querySelector('#username');
            const username = usernameE.value;
            const street1E = this.root.querySelector('#street1');
            const street1 = street1E.value;
            const street2E = this.root.querySelector('#street2');
            const street2 = street2E.value
            const locationdescE = this.root.querySelector('#locationdesc');
            const locationdesc = locationdescE.value
            const potholedescE = this.root.querySelector('#potholedesc');
            const potholedesc = potholedescE.value;
            const severityO = this.root.querySelector('#severity');
            const severityE = severityO.options[severityO.selectedIndex];
            const severity = severityE.value;
            const latitude = 

            console.log(isvalidated);
            console.log(username);

            const url = `http://localhost:55900/api/advancedpotholessearch?isValidated=${isvalidated}&userName=${username}&street1=${street1}&street2=${street2}&locationDesc=${locationdesc}&potholeDesc=${potholedesc}&severity=${severity}&potholeId=${potholeId}&latitude=${latitude}&longitude=${longitude}&reportedDate=${reportedDate}&inspectedDate=${inspectedDate}&repairedDate=${repairedDate}`;
            console.log(url);
            fetch(url)
                .then(response => response.json())
                .then(json => {
                    this.opts.bus.trigger('searchresult', json);
                    console.log(json);
                });
        }


    </script>

</searchbar>