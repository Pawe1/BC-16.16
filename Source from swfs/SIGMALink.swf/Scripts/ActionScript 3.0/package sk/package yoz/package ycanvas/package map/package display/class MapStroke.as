//class MapStroke
package sk.yoz.ycanvas.map.display 
{
    import __AS3__.vec.*;
    import flash.display3D.*;
    import sk.yoz.utils.*;
    
    public class MapStroke extends sk.yoz.ycanvas.map.display.Stroke
    {
        public function MapStroke(arg1:__AS3__.vec.Vector.<Number>, arg2:Number=1, arg3:uint=16777215, arg4:Number=1)
        {
            _basePoints = arg1.concat();
            _originalThickness = arg2;
            super(null, arg2, arg3, arg4, false);
            return;
        }

        public function get basePoints():__AS3__.vec.Vector.<Number>
        {
            return _basePoints;
        }

        public function get layerScale():Number
        {
            return _layerScale;
        }

        public function set layerScale(arg1:Number):void
        {
            if (layerScale == arg1) 
            {
                return;
            }
            _layerScale = arg1;
            thickness = originalThickness / layerScale;
            invalidatePoints();
            return;
        }

        public function get originalThickness():Number
        {
            return _originalThickness;
        }

        internal function invalidatePoints():void
        {
            if (!simplifyTolerance) 
            {
                return;
            }
            var loc1:*=this.autoUpdate;
            this.autoUpdate = false;
            points = null;
            this.autoUpdate = loc1;
            return;
        }

        internal function validatePoints():void
        {
            if (points) 
            {
                return;
            }
            var loc1:*=this.autoUpdate;
            this.autoUpdate = false;
            var loc2:*=simplifyTolerance / layerScale;
            points = simplifyTolerance ? sk.yoz.utils.PathSimplify.simplify(basePoints, loc2, false) : basePoints.concat();
            this.autoUpdate = loc1;
            return;
        }

        public override function update():void
        {
            validatePoints();
            super.update();
            return;
        }

        internal var _basePoints:__AS3__.vec.Vector.<Number>;

        internal var _layerScale:Number;

        internal var _originalThickness:Number;

        public var simplifyTolerance:Number=4;

        internal var _indexBuffer:flash.display3D.IndexBuffer3D;

        internal var _vertexBuffer:flash.display3D.VertexBuffer3D;
    }
}


