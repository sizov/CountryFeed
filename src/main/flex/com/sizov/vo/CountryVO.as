package com.sizov.vo
{
	[Bindable]
	public class CountryVO
	{
		public static const FIELD_HITS:String = "hits";
		public static const FIELD_COUNTRY:String = "countryCode";

		public var countryCode:String;
		public var hits:Number;

		public function CountryVO(countryCode:String)
		{
			this.countryCode = countryCode;
		}
	}
}
