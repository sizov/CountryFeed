package com.sizov.vo
{
	[Bindable]
	public class MessageVO
	{
		public static const DATE_FORMAT:String = "h:mm:ss a MMMM, dd, yyyy";

		public static const FIELD_DATE:String = "date";
		public static const FIELD_COUNTRY_CODE:String = "countryCode";
		public static const FIELD_COUNTRY_CITY:String = "city";

		public var date:Date;
		public var countryCode:String;
		public var city:String;

		public function MessageVO(date:Date, countryCode:String, city:String)
		{
			this.date = date;
			this.countryCode = countryCode;
			this.city = city;
		}
	}
}
