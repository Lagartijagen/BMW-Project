<%@ Page Title="Statistics" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Statistics.aspx.cs" Inherits="Statistics" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.js"></script>
<script type="text/javascript" language="javascript">
     
    var dataDict = {};
       
    var addpair = function (my_key, my_value) {
        dataDict[my_key] = my_value;
    }
    var givevalue = function (my_key) {
        if (dataDict[my_key] == null) {
            return 0;
        } else {
            return dataDict[my_key];
        }  
    }



    var percentageP = function (m_k, m_p) {
        return ((givevalue(m_k) / m_p) * 100);
    }

    function check() {           
        for (var i = 0; i < localStorage.length; i++) {
            var key = localStorage.key(i);
            var value = localStorage.getItem(key);
            console.log('Key: ' + key + ', Value: ' + value);
            addpair(key, value);
        };
    }
        
    var randColorI = [
        'rgba(255, 99, 132, 0.2)',
        'rgba(54, 162, 235, 0.2)',
        'rgba(255, 206, 86, 0.2)',
        'rgba(20, 255, 55, 0.2)',
        'rgba(153, 102, 255, 0.2)',
        'rgba(100, 102, 55, 0.2)',
        'rgba(222, 16, 255, 0.2)',
        'rgba(80, 255, 155, 0.2)',
        'rgba(22, 76, 255, 0.2)',
        'rgba(235, 159, 2, 0.2)'];
    var randColorO = [
        'rgba(255,99,132, 1)',
        'rgba(54, 162, 235, 1)',
        'rgba(255, 206, 86, 1)',
        'rgba(20, 255, 55, 1)',
        'rgba(153, 102, 255, 1)',
        'rgba(100, 102, 55, 1)',
        'rgba(222, 16, 255, 1)',
        'rgba(80, 255, 155, 1)',
        'rgba(22, 76, 255, 1)',
        'rgba(235, 159, 2, 1)'];

</script>

  
    
          
<asp:HiddenField ID="KeyHiddenField" runat="server"></asp:HiddenField>
<asp:HiddenField ID="ValueHiddenField" runat="server"></asp:HiddenField>
<asp:HiddenField ID="LengthHiddenField" runat="server"></asp:HiddenField>
<asp:TextBox ID="txtHidHeaderID" Runat="server" Visible="False"></asp:TextBox>


<div class="jumbotron"  style="padding-bottom: 10px; padding-top: 10px">
    <h1 style="text-align: center">
        <img src="https://i.pinimg.com/originals/27/6a/97/276a970cd35a83cc71beee75cb89f382.png" style="width:150px;height:150px;">
        BMW Survey Statistics
    </h1>
</div>
    
<div class="row">
    <div class="col-md-4">
        <p style="text-align: center; font-family:calibri; color:dimgray" >
            Number of participants in each category:
        </p>
        <canvas id="Chart1" width="200" height="100" style="text-align: center"></canvas>
        <script>
            check();
            var ctx = document.getElementById("Chart1").getContext('2d');
            var myChart1 = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ["adolescents", "unlicensed", "first-timers", "targetables"],
                    datasets: [{
                        label: '# of participants',
                        data: [givevalue("adolescents"), givevalue("unlicensed"), givevalue("firstTimers"), givevalue("targetables")],
                        backgroundColor: randColorI,
                        borderColor: randColorO,
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero: true
                            }
                        }]
                    }
                }
            });
        </script>
    </div>
    <div class="col-md-4">
        <p style="text-align: center; font-family:calibri; color:dimgray" >
            Number of participants in % for each category:
        </p>
        <canvas id="Chart2" width="200" height="100" style="text-align: center"></canvas>
        <script>
 
            var totalParticipantsCh2 = (Number(givevalue("adolescents")) +
                Number(givevalue("unlicensed")) +
                Number(givevalue("firstTimers")) +
                Number(givevalue("targetables")));

            var ctx = document.getElementById("Chart2").getContext('2d');               
            var Chart2 = new Chart(ctx, {
                type: 'polarArea',
                data: {
                    labels: ["adolescents", "unlicensed", "first-timers", "targetables"],
                    datasets: [{
                        label: '% of participants',
                        data: [percentageP("adolescents", totalParticipantsCh2), percentageP("unlicensed", totalParticipantsCh2), percentageP("firstTimers", totalParticipantsCh2), percentageP("targetables", totalParticipantsCh2)],
                        backgroundColor: randColorI,
                        borderColor: randColorO,
                        borderWidth: 1
                    }]
                }
            });
        </script>
    </div>
    <div class="col-md-4">
        <p style="text-align: center; font-family:calibri; color:dimgray" >
            Number of targetable participants in % for each category:
        </p>
        <canvas id="Chart3" width="200" height="100" style="text-align: center"></canvas>
        <script>
            var ctx = document.getElementById("Chart3").getContext('2d');
            var Chart3 = new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: ["drifters", "FWD", "No opinion", "FWD + No opinion"],
                    datasets: [{
                        label: '% of participants',
                        data: [percentageP("drifters", givevalue("targetables")),
                            percentageP("FWD", givevalue("targetables")),
                            percentageP("NO", givevalue("targetables")),
                            (Number(percentageP("FWD", givevalue("targetables"))) + Number(percentageP("NO", givevalue("targetables"))))],
                        backgroundColor: randColorI,
                        borderColor: randColorO,
                        borderWidth: 1
                    }]
                }
            });
        </script>
    </div>
</div>
<div class="row">
    <div class="row">
        <div class="col-md-4" style="visibility: hidden">
            <p>
                take space
                <br>
                take space
                <br>
            </p>
        </div>
        <div class="col-md-4">  
            <p>
                <br>
            </p>
            <p id="averageBMW" style="text-align: center; font-family:calibri; color:dimgray" >

            </p>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-4" style="visibility: hidden">
        <p>
            take space <br>
            take space <br>
        </p>
    </div>
    <div class="col-md-4">
        <canvas id="Chart4" width="200" height="100" style="text-align: center"></canvas>
        <script>
            var BMWmodels = givevalue("BMWType").split(',');

            var modelCounts = {};
            BMWmodels.forEach(function (x) { modelCounts[x] = (modelCounts[x] || 0) + 1; });
            console.log(modelCounts);

            //for (var i = 0; i < modelCounts.length; i++) {
            //    var randColor = ("rgba(" + (Math.floor(Math.random() * 256) + 1) + ", " + (Math.floor(Math.random() * 256) + 1) + ", " + (Math.floor(Math.random() * 255) + 1));
            //    randColorI.push(randColor + ", 0.2)");
            //    randColorO.push(randColor + ", 1)");
            //    console.log(randColor + ", 1)");
            //}

            var ctx = document.getElementById("Chart4").getContext('2d');
            var Chart4 = new Chart(ctx, {
                type: 'pie',
                data: {
                    labels: Object.keys(modelCounts),
                    datasets: [{
                        label: 'BMW model distribution',
                        data: Object.values(modelCounts),
                        backgroundColor: randColorI,
                        borderColor: randColorO,
                        borderWidth: 1
                    }]
                }
            });
        </script>
    </div>
    <div class="col-md-4">
            
    </div>  
</div>
<script>
    var averageOwnedBWMs;
    avgBMW();

    function avgBMW() {
        if (Number(givevalue("targetables")) == 0) {
            averageOwnedBWMs = 0;
            alert('We have no targetable participants');
        } else if (Number(givevalue("ownedBMWs")) == 0) {
            averageOwnedBWMs = 0;
        } else {
            averageOwnedBWMs = Number(givevalue("ownedBMWs")) / Number(givevalue("targetables"));
        }
        document.getElementById('averageBMW').innerHTML = "Targeted group owns " + Math.round(averageOwnedBWMs * 100) / 100 + " BMWs on average";
    }     
</script>
</asp:Content>


