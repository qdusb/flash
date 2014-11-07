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
			elemtNameArr=["d1","d2","d3","d4","d5","d6","d7","d8","d9","d10"];
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
				}
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
			switch(this.name)
			{
				case "hairBar":
				case "hairBar2":
				Main.girl.wearHair(seri,mc);
				break;
				case "pantsBar":
				case "pantsBar2":
				Main.girl.wearPants(seri,mc);
				break;
				case "coatBar":
				case "coatBar2":
				Main.girl.wearCoat(seri,mc);
				break;
				case "dressBar":
				case "dressBar2":
				Main.girl.wearDress(seri,mc);
				break;
				case "necklaceBar":
				case "necklaceBar2":
				Main.girl.wearNecklace(seri,mc);
				break;
				case "earringsBar":
				case "earringsBar2":
				Main.girl.wearEarrings(seri,mc);
				break;
				case "flowerBar":
				case "flowerBar2":
				Main.girl.wearFlower(seri,mc);
				break;
				case "shoesBar":
				case "shoesBar2":
				Main.girl.wearShoes(seri,mc);
				break;
				case "headdressBar":
				case "headdressBar2":
				Main.girl.wearHeaddress(seri,mc);
				break;
			}
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
				var arr:Array=new Array();
				for(var j:int=0;j<pageNum;j++)
				{
					if(elemtArr[i*pageNum+j])
					{
						arr.push(elemtArr[i*pageNum+j]);
					}
				}
				pageArr.push(arr);
			}
			seri=0;
			for each(var mc:MovieClip in elemtArr)
			{
				mc.visible=false;
			}
			for(i=0;i<pageNum;i++)
			{
				elemtArr[i].visible=true;
			}
		}
		public function turnRight():void
		{
			seri++;
			if(seri==pageArr.length)
			{
				seri=0;
			}
			for each(var mc:MovieClip in elemtArr)
			{
				mc.visible=false;
			}
			for(var i:int=0;i<pageNum;i++)
			{
				elemtArr[seri*pageNum+i].visible=true;
			}
		}
		public function turnLeft():void
		{
			seri--;
			if(seri<0)
			{
				seri=pageArr.length-1;
			}
			for each(var mc:MovieClip in elemtArr)
			{
				mc.visible=false;
			}
			for(var i:int=0;i<pageNum;i++)
			{
				elemtArr[seri*pageNum+i].visible=true;
			}
		}
	}
}