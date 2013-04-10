package com.sizov.components
{
	import com.sizov.vo.CountryVO;

	import flash.events.Event;

	import flexunit.framework.Assert;

	import mx.collections.ArrayCollection;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.async.Async;

	public class CountryFeedResponderTest
	{
		var responder:CountryFeedResponder;

		[Before]
		public function setUp():void
		{
			responder = new CountryFeedResponder();
		}

		[After]
		public function tearDown():void
		{
			responder = null;
		}

		[Test(async)]
		public function testFirstMessageEvent():void
		{
			var asyncHandler:Function = Async.asyncHandler(this, firstMessageHandler, 500, null, handleTimeout);
			responder.addEventListener(CountryFeedResponder.FIRST_MESSAGE_RECEIVED, asyncHandler, false, 0, true);
			responder.processNewCountry({country:"RU",city:"Moskow"});
		}

		protected function firstMessageHandler(event:Event, passThroughData:Object):void
		{
		}

		protected function handleTimeout(passThroughData:Object):void
		{
			Assert.fail("First message event haven't received");
		}

		[Test]
		public function testProcessNewCountryCode():void
		{
			responder.processNewCountry({country:"UA", city:"Kiev"});
			responder.processNewCountry({country:"UA", city:"Odessa"});
			responder.processNewCountry({country:"UA", city:"Kiev"});

			responder.processNewCountry({country:"UK", city:"London"});
			responder.processNewCountry({country:"UK", city:"Glasgow"});

			assertEquals("There should be 5 messages in total received", 5, responder.messageHistory.length);
			assertEquals("There should be 2 CountryVO instances", 2, responder.feedItems.length);

			assertEquals("The count of hits with 'RU' code should be 3 ",
					3, getCountryVOByCode(responder.feedItems, 'UA').hits);

			assertEquals("The count of hits with 'GB' code should be 2 ",
					2, getCountryVOByCode(responder.feedItems, 'UK').hits);
		}

		private function getCountryVOByCode(feedItems:ArrayCollection, code:String):CountryVO
		{
			for each (var countryVO:CountryVO in feedItems) {
				if (countryVO.countryCode == code) {
					return countryVO;
				}
			}
			return null;
		}
	}
}
