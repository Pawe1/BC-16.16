//class Stage
package starling.display 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.display3D.*;
    import flash.errors.*;
    import flash.geom.*;
    import starling.core.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.rendering.*;
    import starling.utils.*;
    
    use namespace starling_internal;
    
    public class Stage extends starling.display.DisplayObjectContainer
    {
        public function Stage(arg1:int, arg2:int, arg3:uint=0)
        {
            super();
            this._width = arg1;
            this._height = arg2;
            this._color = arg3;
            this._fieldOfView = 1;
            this._projectionOffset = new flash.geom.Point();
            this._cameraPosition = new flash.geom.Vector3D();
            this._enterFrameEvent = new starling.events.EnterFrameEvent(starling.events.Event.ENTER_FRAME, 0);
            this._enterFrameListeners = new Vector.<starling.display.DisplayObject>(0);
            return;
        }

        public function get focalLength():Number
        {
            return this._width / (2 * Math.tan(this._fieldOfView / 2));
        }

        public function set focalLength(arg1:Number):void
        {
            this._fieldOfView = 2 * Math.atan(this.stageWidth / (2 * arg1));
            return;
        }

        public function get fieldOfView():Number
        {
            return this._fieldOfView;
        }

        public function set fieldOfView(arg1:Number):void
        {
            this._fieldOfView = arg1;
            return;
        }

        public override function hitTest(arg1:flash.geom.Point):starling.display.DisplayObject
        {
            if (!visible || !touchable) 
            {
                return null;
            }
            if (arg1.x < 0 || arg1.x > this._width || arg1.y < 0 || arg1.y > this._height) 
            {
                return null;
            }
            var loc1:*=super.hitTest(arg1);
            return loc1 ? loc1 : this;
        }

        public function get projectionOffset():flash.geom.Point
        {
            return this._projectionOffset;
        }

        public function set projectionOffset(arg1:flash.geom.Point):void
        {
            this._projectionOffset.setTo(arg1.x, arg1.y);
            return;
        }

        public function get cameraPosition():flash.geom.Vector3D
        {
            return this.getCameraPosition(null, this._cameraPosition);
        }

        public function advanceTime(arg1:Number):void
        {
            this._enterFrameEvent.starling_internal::reset(starling.events.Event.ENTER_FRAME, false, arg1);
            broadcastEvent(this._enterFrameEvent);
            return;
        }

        
        {
            sMatrix = new flash.geom.Matrix();
            sMatrix3D = new flash.geom.Matrix3D();
        }

        public function drawToBitmapData(arg1:flash.display.BitmapData=null, arg2:Boolean=true):flash.display.BitmapData
        {
            var loc4:*=0;
            var loc5:*=0;
            var loc1:*=starling.core.Starling.painter;
            var loc2:*=loc1.state;
            var loc3:*=loc1.context;
            if (arg1 == null) 
            {
                loc4 = loc3.backBufferWidth;
                loc5 = loc3.backBufferHeight;
                arg1 = new flash.display.BitmapData(loc4, loc5, arg2);
            }
            loc1.pushState();
            loc2.renderTarget = null;
            loc2.setProjectionMatrix(0, 0, this._width, this._height, this._width, this._height, this.cameraPosition);
            if (arg2) 
            {
                loc1.clear();
            }
            else 
            {
                loc1.clear(this._color, 1);
            }
            render(loc1);
            loc1.finishMeshBatch();
            loc3.drawToBitmapData(arg1);
            loc3.present();
            loc1.popState();
            return arg1;
        }

        public function getStageBounds(arg1:starling.display.DisplayObject, arg2:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            if (arg2 == null) 
            {
                arg2 = new flash.geom.Rectangle();
            }
            arg2.setTo(0, 0, this._width, this._height);
            getTransformationMatrix(arg1, sMatrix);
            return starling.utils.RectangleUtil.getBounds(arg2, sMatrix, arg2);
        }

        public function getCameraPosition(arg1:starling.display.DisplayObject=null, arg2:flash.geom.Vector3D=null):flash.geom.Vector3D
        {
            getTransformationMatrix3D(arg1, sMatrix3D);
            return starling.utils.MatrixUtil.transformCoords3D(sMatrix3D, this._width / 2 + this._projectionOffset.x, this._height / 2 + this._projectionOffset.y, -this.focalLength, arg2);
        }

        function addEnterFrameListener(arg1:starling.display.DisplayObject):void
        {
            var loc1:*=this._enterFrameListeners.indexOf(arg1);
            if (loc1 < 0) 
            {
                this._enterFrameListeners[this._enterFrameListeners.length] = arg1;
            }
            return;
        }

        function removeEnterFrameListener(arg1:starling.display.DisplayObject):void
        {
            var loc1:*=this._enterFrameListeners.indexOf(arg1);
            if (loc1 >= 0) 
            {
                this._enterFrameListeners.removeAt(loc1);
            }
            return;
        }

        override function getChildEventListeners(arg1:starling.display.DisplayObject, arg2:String, arg3:__AS3__.vec.Vector.<starling.display.DisplayObject>):void
        {
            var loc1:*=0;
            var loc2:*=0;
            if (arg2 == starling.events.Event.ENTER_FRAME && arg1 == this) 
            {
                loc1 = 0;
                loc2 = this._enterFrameListeners.length;
                while (loc1 < loc2) 
                {
                    arg3[arg3.length] = this._enterFrameListeners[loc1];
                    ++loc1;
                }
            }
            else 
            {
                super.getChildEventListeners(arg1, arg2, arg3);
            }
            return;
        }

        public override function set width(arg1:Number):void
        {
            throw new flash.errors.IllegalOperationError("Cannot set width of stage");
        }

        public override function set height(arg1:Number):void
        {
            throw new flash.errors.IllegalOperationError("Cannot set height of stage");
        }

        public override function set x(arg1:Number):void
        {
            throw new flash.errors.IllegalOperationError("Cannot set x-coordinate of stage");
        }

        public override function set y(arg1:Number):void
        {
            throw new flash.errors.IllegalOperationError("Cannot set y-coordinate of stage");
        }

        public override function set scaleX(arg1:Number):void
        {
            throw new flash.errors.IllegalOperationError("Cannot scale stage");
        }

        public override function set scaleY(arg1:Number):void
        {
            throw new flash.errors.IllegalOperationError("Cannot scale stage");
        }

        public override function set rotation(arg1:Number):void
        {
            throw new flash.errors.IllegalOperationError("Cannot rotate stage");
        }

        public override function set skewX(arg1:Number):void
        {
            throw new flash.errors.IllegalOperationError("Cannot skew stage");
        }

        public override function set skewY(arg1:Number):void
        {
            throw new flash.errors.IllegalOperationError("Cannot skew stage");
        }

        public override function set filter(arg1:starling.filters.FragmentFilter):void
        {
            throw new flash.errors.IllegalOperationError("Cannot add filter to stage. Add it to \'root\' instead!");
        }

        public function get color():uint
        {
            return this._color;
        }

        public function set color(arg1:uint):void
        {
            this._color = arg1;
            return;
        }

        public function get stageWidth():int
        {
            return this._width;
        }

        public function set stageWidth(arg1:int):void
        {
            this._width = arg1;
            return;
        }

        public function get stageHeight():int
        {
            return this._height;
        }

        public function set stageHeight(arg1:int):void
        {
            this._height = arg1;
            return;
        }

        public function get starling():starling.core.Starling
        {
            var loc1:*=starling.core.Starling.all;
            var loc2:*=loc1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                if (loc1[loc3].stage == this) 
                {
                    return loc1[loc3];
                }
                ++loc3;
            }
            return null;
        }

        internal var _width:int;

        internal var _height:int;

        internal var _color:uint;

        internal var _fieldOfView:Number;

        internal var _cameraPosition:flash.geom.Vector3D;

        internal var _enterFrameEvent:starling.events.EnterFrameEvent;

        internal var _enterFrameListeners:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        internal var _projectionOffset:flash.geom.Point;

        internal static var sMatrix3D:flash.geom.Matrix3D;

        internal static var sMatrix:flash.geom.Matrix;
    }
}


