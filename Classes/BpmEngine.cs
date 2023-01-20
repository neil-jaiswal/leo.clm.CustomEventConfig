using Newtonsoft.Json;

namespace EventConfig.Classes
{
    /// <summary>
    /// The bpm engine.
    /// </summary>
    public class BpmEngine
    {
        /// <summary>
        /// Gets or sets the bpm engine id.
        /// </summary>
        [JsonProperty("bpmEngineId")]
        public string BpmEngineId { get; set; }

        /// <summary>
        /// Gets or sets the process name.
        /// </summary>
        [JsonProperty("processName")]
        public string ProcessName { get; set; }

        /// <summary>
        /// Gets or sets the message name.
        /// </summary>
        [JsonProperty("messageName")]
        public string MessageName { get; set; }

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