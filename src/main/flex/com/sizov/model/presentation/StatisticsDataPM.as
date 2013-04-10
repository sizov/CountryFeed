package com.sizov.model.presentation
{
	import com.sizov.components.CountryFeedResponder;
	import com.sizov.components.IFeedManager;

	[Bindable]
	public class StatisticsDataPM
	{
		[Inject]
		public var feedManager:IFeedManager;

		[Inject]
		public var countryFeedResponder:CountryFeedResponder;
	}
}
