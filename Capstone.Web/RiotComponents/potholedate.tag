<potholedate>
    <div class="edit_pothole_div" id="editPothole" style="display:none">
        <h1>Edit Pothole Date(s)<span id="pothole_number"></span></h1>
        <form method="post" action="/Home/AdminPotholeEdit">

            <div class="inputs_edit align_right">
                <p class="input_p spacer">Date Reported:</p>
                <p class="input_p spacer">Date Inspected:</p>
                <p class="input_p spacer">Repair Date:</p>
            </div>
            <div class="inputs_edit align_right">
                <p class="input_p">{DateReported}</p>
                <p class="input_p"><input id="InspectedDate" type="text" name="InspectedDate" /></p>
                <p class="input_p"><input id="RepairedDate" type="text" name="RepairedDate" /></p>
                <input type="hidden" id="Street2" name="Street2" />
                <input type="hidden" id="Latitude" name="Latitude" />
                <input type="hidden" id="Longitude" name="Longitude" />
                <input type="hidden" id="PotholeId" name="PotholeId" />
                <input type="hidden" id="UserName" name="UserName" />
                <input type="hidden" id="Severity" name="Severity" />
                <input type="hidden" id="IsValidated" name="IsValidated" /></p>
                <textarea hidden id="LocationDesc" rows="10" cols="24" name="LocationDesc"></textarea>
                <textarea hidden id="PotholeDesc" rows="10" cols="24" name="PotholeDesc"></textarea>
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
            document.getElementById('DateReported').value = pothole.DateReported;
            document.getElementById('InspectedDate').value = pothole.InspectedDate;
            document.getElementById('RepairDate').value = pothole.RepairDate;
            this.update;
        })

    </script>
</potholedate>

<!--
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>jQuery UI Datepicker - Default functionality</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
    $(function () {
        $("#datepicker").datepicker();
    });
</script>
</head>
<body>

    <p>Date: <input type="text" id="datepicker"></p>

</body>
</html>

-->