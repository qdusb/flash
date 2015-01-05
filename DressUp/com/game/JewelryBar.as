package com.game
{

	public class JewelryBar
	{
		public var bars:Array;
		private var seri:int=0;

		public function JewelryBar()
		{
			init();
		}
		public function init():void
		{
			seri=0;
			bars=[necklaceBar,earringsBar];
		}
		public function turnLeft():void
		{
			seri--;
			seri=seri<0?bars.length-1:seri;
			showCurrPage();
		}
		public function turnRight():void
		{
			seri++;
			seri=seri==bars.length?0:seri;
			showCurrPage();
		}
		public function showCurrPage()
		{
			for each(var bar:MovieClip in bars)
			{
				bar.visible=false;
			}
			bar[seri].visible=true;
		}

	}

}