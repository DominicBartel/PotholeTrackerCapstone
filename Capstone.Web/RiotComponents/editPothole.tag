<editPothole>
    <form id="editPothole" style="display:none" method="post" action="/Home/AdminPotholeEdit">

        <input type="hidden" id="PotholeId" name="PotholeId" />
        <input type="hidden" hidden id="UserName" name="UserName" />
        <input id="Street1" type="text" name="Street1" />
        <input id="Street2" type="text" name="Street2" />
        <input id="Latitude" type="text" name="Latitude" />
        <input id="Longitude" type="text" name="Longitude" />
        <!--<input id="ReportedDate" type="text" name="ReportedDate" />
        <input id="InspedctedDate" type="text" name="InspectedDate" />
        <input id="RepairedDate" type="text" name="RepairedDate" />-->
        <select name="Severity">

            <option id="1" value="1">1</option>
            <option id="2" value="2">2</option>
            <option id="3" value="3">3</option>
            <option id="4" value="4">4</option>
            <option id="5" value="5">5</option>
            <option id="6" value="6">6</option>
            <option id="7" value="7">7</option>
            <option id="8" value="8">8</option>
            <option id="9" value="9">9</option>
            <option id="10" value="10">10</option>

        </select>
        <input id="IsValidated" type="text" name="IsValidated" />

        <textarea id="LocationDesc" rows="10" cols="24" name="LocationDesc"></textarea>
        <textarea id="PotholeDesc" rows="10" cols="24" name="PotholeDesc"></textarea>
        <button>Submit</button>
    </form>

   

    <script>

        var potholeNum;
        var pothole;
        
        this.opts.bus.on('selectedPothole', data => {
            potholeNum = data;
            console.log(potholeNum + "hello");
            //document.getElementById('PotholeId').value = potholeNum;
            document.getElementById("editPothole").style.display = "";
        })

        this.opts.bus.on('searchresult', data => {
            pothole = data[0];
            document.getElementById('PotholeId').value = pothole.PotholeId;
            document.getElementById('Street1').value = pothole.Street1;
            document.getElementById('Street2').value = pothole.Street2;
            document.getElementById('UserName').value = pothole.UserName;
            document.getElementById('LocationDesc').value = pothole.LocationDesc;
            document.getElementById('IsValidated').value = pothole.IsValidated;
            document.getElementById(pothole.Severity.toString()).selected = true;
            document.getElementById('Latitude').value = pothole.Latitude;
            document.getElementById('Longitude').value = pothole.Longitude;
            document.getElementById('PotholeDesc').value = pothole.PotholeDesc;
            document.getElementById('IsValidated').value = pothole.IsValidated;
            this.update;
        })


    </script>
</editPothole>