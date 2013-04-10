package com.sizov.components
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	import spark.components.Label;
	import spark.components.supportClasses.SkinnableComponent;

	[SkinState("running")]
	[SkinState("idle")]
	public class TimerDisplay extends SkinnableComponent
	{
		private static const TIMER_INTERVAL:int = 1000;

		[SkinPart(required=true)]
		public var hoursDisplay:Label;

		[SkinPart(required=true)]
		public var minuteDisplay:Label;

		[SkinPart(required=true)]
		public var secondDisplay:Label;

		private var timerAtStart:int = 0;
		private var timer:Timer;
		private var minuteStorage:String;
		private var hoursStorage:String;
		private var secondStorage:String;

		private var timerDisplayDirty:Boolean;
		private var dateToDisplay:Date;

		public function TimerDisplay()
		{
			initTimer();
		}

		private function initTimer():void
		{
			timer = new Timer(TIMER_INTERVAL);
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
		}

		private function timerHandler(evt:TimerEvent):void
		{
			updateTimeDisplay(new Date(getTimer() - timerAtStart));
		}

		private var _isRunning:Boolean;

		[Bindable("isRunningChanged")]
		public function get isRunning():Boolean
		{
			return _isRunning;
		}

		public function start():void
		{
			if (isRunning) return;

			_isRunning = true;
			dispatchEvent(new Event("isRunningChanged"));

			reStartTimer();

			dateToDisplay = new Date(0);
			timerDisplayDirty = true;

			invalidateSkinState();
		}

		public function stop():void
		{
			if (!isRunning) return;

			_isRunning = false;
			dispatchEvent(new Event("isRunningChanged"));

			stopTimer();
			dateToDisplay = null;
			timerDisplayDirty = true;

			invalidateSkinState();
		}

		private function reStartTimer():void
		{
			timerAtStart = getTimer();
			timer.reset();
			timer.start();
		}

		private function stopTimer():void
		{
			timer.stop();
		}

		override protected function commitProperties():void
		{
			super.commitProperties();

			if (timerDisplayDirty) {
				timerDisplayDirty = false;
				updateTimeDisplay(dateToDisplay);
			}
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


		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);

			if (instance == hoursDisplay) {
				hoursDisplay.text = hoursStorage;
			}

			if (instance == minuteDisplay) {
				minuteDisplay.text = minuteStorage;
			}

			if (instance == secondDisplay) {
				secondDisplay.text = secondStorage;
			}
		}

		private function updateTimeDisplay(dateToDisplay:Date):void
		{
			var hours:Number = dateToDisplay ? dateToDisplay.hours : NaN;
			var minutes:Number = dateToDisplay ? dateToDisplay.minutes : NaN;
			var seconds:Number = dateToDisplay ? dateToDisplay.seconds : NaN;

			if (!hoursDisplay) {
				hoursStorage = fullDigitConvertor(hours);
			}
			else {
				hoursDisplay.text = fullDigitConvertor(hours);
			}

			if (!minuteDisplay) {
				minuteStorage = fullDigitConvertor(minutes);
			}
			else {
				minuteDisplay.text = fullDigitConvertor(minutes);
			}

			if (!secondDisplay) {
				secondStorage = fullDigitConvertor(seconds);
			}
			else {
				secondDisplay.text = fullDigitConvertor(seconds);
			}
		}

		private static function fullDigitConvertor(number:Number):String
		{
			if (isNaN(number)) return "-";
			return (number < 10) ? '0' + String(number) : String(number);
		}
	}
}
