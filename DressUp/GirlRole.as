package 
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.greensock.TweenLite;

	public class GirlRole extends MovieClip
	{
		public var star:MovieClip;
		public var step:int = 0;
		public var dressArr:Array=new Array();
		public var elemtArr:Array=new Array();
		public var visibleElemtArr:Array=new Array();
		
		public function GirlRole()
		{
			getElemt();
		}
		private function getElemtByName(nameStr:String):MovieClip
		{
			var mc:MovieClip=this.getChildByName(nameStr) as MovieClip;
			return mc;
		}
		private function getElemt():void
		{
			star = getElemtByName("_star");
			star.visible=false;

			var unvisibleElemts:Array = ["socks","scarf","dress","dress2","dress3","pants","coat","coat2","glove","shoes","shoes2","adron","adron2","deron","bag","bag2","earrings","necklace","headdress","flower","flower2","supporting"];
			
			var visibleElemts:Array	= ["toll","tail","hair","hair2","eyes","body","body2","body3","ears","ears2","face","nose","mouth","beard","wings","wings2"];

			for each(var str:String in unvisibleElemts.concat(visibleElemts)){
				var mc:MovieClip=this.getChildByName(str) as MovieClip;
				if(mc){
					elemtArr.push(mc);	
					mc.buttonMode = true;
					mc.isVisible=mc.visible = false;
					mc.gotoAndStop(1);
					mc.addEventListener(MouseEvent.CLICK,hideEvt);
					if(mc.m1){
						mc.m1.gotoAndStop(1);
					}
				}
			}
			for each(str in visibleElemts){
				mc=this.getChildByName(str) as MovieClip;
				if(mc){
					visibleElemtArr.push(mc);
					mc.isVisible=mc.visible=true;
				}
			}			
		}
		private function hideEvt(e:MouseEvent):void
		{
			Voice.clickBtnSound();
			var mc:MovieClip = e.currentTarget as MovieClip;

			var str:String = mc.name;
			var re:RegExp = /[a-z]+/;
			var ename=str.match(re);
			hideElemt(ename);
		}
		private function hideElemt(ename)
		{
			var mc1:MovieClip=getElemtByName(ename);
			if(mc1){
				mc1.visible=mc1.isVisible;
				mc1.gotoAndStop(1);
				if(mc1.m1){
					mc1.m1.gotoAndStop(1);
				}
				if(mc1.mc){
					mc1.mc.visible=true;
					TweenLite.to(mc1.mc,0.3,{x:mc1.mc.posX,y:mc1.mc.posY});
				}
			}

			var mc2:MovieClip=getElemtByName(ename+"2");
			if(mc2){
				mc2.visible=mc2.isVisible;
				mc2.gotoAndStop(1);
				if(mc2.m1){
					mc2.m1.gotoAndStop(1);
				}
			}

			var mc3:MovieClip=getElemtByName(ename+"3");
			if(mc3){
				mc3.visible=mc3.isVisible;
				mc3.gotoAndStop(1);
				if(mc3.m1){
					mc3.m1.gotoAndStop(1);
				}
			}
		}
		public function girlMove():void
		{
			this.addEventListener(Event.ENTER_FRAME,moveEvt);
		}
		public function girlStop():void
		{
			this.removeEventListener(Event.ENTER_FRAME,moveEvt);
		}
		public function moveEvt(e:Event):void
		{
			if (step>=0){
				this.y++;
			}else{
				this.y--;
			}
			if (this.y >= 15){
				step = -1;
			}else if (this.y <= -10){
				step = 1;
			}
		}
		public function resetGirl():void
		{
			dressArr=new Array();
			for each (var mc:MovieClip in elemtArr){
				if (mc){
					mc.visible = false;
					mc.gotoAndStop(1);
				}
			}
			
			for each(mc in visibleElemtArr){
				mc.visible=true;
			}
		}
		public function wearHair(type:int=0,seri:int=2,mc:MovieClip=null):void
		{
			Voice.clickBtnSound();
			star.visible=true;
			star.gotoAndPlay(1);
			var hair:MovieClip=getElemtByName("hair");
			if (dressArr.indexOf(hair) < 0){
				dressArr.push(hair);
			}
			if(mc){
				if(hair.mc&&hair.mc!=mc){
					hair.mc.visible=true;
					hair.mc.x=hair.mc.posX;
					hair.mc.y=hair.mc.posY;
				}
				hair.mc=mc;
			}
			hair.gotoAndStop(type+1);

			if(hair.m1){
				hair.m1.gotoAndStop(seri);
			}

			var hair2:MovieClip=getElemtByName("hair2");
			if(hair2){
				hair2.gotoAndStop(type+1);
				if(hair2.m1){
					hair2.m1.gotoAndStop(seri);
				}
			}
			var hair3:MovieClip=getElemtByName("hair3");
			if(hair3){
				hair3.gotoAndStop(type+1);
				if(hair3.m1){
					hair3.m1.gotoAndStop(seri);
				}
			}
		}
		public function wearTail(type:int=1,seri:int=1,mc:MovieClip=null):void
		{
			star.visible=true;
			star.gotoAndPlay(1);
			var tail:MovieClip=getElemtByName("tail");
			if (dressArr.indexOf(tail) < 0){
				dressArr.push(tail);
			}
			
			if(mc){
				tail.mc=mc;
			}
			
			tail.gotoAndStop(type+1);
			if(tail.m1){
				tail.m1.gotoAndStop(seri);
			}
		}
		
		public function decoratorGirl(decoratorName:String,seri:int,dMc:MovieClip=null):void
		{
			var mc=getElemtByName(decoratorName);
			if(mc){
				if (dressArr.indexOf(mc) < 0){
					dressArr.push(mc);
				}
				mc.visible = true;
				mc.gotoAndStop(seri);
				mc.mc=dMc;
			}
			var mc2=getElemtByName(decoratorName+"2");
			if(mc2){
				mc2.visible = true;
				mc2.gotoAndStop(seri);
				mc2.mc=dMc;
			}
			var mc3=getElemtByName(decoratorName+"3");
			if(mc3){
				mc3.visible = true;
				mc3.gotoAndStop(seri);
				mc3.mc=dMc;
			}
			
			if(decoratorName=="dress"){
				hideElemt("coat");
				hideElemt("pants");
				
			}
			if(decoratorName=="coat"||decoratorName=="pants"){
				hideElemt("dress");
			}
		}
	}

}