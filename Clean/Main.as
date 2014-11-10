package  {
	
	import flash.display.MovieClip;
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	import flash.ui.Mouse;
	import flash.events.MouseEvent;
	import flash.net.LocalConnection;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import flash.net.FileReference;
	import flash.display.Bitmap;
	import flash.printing.PrintJobOptions;
	import flash.geom.Rectangle;
	import flash.printing.*;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.SoundMixer;
	import flash.utils.setTimeout;
	import flash.media.SoundChannel;
	import flash.display.SimpleButton;
	import flash.geom.Matrix;
	import flash.system.Capabilities
	import flash.filters.GlowFilter;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import  com.bwebmedia.as3.yokogames.play.events.event;
	import com.bwebmedia.as3.yokogames.play.Service;
	import com.greensock.plugins.TweenPlugin;
    import com.greensock.plugins.FramePlugin;
    import com.greensock.TweenLite;

	
	public dynamic class Main extends MovieClip {
		
		public static var loopMc:MovieClip;
		public static var score:Array;
		public static var step:int;

		private var loopTime:int=2000;
		private var totalStep=4;
		private var isInit:Boolean=false;
		
		public function Main()
		{
			
		}
		
		private function initElemt():void
		{
			loopMc=this.getChildByName("_loopMc") as MovieClip ;
			loopMc.visible=false;
			this.stage.addChild(loopMc);
		}
		public function init(e:MouseEvent=null):void
		{
			gotoAndStop(1,"sceneOne");
			totalStep=4;
			isInit=true;
			helpBtn.visible=playBtn.visible=moreBtn.visible=true;
			helpBar.visible=false;
			if(BackSoundSpeaker.speakerIndex==1)
			{
				Voice.startBackSound();
			}
			initElemt();
			playBtn.addEventListener(MouseEvent.CLICK,goTwoEvt);
			helpBtn.addEventListener(MouseEvent.CLICK,showHelpBarEvt);
			helpBar.menuBtn.addEventListener(MouseEvent.CLICK,hideHelpBarEvt);
			TweenPlugin.activate([FramePlugin]);
			Main.score=[0,0,0,0,0,0];
			mc2.visible=false;
			mc2.mc.gotoAndStop(1);
			
		}
		private function loopCall(fun:Function)
		{
			loopMc.visible=true;
			loopMc.gotoAndPlay(2);
			setTimeout(fun,loopTime-800);
			setTimeout(hideLoopMc,loopTime);
		}
		private function showHelpBarEvt(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			loopCall(showHelpBar);
		}
		private function showHelpBar():void
		{
			helpBar.visible=true;
		}
		private function hideHelpBar():void
		{
			helpBar.visible=false;
		}
		private function hideLoopMc():void
		{
			loopMc.visible=false;
		}
		private function hideLevelBar():void
		{
			levelBar.visible=false;
		}
		private function hideHelpBarEvt(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			loopCall(hideHelpBar);
		}
		
		public function setScoreBar():int
		{
			var score:int=0;
			for(var i:int=0;i<totalStep;i++)
			{
				score+=Main.score[i];
			}
			levelBar.scoreMc.scoreTxt.text=score.toString();
			return score;
		}
		private function pauseEvt(e:MouseEvent=null)
		{
			Voice.clickBtnSound();
			pauseBar.visible=true;
			controlBar.timePause();
		}
		private function playEvt(e:MouseEvent=null)
		{
			Voice.clickBtnSound();
			pauseBar.visible=false;
			controlBar.timePlay();
		}

		public function d1CallFun()
		{
			initSceneTwo();
			startSceneTwo();
		}
		public function d2CallFun()
		{
			initSceneThree();
			startSceneThree();
		}
		public function d3CallFun()
		{
			initSceneFour();
			startSceneFour();
		}
		public function d4CallFun()
		{
			initSceneFive();
			startSceneFive();
		}
		public function failure()
		{
			loopCall(showFailure);
		}
		public function showFailure()
		{
			failureBar.visible=true;
			failureBar.menuBtn.addEventListener(MouseEvent.CLICK,gmenuEvt);
			
		}
		private function gmenuEvt(e:MouseEvent)
		{
			Voice.clickBtnSound();
			failureBar.visible=false;
			controlBar.callFun=null;
			controlBar.doneBar.resetBar();
			levelBar.visible=true;
		}
		private function initScene(step:int,tipMc:MovieClip):void
		{
			Main.step=step;
			setScoreBar();
			levelBar.visible=true;
			mc2.visible=false;
			tipMc.visible=false;
			levelBar.scoreMc.visible=levelBar.scoreMc.isVisible;
		}
		private function startScene(tipMc:MovieClip,doneBar:MovieClip,completeNum:int,callFun:Function):void
		{
			controlBar.startTimer();
			controlBar.tipMc=tipMc;
			controlBar.doneBar=doneBar;
			controlBar.completeNum=completeNum;
			controlBar.initCounter();
			controlBar.callFun=callFun;
			controlBar.failureFun=failure;
			controlBar.doneBar.resetBar();
		}
		private function endScene(callFun:Function)
		{
			controlBar.callFun=null;
			loopCall(callFun);
		}
		private function goSceneEvt(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			switch(Main.step)
			{
				case 0:
				loopCall(initSceneTwo);
				break;
				case 1:
				loopCall(initSceneThree);
				break;
				case 2:
				loopCall(initSceneFour);
				break;
				case 3:
				loopCall(initSceneFive);
				break;
			}
		}
		private function goTwoEvt(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			loopCall(initSceneTwo);	
		}
		private function initSceneTwo():void
		{
			trace("step_1");
			gotoAndStop(2);
			levelBar.scoreMc.isVisible=false;
			initScene(0,tipMc0);
			
			levelBar.d1.callFun=startSceneTwo;
			controlBar.pauseBtn.addEventListener(MouseEvent.CLICK,pauseEvt);
			controlBar.menuBtn.addEventListener(MouseEvent.CLICK,goSceneEvt);
			pauseBar.pauseBtn.addEventListener(MouseEvent.CLICK,playEvt);
		}
		
		private function startSceneTwo(e:MouseEvent=null)
		{
			loopCall(hideLevelBar);	
			startScene(tipMc0,doneBar0,28,endSceneTwo);
		}
		private function endSceneTwo():void
		{
			endScene(initSceneThree);
		}
		private function initSceneThree():void
		{
			trace("step_2");
			gotoAndStop(3);
			levelBar.scoreMc.isVisible=true;
			initScene(1,tipMc1)
			levelBar.d2.gotoAndStop(2);
			levelBar.d1.callFun=d1CallFun;
			levelBar.d2.callFun=startSceneThree;
		}
		private function goThreeEvt(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			loopCall(initSceneThree);
		}
		private function startSceneThree()
		{
			loopCall(hideLevelBar);
			mc2.visible=true;
			setTimeout(loadMcCall,loopTime,loadFrame3);	
		}
		private function loadFrame3()
		{
			mc2.visible=false;
			startScene(tipMc1,doneBar1,34,endSceneThree);
		}
		private function endSceneThree():void
		{
			endScene(initSceneFour);
		}
		private function initSceneFour():void
		{
			trace("step_3");
			gotoAndStop(4);
			initScene(2,tipMc2);
			levelBar.d3.gotoAndStop(2);
			levelBar.d1.callFun=d1CallFun;
			levelBar.d2.callFun=d2CallFun;
			levelBar.d3.callFun=startSceneFour;	
		}
		private function startSceneFour()
		{
			loopCall(hideLevelBar);
			mc2.visible=true;
			setTimeout(loadMcCall,loopTime,loadFrame4);
		}
		public function loadFrame4()
		{
			mc2.visible=false;
			startScene(tipMc2,doneBar2,33,endSceneFour);
		}
		private function endSceneFour():void
		{
			endScene(initSceneFive);
		}
		private function initSceneFive():void
		{
			trace("step_4");
			gotoAndStop(5);
			initScene(3,tipMc2);
			levelBar.d4.gotoAndStop(2);
			levelBar.d1.callFun=d1CallFun;
			levelBar.d2.callFun=d2CallFun;
			levelBar.d3.callFun=d3CallFun;
			levelBar.d4.callFun=startSceneFive;
		}
		private function goFiveEvt(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			loopCall(initSceneFive);
		}
		private function startSceneFive()
		{
			loopCall(hideLevelBar);
			mc2.visible=true;
			setTimeout(loadMcCall,loopTime,loadFrame5);
		}
		private function loadFrame5()
		{
			mc2.visible=false;
			startScene(tipMc3,doneBar3,33,endSceneFive);
		}
		private function endSceneFive():void
		{
			endScene(initSceneSix);
		}
		private function initSceneSix():void
		{
			gotoAndStop(6);
			var score:int=setScoreBar();
			scoreTxt.text=score.toString();
			replayBtn.addEventListener(MouseEvent.CLICK,replayEvt);
		}
		private function loadMcCall(callFun:Function):void
		{
			loopMc.visible=false;
			mc2.mc.gotoAndStop(1);
			TweenLite.to(mc2.mc,6,{frame:74,onComplete:callFun});
		}
		private function replayEvt(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			loopCall(replayGame);
		}
		private function replayGame():void
		{
			loopMc.visible=false;
			SoundMixer.stopAll();
			gotoAndStop(1,"sceneOne");
			init();
		}
		public function btnLinkHandler(e:MouseEvent):void
		{
			if(isInit==true)
			{
				Voice.clickBtnSound();
			}
			
			navigateToURL(new URLRequest(Service.getInstance().getBtnLink()), "_blank");
		}
		public function facebookLinkHandler(e:MouseEvent):void
		{
			if(isInit==true)
			{
				Voice.clickBtnSound();
			}
			navigateToURL(new URLRequest(Service.getInstance().getFaceBookLink()), "_blank");
		}
		public function textLinkHandler(e:MouseEvent):void
		{
			if(isInit==true)
			{
				Voice.clickBtnSound();
			}
			navigateToURL(new URLRequest(Service.getInstance().getTextLink()), "_blank");
		}
	}
}