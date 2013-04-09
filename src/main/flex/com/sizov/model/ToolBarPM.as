package com.sizov.model
{
	import com.sizov.components.CountryFeedResponder;
	import com.sizov.components.IFeedManager;

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
