package {
	
	import flash.media.*;
	
	public class Voice 
	{
		public static var voiceFlag:uint=1;
		public static var clickFlag:uint=1;
		public static var backVoiceCH:SoundChannel=new SoundChannel();
		public static var clickVoiceCH:SoundChannel=new SoundChannel();
		private static var backVoice:BackVoice;
		private static var clickSound:*;
		
		public function Voice() 
		{
			
		}
		public static function soundOff():void
		{
			stopBackSound();
			
		}
		public static function soundOn():void
		{
			voiceFlag=1;
			
		}
		public static function startBackSound():void
		{
			if(backVoice==null)
			{
				backVoice=new BackVoice();
			}
			
			Voice.backVoiceCH=backVoice.play(0,1000);
			
		}
		public static function stopBackSound():void
		{
			if(Voice.backVoiceCH)
			{
				Voice.backVoiceCH.stop();
			}
		}
		public static function clickBtnSound():void
		{
			if(clickFlag==1)
			{
				
				if(clickSound==null)
				{
					clickSound=new ClickSound();
				}
				Voice.clickVoiceCH=clickSound.play();
			}
		}
		public static function startClickSound():void
		{
			clickFlag=1;
		}
		public static function stopClickSound():void
		{
			clickFlag=0;
			if(Voice.clickVoiceCH)
			{
				Voice.clickVoiceCH.stop();
			}
		}
	}
}