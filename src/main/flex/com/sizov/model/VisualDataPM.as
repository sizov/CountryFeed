package com.sizov.model
{
	import com.sizov.components.CountryFeedResponder;
	import com.sizov.components.IFeedManager;

	[Bindable]
	public class VisualDataPM
	{
		[Inject]
		public var feedManager:IFeedManager;

		//TODO: maybe connect only to feedmanager.responder

		[Inject]
		public var countryFeedResponder:CountryFeedResponder;
	}
}
