using EventConfig.Classes;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace EventConfig
{
    public partial class Form1 : Form
    {
        private readonly string RuleEngineScript = string.Empty;
        private readonly string BpmnEngineScript = string.Empty;
        private readonly StringBuilder builder = new StringBuilder().Append(string.Empty);
        public Form1()
        {
            InitializeComponent();
            richTextBox2.WordWrap = true;
            richTextBox2.AcceptsTab = true;

            RuleEngineScript = string.Format("{0}\\Scripts\\RuleScripts.sql", Directory.GetParent(Directory.GetCurrentDirectory()).Parent.Parent.FullName);
            BpmnEngineScript = string.Format("{0}\\Scripts\\BpmnScript.sql", Directory.GetParent(Directory.GetCurrentDirectory()).Parent.Parent.FullName);
            richTextBox2.AppendText("Rule Engine : " + RuleEngineScript);
            richTextBox2.AppendText(Environment.NewLine);
            richTextBox2.AppendText("Bpmn Engine : " + BpmnEngineScript);

        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                richTextBox2.Text = string.Empty;
                openFileDialog1.ShowDialog();
                if (File.Exists(openFileDialog1.FileName))
                {
                    var JsonText = File.ReadAllText(openFileDialog1.FileName);
                    var JObjectData = JsonConvert.DeserializeObject<JToken>(JsonText);
                    if (JObjectData is JArray)
                    {
                        foreach (var objectItem in JObjectData)
                        { var eventdata = Xoxo(objectItem); }
                    }

                    if (JObjectData is JObject)
                    { var eventdata = Xoxo(JObjectData); }

                    MessageBox.Show("File Exported Successfully");

                    /*******
                    FileStream fileStream = File.OpenRead(openFileDialog1.FileName); 
                    TextReader textReader = File.OpenText(openFileDialog1.FileName); 
                    StreamReader sreamReader = new StreamReader(openFileDialog1.FileName);
                    **********/
                }
            }
            catch (Exception ex)
            {
                richTextBox2.Text = ex.Message;
                MessageBox.Show(ex.Message, "Information", MessageBoxButtons.RetryCancel);
            }
        }

        private EventConfiguration Xoxo(JToken objectItem)
        {
            var eventData = new EventConfiguration();
            if (Convert.ToString(objectItem.SelectToken("eventConfigurationType")) == "Rule")
            {
                var RuleClass = JsonConvert.DeserializeObject<RuleEngine>(objectItem.ToString());
                if (checkBox1.Checked)
                {
                    RuleClass.RuleEngineConfigurationId = Guid.NewGuid().ToString();
                    RuleClass.EventConfigurationId = Guid.NewGuid().ToString();
                }

                if (checkBox2.Checked)
                    RuleClass.Bpc = string.IsNullOrEmpty(richTextBox1.Text) ? RuleClass.Bpc : richTextBox1.Text;

                if (RuleClass != null)
                {
                    var REScript = File.ReadAllText(RuleEngineScript);
                    REScript = REScript.Replace("[#BPC]", RuleClass.Bpc)
                                       .Replace("[#EVENTID]", RuleClass.EventId)
                                       .Replace("[#EVENTNAME]", RuleClass.Event.EventName)
                                       .Replace("[#EVENTCONGIFID]", RuleClass.EventConfigurationId)
                                       .Replace("[#RULEENGINEID]", RuleClass.RuleEngineConfigurationId)
                                       .Replace("[#EVENTTRIGGER]", RuleClass.EventTrigger);
                  
                    richTextBox2.AppendText(Environment.NewLine);
                    richTextBox2.AppendText(REScript);
                    var fileName = string.Format("{0}_{1}_{2}.sql", RuleClass.Event.AppId, RuleClass.EventTrigger, RuleClass.Event.EventName);

                    richTextBox2.AppendText(Environment.NewLine);
                    richTextBox2.AppendText(fileName);

                    TextWriter txt = new StreamWriter(string.Format("{0}\\SQL\\{1}", Directory.GetParent(Directory.GetCurrentDirectory()).Parent.Parent.FullName, fileName.ToUpper()));
                    txt.Write(REScript);
                    txt.Close();
                }
            }
            else if (Convert.ToString(objectItem.SelectToken("eventConfigurationType")) == "Camunda")
            {
                var BpmnClass = JsonConvert.DeserializeObject<BpmEngine>(objectItem.ToString());
                if (checkBox1.Checked)
                {
                    BpmnClass.BpmEngineId = Guid.NewGuid().ToString();
                    BpmnClass.EventConfigurationId = Guid.NewGuid().ToString();
                    BpmnClass.MessageName = string.IsNullOrEmpty(BpmnClass.MessageName) ? null : BpmnClass.MessageName;
                }
                if (checkBox2.Checked)
                    BpmnClass.Bpc = string.IsNullOrEmpty(richTextBox1.Text) ? BpmnClass.Bpc : richTextBox1.Text;

                if (BpmnClass != null)
                {
                    var BpmnScript = File.ReadAllText(BpmnEngineScript);
                    BpmnScript = BpmnScript.Replace("[#BPC]", BpmnClass.Bpc)
                                           .Replace("[#EVENTID]", BpmnClass.Event.EventId)
                                           .Replace("[#EVENTNAME]", BpmnClass.Event.EventName)
                                           .Replace("[#EVENTCONFIGID]", BpmnClass.EventConfigurationId)
                                           .Replace("[#BPMNENGINEID]", BpmnClass.BpmEngineId)
                                           .Replace("[#PROCESSNAME]", BpmnClass.ProcessName)
                                           .Replace("[#MESSAGENAME]", BpmnClass.MessageName);

                    richTextBox2.AppendText(Environment.NewLine);
                    richTextBox2.AppendText(BpmnScript);
                    var fileName = string.Format("{0}_{1}.sql", BpmnClass.ProcessName, BpmnClass.Event.EventName);

                    richTextBox2.AppendText(Environment.NewLine);
                    richTextBox2.AppendText(fileName);
                    TextWriter txt = new StreamWriter(string.Format("{0}\\SQL\\{1}", Directory.GetParent(Directory.GetCurrentDirectory()).Parent.Parent.FullName, fileName.ToUpper()));
                    txt.Write(BpmnScript);
                    txt.Close();
                }
            }
            return eventData;
        }

        private void checkBox2_CheckedChanged(object sender, EventArgs e)
        {
            if (checkBox2.Checked)
                richTextBox1.Visible = true;
            else
                richTextBox1.Visible = false;
        }

        private void richTextBox1_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (System.Text.RegularExpressions.Regex.IsMatch(richTextBox1.Text, "[^0-9]"))
            {
                MessageBox.Show("Please enter only numbers.");
                richTextBox1.Text = richTextBox1.Text.Remove(richTextBox1.Text.Length - 1);
                richTextBox1.Text = string.Empty;
            }
        }
    }
}
