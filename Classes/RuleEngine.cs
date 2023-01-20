using Newtonsoft.Json;

namespace EventConfig.Classes
{
    /// <summary>
    /// The rule engine.
    /// </summary>
    public class RuleEngine
    {
        /// <summary>
        /// Gets or sets the rule engine configuration id.
        /// </summary>
        [JsonProperty("ruleEngineConfigurationId")]
        public string RuleEngineConfigurationId { get; set; }

        /// <summary>
        /// Gets or sets the business case.
        /// </summary>
        [JsonProperty("businessCase")]
        public object BusinessCase { get; set; }

        /// <summary>
        /// Gets or sets the document group.
        /// </summary>
        [JsonProperty("documentGroup")]
        public string DocumentGroup { get; set; }

        /// <summary>
        /// Gets or sets the event trigger.
        /// </summary>
        [JsonProperty("eventTrigger")]
        public string EventTrigger { get; set; }

        /// <summary>
        /// Gets or sets the scope.
        /// </summary>
        [JsonProperty("scope")]
        public object Scope { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether execute all rules.
        /// </summary>
        [JsonProperty("executeAllRules")]
        public bool ExecuteAllRules { get; set; }

        /// <summary>
        /// Gets or sets the event configuration id.
        /// </summary>
        [JsonProperty("eventConfigurationId")]
        public string EventConfigurationId { get; set; }

        /// <summary>
        /// Gets or sets the event id.
        /// </summary>
        [JsonProperty("eventId")]
        public string EventId { get; set; }

        /// <summary>
        /// Gets or sets the event.
        /// </summary>
        [JsonProperty("event")]
        public Event Event { get; set; }

        /// <summary>
        /// Gets or sets the event moment.
        /// </summary>
        [JsonProperty("eventMoment")]
        public int EventMoment { get; set; }

        /// <summary>
        /// Gets or sets the sequence.
        /// </summary>
        [JsonProperty("sequence")]
        public int Sequence { get; set; }

        /// <summary>
        /// Gets or sets the bpc.
        /// </summary>
        [JsonProperty("bpc")]
        public string Bpc { get; set; }

        /// <summary>
        /// Gets or sets the event configuration type.
        /// </summary>
        [JsonProperty("eventConfigurationType")]
        public string EventConfigurationType { get; set; }

        /// <summary>
        /// Gets or sets the version.
        /// </summary>
        [JsonProperty("version")]
        public int Version { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether is active.
        /// </summary>
        [JsonProperty("isActive")]
        public bool IsActive { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether is sync.
        /// </summary>
        [JsonProperty("isSync")]
        public bool IsSync { get; set; }
    }
}