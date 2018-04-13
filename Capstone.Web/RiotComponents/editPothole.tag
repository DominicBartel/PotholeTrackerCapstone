<editPothole>
    <form id="editPothole" style="display:none" method="post" action="/Home/AdminPotholeEdit">
        <span>Success</span>
        <input hidden id="PotholeId" value="{potholeNum}" name="PotholeId" />
        <input hidden id="UserName" name="UserName" />
        <input id="Street1" type="text" name="Street1" />
        <input id="Street2" type="text" name="Street2" />
        <input id="LocationDesc" type="text" name="LocationDesc" />
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
        <button>Submit</button>
    </form>

   

    <script>

        var potholeNum;
        var pothole;
        
        this.opts.bus.on('selectedPothole', data => {
            potholeNum = data;
            //console.log(potholeNum + "hello");
            document.getElementById("editPothole").style.display = "";
        })

        this.opts.bus.on('searchresult', data => {
            pothole = data[0];
            document.getElementById('Street1').value = pothole.Street1;
            document.getElementById('Street2').value = pothole.Street2;
            document.getElementById('UserName').value = pothole.UserName;
            document.getElementById('LocationDesc').value = pothole.LocationDesc;
            document.getElementById('IsValidated').value = pothole.IsValidated;
            document.getElementById(pothole.Severity).value.selected = true;
            this.update;
        })


    </script>
</editPothole>