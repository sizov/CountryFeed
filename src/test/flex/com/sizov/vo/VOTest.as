package com.sizov.vo
{
	import com.sizov.MessageVO;
	import com.sizov.utils.TestUtils;

	import org.flexunit.asserts.assertNull;

	public class VOTest
	{
		[Test]
		public function testVOConstantsMatchFields():void
		{
			processClass(CountryVO);
			processClass(MessageVO);
		}

		private function processClass(classRef:Class):void
		{
			assertNull("Static constants values that describe field names of class should match actual field name",
					TestUtils.constantMatchesField(classRef));
		}
	}
}
