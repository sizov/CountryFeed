package com.sizov.vo
{
	import mx.messaging.messages.IMessage;

	[Bindable]
	public class MessageVO
	{
		public static const FIELD_DATE:String = "date";
		public static const FIELD_COUNTRY_CODE:String = "countryCode";
		public static const DATE_FORMAT:String = "h:mm:ss a MMMM, dd, yyyy";

		public var date:Date;
		public var message:IMessage;
		public var countryCode:String;

		public function MessageVO(message:IMessage, date:Date, countryCode:String)
		{
			this.message = message;
			this.date = date;
			this.countryCode = countryCode;
		}
	}
}
