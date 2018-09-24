<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Survey.aspx.cs" Inherits="_Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript" language="javascript">

        var questionNumber = 1;

        function ChangeQNumber() {
            questionNumber++;
            document.getElementById('h2Q').innerHTML = 'Question ' + questionNumber + ':';
        }

        function ResetQNumber() {
            questionNumber = 1;
            document.getElementById('h2Q').innerHTML = 'Question ' + questionNumber + ':';
        }

        function ThankYouMsg() {
            document.getElementById('h2Q').innerHTML = 'Thank you for participating in our survey!';
        }

        function check() {
            for (var i = 0; i < localStorage.length; i++) {
                console.log(localStorage.key(i));
            };
        }

        function StoreValue(key, value) {
            check();
            var num;
            if (localStorage.getItem(key)) {
                num = Number(localStorage.getItem(key)) + Number(value);
                localStorage.setItem(key, num);
            } else {
                localStorage.setItem(key, Number(value));
            }
            console.log(key + ":" + localStorage.getItem(key) + "");
        }

        function storeBMWTypeCount(type) {
            var existing = localStorage.getItem("BMWType");
            existing = existing ? existing.split(',') : [];
            existing.push(type);
            localStorage.setItem("BMWType", existing.toString());
            console.log("BMWTypes:" + localStorage.getItem("BMWType") + "");
        };

        // for purposes of quickly storing some values and checking statistics
        function generateTestValues() {
            localStorage.setItem("adolescents", (Math.floor(Math.random() * 100) + 60));
            localStorage.setItem("unlicensed", (Math.floor(Math.random() * 80) + 30));
            localStorage.setItem("firstTimers", (Math.floor(Math.random() * 100) + 60));
            localStorage.setItem("targetables", (Math.floor(Math.random() * 150) + 80));
            var targetables = localStorage.getItem("targetables");
            var FWD = Number(targetables) - (Math.floor(Math.random() * Math.floor((targetables / 3)) + 10) + Math.floor((targetables / 3)) - 10);
            targetables = targetables - FWD;
            var RWD = Number(targetables) - (Math.floor(Math.random() * Math.floor((targetables / 3)) + 10) + Math.floor((targetables / 3)) - 10);
            var NO = targetables - RWD;
            localStorage.setItem("FWD", FWD);
            localStorage.setItem("RWD", RWD);
            localStorage.setItem("NO", NO);
            targetables = localStorage.getItem("targetables");
            var drifters = Number(targetables) - (Math.floor(Math.random() * Math.floor((targetables / 2)) + 20) + Math.floor((targetables / 2)) - 20);
            var nonDrifters = targetables - drifters;
            localStorage.setItem("drifters", drifters);
            localStorage.setItem("nonDrifters", nonDrifters);
            localStorage.setItem("ownedBMWs", (Math.floor(Math.random() * 120) + 60));
            var BWMTypes = ["M885i", "M885i", "M885i", "M885i", "M396", "M396", "M396", "M617", "M617", "320d", "320d", "320d", "320d", "320d", "320d", "M617", "M617", "M617", "M396"];
            for (var i = 0; i < BWMTypes.length; i++) {
                storeBMWTypeCount(BWMTypes[i]);
            }
        }

    </script>
    
    <div class="jumbotron" style="padding-bottom: 10px; padding-top: 10px">
        <h1 style="text-align: center">
            <img src="https://i.pinimg.com/originals/27/6a/97/276a970cd35a83cc71beee75cb89f382.png" style="width:150px;height:150px;">
            BMW Survey
        </h1>
    </div>

    <div class="row">
        <h2 id="h2Q" style="text-align: center">Question 1:</h2>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:PlaceHolder ID="PlaceHolder1" runat="server">
                    <div class="row">
                        <p style="text-align: center">
                            Please enter your age:                    
                            <asp:TextBox ID="Q1TextBox" runat="server"></asp:TextBox>
                        </p>
                    </div>
                    <div class="row" style="text-align: center">
                            <asp:Button ID="Button1" runat="server" Text="Next Question" OnClick="Button1_Click" />
                    </div>
                </asp:PlaceHolder>

                <asp:PlaceHolder ID="PlaceHolder2" runat="server">
                    <div class="row">
                        <p style="text-align: center">
                            Please select your gender:
                            <asp:DropDownList ID="Q2DropDownList" runat="server">
                                <asp:ListItem Enabled="true" Text=" " Value="-1"></asp:ListItem>
                                <asp:ListItem Text="Male" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Female" Value="2"></asp:ListItem>
                            </asp:DropDownList>
                        </p>
                    </div>
                    <div class="row" style="text-align: center">
                        <asp:Button ID="Button2" runat="server" Text="Next Question" OnClick="Button2_Click" />
                    </div>
                </asp:PlaceHolder>

                <asp:PlaceHolder ID="PlaceHolder3" runat="server">
                    <div class="row">
                        <p style="text-align: center">
                            Do you own a car driving license?
                            <asp:DropDownList ID="Q3DropDownList" runat="server">
                                <asp:ListItem Enabled="true" Text=" " Value="-1"></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                <asp:ListItem Text="No, I prefer using other transport" Value="2"></asp:ListItem>
                            </asp:DropDownList>
                        </p>
                    </div>
                    <div class="row" style="text-align: center">
                        <asp:Button ID="Button3" runat="server" Text="Next Question" OnClick="Button3_Click" />
                    </div>
                </asp:PlaceHolder>

                <asp:PlaceHolder ID="PlaceHolder4" runat="server">
                    <div class="row">
                        <p style="text-align: center">
                            Is this your first car?
                            <asp:DropDownList ID="Q4DropDownList" runat="server">
                                <asp:ListItem Enabled="true" Text=" " Value="-1"></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                <asp:ListItem Text="No" Value="2"></asp:ListItem>
                            </asp:DropDownList>
                        </p>
                    </div>
                    <div class="row" style="text-align: center">
                        <asp:Button ID="Button4" runat="server" Text="Next Question" OnClick="Button4_Click" />
                    </div>
                </asp:PlaceHolder>

                <asp:PlaceHolder ID="PlaceHolder5" runat="server">
                    <div class="row">
                        <p style="text-align: center">
                            Which drivetrain do you prefer?
                            <asp:DropDownList ID="Q5DropDownList" runat="server">
                                <asp:ListItem Enabled="true" Text=" " Value="-1"></asp:ListItem>
                                <asp:ListItem Text="FWD" Value="1"></asp:ListItem>
                                <asp:ListItem Text="RWD" Value="2"></asp:ListItem>
                                <asp:ListItem Text="I don’t know" Value="3"></asp:ListItem>
                            </asp:DropDownList>
                        </p>
                    </div>
                    <div class="row" style="text-align: center">
                        <asp:Button ID="Button5" runat="server" Text="Next Question" OnClick="Button5_Click" />
                    </div>
                </asp:PlaceHolder>

                <asp:PlaceHolder ID="PlaceHolder6" runat="server">
                    <div class="row">
                        <p style="text-align: center">
                            Do you care about drifting?
                            <asp:DropDownList ID="Q6DropDownList" runat="server">
                                <asp:ListItem Enabled="true" Text=" " Value="-1"></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                <asp:ListItem Text="No" Value="2"></asp:ListItem>
                            </asp:DropDownList>
                        </p>
                    </div>
                    <div class="row" style="text-align: center">
                        <asp:Button ID="Button6" runat="server" Text="Next Question" OnClick="Button6_Click" />
                    </div>
                </asp:PlaceHolder>

                <asp:PlaceHolder ID="PlaceHolder7" runat="server">
                    <div class="row">
                        <p style="text-align: center">
                            How many BMWs did you drive?
                            <asp:TextBox ID="Q7TextBox" runat="server"></asp:TextBox>
                        </p>
                    </div>
                    <div class="row" style="text-align: center">
                        <asp:Button ID="Button7" runat="server" Text="Next Question" OnClick="Button7_Click" />
                    </div>
                </asp:PlaceHolder>

                <asp:PlaceHolder ID="PlaceHolder8" runat="server">
                    <div class="row">
                        <p style="text-align: center">
                            Which BMW did you drive?
                            <asp:TextBox ID="Q8TextBox" runat="server"></asp:TextBox>
                        </p>
                    </div>
                    <div class="row" style="text-align: center">
                        <asp:Button ID="Button8" runat="server" Text="Proceed" OnClick="Button8_Click" />
                    </div>
                </asp:PlaceHolder>
                
                <asp:PlaceHolder ID="PlaceHolder9" runat="server">
                    <div class="row">
                        <p style="text-align: center">    
                            We now have all required information from you.<br>
                            You may retake the survey if you so please..
                        </p>
                    </div>
                    <div class="row" style="text-align: center">
                        <asp:Button ID="Button9" runat="server" Text="Retake survey" OnClick="Button9_Click" />
                    </div>
                </asp:PlaceHolder>

            </ContentTemplate>

            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="Button1" />
                <asp:AsyncPostBackTrigger ControlID="Button2" />
                <asp:AsyncPostBackTrigger ControlID="Button3" />
                <asp:AsyncPostBackTrigger ControlID="Button4" />
                <asp:AsyncPostBackTrigger ControlID="Button5" />
                <asp:AsyncPostBackTrigger ControlID="Button6" />
                <asp:AsyncPostBackTrigger ControlID="Button7" />
                <asp:AsyncPostBackTrigger ControlID="Button8" />
            </Triggers>
            
        </asp:UpdatePanel>
    </div>
    <script>
       
    </script>
</asp:Content>


