package com.sizov.events
{
	import flash.events.Event;

	public class FeedEvent extends Event
	{
		public static const FEED_STARTED:String = "feedStarted";
		public static const FEED_STOPPED:String = "feedStopped";

		public function FeedEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

		override public function clone():Event
		{
			return new FeedEvent(type);
		}
	}
}
