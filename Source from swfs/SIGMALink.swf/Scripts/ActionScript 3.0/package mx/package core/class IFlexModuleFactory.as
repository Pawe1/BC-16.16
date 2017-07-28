//class IFlexModuleFactory
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


