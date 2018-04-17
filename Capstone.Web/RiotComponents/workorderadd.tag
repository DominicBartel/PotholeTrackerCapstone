<workorderadd>

    <div>
        <table class="table-index-page">
            <th colspan="3" width="580">Workers</th>
            <tr style="font-weight:bold">
                <td>Username</td>
                <td>Role</td>
                <td>Reset</td>
            </tr>
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
            <th colspan="3" width="580">Potholes For Workorder</th>

            <tr style="font-weight:bold">
                <td>Severity</td>
                <td>First Cross Street</td>
                <td>Location</td>
            </tr>

            <tr onclick="{removePothole}" each="{potholesWorkorder}">
                <td>{Severity}</td>
                <td>{Street1}</td>
                <td>{LocationDesc}</td>

        </table>

        <table class="table-index-page">
            <th colspan="3" onclick="{fullSearch}">Refresh Potholes</th>
            <tr onclick="{addPothole}">
                <td>#{potholes[0].PotholeId}</td>
                <td>Add To Ticket</td>
            </tr>
        </table>
    </div>
    <div>
        <form method="post" action="/Home/SubmitWorkOrder">
            <input id="usersString" hidden name="Users" value="" />
            <input id="potholesString" hidden name="PotHoles" value="" />

        </form>
        <table class="table-index-page">
            <th>Submit Workorder</th>
        </table>
    </div>


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

        this.addUser = function (data) {
            this.usersWorkorder.push(data.item);
        }

        this.addPothole = function (data) {
            //console.log(data);
            //this.opts.bus.trigger('addedPothole', data.item.PotholeId);

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