<resultstable>

    <table class="table-index-page">
        <th colspan="5">Current Confirmed Potholes:</th>

        <tr style="font-weight:bold">
            <td>Severity</td>
            <td>First Cross Street</td>
            <td>Second Cross Street</td>
            <td>Location</td>
            <td>Pothole Description</td>
        </tr>
        
        <tr each="{potholes}">
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

    </script>
</resultstable>