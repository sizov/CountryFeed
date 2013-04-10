package com.sizov.model.presentation
{
	import com.sizov.components.CountryFeedResponder;
	import com.sizov.components.IFeedManager;

	import flash.events.Event;

	[Event("feedStarted")]
	[Bindable]
	public class ToolBarPM
	{
		[Inject]
		public var feedManager:IFeedManager;

		[Inject]
		public var countryFeedResponder:CountryFeedResponder;

		public function startFeed():void
		{
			countryFeedResponder.resetFeedItems();
			feedManager.start();
		}

		public function stopFeed():void
		{
			feedManager.stop();
		}
	}
}
