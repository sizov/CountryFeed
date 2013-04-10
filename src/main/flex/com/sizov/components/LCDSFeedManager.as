package com.sizov.components
{
	import com.sizov.events.FeedEvent;

	import flash.errors.IllegalOperationError;
	import flash.events.EventDispatcher;

	import mx.messaging.Consumer;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.events.MessageEvent;

	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;

	[Event("feedStarted")]
	[Event("feedStopped")]
	public class LCDSFeedManager extends EventDispatcher implements IFeedManager
	{
		private static const LOG:Logger = LogContext.getLogger(LCDSFeedManager);

		public function start():void
		{
			if (isRunning) return;

			if (!consumer) {
				throw new IllegalOperationError("Consumer can't be null");
			}

			subscribe();

			_isRunning = true;

			dispatchEvent(new FeedEvent(FeedEvent.FEED_STARTED));
		}

		public function stop():void
		{
			if (!isRunning) return;

			unsubscribe();

			_isRunning = false;

			dispatchEvent(new FeedEvent(FeedEvent.FEED_STOPPED));
		}

		private function subscribe():void
		{
			consumer.subscribe();

			if (LOG.isInfoEnabled()) {
				LOG.info("Subscribed to feed");
			}
		}

		private function unsubscribe():void
		{
			consumer.unsubscribe();

			if (LOG.isInfoEnabled()) {
				LOG.info("Unsubscribed from feed");
			}
		}

		/*============================================================*/
		/*isRunning*/
		/*============================================================*/
		private var _isRunning:Boolean;

		[Bindable("feedStarted")]
		[Bindable("feedStopped")]
		public function get isRunning():Boolean
		{
			return _isRunning;
		}

		/*============================================================*/
		/*Consumer*/
		/*============================================================*/
		private var _consumer:Consumer;

		public function get consumer():Consumer
		{
			return _consumer;
		}

		public function set consumer(value:Consumer):void
		{
			if (value == consumer)return;

			if (consumer) {
				consumer.removeEventListener(MessageEvent.MESSAGE, consumer_messageHandler);
				consumer.removeEventListener(ChannelFaultEvent.FAULT, consumer_channelFaultHandler);
			}

			_consumer = value;

			if (consumer) {
				consumer.addEventListener(MessageEvent.MESSAGE, consumer_messageHandler);
				consumer.addEventListener(ChannelFaultEvent.FAULT, consumer_channelFaultHandler);
			}
		}

		/*============================================================*/
		/*Feed responder*/
		/*============================================================*/
		private var _responder:IFeedManagerResponder;

		public function get responder():IFeedManagerResponder
		{
			return _responder;
		}

		public function set responder(value:IFeedManagerResponder):void
		{
			_responder = value;
		}

		/*============================================================*/

		private function consumer_messageHandler(event:MessageEvent):void
		{
			if (responder) {
				responder.messageHandler(event);
			}

			if (LOG.isInfoEnabled()) {
				LOG.info("Consumer message received")
			}
		}

		private function consumer_channelFaultHandler(event:ChannelFaultEvent):void
		{
			if (responder) {
				responder.channelFaultHandler(event);
			}

			if (LOG.isErrorEnabled()) {
				LOG.error("Consumer fault received")
			}
		}
	}
}
