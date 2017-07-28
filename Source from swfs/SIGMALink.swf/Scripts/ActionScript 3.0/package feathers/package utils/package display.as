//package display
//  class ScreenDensityScaleCalculator
package feathers.utils.display 
{
    import __AS3__.vec.*;
    import flash.errors.*;
    
    public class ScreenDensityScaleCalculator extends Object
    {
        public function ScreenDensityScaleCalculator()
        {
            this._buckets = new Vector.<ScreenDensityBucket>(0);
            super();
            return;
        }

        public function addScaleForDensity(arg1:int, arg2:Number):void
        {
            var loc3:*=null;
            var loc1:*=this._buckets.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = this._buckets[loc2];
                if (loc3.density > arg1) 
                {
                    break;
                }
                if (loc3.density === arg1) 
                {
                    throw new ArgumentError("Screen density cannot be added more than once: " + arg1);
                }
                ++loc2;
            }
            this._buckets.insertAt(loc2, new ScreenDensityBucket(arg1, arg2));
            return;
        }

        public function removeScaleForDensity(arg1:int):void
        {
            var loc3:*=null;
            var loc1:*=this._buckets.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = this._buckets[loc2];
                if (loc3.density === arg1) 
                {
                    this._buckets.removeAt(loc2);
                    return;
                }
                ++loc2;
            }
            return;
        }

        public function getScale(arg1:int):Number
        {
            var loc5:*=NaN;
            if (this._buckets.length === 0) 
            {
                throw new flash.errors.IllegalOperationError("Cannot choose scale because none have been added");
            }
            var loc1:*=this._buckets[0];
            if (arg1 <= loc1.density) 
            {
                return loc1.scale;
            }
            var loc2:*=loc1;
            var loc3:*=this._buckets.length;
            var loc4:*=1;
            while (loc4 < loc3) 
            {
                loc1 = this._buckets[loc4];
                if (arg1 > loc1.density) 
                {
                    loc2 = loc1;
                }
                else 
                {
                    loc5 = (loc1.density + loc2.density) / 2;
                    if (arg1 < loc5) 
                    {
                        return loc2.scale;
                    }
                    return loc1.scale;
                }
                ++loc4;
            }
            return loc1.scale;
        }

        protected var _buckets:__AS3__.vec.Vector.<ScreenDensityBucket>;
    }
}


class ScreenDensityBucket extends Object
{
    public function ScreenDensityBucket(arg1:Number, arg2:Number)
    {
        super();
        this.density = arg1;
        this.scale = arg2;
        return;
    }

    public var density:Number;

    public var scale:Number;
}

//  function getDisplayObjectDepthFromStage
package feathers.utils.display 
{
    import starling.display.*;
    
    public function getDisplayObjectDepthFromStage(arg1:starling.display.DisplayObject):int
    {
        if (!arg1.stage) 
        {
            return -1;
        }
        var loc1:*=0;
        while (arg1.parent) 
        {
            arg1 = arg1.parent;
            ++loc1;
        }
        return loc1;
    }
}


//  function stageToStarling
package feathers.utils.display 
{
    import starling.core.*;
    import starling.display.*;
    
    public function stageToStarling(arg1:starling.display.Stage):starling.core.Starling
    {
        var loc1:*=null;
        var loc2:*=0;
        var loc3:*=starling.core.Starling.all;
        for each (loc1 in loc3) 
        {
            if (loc1.stage !== arg1) 
            {
                continue;
            }
            return loc1;
        }
        return null;
    }
}


