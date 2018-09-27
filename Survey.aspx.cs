using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : Page
{
    private static int _age;

    public static int QuestionNumber = 1;
    public static int carCount;

    protected void Page_Load(object sender, EventArgs e)
    {
        PlaceHolderVisibilityReset();        
    }

    protected void SwitchPlaceHolder(PlaceHolder currentHolder, PlaceHolder nextHolder)
    {
        nextHolder.Visible = true;
        currentHolder.Visible = false;
        HidePl1();
        if (nextHolder == PlaceHolder9)
        {
            ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "text", "ThankYouMsg()", true);
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "text", "ChangeQNumber()", true);
        }
        
        //QuestionNumber++;
    }

    protected void KeepPlaceHolder(PlaceHolder currentHolder)
    {
        currentHolder.Visible = true;
        HidePl1();
    }

    protected void HidePl1()
    {
        PlaceHolder1.Visible = false;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {

        if (int.TryParse(Q1TextBox.Text, out _age) && ! Q1TextBox.Text.StartsWith("0"))
        {
            _age = int.Parse(Q1TextBox.Text);
            if (_age > 17 && _age < 120)
            {
                SwitchPlaceHolder(PlaceHolder1, PlaceHolder2);
            }
            else if (_age > 0 && _age < 18)
            {
                SwitchPlaceHolder(PlaceHolder1, PlaceHolder9);
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "StoreValue('adolescents', 1)", true);               
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "ClientScript",
                    "alert('Please fill a believable age')", true);
            }            
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "ClientScript",
                "alert('Please fill in a whole number')", true);
        }              
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        if (Q2DropDownList.SelectedValue != "-1")
        {
            SwitchPlaceHolder(PlaceHolder2, PlaceHolder3);
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "ClientScript", 
                "alert('Please select a valid option')", true);
            KeepPlaceHolder(PlaceHolder2);
        }
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        if (Q3DropDownList.SelectedValue != "-1")
        {
            if (Q3DropDownList.SelectedValue == "1")
            {
                
                if (17 < _age && _age < 26)
                {
                    SwitchPlaceHolder(PlaceHolder3, PlaceHolder4);
                }
                else
                {
                    SwitchPlaceHolder(PlaceHolder3, PlaceHolder5);
                }
            }
            else
            {
                SwitchPlaceHolder(PlaceHolder3, PlaceHolder9);
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "StoreValue('unlicensed', 1)", true);
            }           
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "ClientScript", 
                "alert('Please select a valid option')", true);
            KeepPlaceHolder(PlaceHolder3);
        }
    }

    protected void Button4_Click(object sender, EventArgs e)
    {
        if (Q4DropDownList.SelectedValue == "1")
        {
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "ClientScript",
                "alert('We are targeting more experienced clients, thank you for your interest')", true);
            SwitchPlaceHolder(PlaceHolder4, PlaceHolder9);
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "StoreValue('firstTimers', 1)", true);
        }
        else if (Q4DropDownList.SelectedValue == "2") 
        {
            SwitchPlaceHolder(PlaceHolder4, PlaceHolder5);
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "StoreValue('targetables', 1)", true);
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "ClientScript", 
                "alert('Please select a valid option')", true);
            KeepPlaceHolder(PlaceHolder4);
        }
    }

    protected void Button5_Click(object sender, EventArgs e)
    {
        if (Q5DropDownList.SelectedValue != "-1")
        {
            SwitchPlaceHolder(PlaceHolder5, PlaceHolder6);
            if (Q5DropDownList.SelectedValue == ("1"))
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "StoreValue('FWD', 1)", true);
            } 
            else if (Q5DropDownList.SelectedValue == ("2"))
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "StoreValue('RWD', 1)", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "StoreValue('NO', 1)", true);
            }
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "ClientScript", 
                "alert('Please select a valid option')", true);
            KeepPlaceHolder(PlaceHolder5);
        }
    }

    protected void Button6_Click(object sender, EventArgs e)
    {
        if (Q6DropDownList.SelectedValue != "-1")
        {
            SwitchPlaceHolder(PlaceHolder6, PlaceHolder7);
            if (Q6DropDownList.SelectedValue == ("1"))
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "StoreValue('drifters', 1)", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "StoreValue('nonDrifters', 1)", true);
            }
            
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "ClientScript", 
                "alert('Please select a valid option')", true);
            KeepPlaceHolder(PlaceHolder6);
        }
    }

    protected void Button7_Click(object sender, EventArgs e)
    {
        
        Regex validateCount = new Regex("^[0].+");

        if (int.TryParse(Q7TextBox.Text, out carCount) && !validateCount.IsMatch(Q7TextBox.Text))
        {
            carCount = int.Parse(Q7TextBox.Text);
            if (carCount == 0)
            {
                SwitchPlaceHolder(PlaceHolder7, PlaceHolder9);
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "StoreValue('ownedBMWs', 0)", true);
            }
            else if (carCount > 0 && carCount < 20)
            {
                SwitchPlaceHolder(PlaceHolder7, PlaceHolder8);
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "StoreValue('ownedBMWs', '" + carCount + "');", true);

            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "ClientScript",
                    "alert('Please enter a believable ammount')", true);
                KeepPlaceHolder(PlaceHolder7);
            }
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "ClientScript",
                "alert('Please enter a proper numeric value')", true);
            KeepPlaceHolder(PlaceHolder7);
        }
        
    }

    protected void Button8_Click(object sender, EventArgs e)
    {
        Regex pattern1 = new Regex("^[M]{0,1}[0-9]{3}[di]{0,1}$");
        Regex pattern2 = new Regex("^[XZ][0-9]$");

        if (pattern1.IsMatch(Q8TextBox.Text) || pattern2.IsMatch(Q8TextBox.Text))
        {
            SwitchPlaceHolder(PlaceHolder8, PlaceHolder9);
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "storeBMWTypeCount('" + Q8TextBox.Text + "');", true);
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "ClientScript",
                "alert('Please enter a valid BMW type')", true);
            KeepPlaceHolder(PlaceHolder8);
        }
    }

    protected void Button9_Click(object sender, EventArgs e)
    {
        EntryReset();
        PlaceHolderVisibilityReset();
        ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "text", "ResetQNumber()", true);
    }

    protected void EntryReset()
    {
        Q1TextBox.Text = "";
        Q2DropDownList.SelectedValue = "-1";
        Q3DropDownList.SelectedValue = "-1";
        Q4DropDownList.SelectedValue = "-1";
        Q5DropDownList.SelectedValue = "-1";
        Q6DropDownList.SelectedValue = "-1";
        Q7TextBox.Text = "";
        Q8TextBox.Text = "";

    }

    protected void PlaceHolderVisibilityReset()
    {
        PlaceHolder1.Visible = true;
        PlaceHolder2.Visible = false;
        PlaceHolder3.Visible = false;
        PlaceHolder4.Visible = false;
        PlaceHolder5.Visible = false;
        PlaceHolder6.Visible = false;
        PlaceHolder7.Visible = false;
        PlaceHolder8.Visible = false;
        PlaceHolder9.Visible = false;
    }
}
