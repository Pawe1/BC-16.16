//package core
//  class BitmapAsset
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


//  class ByteArrayAsset
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


//  class FlexBitmap
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


//  class FontAsset
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


//  class IAssetLayoutFeatures
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


//  class IChildList
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


//  class IFlexAsset
package mx.core 
{
    public interface IFlexAsset
    {
    }
}


//  class IFlexDisplayObject
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


//  class IFlexModuleFactory
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


//  class ILayoutDirectionElement
package mx.core 
{
    public interface ILayoutDirectionElement
    {
        function get layoutDirection():String;

        function set layoutDirection(arg1:String):void;

        function invalidateLayoutDirection():void;
    }
}


//  class IMXMLObject
package mx.core 
{
    public interface IMXMLObject
    {
        function initialized(arg1:Object, arg2:String):void;
    }
}


//  class IPropertyChangeNotifier
package mx.core 
{
    import flash.events.*;
    
    public interface IPropertyChangeNotifier extends flash.events.IEventDispatcher, mx.core.IUID
    {
    }
}


//  class IRepeaterClient
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


//  class IUIComponent
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


//  class IUID
package mx.core 
{
    public interface IUID
    {
        function get uid():String;

        function set uid(arg1:String):void;
    }
}


//  class RSLData
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


//  namespace mx_internal
package mx.core 
{
    public namespace mx_internal="http://www.adobe.com/2006/flex/mx/internal";
}


