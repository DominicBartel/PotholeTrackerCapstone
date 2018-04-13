<editPothole>
    <div id="chart_div">


    </div>



    <script>

        var potholeNum;

        this.opts.bus.on('selectedPothole', data => {
            potholeNum = data;
            console.log(potholeNum + "hello");
        })
    </script>
</editPothole>