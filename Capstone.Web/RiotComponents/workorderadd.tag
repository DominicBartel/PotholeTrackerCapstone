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
        <form id="workOrderSubmit" method="post" action="/Home/SubmitWorkOrder">
            <input id="usersString" hidden name="Users" value="" />
            <input id="potholesString" hidden name="PotHoles" value="" />
            <select name="TypeOfJob">
                <option value="Inspection">Inspection</option>
                <option value="Repair">Repair</option>
            </select>
            Inspection On: <input type="date" name="ToInspectDate" />
            Repair On:<input type="date" name="ToRepairDate" />
            <textarea name="notes" placeholder="Enter notes here"></textarea>
        </form>
        <table class="table-index-page" onclick="{submitWorkorder}">
            <th>Submit Workorder</th>
        </table>
    </div>


    <script>

        this.potholesWorkorder = [];
        this.usersWorkorder = [];
        this.users = [];
        let selectedPotholes = [];
        let selectedUsers = [];

        this.submitWorkorder = function () {
            if (this.potholesWorkorder < 1) {
                if (confirm("There are no potholes on the workorder, please add a pothole to your order.")) {
                   
                }
            } else if(this.usersWorkorder < 1) {
                if (confirm("There are no crew members on the workorder, please add a crew member to your order.")) {

                }
            }else {
                submitWorkorder();
            }
        }

        function submitWorkorder() {
            let submitUsers = "";
            let submitPotholes = "";
            for (i = 0; i < selectedUsers.length; i++) {

                if (i > 0) {
                    submitUsers += ',';
                }
                submitUsers += selectedUsers[i].UserId;
               
            }
            for (i = 0; i < selectedPotholes.length; i++) {
                if (i > 0) {
                    submitPotholes += ',';
                }
                submitPotholes += selectedPotholes[i].PotholeId;
            }

            document.getElementById('usersString').value = submitUsers;
            document.getElementById('potholesString').value = submitPotholes;

            document.getElementById('workOrderSubmit').submit();
        }

        this.on('mount', () => {
            selectedPotholes = this.potholesWorkorder;
            selectedUsers = this.usersWorkorder;
            searchUsers();
        })

        this.opts.bus.on('searchresult', data => {
            //console.log(data);
            this.potholes = data;
            this.update();
        })

        this.opts.bus.on('users', data => {
            //console.log(data);
            this.users = data;
            this.update();
        })

        this.addUser = function (data) {
            //console.log(data);
            let worker = data.item;
            this.usersWorkorder.push(worker);
            searchUsers();
            
        }

        this.addPothole = function (data) {
            //console.log(data);
            //this.opts.bus.trigger('addedPothole', data.item.PotholeId);

            this.potholesWorkorder.push(this.potholes[0]);
            console.log(this.potholesWorkorder)
            this.opts.bus.trigger('searchRefresh', 'Please search again')
        }

        this.fullSearch = function () {
            this.opts.bus.trigger('searchRefresh', 'Please search again');
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