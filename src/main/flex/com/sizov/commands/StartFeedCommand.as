package com.sizov.commands
{
	import com.sizov.components.CountryFeedResponder;
	import com.sizov.components.IFeedManager;
	import com.sizov.messages.ServiceMessage;

	public class StartFeedCommand
	{
		[Inject]
		public var feedManager:IFeedManager;

		[Inject]
		public var countryFeedResponder:CountryFeedResponder;

		public function execute(message:ServiceMessage):void
		{
			countryFeedResponder.resetFeedItems();
			feedManager.start();
		}
	}
}
