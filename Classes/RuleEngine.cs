using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EventConfig.Classes
{
    public class RuleEngine
    {
        [JsonProperty("ruleEngineConfigurationId")]
        public string RuleEngineConfigurationId { get; set; }

        [JsonProperty("businessCase")]
        public object BusinessCase { get; set; }

        [JsonProperty("documentGroup")]
        public string DocumentGroup { get; set; }

        [JsonProperty("eventTrigger")]
        public string EventTrigger { get; set; }

        [JsonProperty("scope")]
        public object Scope { get; set; }

        [JsonProperty("executeAllRules")]
        public bool ExecuteAllRules { get; set; }

        [JsonProperty("eventConfigurationId")]
        public string EventConfigurationId { get; set; }

        [JsonProperty("eventId")]
        public string EventId { get; set; }

        [JsonProperty("event")]
        public Event Event { get; set; }

        [JsonProperty("eventMoment")]
        public int EventMoment { get; set; }

        [JsonProperty("sequence")]
        public int Sequence { get; set; }

        [JsonProperty("bpc")]
        public string Bpc { get; set; }

        [JsonProperty("eventConfigurationType")]
        public string EventConfigurationType { get; set; }

        [JsonProperty("version")]
        public int Version { get; set; }

        [JsonProperty("isActive")]
        public bool IsActive { get; set; }

        [JsonProperty("isSync")]
        public bool IsSync { get; set; }

    }
}
