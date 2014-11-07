﻿package  {
	
	import flash.display.MovieClip;
	import com.greensock.*;
	import com.greensock.easing.*;;
	import flash.ui.Mouse;
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
	import com.spilgames.api.*;
	import com.spilgames.bs.BrandingManager;
	import com.spilgames.bs.comps.Logo;
	import flash.media.SoundChannel;
	import flash.display.SimpleButton;
	import flash.geom.Matrix;
	import flash.system.Capabilities
	import flash.filters.GlowFilter;

	
	public class Main extends MovieClip {
		
		public static var loopMc:MovieClip;
		private var loopTime:int=1500;
		private var btnArr:Array=new Array();
		private var barArr:Array=new Array();
		
		private var btnArr2:Array=new Array();
		private var barArr2:Array=new Array();
		private static var issubmit:Boolean=false;
		public var currBar:MovieClip;
		public static var girl:MovieClip;
		
		public function Main()
		{
			stop();
		}
		
		private function initElemt():void
		{
			loopMc=this.getChildByName("_loopMc") as MovieClip ;
			loopMc.visible=false;
			this.addChild(loopMc);
			
		}
		public function init():void
		{
			gotoAndStop(1,"mainScene");
			if(BackSoundSpeaker.speakerIndex==1)
			{
				Voice.startBackSound();
			}
			backMc.gotoAndStop(1);
			initElemt();
		}
		public function goTwoEvt(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			loopMc.visible=true;
			loopMc.gotoAndPlay(2);
			setTimeout(initMakeupScene2,loopTime-500);
			setTimeout(hideLoopMc,loopTime);
		}
		private function hideLoopMc():void
		{
			loopMc.visible=false;
		}
		private function initMakeupScene2():void
		{
			gotoAndStop(2);
			girl=_girl1;
			
			_girl1.visible=true;
			_girl2.visible=false;
			btnArr=[hairBtn,dressBtn,coatBtn,pantsBtn,headdressBtn,earringsBtn,necklaceBtn,flowerBtn,shoesBtn];
			barArr=[hairBar,dressBar,coatBar,pantsBar,headdressBar,earringsBar,necklaceBar,flowerBar,shoesBar];
			for each(var btn:SimpleButton in btnArr)
			{
				btn.addEventListener(MouseEvent.CLICK,selectBarEvt);
				btn.x=800;
			}
			for each(var bar:MovieClip in barArr)
			{
				bar.visible=false;
			}
			hairBar.visible=true;
			
			
			resetBtn.addEventListener(MouseEvent.CLICK,resetEvt);
			nextBtn.addEventListener(MouseEvent.CLICK,goThreeEvt);
			moreBtn.addEventListener(MouseEvent.CLICK,moreClickEvt);
			backBtn.addEventListener(MouseEvent.CLICK,backEvt);
			
			girl.x=-500;
			hairBar.x=850;
			bgMc.x=1100;
			resetBtn.y=nextBtn.y=moreBtn.y=backBtn.y=700;
			currBar=hairBar
			setTimeout(showAction1,500);
		}
		private function showAction1():void
		{
			for each(var btn:SimpleButton in btnArr)
			{
				TweenLite.to(btn,0.8,{x:380});
			}
			TweenLite.to(hairBar,0.8,{x:530});
			TweenLite.to(girl,0.8,{x:-150});
			TweenLite.to(bgMc,0.8,{x:723});
			for each(btn in [resetBtn,nextBtn,moreBtn,backBtn])
			{
				TweenLite.to(btn,0.8,{y:480})
			}
		}
		private function goThreeEvt(e:MouseEvent):void
		{
			
			Voice.clickBtnSound();
			for each(var btn:SimpleButton in btnArr)
			{
				TweenLite.to(btn,0.8,{x:800});
			}
			TweenLite.to(currBar,0.8,{x:850});
			TweenLite.to(girl,0.8,{x:-500});
			TweenLite.to(bgMc,0.8,{x:1100,onComplete:initMakeupScene3});
			for each(btn in [resetBtn,nextBtn,moreBtn,backBtn])
			{
				TweenLite.to(btn,0.8,{y:700})
			}
			
		}
		public function loadToThree()
		{
			loopMc.visible=true;
			loopMc.gotoAndPlay(2);
			setTimeout(initMakeupScene3,loopTime-500);
			setTimeout(hideLoopMc,loopTime);
		}
		private function initMakeupScene3():void
		{
			gotoAndStop(3);
			girl=_girl2;
			girl.x=-250;
			_girl1.visible=false;
			_girl2.visible=true;
			btnArr2=[hairBtn2,dressBtn2,coatBtn2,pantsBtn2,headdressBtn2,earringsBtn2,necklaceBtn2,flowerBtn2,shoesBtn2];
			barArr2=[hairBar2,dressBar2,coatBar2,pantsBar2,headdressBar2,earringsBar2,necklaceBar2,flowerBar2,shoesBar2];
			for each(var btn:SimpleButton in btnArr2)
			{
				btn.addEventListener(MouseEvent.CLICK,selectBarEvt2);
				btn.x=1000;
			}
			for each(var bar:MovieClip in barArr2)
			{
				bar.visible=false;
			}
			hairBar2.visible=true;
			currBar=hairBar2;
			resetBtn2.addEventListener(MouseEvent.CLICK,resetEvt);
			showBtn.addEventListener(MouseEvent.CLICK,showEvt);
			prevBtn.addEventListener(MouseEvent.CLICK,goTwoEvt2);
			backBtn2.addEventListener(MouseEvent.CLICK,backEvt);
			moreBtn2.addEventListener(MouseEvent.CLICK,moreClickEvt);
			girl.x=-700;
			hairBar2.x=850;
			bgMc.x=1100;
			resetBtn2.y=prevBtn.y=showBtn.y=backBtn2.y=moreBtn2.y=700;
			setTimeout(showAction2,500);
		}
		private function showAction2():void
		{
			for each(var btn:SimpleButton in btnArr2)
			{
				TweenLite.to(btn,0.8,{x:690});
			}
			TweenLite.to(hairBar2,0.8,{x:538});
			TweenLite.to(girl,0.8,{x:-250});
			TweenLite.to(bgMc,0.8,{x:723});
			for each(btn in [resetBtn2,prevBtn,showBtn])
			{
				TweenLite.to(btn,0.8,{y:475})
			}
			for each(btn in [backBtn2,moreBtn2])
			{
				TweenLite.to(btn,0.8,{y:513})
			}
		}
		private function goTwoEvt2(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			for each(var btn:SimpleButton in btnArr2)
			{
				TweenLite.to(btn,0.8,{x:800});
			}
			TweenLite.to(currBar,0.8,{x:850});
			TweenLite.to(girl,0.8,{x:-500});
			TweenLite.to(bgMc,0.8,{x:1100,onComplete:initMakeupScene2});
			for each(btn in [resetBtn2,prevBtn,showBtn,backBtn2,moreBtn2])
			{
				TweenLite.to(btn,0.8,{y:700})
			}
			
		}
		private function selectBarEvt2(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			var btn:SimpleButton=e.currentTarget as SimpleButton;
			for each(var bar:MovieClip in barArr2)
			{
				bar.visible=false;
			}
			currBar=barArr2[btnArr2.indexOf(btn)];
			currBar.visible=true;
		}
		
		private function selectBarEvt(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			var btn:SimpleButton=e.currentTarget as SimpleButton;
			for each(var bar:MovieClip in barArr)
			{
				bar.visible=false;
			}
			currBar=barArr[btnArr.indexOf(btn)];
			currBar.visible=true;
		}
		private function backEvt(e:MouseEvent):void
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
			for each(var btn:SimpleButton in btnArr2)
			{
				TweenLite.to(btn,0.8,{x:800});
			}
			TweenLite.to(currBar,0.8,{x:850});
			TweenLite.to(girl,0.8,{x:-500});
			TweenLite.to(bgMc,0.8,{x:1100,onComplete:loadToShow});
			for each(btn in [resetBtn2,prevBtn,showBtn,backBtn2,moreBtn2])
			{
				TweenLite.to(btn,0.8,{y:700})
			}
		}
		public function loadToShow()
		{
			loopMc.visible=true;
			loopMc.gotoAndPlay(2);
			setTimeout(showGame,loopTime-500);
			setTimeout(hideLoopMc,loopTime);
		}
		private function showGame():void
		{
			gotoAndStop(4);
			replayBtn.addEventListener(MouseEvent.CLICK,replayEvt);
			printBtn.addEventListener(MouseEvent.CLICK,printEvt);
			saveBtn.addEventListener(MouseEvent.CLICK,saveEvt);
			moreBtn3.addEventListener(MouseEvent.CLICK,moreClickEvt);
			_girl1.x=-500;
			_girl1.mouseChildren=false;
			_girl1.mouseEnabled=false;
			
			_girl2.x=500;
			_girl2.mouseChildren=false;
			_girl2.mouseEnabled=false;
			
			_girl1.visible=_girl2.visible=true;
			if(_girl1.dressArr.length==9&&_girl2.dressArr.length==9&&issubmit==false)
			{
				//issubmit=true;
				//AwardsService.submitAward('award1');
			}
			star.visible=false;
			setTimeout(moveGirl,800);
			setTimeout(moveGirl2,800);
			
			replayBtn.x=-300;
			moreBtn3.x=-400;
			printBtn.x=saveBtn.x=1000;
			setTimeout(showShowBtn,500);
		
		}
		private function showShowBtn()
		{
			TweenLite.to(replayBtn,0.5,{x:57});
			TweenLite.to(moreBtn3,0.5,{x:81});
			TweenLite.to(printBtn,0.5,{x:665});
			TweenLite.to(saveBtn,0.5,{x:665});
		}

		public function moveGirl():void
		{

			TweenLite.to(_girl1,0.5,{x:0,scaleX:1,scaleY:1});
		}
		public function moveGirl2():void
		{
			TweenLite.to(_girl2,0.5,{x:0,scaleX:1,scaleY:1,onComplete:moveComplete});
		}
		private function moveComplete()
		{
			star.visible=true;
		}
		private function replayEvt(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			TweenLite.to(replayBtn,1,{x:-300});
			TweenLite.to(moreBtn3,1,{x:-400});
			TweenLite.to(printBtn,1,{x:1000});
			TweenLite.to(saveBtn,1,{x:1000,onComplete:loopToReplay});
		}

		private function loopToReplay()
		{
			loopMc.visible=true;
			loopMc.gotoAndPlay(2);
			setTimeout(replayGame,loopTime-300);
			setTimeout(hideLoopMc,loopTime);
		}
		private function replayGame():void
		{
			loopMc.visible=false;
			SoundMixer.stopAll();
			gotoAndStop(1);
			init();
		}
		private function resetEvt(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			backMc.gotoAndStop(1);
			
			if(this.currentFrame==2)
			{
				for each(var bar:MovieClip in barArr)
				{
					bar.visible=false;
				}
				hairBar.visible=true;
			}
			else
			{
				for each(bar in barArr2)
				{
					bar.visible=false;
				}
				hairBar2.visible=true;
			}
			girl.resetGirl();
		}
		private function get_pixel(n:Number):Number
		{
			var dpi:Number = Capabilities.screenDPI;
			return n / 72 * dpi;
		}
		private function printEvt(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			backSoundSpeaker.visible=moreBtn3.visible=replayBtn.visible=saveBtn.visible=printBtn.visible=false;
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
			backSoundSpeaker.visible=moreBtn3.visible=replayBtn.visible=saveBtn.visible=printBtn.visible=true;
		}
		private function saveEvt(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			backSoundSpeaker.visible=moreBtn3.visible=replayBtn.visible=saveBtn.visible=printBtn.visible=false;
			var bmp:BitmapData=new BitmapData(750,550);
			bmp.draw(root);
			var jpgCode:JPGEncoder=new JPGEncoder(85);
			var ba:ByteArray=jpgCode.encode(bmp)

			var file:FileReference=new FileReference();
			file.save(ba,"image.jpg");
			ba.clear();
			backSoundSpeaker.visible=moreBtn3.visible=replayBtn.visible=saveBtn.visible=printBtn.visible=true;
		}
		public function moreClickEvt(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			navigateToURL(new URLRequest(BrandingManager.getInstance().getMoreGamesLink	()),"_blank");
		}
	
	}
	
}
