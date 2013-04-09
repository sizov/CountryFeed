package com.sizov.components
{
	import spark.components.supportClasses.SkinnableComponent;

	[SkinState("running")]
	[SkinState("idle")]
	public class FeedStatusIndicator extends SkinnableComponent
	{
		private var _isRunning:Boolean;

		public function get isRunning():Boolean
		{
			return _isRunning;
		}

		public function set isRunning(value:Boolean):void
		{
			if (value == isRunning) return;

			_isRunning = value;

			invalidateSkinState();
		}

		override protected function getCurrentSkinState():String
		{
			if (isRunning) {
				return "running";
			}
			else {
				return "idle";
			}
		}
	}
}
