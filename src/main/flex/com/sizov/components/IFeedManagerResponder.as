package com.sizov.components
{
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.events.MessageEvent;

	public interface IFeedManagerResponder
	{
		function messageHandler(event:MessageEvent):void;
		function channelFaultHandler(event:ChannelFaultEvent):void;
	}
}
