package com.sizov.model.presentation
{
	import com.sizov.components.CountryFeedResponder;
	import com.sizov.components.IFeedManager;
	import com.sizov.messages.StartFeedMessage;
	import com.sizov.messages.StopFeedMessage;

	[Bindable]
	public class ToolBarPM
	{
		[Inject]
		public var feedManager:IFeedManager;

		[Inject]
		public var countryFeedResponder:CountryFeedResponder;

		[MessageDispatcher]
		public var dispatcher:Function;

		public function startFeed():void
		{
			dispatcher(new StartFeedMessage());
		}

		public function stopFeed():void
		{
			dispatcher(new StopFeedMessage());
		}
	}
}
