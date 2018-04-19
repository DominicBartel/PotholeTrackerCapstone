<editPothole>
    <div class="edit_pothole_div" id="editPothole" style="display:none">
        <h1>Edit Pothole #<span id="pothole_number"></span></h1>
        <form id="form_submit" method="post" action="/Home/AdminPotholeEdit">

            <!--<div class="inputs_edit align_right">


                <p class="input_p spacer">Street:</p>
                <p class="input_p spacer">Cross Street:</p>
                <p class="input_p spacer">Latitude:</p>
                <p class="input_p spacer">Longitude:</p>
                <p class="input_p spacer">Severity:</p>
                <p class="input_p spacer">Validate:</p>
            </div>-->
            <div class="inputs_edit align_right">
                <input type="hidden" id="PotholeId" name="PotholeId" />
                <input type="hidden" hidden id="UserName" name="UserName" />
                <p></p>
                <p class="input_p">Street: <input id="Street1" type="text" name="Street1" /></p>
                <p class="input_p">Cross Street: <input id="Street2" type="text" name="Street2" /></p>
                <p class="input_p">Latitude: <input readonly id="Latitude" type="text" name="Latitude" /></p>
                <p class="input_p">Longitude: <input readonly id="Longitude" type="text" name="Longitude" /></p>
                <p class="input_p">Reported Date: <input readonly id="ReportedDate" type="date" name="ReportedDate" /></p>
                <p class="input_p">Inspected Date: <input id="InspectedDate" type="date" name="InspectedDate" /></p>
                <p class="input_p">Repaired Date: <input id="RepairDate" type="date" name="RepairedDate" /></p>

            </div>
            <div class="inputs_edit">
                <p class="input_p">Location Description</p>
                <textarea id="LocationDesc" rows="10" cols="24" name="LocationDesc" placeholder="Enter a location description."></textarea>
            </div>
            <div class="inputs_edit">
                <p class="input_p">Pothole Description</p>
                <textarea id="PotholeDesc" rows="10" cols="24" name="PotholeDesc" placeholder="Enter a description of the pothole."></textarea>
            </div>
            <div class="inputs_edit">
                <button>Submit</button>
                <button onclick="{deletePothole}">Delete</button>
                <p><p class="input_p">

                    Severity: <select name="Severity">

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
                <p class="input_p"><span>Validate Pothole: </span><input id="IsValidated" onclick="{checkValidate}" value="" type="checkbox" name="IsValidated" /></p></p>
            </div>

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
            document.getElementById("editPothole").style.display = "";
        })

        this.deletePothole = function () {
            if (confirm("Are you sure you want to delete this pothole?")) {
                deletePothole();
            }
        }
        this.checkValidate = function () {
            var checkbox = document.getElementById('IsValidated');
            if (checkbox.checked == true) {
                checkbox.value = "true";
            } else {
                checkbox.value = "false";
            }
        }
        function deletePothole() {
            var form = document.getElementById("form_submit");
            form.action = "/Home/DeletePothole";
            form.submit();
        }

        this.opts.bus.on('searchresult', data => {
            pothole = data[0];
            document.getElementById("pothole_number").textContent = pothole.PotholeId;
            document.getElementById('PotholeId').value = pothole.PotholeId;
            document.getElementById('Street1').value = pothole.Street1;
            document.getElementById('Street2').value = pothole.Street2;
            document.getElementById('UserName').value = pothole.UserName;
            document.getElementById('LocationDesc').value = pothole.LocationDesc;
            document.getElementById('IsValidated').checked = pothole.IsValidated;
            document.getElementById('IsValidated').value = pothole.IsValidated;
            document.getElementById(pothole.Severity.toString()).selected = true;
            document.getElementById('Latitude').value = pothole.Latitude;
            document.getElementById('Longitude').value = pothole.Longitude;
            document.getElementById('PotholeDesc').value = pothole.PotholeDesc;
            document.getElementById('IsValidated').value = pothole.IsValidated;

            document.getElementById('ReportedDate').value = new Date(pothole.ReportedDate).yyyymmdd();
            document.getElementById('InspectedDate').value = (pothole.InspectedDate != null) ? new Date(pothole.InspectedDate).yyyymmdd() : '';
            document.getElementById('RepairDate').value = (pothole.RepairedDate != null) ? new Date(pothole.RepairedDate).yyyymmdd() : '';
            this.update;
        })


        Date.prototype.yyyymmdd = function () {
            var mm = this.getMonth() + 1; // getMonth() is zero-based
            var dd = this.getDate();

            return [this.getFullYear(),
            (mm > 9 ? '' : '0') + mm,
            (dd > 9 ? '' : '0') + dd
            ].join('-');
        };

    </script>
</editPothole>
