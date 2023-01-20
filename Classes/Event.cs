using Newtonsoft.Json;

namespace EventConfig.Classes
{
    /// <summary>
    /// The event.
    /// </summary>
    public class Event
    {
        /// <summary>
        /// Gets or sets the event id.
        /// </summary>
        [JsonProperty("eventId")]
        public string EventId { get; set; }

        /// <summary>
        /// Gets or sets the event name.
        /// </summary>
        [JsonProperty("eventName")]
        public string EventName { get; set; }

        /// <summary>
        /// Gets or sets the app id.
        /// </summary>
        [JsonProperty("appId")]
        public int AppId { get; set; }

        /// <summary>
        /// Gets or sets the document entity.
        /// </summary>
        [JsonProperty("documentEntity")]
        public string DocumentEntity { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether is active.
        /// </summary>
        [JsonProperty("isActive")]
        public bool IsActive { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether on pre.
        /// </summary>
        [JsonProperty("onPre")]
        public bool OnPre { get; set; }
    }

    /// <summary>
    /// The event configuration.
    /// </summary>
    public class EventConfiguration
    {
        /// <summary>
        /// Gets or sets the rule engine.
        /// </summary>
        public RuleEngine RuleEngine { get; set; }
        /// <summary>
        /// Gets or sets the bpm engine.
        /// </summary>
        public BpmEngine BpmEngine { get; set; }
    }
}