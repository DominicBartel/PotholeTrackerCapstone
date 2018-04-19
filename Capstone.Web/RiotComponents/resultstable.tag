<resultstable>

    <table class="table-index-page table-scroll">
        <th colspan="6">Pothole Search Results:</th>

        <tr style="font-weight:bold">
            <td>ID Number</td>
            <td>Severity</td>
            <td>First Cross Street</td>
            <td>Second Cross Street</td>
            <td>Location</td>
            <td>Pothole Description</td>
        </tr>

        <tr onclick="{selectPothole}" each="{potholes}">
            <td>{PotholeId}</td>
            <td>{Severity}</td>
            <td>{Street1}</td>
            <td>{Street2}</td>
            <td>{LocationDesc}</td>
            <td>{PotholeDesc}</td>
        </tr>
        
    </table>

    <script>

        this.opts.bus.on('searchresult', data => {
            console.log(data);
            this.potholes = data;
            this.update();
        });

        this.selectPothole = function (data) {
            console.log(data.item.PotholeId);
            this.opts.bus.trigger('selectedPothole', data.item.PotholeId);
        }

        console.log(bus.user);
    </script>
</resultstable>