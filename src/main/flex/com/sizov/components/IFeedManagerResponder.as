package com.sizov.components
{
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.events.MessageEvent;

	/**
	 * Interface that defines methods for feed manager responder.
	 */
	public interface IFeedManagerResponder
	{
		function messageHandler(event:MessageEvent):void;

		function channelFaultHandler(event:ChannelFaultEvent):void;
	}
}
