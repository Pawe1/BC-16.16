//package mx
//  package core
//    class BitmapAsset
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


//    class ByteArrayAsset
package mx.core 
{
    import flash.utils.*;
    
    use namespace mx_internal;
    
    public class ByteArrayAsset extends flash.utils.ByteArray implements mx.core.IFlexAsset
    {
        public function ByteArrayAsset()
        {
            super();
            return;
        }

        
        {
            mx_internal::VERSION = "4.14.0.0";
        }

        mx_internal static const VERSION:String="4.14.0.0";
    }
}


//    class FlexBitmap
package mx.core 
{
    import flash.display.*;
    import mx.utils.*;
    
    use namespace mx_internal;
    
    public class FlexBitmap extends flash.display.Bitmap
    {
        public function FlexBitmap(arg1:flash.display.BitmapData=null, arg2:String="auto", arg3:Boolean=false)
        {
            super(arg1, arg2, arg3);
            try 
            {
                name = mx.utils.NameUtil.createUniqueName(this);
            }
            catch (e:Error)
            {
            };
            return;
        }

        public override function toString():String
        {
            return mx.utils.NameUtil.displayObjectToString(this);
        }

        
        {
            mx_internal::VERSION = "4.14.0.0";
        }

        mx_internal static const VERSION:String="4.14.0.0";
    }
}


//    class FontAsset
package mx.core 
{
    import flash.text.*;
    
    use namespace mx_internal;
    
    public class FontAsset extends flash.text.Font implements mx.core.IFlexAsset
    {
        public function FontAsset()
        {
            super();
            return;
        }

        
        {
            mx_internal::VERSION = "4.14.0.0";
        }

        mx_internal static const VERSION:String="4.14.0.0";
    }
}


//    class IAssetLayoutFeatures
package mx.core 
{
    import flash.geom.*;
    
    public interface IAssetLayoutFeatures
    {
        function set layoutX(arg1:Number):void;

        function get layoutX():Number;

        function set layoutY(arg1:Number):void;

        function get layoutY():Number;

        function set layoutZ(arg1:Number):void;

        function get layoutZ():Number;

        function get layoutWidth():Number;

        function set layoutWidth(arg1:Number):void;

        function set transformX(arg1:Number):void;

        function get transformX():Number;

        function set transformY(arg1:Number):void;

        function get transformY():Number;

        function set transformZ(arg1:Number):void;

        function get transformZ():Number;

        function set layoutRotationX(arg1:Number):void;

        function get layoutRotationX():Number;

        function set layoutRotationY(arg1:Number):void;

        function get layoutRotationY():Number;

        function set layoutRotationZ(arg1:Number):void;

        function get layoutRotationZ():Number;

        function set layoutScaleX(arg1:Number):void;

        function get layoutScaleX():Number;

        function set layoutScaleY(arg1:Number):void;

        function get layoutScaleY():Number;

        function set layoutScaleZ(arg1:Number):void;

        function get layoutScaleZ():Number;

        function set layoutMatrix(arg1:flash.geom.Matrix):void;

        function get layoutMatrix():flash.geom.Matrix;

        function set layoutMatrix3D(arg1:flash.geom.Matrix3D):void;

        function get layoutMatrix3D():flash.geom.Matrix3D;

        function get is3D():Boolean;

        function get layoutIs3D():Boolean;

        function get mirror():Boolean;

        function set mirror(arg1:Boolean):void;

        function get stretchX():Number;

        function set stretchX(arg1:Number):void;

        function get stretchY():Number;

        function set stretchY(arg1:Number):void;

        function get computedMatrix():flash.geom.Matrix;

        function get computedMatrix3D():flash.geom.Matrix3D;
    }
}


//    class IChildList
package mx.core 
{
    import flash.display.*;
    import flash.geom.*;
    
    public interface IChildList
    {
        function get numChildren():int;

        function addChild(arg1:flash.display.DisplayObject):flash.display.DisplayObject;

        function addChildAt(arg1:flash.display.DisplayObject, arg2:int):flash.display.DisplayObject;

        function removeChild(arg1:flash.display.DisplayObject):flash.display.DisplayObject;

        function removeChildAt(arg1:int):flash.display.DisplayObject;

        function getChildAt(arg1:int):flash.display.DisplayObject;

        function getChildByName(arg1:String):flash.display.DisplayObject;

        function getChildIndex(arg1:flash.display.DisplayObject):int;

        function setChildIndex(arg1:flash.display.DisplayObject, arg2:int):void;

        function getObjectsUnderPoint(arg1:flash.geom.Point):Array;

        function contains(arg1:flash.display.DisplayObject):Boolean;
    }
}


//    class IFlexAsset
package mx.core 
{
    public interface IFlexAsset
    {
    }
}


//    class IFlexDisplayObject
package mx.core 
{
    import flash.accessibility.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    
    public interface IFlexDisplayObject extends flash.display.IBitmapDrawable, flash.events.IEventDispatcher
    {
        function get root():flash.display.DisplayObject;

        function get stage():flash.display.Stage;

        function get name():String;

        function set name(arg1:String):void;

        function get parent():flash.display.DisplayObjectContainer;

        function get mask():flash.display.DisplayObject;

        function set mask(arg1:flash.display.DisplayObject):void;

        function get visible():Boolean;

        function set visible(arg1:Boolean):void;

        function get x():Number;

        function set x(arg1:Number):void;

        function get y():Number;

        function set y(arg1:Number):void;

        function get scaleX():Number;

        function set scaleX(arg1:Number):void;

        function get scaleY():Number;

        function set scaleY(arg1:Number):void;

        function get mouseX():Number;

        function get mouseY():Number;

        function get rotation():Number;

        function set rotation(arg1:Number):void;

        function get alpha():Number;

        function set alpha(arg1:Number):void;

        function get width():Number;

        function set width(arg1:Number):void;

        function get height():Number;

        function set height(arg1:Number):void;

        function get cacheAsBitmap():Boolean;

        function set cacheAsBitmap(arg1:Boolean):void;

        function get opaqueBackground():Object;

        function set opaqueBackground(arg1:Object):void;

        function get scrollRect():flash.geom.Rectangle;

        function set scrollRect(arg1:flash.geom.Rectangle):void;

        function get filters():Array;

        function set filters(arg1:Array):void;

        function get blendMode():String;

        function set blendMode(arg1:String):void;

        function get transform():flash.geom.Transform;

        function set transform(arg1:flash.geom.Transform):void;

        function get scale9Grid():flash.geom.Rectangle;

        function set scale9Grid(arg1:flash.geom.Rectangle):void;

        function globalToLocal(arg1:flash.geom.Point):flash.geom.Point;

        function localToGlobal(arg1:flash.geom.Point):flash.geom.Point;

        function getBounds(arg1:flash.display.DisplayObject):flash.geom.Rectangle;

        function getRect(arg1:flash.display.DisplayObject):flash.geom.Rectangle;

        function get loaderInfo():flash.display.LoaderInfo;

        function hitTestObject(arg1:flash.display.DisplayObject):Boolean;

        function hitTestPoint(arg1:Number, arg2:Number, arg3:Boolean=false):Boolean;

        function get accessibilityProperties():flash.accessibility.AccessibilityProperties;

        function set accessibilityProperties(arg1:flash.accessibility.AccessibilityProperties):void;

        function get measuredHeight():Number;

        function get measuredWidth():Number;

        function move(arg1:Number, arg2:Number):void;

        function setActualSize(arg1:Number, arg2:Number):void;
    }
}


//    class IFlexModuleFactory
package mx.core 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.utils.*;
    
    public interface IFlexModuleFactory
    {
        function get allowDomainsInNewRSLs():Boolean;

        function set allowDomainsInNewRSLs(arg1:Boolean):void;

        function get allowInsecureDomainsInNewRSLs():Boolean;

        function set allowInsecureDomainsInNewRSLs(arg1:Boolean):void;

        function get preloadedRSLs():flash.utils.Dictionary;

        function addPreloadedRSL(arg1:flash.display.LoaderInfo, arg2:__AS3__.vec.Vector.<mx.core.RSLData>):void;

        function allowDomain(... rest):void;

        function allowInsecureDomain(... rest):void;

        function callInContext(arg1:Function, arg2:Object, arg3:Array, arg4:Boolean=true):*;

        function create(... rest):Object;

        function getImplementation(arg1:String):Object;

        function info():Object;

        function registerImplementation(arg1:String, arg2:Object):void;
    }
}


//    class ILayoutDirectionElement
package mx.core 
{
    public interface ILayoutDirectionElement
    {
        function get layoutDirection():String;

        function set layoutDirection(arg1:String):void;

        function invalidateLayoutDirection():void;
    }
}


//    class IMXMLObject
package mx.core 
{
    public interface IMXMLObject
    {
        function initialized(arg1:Object, arg2:String):void;
    }
}


//    class IPropertyChangeNotifier
package mx.core 
{
    import flash.events.*;
    
    public interface IPropertyChangeNotifier extends flash.events.IEventDispatcher, mx.core.IUID
    {
    }
}


//    class IRepeaterClient
package mx.core 
{
    public interface IRepeaterClient
    {
        function get instanceIndices():Array;

        function set instanceIndices(arg1:Array):void;

        function get isDocument():Boolean;

        function get repeaterIndices():Array;

        function set repeaterIndices(arg1:Array):void;

        function get repeaters():Array;

        function set repeaters(arg1:Array):void;

        function initializeRepeaterArrays(arg1:mx.core.IRepeaterClient):void;
    }
}


//    class IUIComponent
package mx.core 
{
    import flash.display.*;
    import mx.managers.*;
    
    public interface IUIComponent extends mx.core.IFlexDisplayObject
    {
        function get baselinePosition():Number;

        function get document():Object;

        function set document(arg1:Object):void;

        function get enabled():Boolean;

        function set enabled(arg1:Boolean):void;

        function get explicitHeight():Number;

        function set explicitHeight(arg1:Number):void;

        function get explicitMaxHeight():Number;

        function get explicitMaxWidth():Number;

        function get explicitMinHeight():Number;

        function get explicitMinWidth():Number;

        function get explicitWidth():Number;

        function set explicitWidth(arg1:Number):void;

        function get focusPane():flash.display.Sprite;

        function set focusPane(arg1:flash.display.Sprite):void;

        function get includeInLayout():Boolean;

        function set includeInLayout(arg1:Boolean):void;

        function get isPopUp():Boolean;

        function set isPopUp(arg1:Boolean):void;

        function get maxHeight():Number;

        function get maxWidth():Number;

        function get measuredMinHeight():Number;

        function set measuredMinHeight(arg1:Number):void;

        function get measuredMinWidth():Number;

        function set measuredMinWidth(arg1:Number):void;

        function get minHeight():Number;

        function get minWidth():Number;

        function get owner():flash.display.DisplayObjectContainer;

        function set owner(arg1:flash.display.DisplayObjectContainer):void;

        function get percentHeight():Number;

        function set percentHeight(arg1:Number):void;

        function get percentWidth():Number;

        function set percentWidth(arg1:Number):void;

        function get systemManager():mx.managers.ISystemManager;

        function set systemManager(arg1:mx.managers.ISystemManager):void;

        function get tweeningProperties():Array;

        function set tweeningProperties(arg1:Array):void;

        function initialize():void;

        function parentChanged(arg1:flash.display.DisplayObjectContainer):void;

        function getExplicitOrMeasuredWidth():Number;

        function getExplicitOrMeasuredHeight():Number;

        function setVisible(arg1:Boolean, arg2:Boolean=false):void;

        function owns(arg1:flash.display.DisplayObject):Boolean;
    }
}


//    class IUID
package mx.core 
{
    public interface IUID
    {
        function get uid():String;

        function set uid(arg1:String):void;
    }
}


//    class RSLData
package mx.core 
{
    use namespace mx_internal;
    
    public class RSLData extends Object
    {
        public function RSLData(arg1:String=null, arg2:String=null, arg3:String=null, arg4:String=null, arg5:Boolean=false, arg6:Boolean=false, arg7:String="default")
        {
            super();
            this._rslURL = arg1;
            this._policyFileURL = arg2;
            this._digest = arg3;
            this._hashType = arg4;
            this._isSigned = arg5;
            this._verifyDigest = arg6;
            this._applicationDomainTarget = arg7;
            this._moduleFactory = this.moduleFactory;
            return;
        }

        public function get applicationDomainTarget():String
        {
            return this._applicationDomainTarget;
        }

        public function get digest():String
        {
            return this._digest;
        }

        public function get hashType():String
        {
            return this._hashType;
        }

        public function get isSigned():Boolean
        {
            return this._isSigned;
        }

        public function get moduleFactory():mx.core.IFlexModuleFactory
        {
            return this._moduleFactory;
        }

        public function set moduleFactory(arg1:mx.core.IFlexModuleFactory):void
        {
            this._moduleFactory = arg1;
            return;
        }

        public function get policyFileURL():String
        {
            return this._policyFileURL;
        }

        public function get rslURL():String
        {
            return this._rslURL;
        }

        public function get verifyDigest():Boolean
        {
            return this._verifyDigest;
        }

        
        {
            mx_internal::VERSION = "4.14.0.0";
        }

        mx_internal static const VERSION:String="4.14.0.0";

        internal var _applicationDomainTarget:String;

        internal var _digest:String;

        internal var _hashType:String;

        internal var _isSigned:Boolean;

        internal var _moduleFactory:mx.core.IFlexModuleFactory;

        internal var _policyFileURL:String;

        internal var _rslURL:String;

        internal var _verifyDigest:Boolean;
    }
}


//    namespace mx_internal
package mx.core 
{
    public namespace mx_internal="http://www.adobe.com/2006/flex/mx/internal";
}


//  package events
//    class PropertyChangeEvent
package mx.events 
{
    import flash.events.*;
    import mx.core.*;
    
    use namespace mx_internal;
    
    public class PropertyChangeEvent extends flash.events.Event
    {
        public function PropertyChangeEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false, arg4:String=null, arg5:Object=null, arg6:Object=null, arg7:Object=null, arg8:Object=null)
        {
            super(arg1, arg2, arg3);
            this.kind = arg4;
            this.property = arg5;
            this.oldValue = arg6;
            this.newValue = arg7;
            this.source = arg8;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new mx.events.PropertyChangeEvent(type, bubbles, cancelable, this.kind, this.property, this.oldValue, this.newValue, this.source);
        }

        public static function createUpdateEvent(arg1:Object, arg2:Object, arg3:Object, arg4:Object):mx.events.PropertyChangeEvent
        {
            var loc1:*=new PropertyChangeEvent(PROPERTY_CHANGE);
            loc1.kind = mx.events.PropertyChangeEventKind.UPDATE;
            loc1.oldValue = arg3;
            loc1.newValue = arg4;
            loc1.source = arg1;
            loc1.property = arg2;
            return loc1;
        }

        
        {
            mx_internal::VERSION = "4.14.0.0";
        }

        mx_internal static const VERSION:String="4.14.0.0";

        public static const PROPERTY_CHANGE:String="propertyChange";

        public var kind:String;

        public var newValue:Object;

        public var oldValue:Object;

        public var property:Object;

        public var source:Object;
    }
}


//    class PropertyChangeEventKind
package mx.events 
{
    import mx.core.*;
    
    use namespace mx_internal;
    
    public final class PropertyChangeEventKind extends Object
    {
        public function PropertyChangeEventKind()
        {
            super();
            return;
        }

        
        {
            mx_internal::VERSION = "4.14.0.0";
        }

        mx_internal static const VERSION:String="4.14.0.0";

        public static const UPDATE:String="update";

        public static const DELETE:String="delete";
    }
}


//  package managers
//    class ISystemManager
package mx.managers 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import mx.core.*;
    
    public interface ISystemManager extends flash.events.IEventDispatcher, mx.core.IChildList, mx.core.IFlexModuleFactory
    {
        function get cursorChildren():mx.core.IChildList;

        function get document():Object;

        function set document(arg1:Object):void;

        function get embeddedFontList():Object;

        function get focusPane():flash.display.Sprite;

        function set focusPane(arg1:flash.display.Sprite):void;

        function get isProxy():Boolean;

        function get loaderInfo():flash.display.LoaderInfo;

        function get numModalWindows():int;

        function set numModalWindows(arg1:int):void;

        function get popUpChildren():mx.core.IChildList;

        function get rawChildren():mx.core.IChildList;

        function get screen():flash.geom.Rectangle;

        function get stage():flash.display.Stage;

        function get toolTipChildren():mx.core.IChildList;

        function get topLevelSystemManager():mx.managers.ISystemManager;

        function getDefinitionByName(arg1:String):Object;

        function isTopLevel():Boolean;

        function isFontFaceEmbedded(arg1:flash.text.TextFormat):Boolean;

        function isTopLevelRoot():Boolean;

        function getTopLevelRoot():flash.display.DisplayObject;

        function getSandboxRoot():flash.display.DisplayObject;

        function getVisibleApplicationRect(arg1:flash.geom.Rectangle=null, arg2:Boolean=false):flash.geom.Rectangle;

        function deployMouseShields(arg1:Boolean):void;

        function invalidateParentSizeAndDisplayList():void;
    }
}


//  package utils
//    class IXMLNotifiable
package mx.utils 
{
    public interface IXMLNotifiable
    {
        function xmlNotification(arg1:Object, arg2:String, arg3:Object, arg4:Object, arg5:Object):void;
    }
}


//    class NameUtil
package mx.utils 
{
    import flash.display.*;
    import flash.utils.*;
    import mx.core.*;
    
    use namespace mx_internal;
    
    public class NameUtil extends Object
    {
        public function NameUtil()
        {
            super();
            return;
        }

        public static function createUniqueName(arg1:Object):String
        {
            if (!arg1) 
            {
                return null;
            }
            var loc1:*=flash.utils.getQualifiedClassName(arg1);
            var loc2:*=loc1.indexOf("::");
            if (loc2 != -1) 
            {
                loc1 = loc1.substr(loc2 + 2);
            }
            var loc3:*=loc1.charCodeAt((loc1.length - 1));
            if (loc3 >= 48 && loc3 <= 57) 
            {
                loc1 = loc1 + "_";
            }
            var loc4:*;
            return loc1 + counter++;
        }

        public static function displayObjectToString(arg1:flash.display.DisplayObject):String
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            try 
            {
                loc2 = arg1;
                while (loc2 != null) 
                {
                    if (!(loc2.parent && loc2.stage && loc2.parent == loc2.stage)) 
                    {
                    };
                    loc3 = "id" in loc2 && loc2["id"] ? loc2["id"] : loc2.name;
                    if (loc2 is mx.core.IRepeaterClient) 
                    {
                        loc4 = mx.core.IRepeaterClient(loc2).instanceIndices;
                        if (loc4) 
                        {
                            loc3 = loc3 + ("[" + loc4.join("][") + "]");
                        }
                    }
                    loc1 = loc1 != null ? loc3 + "." + loc1 : loc3;
                    loc2 = loc2.parent;
                }
            }
            catch (e:SecurityError)
            {
            };
            return loc1;
        }

        public static function getUnqualifiedClassName(arg1:Object):String
        {
            var loc1:*=null;
            if (arg1 is String) 
            {
                loc1 = arg1 as String;
            }
            else 
            {
                loc1 = flash.utils.getQualifiedClassName(arg1);
            }
            var loc2:*=loc1.indexOf("::");
            if (loc2 != -1) 
            {
                loc1 = loc1.substr(loc2 + 2);
            }
            return loc1;
        }

        
        {
            mx_internal::VERSION = "4.14.0.0";
            counter = 0;
        }

        mx_internal static const VERSION:String="4.14.0.0";

        internal static var counter:int=0;
    }
}


//    class StringUtil
package mx.utils 
{
    import mx.core.*;
    
    use namespace mx_internal;
    
    public class StringUtil extends Object
    {
        public function StringUtil()
        {
            super();
            return;
        }

        public static function trim(arg1:String):String
        {
            if (arg1 == null) 
            {
                return "";
            }
            var loc1:*=0;
            while (isWhitespace(arg1.charAt(loc1))) 
            {
                ++loc1;
            }
            var loc2:*=(arg1.length - 1);
            while (isWhitespace(arg1.charAt(loc2))) 
            {
                --loc2;
            }
            if (loc2 >= loc1) 
            {
                return arg1.slice(loc1, loc2 + 1);
            }
            return "";
        }

        public static function trimArrayElements(arg1:String, arg2:String):String
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            if (!(arg1 == "") && !(arg1 == null)) 
            {
                loc1 = arg1.split(arg2);
                loc2 = loc1.length;
                loc3 = 0;
                while (loc3 < loc2) 
                {
                    loc1[loc3] = mx.utils.StringUtil.trim(loc1[loc3]);
                    ++loc3;
                }
                if (loc2 > 0) 
                {
                    arg1 = loc1.join(arg2);
                }
            }
            return arg1;
        }

        public static function isWhitespace(arg1:String):Boolean
        {
            var loc1:*=arg1;
            switch (loc1) 
            {
                case " ":
                case "\t":
                case "\r":
                case "\n":
                case "":
                {
                    return true;
                }
                default:
                {
                    return false;
                }
            }
        }

        public static function substitute(arg1:String, ... rest):String
        {
            var loc2:*=null;
            if (arg1 == null) 
            {
                return "";
            }
            var loc1:*=rest.length;
            if (loc1 == 1 && rest[0] is Array) 
            {
                loc2 = rest[0] as Array;
                loc1 = loc2.length;
            }
            else 
            {
                loc2 = rest;
            }
            var loc3:*=0;
            while (loc3 < loc1) 
            {
                arg1 = arg1.replace(new RegExp("\\{" + loc3 + "\\}", "g"), loc2[loc3]);
                ++loc3;
            }
            return arg1;
        }

        public static function repeat(arg1:String, arg2:int):String
        {
            if (arg2 == 0) 
            {
                return "";
            }
            var loc1:*=arg1;
            var loc2:*=1;
            while (loc2 < arg2) 
            {
                loc1 = loc1 + arg1;
                ++loc2;
            }
            return loc1;
        }

        public static function restrict(arg1:String, arg2:String):String
        {
            var loc4:*=0;
            if (arg2 == null) 
            {
                return arg1;
            }
            if (arg2 == "") 
            {
                return "";
            }
            var loc1:*=[];
            var loc2:*=arg1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc4 = arg1.charCodeAt(loc3);
                if (testCharacter(loc4, arg2)) 
                {
                    loc1.push(loc4);
                }
                ++loc3;
            }
            return String.fromCharCode.apply(null, loc1);
        }

        internal static function testCharacter(arg1:uint, arg2:String):Boolean
        {
            var loc7:*=0;
            var loc9:*=false;
            var loc1:*=false;
            var loc2:*=false;
            var loc3:*=false;
            var loc4:*=true;
            var loc5:*=0;
            var loc6:*=arg2.length;
            if (loc6 > 0) 
            {
                loc7 = arg2.charCodeAt(0);
                if (loc7 == 94) 
                {
                    loc1 = true;
                }
            }
            var loc8:*=0;
            while (loc8 < loc6) 
            {
                loc7 = arg2.charCodeAt(loc8);
                loc9 = false;
                if (loc2) 
                {
                    loc9 = true;
                    loc2 = false;
                }
                else if (loc7 != 45) 
                {
                    if (loc7 != 94) 
                    {
                        if (loc7 != 92) 
                        {
                            loc9 = true;
                        }
                        else 
                        {
                            loc2 = true;
                        }
                    }
                    else 
                    {
                        loc4 = !loc4;
                    }
                }
                else 
                {
                    loc3 = true;
                }
                if (loc9) 
                {
                    if (loc3) 
                    {
                        if (loc5 <= arg1 && arg1 <= loc7) 
                        {
                            loc1 = loc4;
                        }
                        loc3 = false;
                        loc5 = 0;
                    }
                    else 
                    {
                        if (arg1 == loc7) 
                        {
                            loc1 = loc4;
                        }
                        loc5 = loc7;
                    }
                }
                ++loc8;
            }
            return loc1;
        }

        
        {
            mx_internal::VERSION = "4.6.0.23201";
        }

        mx_internal static const VERSION:String="4.6.0.23201";
    }
}


//    class XMLNotifier
package mx.utils 
{
    import flash.utils.*;
    import mx.core.*;
    
    use namespace mx_internal;
    
    public class XMLNotifier extends Object
    {
        public function XMLNotifier(arg1:XMLNotifierSingleton)
        {
            super();
            return;
        }

        public function watchXML(arg1:Object, arg2:mx.utils.IXMLNotifiable, arg3:String=null):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            if (arg1 is XMLList && arg1.length() > 1) 
            {
                var loc5:*=0;
                var loc6:*=arg1;
                for each (loc1 in loc6) 
                {
                    this.watchXML(loc1, arg2, arg3);
                }
            }
            else 
            {
                loc2 = XML(arg1);
                loc3 = loc2.notification();
                if (!(loc3 is Function)) 
                {
                    loc3 = mx_internal::initializeXMLForNotification();
                    loc2.setNotification(loc3 as Function);
                    if (arg3 && loc3["uid"] == null) 
                    {
                        loc3["uid"] = arg3;
                    }
                }
                if (loc3["watched"] != undefined) 
                {
                    loc4 = loc3["watched"];
                }
                else 
                {
                    loc4 = loc5 = new flash.utils.Dictionary(true);
                    loc3["watched"] = loc5;
                }
                loc4[arg2] = true;
            }
            return;
        }

        public function unwatchXML(arg1:Object, arg2:mx.utils.IXMLNotifiable):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            if (arg1 is XMLList && arg1.length() > 1) 
            {
                var loc5:*=0;
                var loc6:*=arg1;
                for each (loc1 in loc6) 
                {
                    this.unwatchXML(loc1, arg2);
                }
            }
            else 
            {
                loc2 = XML(arg1);
                loc3 = loc2.notification();
                if (!(loc3 is Function)) 
                {
                    return;
                }
                if (loc3["watched"] != undefined) 
                {
                    loc4 = loc3["watched"];
                    delete loc4[arg2];
                }
            }
            return;
        }

        public static function getInstance():mx.utils.XMLNotifier
        {
            if (!instance) 
            {
                instance = new XMLNotifier(new XMLNotifierSingleton());
            }
            return instance;
        }

        mx_internal static function initializeXMLForNotification():Function
        {
            var notificationFunction:Function;

            var loc1:*;
            notificationFunction = function (arg1:Object, arg2:String, arg3:Object, arg4:Object, arg5:Object):void
            {
                var loc2:*=null;
                var loc1:*=arguments.callee.watched;
                if (loc1 != null) 
                {
                    var loc3:*=0;
                    var loc4:*=loc1;
                    for (loc2 in loc4) 
                    {
                        mx.utils.IXMLNotifiable(loc2).xmlNotification(arg1, arg2, arg3, arg4, arg5);
                    }
                }
                return;
            }
            return notificationFunction;
        }

        
        {
            mx_internal::VERSION = "4.6.0.23201";
        }

        mx_internal static const VERSION:String="4.6.0.23201";

        internal static var instance:mx.utils.XMLNotifier;
    }
}


class XMLNotifierSingleton extends Object
{
    public function XMLNotifierSingleton()
    {
        super();
        return;
    }
}

