package com.sizov.components
{
	import com.sizov.vo.MessageVO;
	import com.sizov.utils.LayoutManagerClientHelper;
	import com.sizov.vo.CountryVO;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.events.MessageEvent;

	public class CountryFeedResponder extends EventDispatcher implements IFeedManagerResponder
	{
		private static const FEED_ITEMS_CHANGED:String = "feedItemsChanged";

		/**
		 * Accumulation of messages.
		 */
		[Bindable]
		public var messageHistory:ArrayCollection;

		[Bindable]
		public var firstMessage:MessageVO;

		[Bindable]
		public var lastMessage:MessageVO;

		/**
		 * Map that holds amount of hits per country code.
		 * Key is Country code, value is amount of hits.
		 */
		private var countryHits:Dictionary = new Dictionary();
		private var countryArray:Array = [];
		/**
		 * This component is be responsible for providing deferred validation for non-visual components.
		 */
		private var layoutManagerClientHelper:LayoutManagerClientHelper;

		/**
		 * Last event that is received by responder.
		 */
		private var lastMessageEvent:MessageEvent;
		private var lastMessageEventDirty:Boolean;

		public function CountryFeedResponder()
		{
			layoutManagerClientHelper = new LayoutManagerClientHelper(commitProperties);
		}

		public function messageHandler(event:MessageEvent):void
		{
			if (event == lastMessageEvent)return;

			lastMessageEvent = event;
			lastMessageEventDirty = true;

			layoutManagerClientHelper.invalidateProperties();
		}

		private function commitProperties():void
		{
			if (lastMessageEventDirty) {
				lastMessageEventDirty = false;
				handlerNewMessageEvent(lastMessageEvent);
			}
		}

		private function handlerNewMessageEvent(event:MessageEvent):void
		{
			var countryCode:String = event.message.body.country;
			var countryVO:CountryVO = new CountryVO();
			countryVO.countryCode = countryCode;

			if (!firstMessage) {
				firstMessage = new MessageVO(event.message, new Date(),countryCode);
			}

			lastMessage = new MessageVO(event.message, new Date(), countryCode);
			messageHistory.addItem(lastMessage);

			// Add this to an array and call a filter function to check if that country has already
			// had hits detected.
			countryArray.push(countryVO);
			countryArray.filter(accumulateHitsFilter);
		}

		public function channelFaultHandler(event:ChannelFaultEvent):void
		{
			Alert("Fault");
		}

		public function resetFeedItems():void
		{
			messageHistory = new ArrayCollection();

			firstMessage = null;
			lastMessage = null;

			_feedItems = new ArrayCollection();
			dispatchEvent(new Event(FEED_ITEMS_CHANGED));
		}

		/*============================================================*/
		/*Feed items*/
		/*============================================================*/
		private var _feedItems:ArrayCollection;

		[Bindable("feedItemsChanged")]
		public function get feedItems():ArrayCollection
		{
			return _feedItems;
		}

		private function accumulateHitsFilter(item:CountryVO, idx:uint, arr:Array):Boolean
		{
			if (countryHits[item.countryCode] != null) {
				item.hits = item.hits += 1;
				return false;
			} else {
				item.hits = 1;
				countryHits[item.countryCode] = item;
				feedItems.addItem(item);
				return true;
			}
		}
	}
}
