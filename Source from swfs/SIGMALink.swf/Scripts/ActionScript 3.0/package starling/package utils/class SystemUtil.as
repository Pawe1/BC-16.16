//class SystemUtil
package starling.utils 
{
    import flash.display3D.*;
    import flash.events.*;
    import flash.system.*;
    import flash.text.*;
    import flash.utils.*;
    import starling.errors.*;
    
    public class SystemUtil extends Object
    {
        public function SystemUtil()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function initialize():void
        {
            var nativeAppClass:Object;
            var nativeApp:flash.events.EventDispatcher;
            var appDescriptor:XML;
            var ns:Namespace;
            var ds:String;

            var loc1:*;
            nativeAppClass = null;
            nativeApp = null;
            appDescriptor = null;
            ns = null;
            ds = null;
            if (sInitialized) 
            {
                return;
            }
            sInitialized = true;
            sPlatform = flash.system.Capabilities.version.substr(0, 3);
            sVersion = flash.system.Capabilities.version.substr(4);
            sDesktop = !(new RegExp("(WIN|MAC|LNX)").exec(sPlatform) == null);
            try 
            {
                nativeAppClass = flash.utils.getDefinitionByName("flash.desktop::NativeApplication");
                nativeApp = nativeAppClass["nativeApplication"] as flash.events.EventDispatcher;
                nativeApp.addEventListener(flash.events.Event.ACTIVATE, onActivate, false, 0, true);
                nativeApp.addEventListener(flash.events.Event.DEACTIVATE, onDeactivate, false, 0, true);
                appDescriptor = nativeApp["applicationDescriptor"];
                ns = appDescriptor.namespace();
                ds = appDescriptor.ns::initialWindow.ns::depthAndStencil.toString().toLowerCase();
                sSupportsDepthAndStencil = ds == "true";
                sAIR = true;
            }
            catch (e:Error)
            {
                sAIR = false;
            }
            return;
        }

        internal static function onActivate(arg1:Object):void
        {
            var event:Object;
            var call:Array;

            var loc1:*;
            call = null;
            event = arg1;
            sApplicationActive = true;
            var loc2:*=0;
            var loc3:*=sWaitingCalls;
            for each (call in loc3) 
            {
            };
            sWaitingCalls = [];
            return;
        }

        internal static function onDeactivate(arg1:Object):void
        {
            sApplicationActive = false;
            return;
        }

        public static function executeWhenApplicationIsActive(arg1:Function, ... rest):void
        {
            initialize();
            if (sApplicationActive) 
            {
                arg1.apply(null, rest);
            }
            else 
            {
                sWaitingCalls.push([arg1, rest]);
            }
            return;
        }

        public static function get isApplicationActive():Boolean
        {
            initialize();
            return sApplicationActive;
        }

        public static function get isAIR():Boolean
        {
            initialize();
            return sAIR;
        }

        public static function get isDesktop():Boolean
        {
            initialize();
            return sDesktop;
        }

        public static function get platform():String
        {
            initialize();
            return sPlatform;
        }

        public static function get version():String
        {
            initialize();
            return sVersion;
        }

        public static function get supportsDepthAndStencil():Boolean
        {
            return sSupportsDepthAndStencil;
        }

        public static function get supportsVideoTexture():Boolean
        {
            return flash.display3D.Context3D["supportsVideoTexture"];
        }

        public static function updateEmbeddedFonts():void
        {
            sEmbeddedFonts = null;
            return;
        }

        public static function isEmbeddedFont(arg1:String, arg2:Boolean=false, arg3:Boolean=false, arg4:String="embedded"):Boolean
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=false;
            var loc4:*=false;
            if (sEmbeddedFonts == null) 
            {
                sEmbeddedFonts = flash.text.Font.enumerateFonts(false);
            }
            var loc5:*=0;
            var loc6:*=sEmbeddedFonts;
            for each (loc1 in loc6) 
            {
                loc2 = loc1.fontStyle;
                loc3 = loc2 == flash.text.FontStyle.BOLD || loc2 == flash.text.FontStyle.BOLD_ITALIC;
                loc4 = loc2 == flash.text.FontStyle.ITALIC || loc2 == flash.text.FontStyle.BOLD_ITALIC;
                if (!(arg1 == loc1.fontName && arg2 == loc3 && arg3 == loc4 && arg4 == loc1.fontType)) 
                {
                    continue;
                }
                return true;
            }
            return false;
        }

        
        {
            sInitialized = false;
            sApplicationActive = true;
            sWaitingCalls = [];
            sEmbeddedFonts = null;
            sSupportsDepthAndStencil = true;
        }

        internal static var sInitialized:Boolean=false;

        internal static var sApplicationActive:Boolean=true;

        internal static var sWaitingCalls:Array;

        internal static var sPlatform:String;

        internal static var sDesktop:Boolean;

        internal static var sVersion:String;

        internal static var sAIR:Boolean;

        internal static var sEmbeddedFonts:Array=null;

        internal static var sSupportsDepthAndStencil:Boolean=true;
    }
}


