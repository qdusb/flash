package com.game
{
    import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.greensock.TweenLite;
	import flash.display.SimpleButton;
    public class OperationBar extends MovieClip
	{
		private var oNames:Array;
		private var btns:Array=new Array();
		private var bars:Array=new Array();
		private var lBtn:SimpleButton;
		private var rBtn:SimpleButton;
		private var currBar:MovieClip;

		public function OperationBar()
		{
			init();
		}
		private function init()
		{
			oNames=["hair","dress","coat","pants","shoes","socks","headdress","necklace","earrings","flower","bag"];
			for each(var nameStr:String in oNames)
			{
				var btn:SimpleButton=this.getChildByName(nameStr+"Btn") as SimpleButton;
				var bar:MovieClip=this.getChildByName(nameStr+"Bar") as MovieClip;
				if(btn&&bar)
				{
					btns.push(btn);
					bars.push(bar);
					btn.addEventListener(MouseEvent.CLICK,selectBarEvt);
					bar.visible=false;
				}
			}
			currBar=bars[0];
			currBar.visible=true;
			barHook();
			lBtn=this.getChildByName("_lBtn") as SimpleButton;
			rBtn=this.getChildByName("_rBtn") as SimpleButton;
			if(lBtn&&rBtn)
			{
				lBtn.addEventListener(MouseEvent.CLICK,barTurnEvt);
				rBtn.addEventListener(MouseEvent.CLICK,barTurnEvt);
			}
		}
		public function resetBar()
		{
			for each(var bar:MovieClip in bars)
			{
				bar.visible=false;
				bar.resetBar();
			}
			currBar=bars[0];
			currBar.visible=true;
		}
		private function barTurnEvt(e:MouseEvent)
		{
			Voice.clickBtnSound();
			if(e.currentTarget.name=="_lBtn")
			{
				currBar.turnLeft();
			}
			else
			{
				currBar.turnRight();
			}
		}
		private function selectBarEvt(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			var btn:SimpleButton=e.currentTarget as SimpleButton;
			currBar=bars[btns.indexOf(btn)];
			for each(var bar:MovieClip in bars)
			{
				bar.visible=false;
			}
			currBar.visible=true;
			barHook();
		}
		public function barHook()
		{

		}
    }
}