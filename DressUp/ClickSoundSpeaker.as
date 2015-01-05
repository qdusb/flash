package {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class ClickSoundSpeaker extends MovieClip {
		
		public static var speakerIndex:int=1;
		
		public function ClickSoundSpeaker() 
		{
			this.gotoAndStop(speakerIndex);
			this.addEventListener(MouseEvent.CLICK,selectSound);
			this.buttonMode=true;
		}
		private function selectSound(e:MouseEvent):void
		{
			if(this.currentFrame==1)
			{
				speakerIndex=2;
				this.gotoAndStop(2);
				Voice.stopClickSound();
				return;
			}
			if(this.currentFrame==2)
			{
				speakerIndex=1;
				Voice.startClickSound();
				this.gotoAndStop(1);
				return;
			}
		}
	}
	
}
