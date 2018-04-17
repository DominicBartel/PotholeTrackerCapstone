<bargraph>

    <!--Div that will hold the pie chart-->
    <!-- <div id="searchGraph" style="position:relative; overflow:hidden"></div>-->


    <script type="text/javascript">

        // Get the column totals from the database
        // add variable to hold the total number of confirmed potholes
        let confirmed = 0;

        // add variable to hold the total number of repaired potholes
        let repaired = 0;

        this.potholes = [];

        let i = 0;

        this.on('mount', () => {

            fetch(`http://localhost:55900/api/potholes`)
                .then(response => response.json())
                .then(json => {
                    this.potholes = json;
                    console.log(this.potholes);
                    for (i = 0; i < this.potholes.length; i++) {

                        if (this.potholes[i].ReportedDate == null) {

                        }
                        else {
                            confirmed++;
                        }

                        if (this.potholes[i].RepairedDate == null) {
                            //confirmed++;
                            //i++;
                        }
                        else {
                            repaired++;
                            confirmed--;
                            console.log(i);
                        }
                    }

                    console.log("repaired =" + repaired);
                    console.log("confirmed =" + confirmed);
                    console.log("i =" + i);

                    // Load the Visualization API and the corechart package.
                    google.charts.load('current', { 'packages': ['corechart'] });

                    // Set a callback to run when the Google Visualization API is loaded.
                    google.charts.setOnLoadCallback(drawChart);

                    // Callback that creates and populates a data table,
                    // instantiates the chart, passes in the data and
                    // draws it.
                    function drawChart() {

                        // Create the data table.
                        var data = new google.visualization.DataTable();
                        data.addColumn('string', 'Pothole Status');
                        data.addColumn('number', 'Potholes');
                        data.addColumn({ type: 'string', role: 'style' });
                        data.addRows([

                            ['Total Potholes In Need of Repair', confirmed, '#0090C1'],
                            ['Total Repaired Potholes', repaired, '#0090C1']
                        ]);

                        // Set chart options
                        var options = {
                            'title': 'Citywide Pothole Status',
                            legend: { position: 'none' }
                        };

                        // Instantiate and draw our chart, passing in some options.
                        var chart = new google.visualization.ColumnChart(document.getElementById('bargraph'));
                        chart.draw(data, options);
                    }

                })

        });

    </script>

</bargraph>