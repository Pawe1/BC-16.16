//class StatsDisplay
package starling.core 
{
    import flash.system.*;
    import starling.display.*;
    import starling.events.*;
    import starling.rendering.*;
    import starling.styles.*;
    import starling.text.*;
    import starling.utils.*;
    
    internal class StatsDisplay extends starling.display.Sprite
    {
        public function StatsDisplay()
        {
            super();
            var loc1:*=starling.text.BitmapFont.MINI;
            var loc2:*=starling.text.BitmapFont.NATIVE_SIZE;
            var loc3:*=16777215;
            var loc4:*=90;
            var loc5:*=this.supportsGpuMem ? 35 : 27;
            var loc6:*=this.supportsGpuMem ? "\ngpu memory:" : "";
            var loc7:*="frames/sec:\nstd memory:" + loc6 + "\ndraw calls:";
            this._labels = new starling.text.TextField(loc4, loc5, loc7);
            this._labels.format.setTo(loc1, loc2, loc3, starling.utils.Align.LEFT);
            this._labels.batchable = true;
            this._labels.x = 2;
            this._values = new starling.text.TextField((loc4 - 1), loc5, "");
            this._values.format.setTo(loc1, loc2, loc3, starling.utils.Align.RIGHT);
            this._values.batchable = true;
            this._background = new starling.display.Quad(loc4, loc5, 0);
            if (this._background.style.type != starling.styles.MeshStyle) 
            {
                this._background.style = new starling.styles.MeshStyle();
            }
            if (this._labels.style.type != starling.styles.MeshStyle) 
            {
                this._labels.style = new starling.styles.MeshStyle();
            }
            if (this._values.style.type != starling.styles.MeshStyle) 
            {
                this._values.style = new starling.styles.MeshStyle();
            }
            addChild(this._background);
            addChild(this._labels);
            addChild(this._values);
            addEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            return;
        }

        internal function onAddedToStage():void
        {
            addEventListener(starling.events.Event.ENTER_FRAME, this.onEnterFrame);
            var loc1:*;
            this._skipCount = loc1 = 0;
            this._frameCount = loc1 = loc1;
            this._totalTime = loc1;
            this.update();
            return;
        }

        internal function onRemovedFromStage():void
        {
            removeEventListener(starling.events.Event.ENTER_FRAME, this.onEnterFrame);
            return;
        }

        internal function onEnterFrame(arg1:starling.events.EnterFrameEvent):void
        {
            this._totalTime = this._totalTime + arg1.passedTime;
            var loc1:*;
            var loc2:*=((loc1 = this)._frameCount + 1);
            loc1._frameCount = loc2;
            if (this._totalTime > UPDATE_INTERVAL) 
            {
                this.update();
                this._totalTime = loc1 = 0;
                this._skipCount = loc1 = loc1;
                this._frameCount = loc1;
            }
            return;
        }

        public function update():void
        {
            this._background.color = this._skipCount > this._frameCount / 2 ? 16128 : 0;
            this._fps = this._totalTime > 0 ? this._frameCount / this._totalTime : 0;
            this._memory = flash.system.System.totalMemory * B_TO_MB;
            this._gpuMemory = this.supportsGpuMem ? starling.core.Starling.context["totalGPUMemory"] * B_TO_MB : -1;
            var loc1:*=this._fps.toFixed(this._fps < 100 ? 1 : 0);
            var loc2:*=this._memory.toFixed(this._memory < 100 ? 1 : 0);
            var loc3:*=this._gpuMemory.toFixed(this._gpuMemory < 100 ? 1 : 0);
            var loc4:*=(this._totalTime > 0 ? this._drawCount - 2 : this._drawCount).toString();
            this._values.text = loc1 + "\n" + loc2 + "\n" + (this._gpuMemory >= 0 ? loc3 + "\n" : "") + loc4;
            return;
        }

        public function markFrameAsSkipped():void
        {
            this._skipCount = this._skipCount + 1;
            return;
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            arg1.excludeFromCache(this);
            arg1.finishMeshBatch();
            super.render(arg1);
            return;
        }

        internal function get supportsGpuMem():Boolean
        {
            return "totalGPUMemory" in starling.core.Starling.context;
        }

        public function get drawCount():int
        {
            return this._drawCount;
        }

        public function set drawCount(arg1:int):void
        {
            this._drawCount = arg1;
            return;
        }

        public function get fps():Number
        {
            return this._fps;
        }

        public function set fps(arg1:Number):void
        {
            this._fps = arg1;
            return;
        }

        public function get memory():Number
        {
            return this._memory;
        }

        public function set memory(arg1:Number):void
        {
            this._memory = arg1;
            return;
        }

        public function get gpuMemory():Number
        {
            return this._gpuMemory;
        }

        public function set gpuMemory(arg1:Number):void
        {
            this._gpuMemory = arg1;
            return;
        }

        internal static const UPDATE_INTERVAL:Number=0.5;

        internal static const B_TO_MB:Number=1 / (1024 * 1024);

        internal var _background:starling.display.Quad;

        internal var _labels:starling.text.TextField;

        internal var _values:starling.text.TextField;

        internal var _frameCount:int=0;

        internal var _totalTime:Number=0;

        internal var _fps:Number=0;

        internal var _memory:Number=0;

        internal var _gpuMemory:Number=0;

        internal var _drawCount:int=0;

        internal var _skipCount:int=0;
    }
}


