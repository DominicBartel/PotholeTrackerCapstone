<potholedate>
    <div class="edit_pothole_div" id="editPothole">
        <h1>Edit Pothole Inspected and/or Repair Date(s)<span id="pothole_number-date"></span></h1>
        <form method="post" action="/Home/AdminPotholeEdit">

            <div class="inputs_edit align_right">
                <!--<p class="input_p spacer">Date Reported:</p>-->
                <p class="input_p spacer">Date Inspected:</p>
                <p class="input_p spacer">Repair Date:</p>
            </div>
            <div class="inputs_edit align_right">
                <!--<p class="input_p">{dateReported}</p>-->
                <p class="input_p"><input id="InspectedDate-date" type="text" name="InspectedDate" /></p>
                <p class="input_p"><input id="RepairDate-date" type="text" name="RepairedDate" /></p>
                <!--<input type="hidden" id="Street2-date" name="Street2" />
                <input type="hidden" id="Latitude-date" name="Latitude" />
                <input type="hidden" id="Longitude-date" name="Longitude" />
                <input type="hidden" id="PotholeId-date" name="PotholeId" />
                <input type="hidden" id="UserName-date" name="UserName" />
                <input type="hidden" id="Severity-date" name="Severity" />
                <input type="hidden" id="IsValidated-date" name="IsValidated" /></p>
                <textarea hidden id="LocationDesc-date" rows="10" cols="24" name="LocationDesc"></textarea>
                <textarea hidden id="PotholeDesc-date" rows="10" cols="24" name="PotholeDesc"></textarea>-->
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

        var pothole;
        var dateReported;


        //$(function () {
        //    $("#InspectedDate").datepicker();
        //    $("#RepairDate").datepicker();
        //});


        // this receives pothole information from search via the bus -then sets the values from the data on the bus to the properties of pothole

        this.opts.bus.on('searchresult', data => {
            pothole = data[0];
            //document.getElementById("pothole_number-date").textContent = pothole.PotholeId;
            document.getElementById('PotholeId-date').value = pothole.PotholeId;
            document.getElementById('Street1-date').value = pothole.Street1;
            document.getElementById('Street2-date').value = pothole.Street2;
            document.getElementById('UserName-date').value = pothole.UserName;
            document.getElementById('LocationDesc-date').value = pothole.LocationDesc;
            document.getElementById('IsValidated-date').value = pothole.IsValidated;
            document.getElementById(pothole.Severity.toString()).selected = true;
            document.getElementById('Latitude-date').value = pothole.Latitude;
            document.getElementById('Longitude-date').value = pothole.Longitude;
            document.getElementById('PotholeDesc-date').value = pothole.PotholeDesc;
            document.getElementById('IsValidated-date').value = pothole.IsValidated;
            dateReported = pothole.DateReported;
            document.getElementById('InspectedDate-date').value = pothole.InspectedDate;
            document.getElementById('RepairDate-date').value = pothole.RepairedDate;
            this.update;

        });

        console.log(pothole.InspectedDate-date);
        console.log(pothole.RepairDate-date);

        //$(function() {
        //    $("#InspectedDate-date").datepicker();
        //    $("#RepairDate-date").datepicker();
        //});

    </script>

</potholedate>