//class BitmapAsset
package mx.core 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.system.*;
    
    use namespace mx_internal;
    
    public class BitmapAsset extends mx.core.FlexBitmap implements mx.core.IFlexAsset, mx.core.IFlexDisplayObject, mx.core.ILayoutDirectionElement
    {
        public function BitmapAsset(arg1:flash.display.BitmapData=null, arg2:String="auto", arg3:Boolean=false)
        {
            var loc1:*=null;
            super(arg1, arg2, arg3);
            if (FlexVersionClass == null) 
            {
                loc1 = flash.system.ApplicationDomain.currentDomain;
                if (loc1.hasDefinition("mx.core::FlexVersion")) 
                {
                    FlexVersionClass = Class(loc1.getDefinition("mx.core::FlexVersion"));
                }
            }
            if (FlexVersionClass && FlexVersionClass["compatibilityVersion"] >= FlexVersionClass["VERSION_4_0"]) 
            {
                this.addEventListener(flash.events.Event.ADDED, this.addedHandler);
            }
            return;
        }

        internal function initAdvancedLayoutFeatures():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this.layoutFeaturesClass == null) 
            {
                loc1 = flash.system.ApplicationDomain.currentDomain;
                if (loc1.hasDefinition("mx.core::AdvancedLayoutFeatures")) 
                {
                    this.layoutFeaturesClass = Class(loc1.getDefinition("mx.core::AdvancedLayoutFeatures"));
                }
                if (MatrixUtilClass == null) 
                {
                    if (loc1.hasDefinition("mx.utils::MatrixUtil")) 
                    {
                        MatrixUtilClass = Class(loc1.getDefinition("mx.utils::MatrixUtil"));
                    }
                }
            }
            if (this.layoutFeaturesClass != null) 
            {
                loc2 = new this.layoutFeaturesClass();
                loc2.layoutScaleX = this.scaleX;
                loc2.layoutScaleY = this.scaleY;
                loc2.layoutScaleZ = this.scaleZ;
                loc2.layoutRotationX = this.rotationX;
                loc2.layoutRotationY = this.rotationY;
                loc2.layoutRotationZ = this.rotation;
                loc2.layoutX = this.x;
                loc2.layoutY = this.y;
                loc2.layoutZ = this.z;
                loc2.layoutWidth = this.width;
                this._height = this.height;
                this.layoutFeatures = loc2;
            }
            return;
        }

        internal function validateTransformMatrix():void
        {
            if (this.layoutFeatures != null) 
            {
                if (this.layoutFeatures.is3D) 
                {
                    super.transform.matrix3D = this.layoutFeatures.computedMatrix3D;
                }
                else 
                {
                    super.transform.matrix = this.layoutFeatures.computedMatrix;
                }
            }
            return;
        }

        public override function get x():Number
        {
            return this.layoutFeatures != null ? this.layoutFeatures.layoutX : super.x;
        }

        public override function set x(arg1:Number):void
        {
            if (this.x == arg1) 
            {
                return;
            }
            if (this.layoutFeatures != null) 
            {
                this.layoutFeatures.layoutX = arg1;
                this.validateTransformMatrix();
            }
            else 
            {
                super.x = arg1;
            }
            return;
        }

        public override function get y():Number
        {
            return this.layoutFeatures != null ? this.layoutFeatures.layoutY : super.y;
        }

        public override function set y(arg1:Number):void
        {
            if (this.y == arg1) 
            {
                return;
            }
            if (this.layoutFeatures != null) 
            {
                this.layoutFeatures.layoutY = arg1;
                this.validateTransformMatrix();
            }
            else 
            {
                super.y = arg1;
            }
            return;
        }

        public override function get z():Number
        {
            return this.layoutFeatures != null ? this.layoutFeatures.layoutZ : super.z;
        }

        public override function set z(arg1:Number):void
        {
            if (this.z == arg1) 
            {
                return;
            }
            if (this.layoutFeatures != null) 
            {
                this.layoutFeatures.layoutZ = arg1;
                this.validateTransformMatrix();
            }
            else 
            {
                super.z = arg1;
            }
            return;
        }

        public override function get width():Number
        {
            var loc1:*=null;
            if (this.layoutFeatures == null) 
            {
                return super.width;
            }
            if (MatrixUtilClass != null) 
            {
                var loc2:*;
                loc1 = (loc2 = MatrixUtilClass)["transformSize"](this.layoutFeatures.layoutWidth, this._height, transform.matrix);
            }
            return loc1 ? loc1.x : super.width;
        }

        public override function set width(arg1:Number):void
        {
            if (this.width == arg1) 
            {
                return;
            }
            if (this.layoutFeatures != null) 
            {
                this.layoutFeatures.layoutWidth = arg1;
                this.layoutFeatures.layoutScaleX = this.measuredWidth == 0 ? 0 : arg1 / this.measuredWidth;
                this.validateTransformMatrix();
            }
            else 
            {
                super.width = arg1;
            }
            return;
        }

        
        {
            mx_internal::VERSION = "4.14.0.0";
        }

        public override function get height():Number
        {
            var loc1:*=null;
            if (this.layoutFeatures == null) 
            {
                return super.height;
            }
            if (MatrixUtilClass != null) 
            {
                var loc2:*;
                loc1 = (loc2 = MatrixUtilClass)["transformSize"](this.layoutFeatures.layoutWidth, this._height, transform.matrix);
            }
            return loc1 ? loc1.y : super.height;
        }

        public override function set height(arg1:Number):void
        {
            if (this.height == arg1) 
            {
                return;
            }
            if (this.layoutFeatures != null) 
            {
                this._height = arg1;
                this.layoutFeatures.layoutScaleY = this.measuredHeight == 0 ? 0 : arg1 / this.measuredHeight;
                this.validateTransformMatrix();
            }
            else 
            {
                super.height = arg1;
            }
            return;
        }

        public override function get rotationX():Number
        {
            return this.layoutFeatures != null ? this.layoutFeatures.layoutRotationX : super.rotationX;
        }

        public override function set rotationX(arg1:Number):void
        {
            if (this.rotationX == arg1) 
            {
                return;
            }
            if (this.layoutFeatures != null) 
            {
                this.layoutFeatures.layoutRotationX = arg1;
                this.validateTransformMatrix();
            }
            else 
            {
                super.rotationX = arg1;
            }
            return;
        }

        public override function get rotationY():Number
        {
            return this.layoutFeatures != null ? this.layoutFeatures.layoutRotationY : super.rotationY;
        }

        public override function set rotationY(arg1:Number):void
        {
            if (this.rotationY == arg1) 
            {
                return;
            }
            if (this.layoutFeatures != null) 
            {
                this.layoutFeatures.layoutRotationY = arg1;
                this.validateTransformMatrix();
            }
            else 
            {
                super.rotationY = arg1;
            }
            return;
        }

        public override function get rotationZ():Number
        {
            return this.layoutFeatures != null ? this.layoutFeatures.layoutRotationZ : super.rotationZ;
        }

        public override function set rotationZ(arg1:Number):void
        {
            if (this.rotationZ == arg1) 
            {
                return;
            }
            if (this.layoutFeatures != null) 
            {
                this.layoutFeatures.layoutRotationZ = arg1;
                this.validateTransformMatrix();
            }
            else 
            {
                super.rotationZ = arg1;
            }
            return;
        }

        public override function get rotation():Number
        {
            return this.layoutFeatures != null ? this.layoutFeatures.layoutRotationZ : super.rotation;
        }

        public override function set rotation(arg1:Number):void
        {
            if (this.rotation == arg1) 
            {
                return;
            }
            if (this.layoutFeatures != null) 
            {
                this.layoutFeatures.layoutRotationZ = arg1;
                this.validateTransformMatrix();
            }
            else 
            {
                super.rotation = arg1;
            }
            return;
        }

        public override function get scaleX():Number
        {
            return this.layoutFeatures != null ? this.layoutFeatures.layoutScaleX : super.scaleX;
        }

        public override function set scaleX(arg1:Number):void
        {
            if (this.scaleX == arg1) 
            {
                return;
            }
            if (this.layoutFeatures != null) 
            {
                this.layoutFeatures.layoutScaleX = arg1;
                this.layoutFeatures.layoutWidth = Math.abs(arg1) * this.measuredWidth;
                this.validateTransformMatrix();
            }
            else 
            {
                super.scaleX = arg1;
            }
            return;
        }

        public override function get scaleY():Number
        {
            return this.layoutFeatures != null ? this.layoutFeatures.layoutScaleY : super.scaleY;
        }

        public override function set scaleY(arg1:Number):void
        {
            if (this.scaleY == arg1) 
            {
                return;
            }
            if (this.layoutFeatures != null) 
            {
                this.layoutFeatures.layoutScaleY = arg1;
                this._height = Math.abs(arg1) * this.measuredHeight;
                this.validateTransformMatrix();
            }
            else 
            {
                super.scaleY = arg1;
            }
            return;
        }

        public override function get scaleZ():Number
        {
            return this.layoutFeatures != null ? this.layoutFeatures.layoutScaleZ : super.scaleZ;
        }

        public override function set scaleZ(arg1:Number):void
        {
            if (this.scaleZ == arg1) 
            {
                return;
            }
            if (this.layoutFeatures != null) 
            {
                this.layoutFeatures.layoutScaleZ = arg1;
                this.validateTransformMatrix();
            }
            else 
            {
                super.scaleZ = arg1;
            }
            return;
        }

        public function get layoutDirection():String
        {
            return this._layoutDirection;
        }

        public function set layoutDirection(arg1:String):void
        {
            if (arg1 == this._layoutDirection) 
            {
                return;
            }
            this._layoutDirection = arg1;
            this.invalidateLayoutDirection();
            return;
        }

        public function get measuredHeight():Number
        {
            if (bitmapData) 
            {
                return bitmapData.height;
            }
            return 0;
        }

        public function get measuredWidth():Number
        {
            if (bitmapData) 
            {
                return bitmapData.width;
            }
            return 0;
        }

        public function invalidateLayoutDirection():void
        {
            var loc2:*=false;
            var loc1:*=parent;
            while (loc1) 
            {
                if (loc1 is mx.core.ILayoutDirectionElement) 
                {
                    loc2 = !(this._layoutDirection == null) && !(mx.core.ILayoutDirectionElement(loc1).layoutDirection == null) && !(this._layoutDirection == mx.core.ILayoutDirectionElement(loc1).layoutDirection);
                    if (loc2 && this.layoutFeatures == null) 
                    {
                        this.initAdvancedLayoutFeatures();
                        if (this.layoutFeatures != null) 
                        {
                            this.layoutFeatures.mirror = loc2;
                            this.validateTransformMatrix();
                        }
                    }
                    else if (!loc2 && this.layoutFeatures) 
                    {
                        this.layoutFeatures.mirror = loc2;
                        this.validateTransformMatrix();
                        this.layoutFeatures = null;
                    }
                    break;
                }
                loc1 = loc1.parent;
            }
            return;
        }

        public function move(arg1:Number, arg2:Number):void
        {
            this.x = arg1;
            this.y = arg2;
            return;
        }

        public function setActualSize(arg1:Number, arg2:Number):void
        {
            this.width = arg1;
            this.height = arg2;
            return;
        }

        internal function addedHandler(arg1:flash.events.Event):void
        {
            this.invalidateLayoutDirection();
            return;
        }

        mx_internal static const VERSION:String="4.14.0.0";

        internal var layoutFeaturesClass:Class;

        internal var layoutFeatures:mx.core.IAssetLayoutFeatures;

        internal var _height:Number;

        internal static var FlexVersionClass:Class;

        internal static var MatrixUtilClass:Class;

        internal var _layoutDirection:String="ltr";
    }
}


