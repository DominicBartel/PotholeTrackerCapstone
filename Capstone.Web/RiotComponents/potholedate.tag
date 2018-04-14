<editPothole>
    <div class="edit_pothole_div" id="editPothole" style="display:none">
        <h1>Edit Pothole #<span id="pothole_number"></span></h1>
        <form method="post" action="/Home/AdminPotholeEdit">

            <div class="inputs_edit align_right">


                <p class="input_p spacer">Street:</p>
                <p class="input_p spacer">Cross Street:</p>
                <p class="input_p spacer">Latitude:</p>
                <p class="input_p spacer">Longitude:</p>
                <p class="input_p spacer">Severity:</p>
                <p class="input_p spacer">Validate:</p>
            </div>
            <div class="inputs_edit align_right">
                <input type="hidden" id="PotholeId" name="PotholeId" />
                <input type="hidden" hidden id="UserName" name="UserName" />
                <p class="input_p"><input id="Street1" type="text" name="Street1" /></p>
                <p class="input_p"><input id="Street2" type="text" name="Street2" /></p>
                <p class="input_p"><input id="Latitude" type="text" name="Latitude" /></p>
                <p class="input_p"><input id="Longitude" type="text" name="Longitude" /></p>
                <!--<input id="ReportedDate" type="text" name="ReportedDate" />
                <input id="InspedctedDate" type="text" name="InspectedDate" />
                <input id="RepairedDate" type="text" name="RepairedDate" />-->
                <p class="input_p">

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
                </p>
                <p class="input_p"><input id="IsValidated" type="text" name="IsValidated" /></p>
            </div>
            <div class="inputs_edit">
                <p class="input_p">Location Description</p>
                <textarea id="LocationDesc" rows="10" cols="24" name="LocationDesc"></textarea>
            </div>
            <div class="inputs_edit">
                <p class="input_p">Pothole Description</p>
                <textarea id="PotholeDesc" rows="10" cols="24" name="PotholeDesc"></textarea>
            </div>
            <button>Submit</button>
        </form>
    </div>

    <style>
        .spacer {
            padding: 18px
        }

        .align_right {
            text-align: right;
        }

        .inputs_edit {
            vertical-align: top;
            display: inline-block;
            padding: 0;
            margin: 0;
        }

        .input_p {
            padding: 0;
            margin: 0;
        }
    </style>

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
            document.getElementById("pothole_number").textContent = pothole.PotholeId;
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