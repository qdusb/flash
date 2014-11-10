package 
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import com.greensock.TweenLite;
	import flash.utils.setTimeout;


	public class NeedDoneBar0 extends MovieClip
	{

		public var clickElemtArr:Array=new Array();
		public var dragElemtArr:Array=new Array();
		public var dragTargetArr:Array=new Array();
		public var dragTrashArr:Array=new Array();
		public var toolArr:Array=new Array();
		public var glow:GlowFilter=new GlowFilter(0xFFFF00,0.8,15,15);
		
		public function NeedDoneBar0()
		{
			init();
		}
		private function init():void
		{
			var cnt:int=this.numChildren;
			for(var i:int=0;i<cnt;i++)
			{
				if(this.getChildAt(i) is MovieClip)
				{
					var elemt:MovieClip=MovieClip(this.getChildAt(i));
					elemt.gotoAndStop(1);
					elemt.buttonMode=true;
					elemt.posX=elemt.x;
					elemt.posY=elemt.y;
					elemt.dgree=this.getChildIndex(elemt);
				}
			}
			clickElemtArr=[d2,d3,d4,d5,d6,d7,d8,d9,d11,d13,d14,d16];
			dragElemtArr= [d1,d10,d12,d15,d17,d18];
			dragTargetArr=[m1,m10,m12,m15, m1,m18];
			dragTrashArr=[d201,d202,d204,d203,d205,d206];
			toolArr=[shuazi,saoba,cazi];
			toolArr[0].objectArr=[d401,d402];
			toolArr[1].objectArr=[d301,d302];
			toolArr[2].objectArr=[d501,d502];

			for each(var mc:MovieClip in clickElemtArr.concat(dragElemtArr,dragTrashArr))
			{
				mc.posX=mc.x;
				mc.posY=mc.y;
				mc.addEventListener(MouseEvent.ROLL_OUT,rollEvt);
				mc.addEventListener(MouseEvent.ROLL_OVER,rollEvt)
			}
			for each(mc in clickElemtArr)
			{
				mc.addEventListener(MouseEvent.CLICK,clickEvt);
			}
			for each(mc in dragElemtArr)
			{
				mc.addEventListener(MouseEvent.MOUSE_DOWN,mouseDragEvt);
				mc.addEventListener(MouseEvent.MOUSE_UP,mouseDragEvt);
			}
			for each(mc in dragTrashArr)
			{
				mc.addEventListener(MouseEvent.MOUSE_DOWN,dragTrashEvt);
				mc.addEventListener(MouseEvent.MOUSE_UP,dragTrashEvt);
			}
			for each(mc in toolArr)
			{
				mc.seri=0;
				mc.addEventListener(MouseEvent.MOUSE_DOWN,toolDragEvt);
				mc.addEventListener(MouseEvent.MOUSE_UP,toolDragEvt);
			}

			for each(mc in dragTargetArr)
			{
				mc.alpha=0;
				mc.mouseEnabled=false;
				mc.mouseChildren=false;
			}
			
			addMc.visible=false;
			addMc.gotoAndStop(1);
			redMc.visible=false;
			redMc.gotoAndStop(1);
			starMc.visible=false;
			starMc.gotoAndStop(1);
		
			addMc.mouseEnabled=false;
			addMc.mouseChildren=false;
			redMc.mouseEnabled=false;
			redMc.mouseChildren=false;
			starMc.mouseEnabled=false;
			starMc.mouseChildren=false;
			
		}
		public function resetBar()
		{
			for each(var mc:MovieClip in clickElemtArr.concat(dragElemtArr,dragTrashArr))
			{
				mc.gotoAndStop(1);
				mc.visible=true;
				mc.x=mc.posX;
				mc.y=mc.posY;
			}
			for each(mc in toolArr)
			{
				mc.gotoAndStop(1);
				mc.seri=0;
				for each(var mc1:MovieClip in mc.objectArr)
				{
					mc1.visible=true;
					mc1.gotoAndStop(1);
				}
			}
		}
		public function addScore(mc:MovieClip=null):void
		{
			ControlBar.self.addScore();
			addMc.visible=true;
			addMc.gotoAndStop(1);
			addMc.gotoAndPlay(1);
			addMc.x=this.mouseX;
			addMc.y=this.mouseY;
			
			starMc.visible=true;
			starMc.gotoAndStop(1);
			starMc.gotoAndPlay(1);
			starMc.x=this.mouseX;
			starMc.y=this.mouseY;
			Voice.playSucessSound();
		}
		public function reduceScore(mc:MovieClip=null):void
		{
			ControlBar.self.reduceScore();
			redMc.visible=true;
			redMc.gotoAndStop(1);
			redMc.gotoAndPlay(1);
			redMc.x=this.mouseX;
			redMc.y=this.mouseY;
			Voice.playFailSound();
		}
		private function toolDragEvt(e:MouseEvent):void
		{
			var mc:MovieClip=e.currentTarget as MovieClip;
			var has:Boolean=false;
			for each(var mc1:MovieClip in mc.objectArr)
			{
				if(mc1.currentFrame==1)
				{
					has=true;
					break;
				}
			}
			if(!has)
			{
				return;
			}
			if(e.type=="mouseDown")
			{
				mc.startDrag();
				this.addChild(mc);
			}
			else if(e.type=="mouseUp")
			{
				var hit:Boolean=false;
				mc.stopDrag();
				for each(mc1 in mc.objectArr)
				{
					if(BitmapHitTest.complexHitTestObject(mc,mc1)&&mc1.currentFrame==1)
					{
						mc.visible=false;
						mc1.gotoAndStop(2);
						hit=true;
						break;
					}
				}
				if(hit)
				{
					this.addChildAt(mc,mc.dgree);
					addScore();
				}
				else
				{
					reduceScore();
				}
				TweenLite.to(mc,0.5,{x:mc.posX,y:mc.posY});
			}
		}
		private function dragTrashEvt(e:MouseEvent):void
		{
			var mc:MovieClip=e.currentTarget as MovieClip;
			if(e.type=="mouseDown")
			{
				mc.startDrag();
				this.addChild(mc);
			}
			else
			{
				mc.stopDrag();
				if(mc.hitTestObject(lajitong))
				{
					this.addChildAt(mc,mc.dgree);
					addScore();
					mc.gotoAndStop(2);
				}
				else
				{
					reduceScore();
					mc.x=mc.posX;
					mc.y=mc.posY;
				}
			}
		}
		private function mouseDragEvt(e:MouseEvent):void
		{
			var mc:MovieClip=e.currentTarget as MovieClip;
			if(mc.currentFrame==2)
			{
				return;
			}
			
			if(e.type=="mouseDown")
			{
				mc.startDrag();
				this.addChild(mc);
			}
			else
			{
				mc.stopDrag();
				mc.filters=[];

				var mmc:MovieClip=dragTargetArr[dragElemtArr.indexOf(mc)];
				if(mc.hitTestObject(mmc))
				{
					this.addChildAt(mc,mc.dgree);
					mc.gotoAndStop(2);
					addScore();
					mc.x=mc.posX;
					mc.y=mc.posY;
				}
				else
				{
					reduceScore();
					mc.x=mc.posX;
					mc.y=mc.posY;
				}
				
			}
		}
		private function rollEvt(e:MouseEvent):void
		{
			var mc:MovieClip=e.currentTarget as MovieClip;
			if(mc.currentFrame==2)
			{
				return;
			}
			if(e.type=="rollOver")
			{
				mc.filters=[glow];
			}
			else
			{
				mc.filters=[];
			}
		}
		private function clickEvt(e:MouseEvent)
		{
			var mc:MovieClip=e.currentTarget as MovieClip;
			if(mc.currentFrame==2)
			{
				return;
			}
			addScore();
			mc.gotoAndStop(2);
			mc.filters=[];
		}
	}
}