package {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class BackSoundSpeaker extends MovieClip {
		
		public static var speakerIndex:int=1;
		
		public function BackSoundSpeaker() 
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
				Voice.stopBackSound();
				return;
			}
			if(this.currentFrame==2)
			{
				speakerIndex=1;
				Voice.startBackSound();
				this.gotoAndStop(1);
				return;
			}
		}
	}
	
}
