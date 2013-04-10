package com.sizov.components
{
	import flash.events.IEventDispatcher;

	public interface IFeedManager extends IEventDispatcher
	{
		function get isRunning():Boolean;

		function start():void;

		function stop():void;
	}
}
