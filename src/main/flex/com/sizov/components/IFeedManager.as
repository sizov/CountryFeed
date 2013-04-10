package com.sizov.components
{
	import flash.events.IEventDispatcher;

	/**
	 * Interface that defines methods for feed manager.
	 */
	public interface IFeedManager extends IEventDispatcher
	{
		function get isRunning():Boolean;

		function start():void;

		function stop():void;
	}
}
