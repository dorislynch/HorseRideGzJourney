using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Horse.Ride.Gz.Journey.RNHorseRideGzJourney
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNHorseRideGzJourneyModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNHorseRideGzJourneyModule"/>.
        /// </summary>
        internal RNHorseRideGzJourneyModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNHorseRideGzJourney";
            }
        }
    }
}
