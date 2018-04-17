<workorderadd>
    <p id="refresh"><input type="button" onclick="{fullSearch}" value="Refresh Potholes" /></p>
    <table class="table-index-page">
        <th colspan="3">Potholes For Workorder</th>

        <tr style="font-weight:bold">
            <td>Severity</td>
            <td>First Cross Street</td>
            <td>Location</td>
        </tr>

        <tr onclick="{removePothole}" each="{potholesWorkorder}">
            <td>{Severity}</td>
            <td>{Street1}</td>
            <td>{LocationDesc}</td>

            <th colspan="3">Workers</th>

        <tr onclick="{removeUser}" each="{usersWorkorder}">
            <td>{UserName}</td>
            <td></td>
            <td>Remove Worker</td>

        </tr>
    </table>

    <table class="table-index-page">
        <tr each="{users}" onclick="{addUser}">
            <td>{UserName}</td>
            <td>Add CrewMember</td>
        </tr>
    </table>

    <table class="table-index-page">
        <tr onclick="{addPothole}">
            <td>#{potholes[0].PotholeId}</td>
            <td>Add To Ticket</td>
        </tr>
    </table>




    <script>

        this.potholesWorkorder = [];
        this.usersWorkorder = [];
        this.users = [];

        this.on('mount', () => {
            searchUsers();
        });

        this.opts.bus.on('searchresult', data => {
            //console.log(data);
            this.potholes = data;
            this.update();
        });

        this.opts.bus.on('users', data => {
            console.log(data);
            this.users = data;
            this.update();
        });

        this.addPothole = function (data) {
            //console.log(data);
            //this.opts.bus.trigger('addedPothole', data.item.PotholeId);
            if (this.potholesWorkorder)
                this.potholesWorkorder.push(this.potholes[0]);
            console.log(this.potholesWorkorder)
            this.update;
        }

        this.fullSearch = function () {
            this.opts.bus.trigger('searchRefresh', 'Please search again')
        }
        function searchUsers() {

            const url = `http://localhost:55900/api/users`;
            fetch(url)
                .then(response => response.json())
                .then(json => {
                    opts.bus.trigger('users', json);

                });
            console.log(bus.users);
        }

    </script>
</workorderadd>