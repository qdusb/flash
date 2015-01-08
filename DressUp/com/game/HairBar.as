package com.game
{

	import flash.display.MovieClip;
	import flash.filters.GlowFilter;
	import flash.events.MouseEvent;
	import com.greensock.TweenLite;


	public class HairBar extends MovieClip
	{
		public var elemtArr:Array=new Array();
		public var elemtArr2:Array=new Array();
		public var pageArr:Array=new Array();
		public var elemtNameArr:Array=new Array();
		public var elemtNameArr2:Array=new Array();
		public var seri:int=0;
		public var pageNum:int=1;
		public var clickFlag:int=0;
		private var glow:GlowFilter=new GlowFilter(0xFFFF00,0.8,20,20);

		public function HairBar()
		{
			elemtNameArr=["d1","d2","d3","d4","d5","d6","d7","d8","d9","d10",
						  "d11","d12","d13","d14","d15","d16","d17","d18","d19","d20",
						  "d21","d22","d23","d24","d25","d26","d27","d28","d29","d30"];
			elemtNameArr2=["m1","m2","m3","m4","m5","m6"];
			initElemt();
		}
		public function initElemt():void
		{
			for each(var str:String in elemtNameArr)
			{
				var mc:MovieClip = this.getChildByName(str) as MovieClip;
				if(mc)
				{
					elemtArr.push(mc);
					mc.buttonMode=true;
					mc.addEventListener(MouseEvent.ROLL_OVER,mouseEvt);
					mc.addEventListener(MouseEvent.ROLL_OUT,mouseEvt);
					mc.addEventListener(MouseEvent.CLICK,clickEvt);
				}
			}
			for each(str in elemtNameArr2)
			{
				 mc = this.getChildByName(str) as MovieClip;
				 if(mc)
				{
					elemtArr2.push(mc);
					mc.posX=mc.x;
					mc.posY=mc.y;
					mc.buttonMode=true;
					mc.addEventListener(MouseEvent.ROLL_OVER,mouseEvt);
					mc.addEventListener(MouseEvent.ROLL_OUT,mouseEvt);
					
					mc.addEventListener(MouseEvent.MOUSE_DOWN,dragEvt);
					mc.addEventListener(MouseEvent.MOUSE_UP,dragEvt);
				}
			}
		}
		public function resetHair(){
			for each(var mc:MovieClip in elemtArr2)
			{
				mc.x=mc.posX;
				mc.y=mc.posY;
				mc.visible=true;
			}
		}
		private function dragEvt(e:MouseEvent):void
		{
			var mc:MovieClip=e.currentTarget as MovieClip;
			if(e.type=="mouseDown")
			{
				mc.filters=[glow];
				mc.startDrag();
			}
			else
			{
				mc.filters=[];
				mc.stopDrag();
				if(BitmapHitTest.complexHitTestObject(mc,Main.girl))
				{
					mc.visible=false;
					Main.girl.wearHair(elemtArr2.indexOf(mc),0,mc);
				   for each(var mcc in elemtArr2)
					{
						if(mcc!=mc)
						{
							mcc.visible=true;
							TweenLite.to(mcc,0.3,{x:mcc.posX,y:mcc.posY});
						}
					}
				}
				else
				{
					
					 TweenLite.to(mc,0.3,{x:mc.posX,y:mc.posY});
				}
				
			}
		}
		private function mouseEvt(e:MouseEvent):void
		{
			var mc:MovieClip=e.currentTarget as MovieClip;
			if(e.type=="rollOver")
			{
				mc.filters=[glow];
			}
			else
			{
				mc.filters=[];
			}
		}
		private function clickEvt(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			var mc:MovieClip=e.currentTarget as MovieClip;
			Main.girl.star.visible=true;
			Main.girl.star.gotoAndPlay(1);
			
			var seri:int=elemtNameArr.indexOf(mc.name);
			if(seri<0)
			{
				seri=elemtNameArr2.indexOf(mc.name);
				var type:int=seri;
				var val:int=0;
			}
			else
			{
				type=Math.floor(seri/5);
				val=seri%5+1;
				
			}
			Main.girl.wearHair(type,val,elemtArr2[type]);
		}
	}

}