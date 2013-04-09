package com.sizov.utils
{
	import flash.utils.describeType;

	public class TestUtils
	{
		/**
		 * Checks if all static constants that have certain prefix and
		 * describe class field names match actual class field names
		 *
		 * @param classRef Reference to class
		 * @param fieldPrefix Prefix that is used for static constant name
		 * @return Name of first constants that does not have field for it,
		 * <code>null</code> if all constants match their field names in class
		 */
		public static function constantMatchesField(classRef:Class, fieldPrefix:String = "FIELD_"):String
		{
			var describeTypeXML:XML = describeType(classRef);

			var staticConstants:XMLList = describeTypeXML.constant;
			var fields:XMLList = describeTypeXML.factory.accessor;

			var fieldConstantsValues:Array = [];
			var fieldNames:Array = [];

			for each (var field:XML in fields) {
				var fieldName:String = field.@name;
				fieldNames.push(fieldName);
			}

			for each (var constant:XML in staticConstants) {
				var constantName:String = constant.@name;
				if (constantName.indexOf(fieldPrefix) == 0) {
					fieldConstantsValues.push(classRef[constantName]);
				}
			}

			for each (var fieldConstantValue:String in fieldConstantsValues) {
				if (fieldNames.indexOf(fieldConstantValue) == -1) {
					return fieldConstantValue;
				}
			}

			return null;
		}
	}
}
