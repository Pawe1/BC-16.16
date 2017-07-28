//class IAssetLayoutFeatures
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


