package com.sizov.components
{
	import com.sizov.utils.LayoutManagerClientHelper;
	import com.sizov.vo.CountryVO;
	import com.sizov.vo.MessageVO;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.events.MessageEvent;

	[Event("firstMessageReceived")]
	public class CountryFeedResponder extends EventDispatcher implements IFeedManagerResponder
	{
		public static const FIRST_MESSAGE_RECEIVED:String = "firstMessageReceived";
		public static const FEED_ITEMS_CHANGED_EVENT:String = "feedItemsChanged";

		/**
		 * Accumulation of all messages.
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
		private var countryHitsMap:Dictionary;

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
			resetFeedItems();
		}

		private var _feedItems:ArrayCollection;

		[Bindable("feedItemsChanged")]
		public function get feedItems():ArrayCollection
		{
			return _feedItems;
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
				handleNewMessage(lastMessageEvent);
			}
		}

		private function handleNewMessage(event:MessageEvent):void
		{
			processNewCountryCode(event.message.body);
		}

		public function processNewCountryCode(countryData:Object):void
		{
			const FIELD_COUNTRY:String = "country";
			const FIELD_CITY:String = "city";

			var countryCode:String = countryData.hasOwnProperty(FIELD_COUNTRY) ? countryData[FIELD_COUNTRY] : "";
			var city:String = countryData.hasOwnProperty(FIELD_CITY) ? countryData[FIELD_CITY] : "";

			if (!firstMessage) {
				firstMessage = new MessageVO(new Date(), countryCode, city);
				dispatchEvent(new Event(FIRST_MESSAGE_RECEIVED));
			}

			lastMessage = new MessageVO(new Date(), countryCode, city);

			messageHistory.addItem(lastMessage);

			updateFeedItems(countryCode);
		}

		private function updateFeedItems(countryCode:String):void
		{
			var countryVoByCode:CountryVO = countryHitsMap[countryCode] as CountryVO;

			if (countryVoByCode) {
				countryVoByCode.hits += 1;
			} else {
				countryVoByCode = new CountryVO(countryCode);
				countryVoByCode.hits = 1;
				countryHitsMap[countryCode] = countryVoByCode;

				feedItems.addItem(countryVoByCode);
			}
		}

		public function channelFaultHandler(event:ChannelFaultEvent):void
		{
			Alert("Channel fault");
		}

		public function resetFeedItems():void
		{
			messageHistory = new ArrayCollection();
			countryHitsMap = new Dictionary();

			firstMessage = null;
			lastMessage = null;

			_feedItems = new ArrayCollection();
			dispatchEvent(new Event(FEED_ITEMS_CHANGED_EVENT));
		}
	}
}
