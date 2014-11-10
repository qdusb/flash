package  {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	
	public class ControlBar extends MovieClip {
		
		public var hintNum:int=5;
		public var scoreTxt:TextField;
		public static var COMPLETE:String="complete";
		public static var gameScore:int=0;
		public var doneNum:int=0;
		public var completeNum:int;
		public static var self:ControlBar;
		public var callFun:Function;
		public var failureFun:Function;
		public var tipMc:MovieClip;
		public var doneBar:MovieClip;
		public var timer;
		
		private var cnt:int=300;
		
		public function ControlBar() {
			hintNum=5;
			scoreTxt=this.getChildByName("score") as TextField;
			self=this;
			hintBtn.addEventListener(MouseEvent.CLICK,showHintBar);
			timer=new Timer(1000,cnt);
			timer.addEventListener(TimerEvent.TIMER,timerEvt);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,timerCompleteEvt);
		}
		public function startTimer()
		{
			doneNum=0;
			hintNum=5;
			gameScore=0;
			timer.reset();
			timer.start();
			timeTxt.text="00:00";
			scoreTxt.text="0";
			hint.text=hintNum.toString();
		}
		public function timePause()
		{
			timer.stop();
		}
		public function timePlay()
		{
			timer.start();
		}
		public function initCounter()
		{
			cNum.text=doneNum.toString();
			tNum.text=completeNum.toString();
		}
		private function timerCompleteEvt(e:TimerEvent):void
		{
			if(failureFun!=null)
			{
				failureFun();
			}
		}
		private function timerEvt(e:TimerEvent):void
		{
			var rcnt=cnt-timer.currentCount;
			var time:String=intToTime(rcnt);
			timeTxt.text=time;
		}
		private function intToTime(val:int):String
		{
			var minite:int=Math.floor(val/60);
			var sec:int=val%60;
			var secStr:String=sec<10?("0"+sec.toString()):sec.toString();
			return "0"+minite.toString()+":"+secStr;
		}
		private function showHintBar(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			if(hintNum>0&&tipMc.visible==false)
			{
				tipMc.visible=true;
				hintNum--;
				hint.text=hintNum.toString();
				setTimeout(hideHintBar,2500);
				doneBar.visible=false;
			}
		}
		private function hideHintBar():void
		{
			tipMc.visible=false;
			doneBar.visible=true;
		}
		public  function  addScore(val:int=50):void
		{
			gameScore+=val;
			scoreTxt.text=gameScore.toString();
			doneNum++;
			initCounter();
			trace(doneNum)
			if(doneNum==completeNum)
			{
				if(callFun!=null){
					timer.stop();
					setTimeout(callFun,1000);
				}
				Main.score[Main.step]=gameScore;
			}
		}
		public  function  reduceScore(val:int=5):void
		{
			gameScore-=val;
			gameScore=Math.max(0,gameScore);
			scoreTxt.text=gameScore.toString();
		}
	}
	
}
