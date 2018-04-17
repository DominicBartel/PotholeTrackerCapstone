<workorderadd>
    <table class="table-index-page">
        <th colspan="5">Potholes For Workorder</th>

        <tr style="font-weight:bold">
            <td>Severity</td>
            <td>First Cross Street</td>
            <td>Location</td>
        </tr>

        <tr onclick="{removePothole}" each="{potholesWorkorder}">
            <td>{Severity}</td>
            <td>{Street1}</td>
            <td>{LocationDesc}</td>
            
        </tr>
    </table>

    <table class="table-index-page">
        <th colspan="2" onclick="{addPothole}">Add Pothole?</th>
        <tr>
            <td>Pothole ID</td>
            <td>{potholes[0].PotholeId}</td>
        </tr>
    </table>


    <script>
        this.potholesWorkorder = [];

        this.opts.bus.on('searchresult', data => {
            console.log(data);
            this.potholes = data;
            this.update();
        });

        this.addPothole = function (data) {
            //console.log(data);
            //this.opts.bus.trigger('addedPothole', data.item.PotholeId);
            this.potholesWorkorder.push(this.potholes[0]);
            console.log(this.potholesWorkorder)
            this.update;
        }

        console.log(bus.user);
    </script>
</workorderadd>