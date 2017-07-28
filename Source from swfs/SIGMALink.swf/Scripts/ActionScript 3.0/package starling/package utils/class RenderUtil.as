//class RenderUtil
package starling.utils 
{
    import flash.display.*;
    import flash.display3D.*;
    import flash.events.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.errors.*;
    import starling.textures.*;
    
    public class RenderUtil extends Object
    {
        public function RenderUtil()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function clear(arg1:uint=0, arg2:Number=0):void
        {
            starling.core.Starling.context.clear(starling.utils.Color.getRed(arg1) / 255, starling.utils.Color.getGreen(arg1) / 255, starling.utils.Color.getBlue(arg1) / 255, arg2);
            return;
        }

        public static function getTextureLookupFlags(arg1:String, arg2:Boolean, arg3:Boolean=false, arg4:String="bilinear"):String
        {
            var loc1:*=["2d", arg3 ? "repeat" : "clamp"];
            if (arg1 != flash.display3D.Context3DTextureFormat.COMPRESSED) 
            {
                if (arg1 == "compressedAlpha") 
                {
                    loc1.push("dxt5");
                }
            }
            else 
            {
                loc1.push("dxt1");
            }
            if (arg4 != starling.textures.TextureSmoothing.NONE) 
            {
                if (arg4 != starling.textures.TextureSmoothing.BILINEAR) 
                {
                    loc1.push("linear", arg2 ? "miplinear" : "mipnone");
                }
                else 
                {
                    loc1.push("linear", arg2 ? "mipnearest" : "mipnone");
                }
            }
            else 
            {
                loc1.push("nearest", arg2 ? "mipnearest" : "mipnone");
            }
            return "<" + loc1.join() + ">";
        }

        public static function getTextureVariantBits(arg1:starling.textures.Texture):uint
        {
            if (arg1 == null) 
            {
                return 0;
            }
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=arg1.format;
            switch (loc3) 
            {
                case flash.display3D.Context3DTextureFormat.COMPRESSED_ALPHA:
                {
                    loc2 = 3;
                    break;
                }
                case flash.display3D.Context3DTextureFormat.COMPRESSED:
                {
                    loc2 = 2;
                    break;
                }
                default:
                {
                    loc2 = 1;
                }
            }
            loc1 = loc1 | loc2;
            if (!arg1.premultipliedAlpha) 
            {
                loc1 = loc1 | 1 << 2;
            }
            return loc1;
        }

        public static function setSamplerStateAt(arg1:int, arg2:Boolean, arg3:String="bilinear", arg4:Boolean=false):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=arg4 ? flash.display3D.Context3DWrapMode.REPEAT : flash.display3D.Context3DWrapMode.CLAMP;
            if (arg3 != starling.textures.TextureSmoothing.NONE) 
            {
                if (arg3 != starling.textures.TextureSmoothing.BILINEAR) 
                {
                    loc2 = flash.display3D.Context3DTextureFilter.LINEAR;
                    loc3 = arg2 ? flash.display3D.Context3DMipFilter.MIPLINEAR : flash.display3D.Context3DMipFilter.MIPNONE;
                }
                else 
                {
                    loc2 = flash.display3D.Context3DTextureFilter.LINEAR;
                    loc3 = arg2 ? flash.display3D.Context3DMipFilter.MIPNEAREST : flash.display3D.Context3DMipFilter.MIPNONE;
                }
            }
            else 
            {
                loc2 = flash.display3D.Context3DTextureFilter.NEAREST;
                loc3 = arg2 ? flash.display3D.Context3DMipFilter.MIPNEAREST : flash.display3D.Context3DMipFilter.MIPNONE;
            }
            starling.core.Starling.context.setSamplerStateAt(arg1, loc1, loc2, loc3);
            return;
        }

        public static function createAGALTexOperation(arg1:String, arg2:String, arg3:int, arg4:starling.textures.Texture, arg5:Boolean=true, arg6:String="ft0"):String
        {
            var loc2:*=null;
            var loc1:*=arg4.format;
            var loc6:*=loc1;
            switch (loc6) 
            {
                case flash.display3D.Context3DTextureFormat.COMPRESSED:
                {
                    loc2 = "dxt1";
                    break;
                }
                case flash.display3D.Context3DTextureFormat.COMPRESSED_ALPHA:
                {
                    loc2 = "dxt5";
                    break;
                }
                default:
                {
                    loc2 = "rgba";
                }
            }
            var loc3:*=arg5 && !arg4.premultipliedAlpha;
            var loc4:*=loc3 && arg1 == "oc" ? arg6 : arg1;
            var loc5:*="tex " + loc4 + ", " + arg2 + ", fs" + arg3 + " <2d, " + loc2 + ">\n";
            if (loc3) 
            {
                if (arg1 != "oc") 
                {
                    loc5 = loc5 + ("mul " + arg1 + ".xyz, " + loc4 + ".xyz, " + loc4 + ".www\n");
                }
                else 
                {
                    loc5 = loc5 + ("mul " + loc4 + ".xyz, " + loc4 + ".xyz, " + loc4 + ".www\n");
                    loc5 = loc5 + ("mov " + arg1 + ", " + loc4);
                }
            }
            return loc5;
        }

        public static function requestContext3D(arg1:flash.display.Stage3D, arg2:String, arg3:*):void
        {
            var stage3D:flash.display.Stage3D;
            var renderMode:String;
            var profile:*;
            var profiles:Array;
            var currentProfile:String;
            var requestNextProfile:Function;
            var onCreated:Function;
            var onError:Function;
            var onFinished:Function;

            var loc1:*;
            profiles = null;
            currentProfile = null;
            requestNextProfile = null;
            onCreated = null;
            onError = null;
            stage3D = arg1;
            renderMode = arg2;
            profile = arg3;
            requestNextProfile = function ():void
            {
                var loc1:*;
                currentProfile = profiles.shift();
                try 
                {
                    starling.utils.execute(stage3D.requestContext3D, renderMode, currentProfile);
                }
                catch (error:Error)
                {
                    if (profiles.length == 0) 
                    {
                        throw error;
                    }
                    else 
                    {
                        flash.utils.setTimeout(requestNextProfile, 1);
                    }
                }
                return;
            }
            onCreated = function (arg1:flash.events.Event):void
            {
                var loc1:*=stage3D.context3D;
                if (renderMode == flash.display3D.Context3DRenderMode.AUTO && !(profiles.length == 0) && !(loc1.driverInfo.indexOf("Software") == -1)) 
                {
                    onError(arg1);
                }
                else 
                {
                    onFinished();
                }
                return;
            }
            onError = function (arg1:flash.events.Event):void
            {
                if (profiles.length == 0) 
                {
                    onFinished();
                }
                else 
                {
                    arg1.stopImmediatePropagation();
                    flash.utils.setTimeout(requestNextProfile, 1);
                }
                return;
            }
            onFinished = function ():void
            {
                stage3D.removeEventListener(flash.events.Event.CONTEXT3D_CREATE, onCreated);
                stage3D.removeEventListener(flash.events.ErrorEvent.ERROR, onError);
                return;
            }
            if (profile != "auto") 
            {
                if (profile is String) 
                {
                    profiles = [profile as String];
                }
                else if (profile is Array) 
                {
                    profiles = profile as Array;
                }
                else 
                {
                    throw new ArgumentError("Profile must be of type \'String\' or \'Array\'");
                }
            }
            else 
            {
                profiles = ["standardExtended", "standard", "standardConstrained", "baselineExtended", "baseline", "baselineConstrained"];
            }
            stage3D.addEventListener(flash.events.Event.CONTEXT3D_CREATE, onCreated, false, 100);
            stage3D.addEventListener(flash.events.ErrorEvent.ERROR, onError, false, 100);
            requestNextProfile();
            return;
        }
    }
}


