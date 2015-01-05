package com.game
{
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;
	import flash.events.MouseEvent;
	import com.greensock.TweenLite;

	public class BasicBar extends MovieClip
	{

		public var elemtArr:Array=new Array();
		public var pageArr:Array=new Array();
		public var elemtNameArr:Array=new Array();
		public var seri:int=0;
		public var pageNum:int=1;
		public var clickFlag:int=0;
		private var glow:GlowFilter=new GlowFilter(0xFFFF00,0.8,20,20);
		public function BasicBar()
		{
			elemtNameArr=["d1","d2","d3","d4","d5","d6","d7","d8","d9","d10",
						  "d11","d12","d13","d14","d15","d16","d17","d18","d19","d20",
						  "d21","d22","d23","d24","d25","d26","d27","d28","d29","d30",
						  "d31","d32","d33","d34","d35","d36","d37","d38","d39","d40",
						  "d41","d42","d43","d44","d45","d46","d47","d48","d49","d50"];
			initElemt();
			//setPageArr(2);
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
					mc.posX=mc.x;
					mc.posY=mc.y;
					mc.addEventListener(MouseEvent.MOUSE_DOWN,mouseEvt);
					mc.addEventListener(MouseEvent.MOUSE_UP,mouseEvt);
					//mc.addEventListener(MouseEvent.CLICK,clickEvt);
				}
			}
		}
		public function resetBar()
		{
			for each(var mc:MovieClip in elemtArr)
			{
				mc.x=mc.posX;
				mc.y=mc.posY;
				mc.visible=true;
			}
		}
		private function mouseEvt(e:MouseEvent):void
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
					deronMc(mc);
				   for each(var mcc in elemtArr)
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
		private function deronMc(mc):void
		{
			Voice.clickBtnSound();
			var seri:int=elemtNameArr.indexOf(mc.name)+1;
			Main.girl.star.visible=true;
			Main.girl.star.gotoAndPlay(1);
			var str:String = this.name;
			var re:RegExp = /([a-z]+)Bar/;
			var ename=str.match(re);
			Main.girl.decoratorGirl(ename[1],seri,mc);
		}
		public function setPageArr(num:int=6):void
		{
			pageNum=num;
			var cnt:int=elemtArr.length;
			if(cnt<=0)
			{
				return;
			}
			var page:int=Math.ceil(cnt/pageNum);
			for(var i:int=0;i<page;i++)
			{
				var arr:Array=elemtArr.slice(pageNum*i,pageNum*(i+1));
				pageArr.push(arr);
			}
			seri=0;
			for each(var mc:MovieClip in elemtArr)
			{
				mc.visible=false;
			}
			for each(mc in pageArr[0])
			{
				mc.visible=true;
			}
		}
		public function turnRight():void
		{
			seri++;
			seri=seri==pageArr.length?0:seri;
			showCurrPage();
		}
		public function turnLeft():void
		{
			seri--;
			seri=seri<0?pageArr.length-1:seri;
			showCurrPage();
		}
		public function showCurrPage()
		{
			for each(var mc:MovieClip in elemtArr)
			{
				mc.visible=false;
			}
			for each(mc in pageArr[seri])
			{
				mc.visible=true;
			}
		}

	}

}