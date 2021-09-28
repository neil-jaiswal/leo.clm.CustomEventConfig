using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EventConfig.Classes
{
    public class Event
    {
        [JsonProperty("eventId")]
        public string EventId { get; set; }

        [JsonProperty("eventName")]
        public string EventName { get; set; }

        [JsonProperty("appId")]
        public int AppId { get; set; }

        [JsonProperty("documentEntity")]
        public string DocumentEntity { get; set; }

        [JsonProperty("isActive")]
        public bool IsActive { get; set; }

        [JsonProperty("onPre")]
        public bool OnPre { get; set; }
    }

    public class EventConfiguration
    {
        public RuleEngine RuleEngine { get; set; }
        public BpmEngine BpmEngine { get; set; }
    }
}
