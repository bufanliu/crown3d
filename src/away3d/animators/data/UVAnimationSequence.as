package away3d.animators.data
{
	import away3d.arcane;

	use namespace arcane;

	public class UVAnimationSequence extends AnimationSequenceBase
	{
		public var frames : Vector.<UVAnimationFrame>;
		
		public function UVAnimationSequence(name:String)
		{
			super(name);
			
			frames = new Vector.<UVAnimationFrame>();
		}
		
		
		public function addFrame(frame : UVAnimationFrame, duration : Number) : void
		{
			insertFrame(frame, duration, -1);
		}
		
		public function insertFrame(frame : UVAnimationFrame, duration : Number, pos : int) : void
		{
			if(pos >= frames.length) pos = -1;
			
			_totalDuration += duration;
			frames.splice(pos, 0, frame);
			_durations.splice(pos, 0, duration);
		}
		
		public function removeFrame(pos : int):void
		{
			if(pos >= frames.length) pos = -1;
			
			frames.splice(pos, 1);
			var removeVec : Vector.<uint> = _durations.splice(pos, 1);
			_totalDuration -= removeVec[0];
		}
		
		public function changeFrameTime(pos:int, duration:Number):void
		{
			_totalDuration -= _durations[pos];
			_durations[pos] = duration;
			_totalDuration += _durations[pos];
		}
		
		public function getFrameTime(pos:int):Number
		{
			return _durations[pos];
		}
	}
}