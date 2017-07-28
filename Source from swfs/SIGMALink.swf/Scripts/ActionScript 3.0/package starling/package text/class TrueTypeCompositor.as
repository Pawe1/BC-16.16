//class TrueTypeCompositor
package starling.text 
{
    import flash.geom.*;
    import flash.text.*;
    import starling.display.*;
    import starling.textures.*;
    import starling.utils.*;
    
    public class TrueTypeCompositor extends Object implements starling.text.ITextCompositor
    {
        public function TrueTypeCompositor()
        {
            super();
            return;
        }

        public function dispose():void
        {
            return;
        }

        public function fillMeshBatch(arg1:starling.display.MeshBatch, arg2:Number, arg3:Number, arg4:String, arg5:starling.text.TextFormat, arg6:starling.text.TextOptions=null):void
        {
            var meshBatch:starling.display.MeshBatch;
            var width:Number;
            var height:Number;
            var text:String;
            var format:starling.text.TextFormat;
            var options:starling.text.TextOptions=null;
            var texture:starling.textures.Texture;
            var textureFormat:String;
            var bitmapData:BitmapDataEx;

            var loc1:*;
            texture = null;
            bitmapData = null;
            meshBatch = arg1;
            width = arg2;
            height = arg3;
            text = arg4;
            format = arg5;
            options = arg6;
            if (text == null || text == "") 
            {
                return;
            }
            textureFormat = options.textureFormat;
            bitmapData = this.renderText(width, height, text, format, options);
            texture = starling.textures.Texture.fromBitmapData(bitmapData, false, false, bitmapData.scale, textureFormat);
            texture.root.onRestore = function ():void
            {
                bitmapData = renderText(width, height, text, format, options);
                texture.root.uploadBitmapData(bitmapData);
                bitmapData.dispose();
                bitmapData = null;
                return;
            }
            bitmapData.dispose();
            bitmapData = null;
            sHelperQuad.texture = texture;
            sHelperQuad.readjustSize();
            if (format.horizontalAlign != starling.utils.Align.LEFT) 
            {
                if (format.horizontalAlign != starling.utils.Align.CENTER) 
                {
                    sHelperQuad.x = width - texture.width;
                }
                else 
                {
                    sHelperQuad.x = int((width - texture.width) / 2);
                }
            }
            else 
            {
                sHelperQuad.x = 0;
            }
            if (format.verticalAlign != starling.utils.Align.TOP) 
            {
                if (format.verticalAlign != starling.utils.Align.CENTER) 
                {
                    sHelperQuad.y = height - texture.height;
                }
                else 
                {
                    sHelperQuad.y = int((height - texture.height) / 2);
                }
            }
            else 
            {
                sHelperQuad.y = 0;
            }
            meshBatch.addMesh(sHelperQuad);
            sHelperQuad.texture = null;
            return;
        }

        public function clearMeshBatch(arg1:starling.display.MeshBatch):void
        {
            arg1.clear();
            if (arg1.texture) 
            {
                arg1.texture.dispose();
            }
            return;
        }

        internal function renderText(arg1:Number, arg2:Number, arg3:String, arg4:starling.text.TextFormat, arg5:starling.text.TextOptions):BitmapDataEx
        {
            var loc11:*=null;
            var loc1:*=arg1 * arg5.textureScale;
            var loc2:*=arg2 * arg5.textureScale;
            var loc3:*=arg4.horizontalAlign;
            arg4.toNativeFormat(sNativeFormat);
            sNativeFormat.size = Number(sNativeFormat.size) * arg5.textureScale;
            sNativeTextField.embedFonts = starling.utils.SystemUtil.isEmbeddedFont(arg4.font, arg4.bold, arg4.italic);
            sNativeTextField.defaultTextFormat = sNativeFormat;
            sNativeTextField.width = loc1;
            sNativeTextField.height = loc2;
            sNativeTextField.antiAliasType = flash.text.AntiAliasType.ADVANCED;
            sNativeTextField.selectable = false;
            sNativeTextField.multiline = true;
            sNativeTextField.wordWrap = arg5.wordWrap;
            if (arg5.isHtmlText) 
            {
                sNativeTextField.htmlText = arg3;
            }
            else 
            {
                sNativeTextField.text = arg3;
            }
            if (arg5.autoScale) 
            {
                this.autoScaleNativeTextField(sNativeTextField, arg3, arg5.isHtmlText);
            }
            var loc4:*=sNativeTextField.textWidth;
            var loc5:*=sNativeTextField.textHeight;
            var loc6:*=Math.ceil(loc4) + 4;
            var loc7:*=Math.ceil(loc5) + 4;
            var loc8:*=starling.textures.Texture.maxSize;
            var loc9:*=1;
            var loc10:*=0;
            if (arg5.isHtmlText) 
            {
                var loc12:*;
                loc6 = loc12 = loc1;
                loc4 = loc12;
            }
            if (loc6 < loc9) 
            {
                loc6 = 1;
            }
            if (loc7 < loc9) 
            {
                loc7 = 1;
            }
            if (loc7 > loc8 || loc6 > loc8) 
            {
                arg5.textureScale = arg5.textureScale * loc8 / Math.max(loc6, loc7);
                return this.renderText(arg1, arg2, arg3, arg4, arg5);
            }
            if (!arg5.isHtmlText) 
            {
                if (loc3 != starling.utils.Align.RIGHT) 
                {
                    if (loc3 == starling.utils.Align.CENTER) 
                    {
                        loc10 = (loc1 - loc4 - 4) / 2;
                    }
                }
                else 
                {
                    loc10 = loc1 - loc4 - 4;
                }
            }
            loc11 = new BitmapDataEx(loc6, loc7);
            sHelperMatrix.setTo(1, 0, 0, 1, -loc10, 0);
            loc11.draw(sNativeTextField, sHelperMatrix);
            loc11.scale = arg5.textureScale;
            sNativeTextField.text = "";
            return loc11;
        }

        internal function autoScaleNativeTextField(arg1:flash.text.TextField, arg2:String, arg3:Boolean):void
        {
            var loc1:*=arg1.defaultTextFormat;
            var loc2:*=arg1.width - 4;
            var loc3:*=arg1.height - 4;
            var loc4:*=Number(loc1.size);
            while (arg1.textWidth > loc2 || arg1.textHeight > loc3) 
            {
                if (loc4 <= 4) 
                {
                    break;
                }
                loc1.size = loc4--;
                arg1.defaultTextFormat = loc1;
                if (arg3) 
                {
                    arg1.htmlText = arg2;
                    continue;
                }
                arg1.text = arg2;
            }
            return;
        }

        
        {
            sHelperMatrix = new flash.geom.Matrix();
            sHelperQuad = new starling.display.Quad(100, 100);
            sNativeTextField = new flash.text.TextField();
            sNativeFormat = new flash.text.TextFormat();
        }

        internal static var sHelperMatrix:flash.geom.Matrix;

        internal static var sHelperQuad:starling.display.Quad;

        internal static var sNativeTextField:flash.text.TextField;

        internal static var sNativeFormat:flash.text.TextFormat;
    }
}

import flash.display.*;


class BitmapDataEx extends flash.display.BitmapData
{
    public function BitmapDataEx(arg1:int, arg2:int, arg3:Boolean=true, arg4:uint=0)
    {
        super(arg1, arg2, arg3, arg4);
        return;
    }

    public function get scale():Number
    {
        return this._scale;
    }

    public function set scale(arg1:Number):void
    {
        this._scale = arg1;
        return;
    }

    internal var _scale:Number=1;
}

