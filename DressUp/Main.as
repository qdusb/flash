package  {

	import flash.display.MovieClip;
	import com.greensock.TweenLite;
	import com.greensock.easing.Bounce;
	import flash.events.MouseEvent;
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
	import flash.display.SimpleButton;
	import flash.geom.Matrix;
	import flash.system.Capabilities
	import com.greensock.easing.Bounce;
	
	public class Main extends MovieClip 
	{
		public static var loopMc:MovieClip;
		public static var girl:GirlRole;
		private var nextCall:Function;
		
		public function Main()
		{
			init();
		}
		
		private function init():void
		{
			stop();
			if(BackSoundSpeaker.speakerIndex==1)
			{
				Voice.startBackSound();
			}
			backMc.gotoAndStop(1);
			initElemt();
		}
		

		public function playEvt(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			loopCall(initFrame2);
		}
		
		private function initFrame2():void
		{
			gotoAndStop(2);
			girl=_girl;
			backBtn.addEventListener(MouseEvent.CLICK,backMcEvt);
			showBtn.addEventListener(MouseEvent.CLICK,showEvt);
			resetBtn.addEventListener(MouseEvent.CLICK,resetEvt);
			moreBtn.addEventListener(MouseEvent.CLICK,moreClickEvt);
			initFrame2Pos();
			setTimeout(actionFrame2Pos,500);
		}
		private function initFrame2Pos(speed:Number=0):void
		{
			var btns:Array=[showBtn,resetBtn,backBtn,moreBtn];
			for each(var btn:SimpleButton in btns)
			{
				TweenLite.to(btn,speed,{y:btn.y+200});
			}
			TweenLite.to(girl,speed,{x:500});
		}
		private function actionFrame2Pos()
		{
			TweenLite.to(girl,1,{x:0});
			var btns:Array=[showBtn,resetBtn,backBtn,moreBtn2];
			for each(var btn:SimpleButton in btns)
			{
				TweenLite.to(btn,1,{y:506});
			}
		}
		private function selectBarEvt(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			var btn:SimpleButton=e.currentTarget as SimpleButton;
			currBar=barArr[btnArr.indexOf(btn)];
			for each(var bar:MovieClip in barArr)
			{
				bar.visible=false;
			}
			currBar.visible=true;
		}
		
		private function backMcEvt(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			if(backMc.currentFrame==backMc.totalFrames)
			{
				backMc.gotoAndStop(1);
			}
			else
			{
				backMc.nextFrame();
			}
		}
		private function showEvt(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			initFrame2Pos(1);
			setTimeout(loopCall,800,showGame);
		}
		private function showGame():void
		{
			gotoAndStop(3);
			replayBtn.addEventListener(MouseEvent.CLICK,replayEvt);
			printBtn.addEventListener(MouseEvent.CLICK,printEvt);
			saveBtn.addEventListener(MouseEvent.CLICK,saveEvt);
			moreBtn.addEventListener(MouseEvent.CLICK,moreClickEvt);

			girl.mouseChildren=false;
			girl.mouseEnabled=false;
			star.visible=false
			initShowFramePos();
			setTimeout(actionShowFramePos,500);
		}
		private function initShowFramePos(speed:Number=0):void
		{

			TweenLite.to(moreBtn,speed,{x:886});
			TweenLite.to(replayBtn,speed,{x:886});
			TweenLite.to(printBtn,speed,{x:-170});
			TweenLite.to(saveBtn,speed,{x:-170});
			TweenLite.to(girl,speed,{x:500});
		}
		private function actionShowFramePos():void
		{
			TweenLite.to(moreBtn,1,{x:680});
			TweenLite.to(replayBtn,1,{x:680});
			TweenLite.to(printBtn,1,{x:62});
			TweenLite.to(saveBtn,1,{x:62});
			TweenLite.to(girl,1,{x:-200,y:0,scaleX:1,scaleY:1,ease:Bounce.easeOut,onComplete:function(){star.visible=true;}});
		}
		private function replayEvt(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			initShowFramePos(1);
			setTimeout(loopCall,800,replayGame);
		}
		private function replayGame():void
		{
			loopMc.visible=false;
			//girl.girlStop();
			SoundMixer.stopAll();
			gotoAndStop(1);
			init();
		}
		private function resetEvt(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			backMc.gotoAndStop(1);
			girl.resetGirl();
			bar.resetBar();
		}
		private function initElemt():void
		{
			loopMc=_loopMc ;
			loopMc.visible=false;
			loopMc.addEventListener("TransitionMiddle", transitionEventHandler);
			loopMc.addEventListener("TransitionComplete", transitionEventHandler);
			this.stage.addChild(loopMc);
		}
		private function transitionEventHandler(e:Event):void {
			
			switch(e.type) {
				case "TransitionMiddle":
					nextCall();
				break;
				case "TransitionComplete":
					loopMc.visible = false;
				break;
			}
		}
		private function loopCall(func:Function):void {
			nextCall = func;
			loopMc.visible = true;
			loopMc.gotoAndPlay(2);
		}
		private function get_pixel(n:Number):Number
		{
			var dpi:Number = Capabilities.screenDPI;
			return n / 72 * dpi;
		}
		public function setBtnVisible($v:Boolean)
		{
			backSoundSpeaker.visible=moreBtn.visible=replayBtn.visible=saveBtn.visible=printBtn.visible=$v;
		}
		private function printEvt(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			setBtnVisible(false);
			var pj:PrintJob = new PrintJob;
			if(pj.start())
			{
				var paperWidth:Number = get_pixel(pj.pageWidth);
				var paperHeight:Number = get_pixel(pj.pageHeight);
				var ratio:Number = 550 / 375;//1.36
				var printW:Number = paperWidth;
				var printH:Number = paperHeight;
				var scale:Number;
				var bmp:BitmapData;
				var m:Matrix = new Matrix();
				if(paperWidth < paperHeight) 
				{
					if(printH / printW > ratio)// 1.41
					{
						scale = printW / 550
					}
					else
					{
						scale = printH / 750;
					}
					trace("scale",scale);
					bmp = new BitmapData(550 * scale, 750 * scale);
					m.rotate(Math.PI / 2);
					m.scale(scale, scale);
					m.tx = bmp.width;
				}
				else
				{
					if(printW / printH > ratio)
					{
						scale = printH / 550;
					}
					else
					{
						scale = printW / 750;
					}
					bmp = new BitmapData(750 * scale, 550 * scale);
					m.scale(scale, scale);
				}
				bmp.draw(stage,m);
				var bitmap:Bitmap = new Bitmap(bmp);
				var sp:Sprite = new Sprite();
				sp.addChild(bitmap);
				stage.addChild(sp);
				pj.addPage(sp, null, new PrintJobOptions(true));
				pj.send();
				stage.removeChild(sp);
				bmp.dispose();
			}
			setBtnVisible(true);
		}
		private function saveEvt(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			setBtnVisible(false);
			var bmp:BitmapData=new BitmapData(750,550);
			bmp.draw(root);
			var jpgCode:JPGEncoder=new JPGEncoder(85);
			var ba:ByteArray=jpgCode.encode(bmp)

			var file:FileReference=new FileReference();
			file.save(ba,"image.jpg");
			ba.clear();
			setBtnVisible(true);
		}
		public function moreClickEvt(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			navigateToURL(new URLRequest("http://www.starsue.net/online-games/My_Little_Pony.html"),"_blank");
		}
	}
}