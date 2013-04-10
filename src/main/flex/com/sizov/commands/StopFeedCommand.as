package com.sizov.commands
{
	import com.sizov.components.IFeedManager;
	import com.sizov.messages.ServiceMessage;

	public class StopFeedCommand
	{
		[Inject]
		public var feedManager:IFeedManager;

		public function execute(message:ServiceMessage):void
		{
			feedManager.stop();
		}
	}
}
