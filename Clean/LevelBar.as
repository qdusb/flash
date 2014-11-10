package 
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.greensock.TweenLite;

	public class LevelBar extends MovieClip
	{
		private var btnNames:Array;
		public function LevelBar()
		{
			btnNames=["d1","d2","d3","d4","d5","d6"];
			for each(var str:String in btnNames)
			{
				var mc:MovieClip=this.getChildByName(str) as MovieClip;
				if(mc)
				{
					mc.gotoAndStop(1);
					mc.buttonMode=true;
					mc.addEventListener(MouseEvent.CLICK,clickEvt);
				}

			}
		}
		public function clickEvt(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			var mc:MovieClip=e.currentTarget as MovieClip;
			if(mc.name!="d1"&&mc.currentFrame==1)
			{
				return;
			}
			if(mc.callFun!=null){
				mc.callFun();
			}
		}
	}

}