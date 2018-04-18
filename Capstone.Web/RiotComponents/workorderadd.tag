<workorderadd>

    <div>
        <div>
            <table class="table-index-page">
                <th colspan="3" width="580">Workers</th>
                <tr style="font-weight:bold">
                    <td>Username</td>
                    <td>Role</td>
                    <td onclick="{resetCrewlist}">Reset</td>
                </tr>
                <tr each="{usersWorkorder}">
                    <td>{UserName}</td>
                    <td></td>
                    <td onclick="{removeUser}" >Remove Worker</td>

                </tr>
            </table>

            <table class="table-index-page">
                <tr each="{users}" onclick="{addUser}">
                    <td>{UserName}</td>
                    <td>Add CrewMember</td>
                </tr>
            </table>
        </div>



        <div>
            <table class="table-index-page">
                <th colspan="4" width="580">Potholes For Workorder</th>

                <tr style="font-weight:bold">
                    <td>Severity</td>
                    <td>First Cross Street</td>
                    <td>Location</td>
                    <td onclick="{resetPothole}">Reset</td>
                </tr>

                <tr  each="{potholesWorkorder}">
                    <td>{Severity}</td>
                    <td>{Street1}</td>
                    <td>{LocationDesc}</td>
                    <td onclick="{removePothole}">Remove Pothole</td>

            </table>

            <table class="table-index-page">
                <th colspan="3" onclick="{fullSearch}">Selected Pothole</th>
                <tr onclick="{addPothole}">
                    <td>#{potholes[0].PotholeId}</td>
                    <td>Add To Ticket</td>
                </tr>
            </table>
        </div>
        
    </div>
    <div class="table-index-page updiv">
        <form id="workOrderSubmit" method="post" action="/Home/SubmitWorkOrder">
            <div class="orderInfo">
                <input id="usersString" hidden name="Users" value="" />
                <input id="potholesString" hidden name="PotHoles" value="" />
                <span>
                    <select name="TypeOfJob">
                        <option value="Inspection">Inspection</option>
                        <option value="Repair">Repair</option>
                    </select>
                </span>
                <span>Inspection On: <input type="date" name="ToInspectDate" /></span>
                <span>Repair On: <input type="date" name="ToRepairDate" /></span>
            </div>
            <textarea name="notes" placeholder="Enter notes here"></textarea>
        </form>
        <table class="table-index-page" onclick="{submitWorkorder}">
            <th>Submit Workorder</th>
        </table>
        <table class="table-index-page" onclick="{fullSearch}">
            <th>Reload Potholes</th>
        </table>
    </div>
    
    <style>
        .table-index-page.updiv{
            
        }
        span{
            display:block;
            text-align:right;
        }
        table{
            vertical-align:top;
        }
        textarea {
            margin:8px;
            display:inline-block;
            height: 124px;
            width: 246px;
        }
        .orderInfo {
            padding-top:20px;
            padding-right:10px;
            vertical-align: top;
            display: inline-block;
            width: 400px;
            right: 0px;
            height: auto;
        }
    </style>

    <script>

        this.potholesWorkorder = [];
        this.usersWorkorder = [];
        this.users = [];
        let selectedPotholes = [];
        let selectedUsers = [];

        this.resetCrewlist = function () {
            if (confirm("Remove all crew members from order?")) {
                this.usersWorkorder = [];
            }
            this.update;
        }

        this.resetPothole = function () {
            if (confirm("Remove all potholes from order?")) {
                this.potholesWorkorder = [];
            }
            this.update;
        }

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

        this.removeUser = function (data) {

            for (i = 0; i < this.usersWorkorder.length; i++) {
                if (this.usersWorkorder[i].UserId == data.item.UserId) {
                    this.usersWorkorder.splice(i, 1);
                }
            }

            this.update;
        }

        this.removePothole = function (data) {

            for (i = 0; i < this.potholesWorkorder.length; i++) {
                if (this.potholesWorkorder[i].PotholeId == data.item.PotholeId) {
                    this.potholesWorkorder.splice(i, 1);
                }
            }
            
            this.update;
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