//package utils
//  class Align
package starling.utils 
{
    import starling.errors.*;
    
    public final class Align extends Object
    {
        public function Align()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function isValid(arg1:String):Boolean
        {
            return arg1 == LEFT || arg1 == RIGHT || arg1 == CENTER || arg1 == TOP || arg1 == BOTTOM;
        }

        public static function isValidHorizontal(arg1:String):Boolean
        {
            return arg1 == LEFT || arg1 == CENTER || arg1 == RIGHT;
        }

        public static function isValidVertical(arg1:String):Boolean
        {
            return arg1 == TOP || arg1 == CENTER || arg1 == BOTTOM;
        }

        public static const LEFT:String="left";

        public static const RIGHT:String="right";

        public static const TOP:String="top";

        public static const BOTTOM:String="bottom";

        public static const CENTER:String="center";
    }
}


//  class AssetManager
package starling.utils 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.events.*;
    import starling.text.*;
    import starling.textures.*;
    
    public class AssetManager extends starling.events.EventDispatcher
    {
        public function AssetManager(arg1:Number=1, arg2:Boolean=false)
        {
            super();
            this._defaultTextureOptions = new starling.textures.TextureOptions(arg1, arg2);
            this._textures = new flash.utils.Dictionary();
            this._atlases = new flash.utils.Dictionary();
            this._sounds = new flash.utils.Dictionary();
            this._xmls = new flash.utils.Dictionary();
            this._objects = new flash.utils.Dictionary();
            this._byteArrays = new flash.utils.Dictionary();
            this._numConnections = 3;
            this._verbose = true;
            this._queue = [];
            return;
        }

        public function get useMipMaps():Boolean
        {
            return this._defaultTextureOptions.mipMapping;
        }

        public function set useMipMaps(arg1:Boolean):void
        {
            this._defaultTextureOptions.mipMapping = arg1;
            return;
        }

        public function get scaleFactor():Number
        {
            return this._defaultTextureOptions.scale;
        }

        public function set scaleFactor(arg1:Number):void
        {
            this._defaultTextureOptions.scale = arg1;
            return;
        }

        public function get textureFormat():String
        {
            return this._defaultTextureOptions.format;
        }

        public function set textureFormat(arg1:String):void
        {
            this._defaultTextureOptions.format = arg1;
            return;
        }

        public function get forcePotTextures():Boolean
        {
            return this._defaultTextureOptions.forcePotTexture;
        }

        public function set forcePotTextures(arg1:Boolean):void
        {
            this._defaultTextureOptions.forcePotTexture = arg1;
            return;
        }

        public function get checkPolicyFile():Boolean
        {
            return this._checkPolicyFile;
        }

        public function getTextures(arg1:String="", arg2:__AS3__.vec.Vector.<starling.textures.Texture>=null):__AS3__.vec.Vector.<starling.textures.Texture>
        {
            var loc1:*=null;
            if (arg2 == null) 
            {
                arg2 = new Vector.<starling.textures.Texture>(0);
            }
            var loc2:*=0;
            var loc3:*=this.getTextureNames(arg1, sNames);
            for each (loc1 in loc3) 
            {
                arg2[arg2.length] = this.getTexture(loc1);
            }
            sNames.length = 0;
            return arg2;
        }

        public function set checkPolicyFile(arg1:Boolean):void
        {
            this._checkPolicyFile = arg1;
            return;
        }

        public function get keepAtlasXmls():Boolean
        {
            return this._keepAtlasXmls;
        }

        public function set keepAtlasXmls(arg1:Boolean):void
        {
            this._keepAtlasXmls = arg1;
            return;
        }

        public function get keepFontXmls():Boolean
        {
            return this._keepFontXmls;
        }

        public function set keepFontXmls(arg1:Boolean):void
        {
            this._keepFontXmls = arg1;
            return;
        }

        public function get numConnections():int
        {
            return this._numConnections;
        }

        public function set numConnections(arg1:int):void
        {
            this._numConnections = arg1;
            return;
        }

        public function dispose():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=this._textures;
            for each (loc1 in loc6) 
            {
                loc1.dispose();
            }
            loc5 = 0;
            loc6 = this._atlases;
            for each (loc2 in loc6) 
            {
                loc2.dispose();
            }
            loc5 = 0;
            loc6 = this._xmls;
            for each (loc3 in loc6) 
            {
                flash.system.System.disposeXML(loc3);
            }
            loc5 = 0;
            loc6 = this._byteArrays;
            for each (loc4 in loc6) 
            {
                loc4.clear();
            }
            return;
        }

        public function getTexture(arg1:String):starling.textures.Texture
        {
            var loc1:*=null;
            var loc2:*=null;
            if (arg1 in this._textures) 
            {
                return this._textures[arg1];
            }
            var loc3:*=0;
            var loc4:*=this._atlases;
            for each (loc1 in loc4) 
            {
                loc2 = loc1.getTexture(arg1);
                if (!loc2) 
                {
                    continue;
                }
                return loc2;
            }
            return null;
        }

        
        {
            sNames = new Vector.<String>(0);
        }

        public function getTextureNames(arg1:String="", arg2:__AS3__.vec.Vector.<String>=null):__AS3__.vec.Vector.<String>
        {
            var loc1:*=null;
            arg2 = this.getDictionaryKeys(this._textures, arg1, arg2);
            var loc2:*=0;
            var loc3:*=this._atlases;
            for each (loc1 in loc3) 
            {
                loc1.getNames(arg1, arg2);
            }
            arg2.sort(Array.CASEINSENSITIVE);
            return arg2;
        }

        public function getTextureAtlas(arg1:String):starling.textures.TextureAtlas
        {
            return this._atlases[arg1] as starling.textures.TextureAtlas;
        }

        public function getTextureAtlasNames(arg1:String="", arg2:__AS3__.vec.Vector.<String>=null):__AS3__.vec.Vector.<String>
        {
            return this.getDictionaryKeys(this._atlases, arg1, arg2);
        }

        public function getSound(arg1:String):flash.media.Sound
        {
            return this._sounds[arg1];
        }

        public function getSoundNames(arg1:String="", arg2:__AS3__.vec.Vector.<String>=null):__AS3__.vec.Vector.<String>
        {
            return this.getDictionaryKeys(this._sounds, arg1, arg2);
        }

        public function playSound(arg1:String, arg2:Number=0, arg3:int=0, arg4:flash.media.SoundTransform=null):flash.media.SoundChannel
        {
            if (arg1 in this._sounds) 
            {
                return this.getSound(arg1).play(arg2, arg3, arg4);
            }
            return null;
        }

        public function getXml(arg1:String):XML
        {
            return this._xmls[arg1];
        }

        public function getXmlNames(arg1:String="", arg2:__AS3__.vec.Vector.<String>=null):__AS3__.vec.Vector.<String>
        {
            return this.getDictionaryKeys(this._xmls, arg1, arg2);
        }

        public function getObject(arg1:String):Object
        {
            return this._objects[arg1];
        }

        public function getObjectNames(arg1:String="", arg2:__AS3__.vec.Vector.<String>=null):__AS3__.vec.Vector.<String>
        {
            return this.getDictionaryKeys(this._objects, arg1, arg2);
        }

        public function getByteArray(arg1:String):flash.utils.ByteArray
        {
            return this._byteArrays[arg1];
        }

        public function getByteArrayNames(arg1:String="", arg2:__AS3__.vec.Vector.<String>=null):__AS3__.vec.Vector.<String>
        {
            return this.getDictionaryKeys(this._byteArrays, arg1, arg2);
        }

        public function addTexture(arg1:String, arg2:starling.textures.Texture):void
        {
            this.log("Adding texture \'" + arg1 + "\'");
            if (arg1 in this._textures) 
            {
                this.log("Warning: name was already in use; the previous texture will be replaced.");
                this._textures[arg1].dispose();
            }
            this._textures[arg1] = arg2;
            return;
        }

        public function addTextureAtlas(arg1:String, arg2:starling.textures.TextureAtlas):void
        {
            this.log("Adding texture atlas \'" + arg1 + "\'");
            if (arg1 in this._atlases) 
            {
                this.log("Warning: name was already in use; the previous atlas will be replaced.");
                this._atlases[arg1].dispose();
            }
            this._atlases[arg1] = arg2;
            return;
        }

        public function addSound(arg1:String, arg2:flash.media.Sound):void
        {
            this.log("Adding sound \'" + arg1 + "\'");
            if (arg1 in this._sounds) 
            {
                this.log("Warning: name was already in use; the previous sound will be replaced.");
            }
            this._sounds[arg1] = arg2;
            return;
        }

        public function addXml(arg1:String, arg2:XML):void
        {
            this.log("Adding XML \'" + arg1 + "\'");
            if (arg1 in this._xmls) 
            {
                this.log("Warning: name was already in use; the previous XML will be replaced.");
                flash.system.System.disposeXML(this._xmls[arg1]);
            }
            this._xmls[arg1] = arg2;
            return;
        }

        public function addObject(arg1:String, arg2:Object):void
        {
            this.log("Adding object \'" + arg1 + "\'");
            if (arg1 in this._objects) 
            {
                this.log("Warning: name was already in use; the previous object will be replaced.");
            }
            this._objects[arg1] = arg2;
            return;
        }

        public function addByteArray(arg1:String, arg2:flash.utils.ByteArray):void
        {
            this.log("Adding byte array \'" + arg1 + "\'");
            if (arg1 in this._byteArrays) 
            {
                this.log("Warning: name was already in use; the previous byte array will be replaced.");
                this._byteArrays[arg1].clear();
            }
            this._byteArrays[arg1] = arg2;
            return;
        }

        public function removeTexture(arg1:String, arg2:Boolean=true):void
        {
            this.log("Removing texture \'" + arg1 + "\'");
            if (arg2 && arg1 in this._textures) 
            {
                this._textures[arg1].dispose();
            }
            delete this._textures[arg1];
            return;
        }

        public function removeTextureAtlas(arg1:String, arg2:Boolean=true):void
        {
            this.log("Removing texture atlas \'" + arg1 + "\'");
            if (arg2 && arg1 in this._atlases) 
            {
                this._atlases[arg1].dispose();
            }
            delete this._atlases[arg1];
            return;
        }

        public function removeSound(arg1:String):void
        {
            this.log("Removing sound \'" + arg1 + "\'");
            delete this._sounds[arg1];
            return;
        }

        public function removeXml(arg1:String, arg2:Boolean=true):void
        {
            this.log("Removing xml \'" + arg1 + "\'");
            if (arg2 && arg1 in this._xmls) 
            {
                flash.system.System.disposeXML(this._xmls[arg1]);
            }
            delete this._xmls[arg1];
            return;
        }

        public function removeObject(arg1:String):void
        {
            this.log("Removing object \'" + arg1 + "\'");
            delete this._objects[arg1];
            return;
        }

        public function removeByteArray(arg1:String, arg2:Boolean=true):void
        {
            this.log("Removing byte array \'" + arg1 + "\'");
            if (arg2 && arg1 in this._byteArrays) 
            {
                this._byteArrays[arg1].clear();
            }
            delete this._byteArrays[arg1];
            return;
        }

        public function purgeQueue():void
        {
            this._queue.length = 0;
            dispatchEventWith(starling.events.Event.CANCEL);
            return;
        }

        public function purge():void
        {
            this.log("Purging all assets, emptying queue");
            this.purgeQueue();
            this.dispose();
            this._textures = new flash.utils.Dictionary();
            this._atlases = new flash.utils.Dictionary();
            this._sounds = new flash.utils.Dictionary();
            this._xmls = new flash.utils.Dictionary();
            this._objects = new flash.utils.Dictionary();
            this._byteArrays = new flash.utils.Dictionary();
            return;
        }

        public function enqueue(... rest):void
        {
            var rawAssets:Array;
            var rawAsset:Object;
            var typeXml:XML;
            var childNode:XML;

            var loc1:*;
            rawAsset = null;
            typeXml = null;
            childNode = null;
            rawAssets = rest;
            var loc2:*=0;
            var loc3:*=rawAssets;
            for each (rawAsset in loc3) 
            {
                if (rawAsset is Array) 
                {
                    this.enqueue.apply(this, rawAsset);
                    continue;
                }
                if (rawAsset is Class) 
                {
                    typeXml = flash.utils.describeType(rawAsset);
                    if (this._verbose) 
                    {
                        this.log("Looking for static embedded assets in \'" + typeXml.@name.split("::").pop() + "\'");
                    }
                    var loc4:*=0;
                    var loc7:*=0;
                    var loc8:*=typeXml.constant;
                    var loc6:*=new XMLList("");
                    for each (var loc9:* in loc8) 
                    {
                        var loc10:*;
                        with (loc10 = loc9) 
                        {
                            if (@type == "Class") 
                            {
                                loc6[loc7] = loc9;
                            }
                        }
                    }
                    var loc5:*=loc6;
                    for each (childNode in loc5) 
                    {
                        this.enqueueWithName(rawAsset[childNode.@name], childNode.@name);
                    }
                    loc4 = 0;
                    loc7 = 0;
                    loc8 = typeXml.variable;
                    loc6 = new XMLList("");
                    for each (loc9 in loc8) 
                    {
                        with (loc10 = loc9) 
                        {
                            if (@type == "Class") 
                            {
                                loc6[loc7] = loc9;
                            }
                        }
                    }
                    loc5 = loc6;
                    for each (childNode in loc5) 
                    {
                        this.enqueueWithName(rawAsset[childNode.@name], childNode.@name);
                    }
                    continue;
                }
                if (flash.utils.getQualifiedClassName(rawAsset) == "flash.filesystem::File") 
                {
                    if (rawAsset["exists"]) 
                    {
                        if (!rawAsset["isHidden"]) 
                        {
                            if (rawAsset["isDirectory"]) 
                            {
                                this.enqueue.apply(this, (loc4 = rawAsset)["getDirectoryListing"]());
                            }
                            else 
                            {
                                this.enqueueWithName(rawAsset);
                            }
                        }
                    }
                    else 
                    {
                        this.log("File or directory not found: \'" + rawAsset["url"] + "\'");
                    }
                    continue;
                }
                if (rawAsset is String || rawAsset is flash.net.URLRequest) 
                {
                    this.enqueueWithName(rawAsset);
                    continue;
                }
                this.log("Ignoring unsupported asset type: " + flash.utils.getQualifiedClassName(rawAsset));
            }
            return;
        }

        public function enqueueWithName(arg1:Object, arg2:String=null, arg3:starling.textures.TextureOptions=null):String
        {
            var loc1:*=null;
            if (flash.utils.getQualifiedClassName(arg1) == "flash.filesystem::File") 
            {
                loc1 = arg1["name"];
                arg1 = decodeURI(arg1["url"]);
            }
            if (arg2 == null) 
            {
                arg2 = this.getName(arg1);
            }
            if (arg3 != null) 
            {
                arg3 = arg3.clone();
            }
            else 
            {
                arg3 = this._defaultTextureOptions.clone();
            }
            this.log("Enqueuing \'" + (loc1 || arg2) + "\'");
            this._queue.push({"name":arg2, "asset":arg1, "options":arg3});
            return arg2;
        }

        public function loadQueue(arg1:Function):void
        {
            var onProgress:Function;
            var PROGRESS_PART_ASSETS:Number=0.9;
            var PROGRESS_PART_XMLS:Number=0.1;
            var i:int;
            var canceled:Boolean;
            var xmls:__AS3__.vec.Vector.<XML>;
            var assetInfos:Array;
            var assetCount:int;
            var assetProgress:Array;
            var assetIndex:int;
            var loadNextQueueElement:Function;
            var loadQueueElement:Function;
            var updateAssetProgress:Function;
            var processXmls:Function;
            var processXml:Function;
            var cancel:Function;
            var finish:Function;

            var loc1:*;
            PROGRESS_PART_ASSETS = NaN;
            PROGRESS_PART_XMLS = NaN;
            i = 0;
            canceled = false;
            xmls = null;
            assetInfos = null;
            assetCount = 0;
            assetProgress = null;
            assetIndex = 0;
            processXml = null;
            cancel = null;
            onProgress = arg1;
            loadNextQueueElement = function ():void
            {
                var loc1:*=0;
                if (assetIndex < assetInfos.length) 
                {
                    var loc2:*;
                    loc1 = assetIndex++;
                    loadQueueElement(loc1, assetInfos[loc1]);
                }
                return;
            }
            loadQueueElement = function (arg1:int, arg2:Object):void
            {
                var index:int;
                var assetInfo:Object;
                var onElementProgress:Function;
                var onElementLoaded:Function;

                var loc1:*;
                index = arg1;
                assetInfo = arg2;
                if (canceled) 
                {
                    return;
                }
                onElementProgress = function (arg1:Number):void
                {
                    updateAssetProgress(index, arg1 * 0.8);
                    return;
                }
                onElementLoaded = function ():void
                {
                    updateAssetProgress(index, 1);
                    var loc1:*;
                    assetCount--;
                    if (assetCount > 0) 
                    {
                        loadNextQueueElement();
                    }
                    else 
                    {
                        processXmls();
                    }
                    return;
                }
                processRawAsset(assetInfo.name, assetInfo.asset, assetInfo.options, xmls, onElementProgress, onElementLoaded);
                return;
            }
            updateAssetProgress = function (arg1:int, arg2:Number):void
            {
                assetProgress[arg1] = arg2;
                var loc1:*=0;
                var loc2:*=assetProgress.length;
                i = 0;
                while (i < loc2) 
                {
                    loc1 = loc1 + assetProgress[i];
                    var loc3:*;
                    i++;
                }
                onProgress(loc1 / loc2 * PROGRESS_PART_ASSETS);
                return;
            }
            processXmls = function ():void
            {
                var loc1:*;
                xmls.sort(function (arg1:XML, arg2:XML):int
                {
                    return arg1.localName() != "TextureAtlas" ? 1 : -1;
                })
                flash.utils.setTimeout(processXml, 1, 0);
                return;
            }
            processXml = function (arg1:int):void
            {
                var loc1:*=null;
                var loc2:*=null;
                if (canceled) 
                {
                    return;
                }
                if (arg1 == xmls.length) 
                {
                    finish();
                    return;
                }
                var loc3:*=xmls[arg1];
                var loc4:*=loc3.localName();
                var loc5:*=(arg1 + 1) / (xmls.length + 1);
                if (loc4 != "TextureAtlas") 
                {
                    if (loc4 != "font") 
                    {
                        throw new Error("XML contents not recognized: " + loc4);
                    }
                    else 
                    {
                        loc1 = getName(loc3.pages.page.@file.toString());
                        loc2 = getTexture(loc1);
                        if (loc2) 
                        {
                            log("Adding bitmap font \'" + loc1 + "\'");
                            starling.text.TextField.registerCompositor(new starling.text.BitmapFont(loc2, loc3), loc1);
                            removeTexture(loc1, false);
                            if (_keepFontXmls) 
                            {
                                addXml(loc1, loc3);
                            }
                            else 
                            {
                                flash.system.System.disposeXML(loc3);
                            }
                        }
                        else 
                        {
                            log("Cannot create bitmap font: texture \'" + loc1 + "\' is missing.");
                        }
                    }
                }
                else 
                {
                    loc1 = getName(loc3.@imagePath.toString());
                    loc2 = getTexture(loc1);
                    if (loc2) 
                    {
                        addTextureAtlas(loc1, new starling.textures.TextureAtlas(loc2, loc3));
                        removeTexture(loc1, false);
                        if (_keepAtlasXmls) 
                        {
                            addXml(loc1, loc3);
                        }
                        else 
                        {
                            flash.system.System.disposeXML(loc3);
                        }
                    }
                    else 
                    {
                        log("Cannot create atlas: texture \'" + loc1 + "\' is missing.");
                    }
                }
                onProgress(PROGRESS_PART_ASSETS + PROGRESS_PART_XMLS * loc5);
                flash.utils.setTimeout(processXml, 1, arg1 + 1);
                return;
            }
            cancel = function ():void
            {
                removeEventListener(starling.events.Event.CANCEL, cancel);
                var loc1:*;
                _numLoadingQueues--;
                canceled = true;
                return;
            }
            finish = function ():void
            {
                var loc1:*;
                flash.utils.setTimeout(function ():void
                {
                    if (!canceled) 
                    {
                        cancel();
                        onProgress(1);
                    }
                    return;
                }, 1)
                return;
            }
            if (onProgress == null) 
            {
                throw new ArgumentError("Argument \'onProgress\' must not be null");
            }
            if (this._queue.length == 0) 
            {
                onProgress(1);
                return;
            }
            this._starling = starling.core.Starling.current;
            if (this._starling == null || this._starling.context == null) 
            {
                throw new Error("The Starling instance needs to be ready before assets can be loaded.");
            }
            PROGRESS_PART_ASSETS = 0.9;
            PROGRESS_PART_XMLS = 1 - PROGRESS_PART_ASSETS;
            canceled = false;
            xmls = new Vector.<XML>(0);
            assetInfos = this._queue.concat();
            assetCount = this._queue.length;
            assetProgress = [];
            assetIndex = 0;
            i = 0;
            while (i < assetCount) 
            {
                assetProgress[i] = 0;
                ++i;
            }
            i = 0;
            while (i < this._numConnections) 
            {
                loadNextQueueElement();
                ++i;
            }
            this._queue.length = 0;
            var loc2:*;
            var loc3:*=((loc2 = this)._numLoadingQueues + 1);
            loc2._numLoadingQueues = loc3;
            addEventListener(starling.events.Event.CANCEL, cancel);
            return;
        }

        internal function processRawAsset(arg1:String, arg2:Object, arg3:starling.textures.TextureOptions, arg4:__AS3__.vec.Vector.<XML>, arg5:Function, arg6:Function):void
        {
            var name:String;
            var rawAsset:Object;
            var options:starling.textures.TextureOptions;
            var xmls:__AS3__.vec.Vector.<XML>;
            var onProgress:Function;
            var onComplete:Function;
            var canceled:Boolean;
            var process:Function;
            var progress:Function;
            var cancel:Function;

            var loc1:*;
            canceled = false;
            process = null;
            progress = null;
            cancel = null;
            name = arg1;
            rawAsset = arg2;
            options = arg3;
            xmls = arg4;
            onProgress = arg5;
            onComplete = arg6;
            process = function (arg1:Object):void
            {
                var asset:Object;
                var texture:starling.textures.Texture;
                var bytes:flash.utils.ByteArray;
                var object:Object;
                var xml:XML;

                var loc1:*;
                texture = null;
                bytes = null;
                asset = arg1;
                object = null;
                xml = null;
                _starling.makeCurrent();
                if (!canceled) 
                {
                    if (asset != null) 
                    {
                        if (asset is flash.media.Sound) 
                        {
                            addSound(name, asset as flash.media.Sound);
                            onComplete();
                        }
                        else if (asset is XML) 
                        {
                            xml = asset as XML;
                            if (xml.localName() == "TextureAtlas" || xml.localName() == "font") 
                            {
                                xmls.push(xml);
                            }
                            else 
                            {
                                addXml(name, xml);
                            }
                            onComplete();
                        }
                        else 
                        {
                            if (_starling.context.driverInfo == "Disposed") 
                            {
                                log("Context lost while processing assets, retrying ...");
                                flash.utils.setTimeout(process, 1, asset);
                                return;
                            }
                            if (asset is flash.display.Bitmap) 
                            {
                                texture = starling.textures.Texture.fromData(asset, options);
                                texture.root.onRestore = function ():void
                                {
                                    var loc1:*;
                                    var loc2:*;
                                    _numLostTextures++;
                                    loadRawAsset(rawAsset, null, function (arg1:Object):void
                                    {
                                        var asset:Object;

                                        var loc1:*;
                                        asset = arg1;
                                        try 
                                        {
                                            if (asset == null) 
                                            {
                                                throw new Error("Reload failed");
                                            }
                                            texture.root.uploadBitmap(asset as flash.display.Bitmap);
                                            asset.bitmapData.dispose();
                                        }
                                        catch (e:Error)
                                        {
                                            log("Texture restoration failed for \'" + name + "\': " + e.message);
                                        }
                                        _numRestoredTextures++;
                                        starling.core.Starling.current.stage.setRequiresRedraw();
                                        if (_numLostTextures == _numRestoredTextures) 
                                        {
                                            dispatchEventWith(starling.events.Event.TEXTURES_RESTORED);
                                        }
                                        return;
                                    })
                                    return;
                                }
                                asset.bitmapData.dispose();
                                addTexture(name, texture);
                                onComplete();
                            }
                            else if (asset is flash.utils.ByteArray) 
                            {
                                bytes = asset as flash.utils.ByteArray;
                                if (starling.textures.AtfData.isAtfData(bytes)) 
                                {
                                    options.onReady = prependCallback(options.onReady, function ():void
                                    {
                                        addTexture(name, texture);
                                        onComplete();
                                        return;
                                    })
                                    texture = starling.textures.Texture.fromData(bytes, options);
                                    texture.root.onRestore = function ():void
                                    {
                                        var loc1:*;
                                        var loc2:*;
                                        _numLostTextures++;
                                        loadRawAsset(rawAsset, null, function (arg1:Object):void
                                        {
                                            var asset:Object;

                                            var loc1:*;
                                            asset = arg1;
                                            try 
                                            {
                                                if (asset == null) 
                                                {
                                                    throw new Error("Reload failed");
                                                }
                                                texture.root.uploadAtfData(asset as flash.utils.ByteArray, 0, false);
                                                asset.clear();
                                            }
                                            catch (e:Error)
                                            {
                                                log("Texture restoration failed for \'" + name + "\': " + e.message);
                                            }
                                            _numRestoredTextures++;
                                            starling.core.Starling.current.stage.setRequiresRedraw();
                                            if (_numLostTextures == _numRestoredTextures) 
                                            {
                                                dispatchEventWith(starling.events.Event.TEXTURES_RESTORED);
                                            }
                                            return;
                                        })
                                        return;
                                    }
                                    bytes.clear();
                                }
                                else if (byteArrayStartsWith(bytes, "{") || byteArrayStartsWith(bytes, "[")) 
                                {
                                    try 
                                    {
                                        object = JSON.parse(bytes.readUTFBytes(bytes.length));
                                    }
                                    catch (e:Error)
                                    {
                                        log("Could not parse JSON: " + e.message);
                                        dispatchEventWith(starling.events.Event.PARSE_ERROR, false, name);
                                    }
                                    if (object) 
                                    {
                                        addObject(name, object);
                                    }
                                    bytes.clear();
                                    onComplete();
                                }
                                else if (byteArrayStartsWith(bytes, "<")) 
                                {
                                    try 
                                    {
                                        xml = new XML(bytes);
                                    }
                                    catch (e:Error)
                                    {
                                        log("Could not parse XML: " + e.message);
                                        dispatchEventWith(starling.events.Event.PARSE_ERROR, false, name);
                                    }
                                    process(xml);
                                    bytes.clear();
                                }
                                else 
                                {
                                    addByteArray(name, bytes);
                                    onComplete();
                                }
                            }
                            else 
                            {
                                addObject(name, asset);
                                onComplete();
                            }
                        }
                    }
                    else 
                    {
                        onComplete();
                    }
                }
                asset = null;
                bytes = null;
                removeEventListener(starling.events.Event.CANCEL, cancel);
                return;
            }
            progress = function (arg1:Number):void
            {
                if (!canceled) 
                {
                    onProgress(arg1);
                }
                return;
            }
            cancel = function ():void
            {
                canceled = true;
                return;
            }
            canceled = false;
            addEventListener(starling.events.Event.CANCEL, cancel);
            this.loadRawAsset(rawAsset, progress, process);
            return;
        }

        protected function loadRawAsset(arg1:Object, arg2:Function, arg3:Function):void
        {
            var rawAsset:Object;
            var onProgress:Function;
            var onComplete:Function;
            var extension:String;
            var loaderInfo:flash.display.LoaderInfo;
            var urlLoader:flash.net.URLLoader;
            var urlRequest:flash.net.URLRequest;
            var url:String;
            var onIoError:Function;
            var onSecurityError:Function;
            var onHttpResponseStatus:Function;
            var onLoadProgress:Function;
            var onUrlLoaderComplete:Function;
            var onLoaderComplete:Function;
            var complete:Function;

            var loc1:*;
            extension = null;
            loaderInfo = null;
            urlLoader = null;
            url = null;
            onIoError = null;
            onSecurityError = null;
            onHttpResponseStatus = null;
            onLoadProgress = null;
            onUrlLoaderComplete = null;
            onLoaderComplete = null;
            complete = null;
            rawAsset = arg1;
            onProgress = arg2;
            onComplete = arg3;
            onIoError = function (arg1:flash.events.IOErrorEvent):void
            {
                log("IO error: " + arg1.text);
                dispatchEventWith(starling.events.Event.IO_ERROR, false, url);
                complete(null);
                return;
            }
            onSecurityError = function (arg1:flash.events.SecurityErrorEvent):void
            {
                log("security error: " + arg1.text);
                dispatchEventWith(starling.events.Event.SECURITY_ERROR, false, url);
                complete(null);
                return;
            }
            onHttpResponseStatus = function (arg1:flash.events.HTTPStatusEvent):void
            {
                var loc1:*=null;
                var loc2:*=null;
                if (extension == null) 
                {
                    loc1 = arg1["responseHeaders"];
                    loc2 = getHttpHeader(loc1, "Content-Type");
                    if (loc2 && new RegExp("(audio|image)\\/").exec(loc2)) 
                    {
                        extension = loc2.split("/").pop();
                    }
                }
                return;
            }
            onLoadProgress = function (arg1:flash.events.ProgressEvent):void
            {
                if (!(onProgress == null) && arg1.bytesTotal > 0) 
                {
                    onProgress(arg1.bytesLoaded / arg1.bytesTotal);
                }
                return;
            }
            onUrlLoaderComplete = function (arg1:Object):void
            {
                var loc2:*=null;
                var loc3:*=null;
                var loc4:*=null;
                var loc1:*=transformData(urlLoader.data as flash.utils.ByteArray, url);
                if (loc1 == null) 
                {
                    complete(null);
                    return;
                }
                if (extension) 
                {
                    extension = extension.toLowerCase();
                }
                var loc5:*=extension;
                switch (loc5) 
                {
                    case "mpeg":
                    case "mp3":
                    {
                        loc2 = new flash.media.Sound();
                        loc2.loadCompressedDataFromByteArray(loc1, loc1.length);
                        loc1.clear();
                        complete(loc2);
                        break;
                    }
                    case "jpg":
                    case "jpeg":
                    case "png":
                    case "gif":
                    {
                        loc3 = new flash.system.LoaderContext(_checkPolicyFile);
                        loc4 = new flash.display.Loader();
                        loc3.imageDecodingPolicy = flash.system.ImageDecodingPolicy.ON_LOAD;
                        loaderInfo = loc4.contentLoaderInfo;
                        loaderInfo.addEventListener(flash.events.IOErrorEvent.IO_ERROR, onIoError);
                        loaderInfo.addEventListener(starling.events.Event.COMPLETE, onLoaderComplete);
                        loc4.loadBytes(loc1, loc3);
                        break;
                    }
                    default:
                    {
                        complete(loc1);
                        break;
                    }
                }
                return;
            }
            onLoaderComplete = function (arg1:Object):void
            {
                urlLoader.data.clear();
                complete(arg1.target.content);
                return;
            }
            complete = function (arg1:Object):void
            {
                if (urlLoader) 
                {
                    urlLoader.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, onIoError);
                    urlLoader.removeEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
                    urlLoader.removeEventListener(HTTP_RESPONSE_STATUS, onHttpResponseStatus);
                    urlLoader.removeEventListener(flash.events.ProgressEvent.PROGRESS, onLoadProgress);
                    urlLoader.removeEventListener(starling.events.Event.COMPLETE, onUrlLoaderComplete);
                }
                if (loaderInfo) 
                {
                    loaderInfo.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, onIoError);
                    loaderInfo.removeEventListener(starling.events.Event.COMPLETE, onLoaderComplete);
                }
                if (starling.utils.SystemUtil.isDesktop) 
                {
                    onComplete(arg1);
                }
                else 
                {
                    starling.utils.SystemUtil.executeWhenApplicationIsActive(onComplete, arg1);
                }
                return;
            }
            extension = null;
            loaderInfo = null;
            urlLoader = null;
            urlRequest = null;
            url = null;
            if (rawAsset is Class) 
            {
                flash.utils.setTimeout(complete, 1, new rawAsset());
            }
            else if (rawAsset is String || rawAsset is flash.net.URLRequest) 
            {
                urlRequest = rawAsset as flash.net.URLRequest || new flash.net.URLRequest(rawAsset as String);
                url = urlRequest.url;
                extension = this.getExtensionFromUrl(url);
                urlLoader = new flash.net.URLLoader();
                urlLoader.dataFormat = flash.net.URLLoaderDataFormat.BINARY;
                urlLoader.addEventListener(flash.events.IOErrorEvent.IO_ERROR, onIoError);
                urlLoader.addEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
                urlLoader.addEventListener(HTTP_RESPONSE_STATUS, onHttpResponseStatus);
                urlLoader.addEventListener(flash.events.ProgressEvent.PROGRESS, onLoadProgress);
                urlLoader.addEventListener(starling.events.Event.COMPLETE, onUrlLoaderComplete);
                urlLoader.load(urlRequest);
            }
            return;
        }

        protected function getName(arg1:Object):String
        {
            var loc1:*=null;
            if (arg1 is String) 
            {
                loc1 = arg1 as String;
            }
            else if (arg1 is flash.net.URLRequest) 
            {
                loc1 = (arg1 as flash.net.URLRequest).url;
            }
            else if (arg1 is flash.net.FileReference) 
            {
                loc1 = (arg1 as flash.net.FileReference).name;
            }
            if (loc1) 
            {
                loc1 = loc1.replace(new RegExp("%20", "g"), " ");
                loc1 = this.getBasenameFromUrl(loc1);
                if (loc1) 
                {
                    return loc1;
                }
                throw new ArgumentError("Could not extract name from String \'" + arg1 + "\'");
            }
            loc1 = flash.utils.getQualifiedClassName(arg1);
            throw new ArgumentError("Cannot extract names for objects of type \'" + loc1 + "\'");
        }

        protected function transformData(arg1:flash.utils.ByteArray, arg2:String):flash.utils.ByteArray
        {
            return arg1;
        }

        protected function log(arg1:String):void
        {
            if (this._verbose) 
            {
                trace("[AssetManager]", arg1);
            }
            return;
        }

        internal function byteArrayStartsWith(arg1:flash.utils.ByteArray, arg2:String):Boolean
        {
            var loc5:*=0;
            var loc1:*=0;
            var loc2:*=arg1.length;
            var loc3:*=arg2.charCodeAt(0);
            if (loc2 >= 4 && arg1[0] == 0 && arg1[1] == 0 && arg1[2] == 254 && arg1[3] == 255 || arg1[0] == 255 && arg1[1] == 254 && arg1[2] == 0 && arg1[3] == 0) 
            {
                loc1 = 4;
            }
            else if (loc2 >= 3 && arg1[0] == 239 && arg1[1] == 187 && arg1[2] == 191) 
            {
                loc1 = 3;
            }
            else if (loc2 >= 2 && arg1[0] == 254 && arg1[1] == 255 || arg1[0] == 255 && arg1[1] == 254) 
            {
                loc1 = 2;
            }
            var loc4:*=loc1;
            while (loc4 < loc2) 
            {
                loc5 = arg1[loc4];
                if (!(loc5 == 0 || loc5 == 10 || loc5 == 13 || loc5 == 32)) 
                {
                    return loc5 == loc3;
                }
                ++loc4;
            }
            return false;
        }

        internal function getDictionaryKeys(arg1:flash.utils.Dictionary, arg2:String="", arg3:__AS3__.vec.Vector.<String>=null):__AS3__.vec.Vector.<String>
        {
            var loc1:*=null;
            if (arg3 == null) 
            {
                arg3 = new Vector.<String>(0);
            }
            var loc2:*=0;
            var loc3:*=arg1;
            for (loc1 in loc3) 
            {
                if (loc1.indexOf(arg2) != 0) 
                {
                    continue;
                }
                arg3[arg3.length] = loc1;
            }
            arg3.sort(Array.CASEINSENSITIVE);
            return arg3;
        }

        internal function getHttpHeader(arg1:Array, arg2:String):String
        {
            var loc1:*=null;
            if (arg1) 
            {
                var loc2:*=0;
                var loc3:*=arg1;
                for each (loc1 in loc3) 
                {
                    if (loc1.name != arg2) 
                    {
                        continue;
                    }
                    return loc1.value;
                }
            }
            return null;
        }

        protected function getBasenameFromUrl(arg1:String):String
        {
            var loc1:*=NAME_REGEX.exec(arg1);
            if (loc1 && loc1.length > 0) 
            {
                return loc1[1];
            }
            return null;
        }

        protected function getExtensionFromUrl(arg1:String):String
        {
            var loc1:*=NAME_REGEX.exec(arg1);
            if (loc1 && loc1.length > 1) 
            {
                return loc1[2];
            }
            return null;
        }

        internal function prependCallback(arg1:Function, arg2:Function):Function
        {
            var oldCallback:Function;
            var newCallback:Function;

            var loc1:*;
            oldCallback = arg1;
            newCallback = arg2;
            if (oldCallback == null) 
            {
                return newCallback;
            }
            if (newCallback == null) 
            {
                return oldCallback;
            }
            return function ():void
            {
                newCallback();
                oldCallback();
                return;
            }
        }

        protected function get queue():Array
        {
            return this._queue;
        }

        public function get numQueuedAssets():int
        {
            return this._queue.length;
        }

        public function get verbose():Boolean
        {
            return this._verbose;
        }

        public function set verbose(arg1:Boolean):void
        {
            this._verbose = arg1;
            return;
        }

        public function get isLoading():Boolean
        {
            return this._numLoadingQueues > 0;
        }

        internal static const NAME_REGEX:RegExp=new RegExp("([^\\?\\/\\\\]+?)(?:\\.([\\w\\-]+))?(?:\\?.*)?$");

        internal static const HTTP_RESPONSE_STATUS:String="httpResponseStatus";

        internal var _starling:starling.core.Starling;

        internal var _numLostTextures:int;

        internal var _numRestoredTextures:int;

        internal var _numLoadingQueues:int;

        internal var _defaultTextureOptions:starling.textures.TextureOptions;

        internal var _checkPolicyFile:Boolean;

        internal var _keepAtlasXmls:Boolean;

        internal var _keepFontXmls:Boolean;

        internal var _numConnections:int;

        internal var _queue:Array;

        internal var _textures:flash.utils.Dictionary;

        internal var _atlases:flash.utils.Dictionary;

        internal var _sounds:flash.utils.Dictionary;

        internal var _xmls:flash.utils.Dictionary;

        internal var _objects:flash.utils.Dictionary;

        internal var _byteArrays:flash.utils.Dictionary;

        internal var _verbose:Boolean;

        internal static var sNames:__AS3__.vec.Vector.<String>;
    }
}


//  class Color
package starling.utils 
{
    import __AS3__.vec.*;
    import starling.errors.*;
    
    public class Color extends Object
    {
        public function Color()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function getAlpha(arg1:uint):int
        {
            return arg1 >> 24 & 255;
        }

        public static function getRed(arg1:uint):int
        {
            return arg1 >> 16 & 255;
        }

        public static function getGreen(arg1:uint):int
        {
            return arg1 >> 8 & 255;
        }

        public static function getBlue(arg1:uint):int
        {
            return arg1 & 255;
        }

        public static function rgb(arg1:int, arg2:int, arg3:int):uint
        {
            return arg1 << 16 | arg2 << 8 | arg3;
        }

        public static function argb(arg1:int, arg2:int, arg3:int, arg4:int):uint
        {
            return arg1 << 24 | arg2 << 16 | arg3 << 8 | arg4;
        }

        public static function toVector(arg1:uint, arg2:__AS3__.vec.Vector.<Number>=null):__AS3__.vec.Vector.<Number>
        {
            if (arg2 == null) 
            {
                arg2 = new Vector.<Number>(4, true);
            }
            arg2[0] = (arg1 >> 16 & 255) / 255;
            arg2[1] = (arg1 >> 8 & 255) / 255;
            arg2[2] = (arg1 & 255) / 255;
            arg2[3] = (arg1 >> 24 & 255) / 255;
            return arg2;
        }

        public static function multiply(arg1:uint, arg2:Number):uint
        {
            var loc1:*=(arg1 >> 24 & 255) * arg2;
            var loc2:*=(arg1 >> 16 & 255) * arg2;
            var loc3:*=(arg1 >> 8 & 255) * arg2;
            var loc4:*=(arg1 & 255) * arg2;
            if (loc1 > 255) 
            {
                loc1 = 255;
            }
            if (loc2 > 255) 
            {
                loc2 = 255;
            }
            if (loc3 > 255) 
            {
                loc3 = 255;
            }
            if (loc4 > 255) 
            {
                loc4 = 255;
            }
            return argb(loc1, loc2, loc3, loc4);
        }

        public static function interpolate(arg1:uint, arg2:uint, arg3:Number):uint
        {
            var loc1:*=arg1 >> 24 & 255;
            var loc2:*=arg1 >> 16 & 255;
            var loc3:*=arg1 >> 8 & 255;
            var loc4:*=arg1 & 255;
            var loc5:*=arg2 >> 24 & 255;
            var loc6:*=arg2 >> 16 & 255;
            var loc7:*=arg2 >> 8 & 255;
            var loc8:*=arg2 & 255;
            var loc9:*=loc1 + (loc5 - loc1) * arg3;
            var loc10:*=loc2 + (loc6 - loc2) * arg3;
            var loc11:*=loc3 + (loc7 - loc3) * arg3;
            var loc12:*=loc4 + (loc8 - loc4) * arg3;
            return loc9 << 24 | loc10 << 16 | loc11 << 8 | loc12;
        }

        public static const WHITE:uint=16777215;

        public static const SILVER:uint=12632256;

        public static const GRAY:uint=8421504;

        public static const BLACK:uint=0;

        public static const RED:uint=16711680;

        public static const MAROON:uint=8388608;

        public static const YELLOW:uint=16776960;

        public static const OLIVE:uint=8421376;

        public static const LIME:uint=65280;

        public static const GREEN:uint=32768;

        public static const AQUA:uint=65535;

        public static const TEAL:uint=32896;

        public static const BLUE:uint=255;

        public static const NAVY:uint=128;

        public static const FUCHSIA:uint=16711935;

        public static const PURPLE:uint=8388736;
    }
}


//  class MathUtil
package starling.utils 
{
    import flash.geom.*;
    import starling.errors.*;
    
    public class MathUtil extends Object
    {
        public function MathUtil()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function intersectLineWithXYPlane(arg1:flash.geom.Vector3D, arg2:flash.geom.Vector3D, arg3:flash.geom.Point=null):flash.geom.Point
        {
            if (arg3 == null) 
            {
                arg3 = new flash.geom.Point();
            }
            var loc1:*=arg2.x - arg1.x;
            var loc2:*=arg2.y - arg1.y;
            var loc3:*=arg2.z - arg1.z;
            var loc4:*=(-arg1.z) / loc3;
            arg3.x = arg1.x + loc4 * loc1;
            arg3.y = arg1.y + loc4 * loc2;
            return arg3;
        }

        public static function isPointInTriangle(arg1:flash.geom.Point, arg2:flash.geom.Point, arg3:flash.geom.Point, arg4:flash.geom.Point):Boolean
        {
            var loc1:*=arg4.x - arg2.x;
            var loc2:*=arg4.y - arg2.y;
            var loc3:*=arg3.x - arg2.x;
            var loc4:*=arg3.y - arg2.y;
            var loc5:*=arg1.x - arg2.x;
            var loc6:*=arg1.y - arg2.y;
            var loc7:*=loc1 * loc1 + loc2 * loc2;
            var loc8:*=loc1 * loc3 + loc2 * loc4;
            var loc9:*=loc1 * loc5 + loc2 * loc6;
            var loc10:*=loc3 * loc3 + loc4 * loc4;
            var loc11:*=loc3 * loc5 + loc4 * loc6;
            var loc12:*=1 / (loc7 * loc10 - loc8 * loc8);
            var loc13:*=(loc10 * loc9 - loc8 * loc11) * loc12;
            var loc14:*=(loc7 * loc11 - loc8 * loc9) * loc12;
            return loc13 >= 0 && loc14 >= 0 && loc13 + loc14 < 1;
        }

        public static function normalizeAngle(arg1:Number):Number
        {
            arg1 = arg1 % TWO_PI;
            if (arg1 < -Math.PI) 
            {
                arg1 = arg1 + TWO_PI;
            }
            if (arg1 > Math.PI) 
            {
                arg1 = arg1 - TWO_PI;
            }
            return arg1;
        }

        public static function getNextPowerOfTwo(arg1:Number):int
        {
            var loc1:*=0;
            if (arg1 is int && arg1 > 0 && (arg1 & (arg1 - 1)) == 0) 
            {
                return arg1;
            }
            loc1 = 1;
            arg1 = arg1 - 1e-009;
            while (loc1 < arg1) 
            {
                loc1 = loc1 << 1;
            }
            return loc1;
        }

        public static function isEquivalent(arg1:Number, arg2:Number, arg3:Number=0.0001):Boolean
        {
            return arg1 - arg3 < arg2 && arg1 + arg3 > arg2;
        }

        public static function max(arg1:Number, arg2:Number):Number
        {
            return arg1 > arg2 ? arg1 : arg2;
        }

        public static function min(arg1:Number, arg2:Number):Number
        {
            return arg1 < arg2 ? arg1 : arg2;
        }

        public static function clamp(arg1:Number, arg2:Number, arg3:Number):Number
        {
            return arg1 < arg2 ? arg2 : arg1 > arg3 ? arg3 : arg1;
        }

        internal static const TWO_PI:Number=Math.PI * 2;
    }
}


//  class MatrixUtil
package starling.utils 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import starling.errors.*;
    
    public class MatrixUtil extends Object
    {
        public function MatrixUtil()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function convertTo3D(arg1:flash.geom.Matrix, arg2:flash.geom.Matrix3D=null):flash.geom.Matrix3D
        {
            if (arg2 == null) 
            {
                arg2 = new flash.geom.Matrix3D();
            }
            sRawData[0] = arg1.a;
            sRawData[1] = arg1.b;
            sRawData[4] = arg1.c;
            sRawData[5] = arg1.d;
            sRawData[12] = arg1.tx;
            sRawData[13] = arg1.ty;
            arg2.copyRawDataFrom(sRawData);
            return arg2;
        }

        public static function convertTo2D(arg1:flash.geom.Matrix3D, arg2:flash.geom.Matrix=null):flash.geom.Matrix
        {
            if (arg2 == null) 
            {
                arg2 = new flash.geom.Matrix();
            }
            arg1.copyRawDataTo(sRawData2);
            arg2.a = sRawData2[0];
            arg2.b = sRawData2[1];
            arg2.c = sRawData2[4];
            arg2.d = sRawData2[5];
            arg2.tx = sRawData2[12];
            arg2.ty = sRawData2[13];
            return arg2;
        }

        public static function isIdentity(arg1:flash.geom.Matrix):Boolean
        {
            return arg1.a == 1 && arg1.b == 0 && arg1.c == 0 && arg1.d == 1 && arg1.tx == 0 && arg1.ty == 0;
        }

        public static function isIdentity3D(arg1:flash.geom.Matrix3D):Boolean
        {
            var loc1:*=sRawData2;
            arg1.copyRawDataTo(loc1);
            return loc1[0] == 1 && loc1[1] == 0 && loc1[2] == 0 && loc1[3] == 0 && loc1[4] == 0 && loc1[5] == 1 && loc1[6] == 0 && loc1[7] == 0 && loc1[8] == 0 && loc1[9] == 0 && loc1[10] == 1 && loc1[11] == 0 && loc1[12] == 0 && loc1[13] == 0 && loc1[14] == 0 && loc1[15] == 1;
        }

        public static function transformPoint(arg1:flash.geom.Matrix, arg2:flash.geom.Point, arg3:flash.geom.Point=null):flash.geom.Point
        {
            return transformCoords(arg1, arg2.x, arg2.y, arg3);
        }

        public static function transformPoint3D(arg1:flash.geom.Matrix3D, arg2:flash.geom.Vector3D, arg3:flash.geom.Vector3D=null):flash.geom.Vector3D
        {
            return transformCoords3D(arg1, arg2.x, arg2.y, arg2.z, arg3);
        }

        public static function transformCoords(arg1:flash.geom.Matrix, arg2:Number, arg3:Number, arg4:flash.geom.Point=null):flash.geom.Point
        {
            if (arg4 == null) 
            {
                arg4 = new flash.geom.Point();
            }
            arg4.x = arg1.a * arg2 + arg1.c * arg3 + arg1.tx;
            arg4.y = arg1.d * arg3 + arg1.b * arg2 + arg1.ty;
            return arg4;
        }

        public static function transformCoords3D(arg1:flash.geom.Matrix3D, arg2:Number, arg3:Number, arg4:Number, arg5:flash.geom.Vector3D=null):flash.geom.Vector3D
        {
            if (arg5 == null) 
            {
                arg5 = new flash.geom.Vector3D();
            }
            arg1.copyRawDataTo(sRawData2);
            arg5.x = arg2 * sRawData2[0] + arg3 * sRawData2[4] + arg4 * sRawData2[8] + sRawData2[12];
            arg5.y = arg2 * sRawData2[1] + arg3 * sRawData2[5] + arg4 * sRawData2[9] + sRawData2[13];
            arg5.z = arg2 * sRawData2[2] + arg3 * sRawData2[6] + arg4 * sRawData2[10] + sRawData2[14];
            arg5.w = arg2 * sRawData2[3] + arg3 * sRawData2[7] + arg4 * sRawData2[11] + sRawData2[15];
            return arg5;
        }

        public static function skew(arg1:flash.geom.Matrix, arg2:Number, arg3:Number):void
        {
            var loc1:*=Math.sin(arg2);
            var loc2:*=Math.cos(arg2);
            var loc3:*=Math.sin(arg3);
            var loc4:*=Math.cos(arg3);
            arg1.setTo(arg1.a * loc4 - arg1.b * loc1, arg1.a * loc3 + arg1.b * loc2, arg1.c * loc4 - arg1.d * loc1, arg1.c * loc3 + arg1.d * loc2, arg1.tx * loc4 - arg1.ty * loc1, arg1.tx * loc3 + arg1.ty * loc2);
            return;
        }

        public static function prependMatrix(arg1:flash.geom.Matrix, arg2:flash.geom.Matrix):void
        {
            arg1.setTo(arg1.a * arg2.a + arg1.c * arg2.b, arg1.b * arg2.a + arg1.d * arg2.b, arg1.a * arg2.c + arg1.c * arg2.d, arg1.b * arg2.c + arg1.d * arg2.d, arg1.tx + arg1.a * arg2.tx + arg1.c * arg2.ty, arg1.ty + arg1.b * arg2.tx + arg1.d * arg2.ty);
            return;
        }

        public static function prependTranslation(arg1:flash.geom.Matrix, arg2:Number, arg3:Number):void
        {
            arg1.tx = arg1.tx + (arg1.a * arg2 + arg1.c * arg3);
            arg1.ty = arg1.ty + (arg1.b * arg2 + arg1.d * arg3);
            return;
        }

        public static function prependScale(arg1:flash.geom.Matrix, arg2:Number, arg3:Number):void
        {
            arg1.setTo(arg1.a * arg2, arg1.b * arg2, arg1.c * arg3, arg1.d * arg3, arg1.tx, arg1.ty);
            return;
        }

        public static function prependRotation(arg1:flash.geom.Matrix, arg2:Number):void
        {
            var loc1:*=Math.sin(arg2);
            var loc2:*=Math.cos(arg2);
            arg1.setTo(arg1.a * loc2 + arg1.c * loc1, arg1.b * loc2 + arg1.d * loc1, arg1.c * loc2 - arg1.a * loc1, arg1.d * loc2 - arg1.b * loc1, arg1.tx, arg1.ty);
            return;
        }

        public static function prependSkew(arg1:flash.geom.Matrix, arg2:Number, arg3:Number):void
        {
            var loc1:*=Math.sin(arg2);
            var loc2:*=Math.cos(arg2);
            var loc3:*=Math.sin(arg3);
            var loc4:*=Math.cos(arg3);
            arg1.setTo(arg1.a * loc4 + arg1.c * loc3, arg1.b * loc4 + arg1.d * loc3, arg1.c * loc2 - arg1.a * loc1, arg1.d * loc2 - arg1.b * loc1, arg1.tx, arg1.ty);
            return;
        }

        public static function toString3D(arg1:flash.geom.Matrix3D, arg2:Boolean=true, arg3:int=3):String
        {
            if (arg2) 
            {
                arg1.transpose();
            }
            arg1.copyRawDataTo(sRawData2);
            if (arg2) 
            {
                arg1.transpose();
            }
            return "[Matrix3D rawData=\n" + formatRawData(sRawData2, 4, 4, arg3) + "\n]";
        }

        public static function toString(arg1:flash.geom.Matrix, arg2:int=3):String
        {
            sRawData2[0] = arg1.a;
            sRawData2[1] = arg1.c;
            sRawData2[2] = arg1.tx;
            sRawData2[3] = arg1.b;
            sRawData2[4] = arg1.d;
            sRawData2[5] = arg1.ty;
            return "[Matrix rawData=\n" + formatRawData(sRawData2, 3, 2, arg2) + "\n]";
        }

        internal static function formatRawData(arg1:__AS3__.vec.Vector.<Number>, arg2:int, arg3:int, arg4:int, arg5:String="  "):String
        {
            var loc4:*=null;
            var loc5:*=NaN;
            var loc9:*=0;
            var loc1:*=arg5;
            var loc2:*=arg2 * arg3;
            var loc3:*=0;
            var loc6:*=0;
            while (loc6 < loc2) 
            {
                loc5 = Math.abs(arg1[loc6]);
                if (loc5 > loc3) 
                {
                    loc3 = loc5;
                }
                ++loc6;
            }
            var loc7:*=loc3.toFixed(arg4).length + 1;
            var loc8:*=0;
            while (loc8 < arg3) 
            {
                loc9 = 0;
                while (loc9 < arg2) 
                {
                    loc5 = arg1[arg2 * loc8 + loc9];
                    loc4 = loc5.toFixed(arg4);
                    while (loc4.length < loc7) 
                    {
                        loc4 = " " + loc4;
                    }
                    loc1 = loc1 + loc4;
                    if (loc9 != (arg2 - 1)) 
                    {
                        loc1 = loc1 + ", ";
                    }
                    ++loc9;
                }
                if (loc8 != (arg3 - 1)) 
                {
                    loc1 = loc1 + ("\n" + arg5);
                }
                ++loc8;
            }
            return loc1;
        }

        public static function snapToPixels(arg1:flash.geom.Matrix, arg2:Number):void
        {
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc1:*=0.0001;
            var loc2:*=false;
            if (arg1.b + loc1 > 0 && arg1.b - loc1 < 0 && arg1.c + loc1 > 0 && arg1.c - loc1 < 0) 
            {
                loc3 = arg1.a * arg1.a;
                loc6 = arg1.d * arg1.d;
                loc2 = loc3 + loc1 > 1 && loc3 - loc1 < 1 && loc6 + loc1 > 1 && loc6 - loc1 < 1;
            }
            else if (arg1.a + loc1 > 0 && arg1.a - loc1 < 0 && arg1.d + loc1 > 0 && arg1.d - loc1 < 0) 
            {
                loc4 = arg1.b * arg1.b;
                loc5 = arg1.c * arg1.c;
                loc2 = loc4 + loc1 > 1 && loc4 - loc1 < 1 && loc5 + loc1 > 1 && loc5 - loc1 < 1;
            }
            if (loc2) 
            {
                arg1.tx = Math.round(arg1.tx / arg2) * arg2;
                arg1.ty = Math.round(arg1.ty / arg2) * arg2;
            }
            return;
        }

        public static function createPerspectiveProjectionMatrix(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number=0, arg6:Number=0, arg7:flash.geom.Vector3D=null, arg8:flash.geom.Matrix3D=null):flash.geom.Matrix3D
        {
            var loc1:*=NaN;
            if (arg8 == null) 
            {
                arg8 = new flash.geom.Matrix3D();
            }
            if (arg5 <= 0) 
            {
                arg5 = arg3;
            }
            if (arg6 <= 0) 
            {
                arg6 = arg4;
            }
            if (arg7 == null) 
            {
                arg7 = sPoint3D;
                arg7.setTo(arg5 / 2, arg6 / 2, arg5 / Math.tan(0.5) * 0.5);
            }
            loc1 = Math.abs(arg7.z);
            var loc2:*=arg7.x - arg5 / 2;
            var loc3:*=arg7.y - arg6 / 2;
            var loc4:*=loc1 * 20;
            var loc5:*=1;
            var loc6:*=arg5 / arg3;
            var loc7:*=arg6 / arg4;
            sMatrixData[0] = 2 * loc1 / arg5;
            sMatrixData[5] = -2 * loc1 / arg6;
            sMatrixData[10] = loc4 / (loc4 - loc5);
            sMatrixData[14] = (-loc4) * loc5 / (loc4 - loc5);
            sMatrixData[11] = 1;
            sMatrixData[0] = sMatrixData[0] * loc6;
            sMatrixData[5] = sMatrixData[5] * loc7;
            sMatrixData[8] = (loc6 - 1) - 2 * loc6 * (arg1 - loc2) / arg5;
            sMatrixData[9] = -loc7 + 1 + 2 * loc7 * (arg2 - loc3) / arg6;
            arg8.copyRawDataFrom(sMatrixData);
            arg8.prependTranslation((-arg5) / 2 - loc2, (-arg6) / 2 - loc3, loc1);
            return arg8;
        }

        public static function createOrthographicProjectionMatrix(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:flash.geom.Matrix=null):flash.geom.Matrix
        {
            if (arg5 == null) 
            {
                arg5 = new flash.geom.Matrix();
            }
            arg5.setTo(2 / arg3, 0, 0, -2 / arg4, (-(2 * arg1 + arg3)) / arg3, (2 * arg2 + arg4) / arg4);
            return arg5;
        }

        
        {
            new Vector.<Number>(16)[0] = 1;
            new Vector.<Number>(16)[1] = 0;
            new Vector.<Number>(16)[2] = 0;
            new Vector.<Number>(16)[3] = 0;
            new Vector.<Number>(16)[4] = 0;
            new Vector.<Number>(16)[5] = 1;
            new Vector.<Number>(16)[6] = 0;
            new Vector.<Number>(16)[7] = 0;
            new Vector.<Number>(16)[8] = 0;
            new Vector.<Number>(16)[9] = 0;
            new Vector.<Number>(16)[10] = 1;
            new Vector.<Number>(16)[11] = 0;
            new Vector.<Number>(16)[12] = 0;
            new Vector.<Number>(16)[13] = 0;
            new Vector.<Number>(16)[14] = 0;
            new Vector.<Number>(16)[15] = 1;
            sRawData = new Vector.<Number>(16);
            sRawData2 = new Vector.<Number>(16, true);
            sPoint3D = new flash.geom.Vector3D();
            new Vector.<Number>(16)[0] = 0;
            new Vector.<Number>(16)[1] = 0;
            new Vector.<Number>(16)[2] = 0;
            new Vector.<Number>(16)[3] = 0;
            new Vector.<Number>(16)[4] = 0;
            new Vector.<Number>(16)[5] = 0;
            new Vector.<Number>(16)[6] = 0;
            new Vector.<Number>(16)[7] = 0;
            new Vector.<Number>(16)[8] = 0;
            new Vector.<Number>(16)[9] = 0;
            new Vector.<Number>(16)[10] = 0;
            new Vector.<Number>(16)[11] = 0;
            new Vector.<Number>(16)[12] = 0;
            new Vector.<Number>(16)[13] = 0;
            new Vector.<Number>(16)[14] = 0;
            new Vector.<Number>(16)[15] = 0;
            sMatrixData = new Vector.<Number>(16);
        }

        internal static var sRawData:__AS3__.vec.Vector.<Number>;

        internal static var sRawData2:__AS3__.vec.Vector.<Number>;

        internal static var sPoint3D:flash.geom.Vector3D;

        internal static var sMatrixData:__AS3__.vec.Vector.<Number>;
    }
}


//  class MeshSubset
package starling.utils 
{
    public class MeshSubset extends Object
    {
        public function MeshSubset(arg1:int=0, arg2:int=-1, arg3:int=0, arg4:int=-1)
        {
            super();
            this.setTo(arg1, arg2, arg3, arg4);
            return;
        }

        public function setTo(arg1:int=0, arg2:int=-1, arg3:int=0, arg4:int=-1):void
        {
            this.vertexID = arg1;
            this.numVertices = arg2;
            this.indexID = arg3;
            this.numIndices = arg4;
            return;
        }

        public var vertexID:int;

        public var numVertices:int;

        public var indexID:int;

        public var numIndices:int;
    }
}


//  class MeshUtil
package starling.utils 
{
    import flash.geom.*;
    import starling.display.*;
    import starling.errors.*;
    import starling.rendering.*;
    
    public class MeshUtil extends Object
    {
        public function MeshUtil()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function containsPoint(arg1:starling.rendering.VertexData, arg2:starling.rendering.IndexData, arg3:flash.geom.Point):Boolean
        {
            var loc1:*=0;
            var loc2:*=false;
            var loc3:*=arg2.numIndices;
            var loc4:*=starling.utils.Pool.getPoint();
            var loc5:*=starling.utils.Pool.getPoint();
            var loc6:*=starling.utils.Pool.getPoint();
            loc1 = 0;
            while (loc1 < loc3) 
            {
                arg1.getPoint(arg2.getIndex(loc1), "position", loc4);
                arg1.getPoint(arg2.getIndex(loc1 + 1), "position", loc5);
                arg1.getPoint(arg2.getIndex(loc1 + 2), "position", loc6);
                if (starling.utils.MathUtil.isPointInTriangle(arg3, loc4, loc5, loc6)) 
                {
                    loc2 = true;
                    break;
                }
                loc1 = loc1 + 3;
            }
            starling.utils.Pool.putPoint(loc4);
            starling.utils.Pool.putPoint(loc5);
            starling.utils.Pool.putPoint(loc6);
            return loc2;
        }

        public static function calculateBounds(arg1:starling.rendering.VertexData, arg2:starling.display.DisplayObject, arg3:starling.display.DisplayObject, arg4:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            if (arg4 == null) 
            {
                arg4 = new flash.geom.Rectangle();
            }
            var loc1:*=arg2.stage;
            if (arg2.is3D && loc1) 
            {
                loc1.getCameraPosition(arg3, sPoint3D);
                arg2.getTransformationMatrix3D(arg3, sMatrix3D);
                arg1.getBoundsProjected("position", sMatrix3D, sPoint3D, 0, -1, arg4);
            }
            else 
            {
                arg2.getTransformationMatrix(arg3, sMatrix);
                arg1.getBounds("position", sMatrix, 0, -1, arg4);
            }
            return arg4;
        }

        
        {
            sPoint3D = new flash.geom.Vector3D();
            sMatrix = new flash.geom.Matrix();
            sMatrix3D = new flash.geom.Matrix3D();
        }

        internal static var sPoint3D:flash.geom.Vector3D;

        internal static var sMatrix:flash.geom.Matrix;

        internal static var sMatrix3D:flash.geom.Matrix3D;
    }
}


//  class Padding
package starling.utils 
{
    import starling.events.*;
    
    public class Padding extends starling.events.EventDispatcher
    {
        public function Padding(arg1:Number=0, arg2:Number=0, arg3:Number=0, arg4:Number=0)
        {
            super();
            this.setTo(arg1, arg2, arg3, arg4);
            return;
        }

        public function setTo(arg1:Number=0, arg2:Number=0, arg3:Number=0, arg4:Number=0):void
        {
            var loc1:*=!(this._left == arg1) || !(this._right == arg2) || !(this._top == arg3) || !(this._bottom == arg4);
            this._left = arg1;
            this._right = arg2;
            this._top = arg3;
            this._bottom = arg4;
            if (loc1) 
            {
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function copyFrom(arg1:starling.utils.Padding):void
        {
            if (arg1 != null) 
            {
                this.setTo(arg1._left, arg1._right, arg1._top, arg1._bottom);
            }
            else 
            {
                this.setTo(0, 0, 0, 0);
            }
            return;
        }

        public function clone():starling.utils.Padding
        {
            return new starling.utils.Padding(this._left, this._right, this._top, this._bottom);
        }

        public function get left():Number
        {
            return this._left;
        }

        public function set left(arg1:Number):void
        {
            if (this._left != arg1) 
            {
                this._left = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function get right():Number
        {
            return this._right;
        }

        public function set right(arg1:Number):void
        {
            if (this._right != arg1) 
            {
                this._right = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function get top():Number
        {
            return this._top;
        }

        public function set top(arg1:Number):void
        {
            if (this._top != arg1) 
            {
                this._top = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function get bottom():Number
        {
            return this._bottom;
        }

        public function set bottom(arg1:Number):void
        {
            if (this._bottom != arg1) 
            {
                this._bottom = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        internal var _left:Number;

        internal var _right:Number;

        internal var _top:Number;

        internal var _bottom:Number;
    }
}


//  class Pool
package starling.utils 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import starling.errors.*;
    
    public class Pool extends Object
    {
        public function Pool()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function getPoint(arg1:Number=0, arg2:Number=0):flash.geom.Point
        {
            var loc1:*=null;
            if (sPoints.length == 0) 
            {
                return new flash.geom.Point(arg1, arg2);
            }
            loc1 = sPoints.pop();
            loc1.x = arg1;
            loc1.y = arg2;
            return loc1;
        }

        public static function putPoint(arg1:flash.geom.Point):void
        {
            if (arg1) 
            {
                sPoints[sPoints.length] = arg1;
            }
            return;
        }

        public static function getPoint3D(arg1:Number=0, arg2:Number=0, arg3:Number=0):flash.geom.Vector3D
        {
            var loc1:*=null;
            if (sPoints.length == 0) 
            {
                return new flash.geom.Vector3D(arg1, arg2, arg3);
            }
            loc1 = sPoints3D.pop();
            loc1.x = arg1;
            loc1.y = arg2;
            loc1.z = arg3;
            return loc1;
        }

        public static function putPoint3D(arg1:flash.geom.Vector3D):void
        {
            if (arg1) 
            {
                sPoints3D[sPoints3D.length] = arg1;
            }
            return;
        }

        public static function getMatrix(arg1:Number=1, arg2:Number=0, arg3:Number=0, arg4:Number=1, arg5:Number=0, arg6:Number=0):flash.geom.Matrix
        {
            var loc1:*=null;
            if (sMatrices.length == 0) 
            {
                return new flash.geom.Matrix(arg1, arg2, arg3, arg4, arg5, arg6);
            }
            loc1 = sMatrices.pop();
            loc1.setTo(arg1, arg2, arg3, arg4, arg5, arg6);
            return loc1;
        }

        public static function putMatrix(arg1:flash.geom.Matrix):void
        {
            if (arg1) 
            {
                sMatrices[sMatrices.length] = arg1;
            }
            return;
        }

        public static function getMatrix3D(arg1:Boolean=true):flash.geom.Matrix3D
        {
            var loc1:*=null;
            if (sMatrices3D.length == 0) 
            {
                return new flash.geom.Matrix3D();
            }
            loc1 = sMatrices3D.pop();
            if (arg1) 
            {
                loc1.identity();
            }
            return loc1;
        }

        public static function putMatrix3D(arg1:flash.geom.Matrix3D):void
        {
            if (arg1) 
            {
                sMatrices3D[sMatrices3D.length] = arg1;
            }
            return;
        }

        public static function getRectangle(arg1:Number=0, arg2:Number=0, arg3:Number=0, arg4:Number=0):flash.geom.Rectangle
        {
            var loc1:*=null;
            if (sRectangles.length == 0) 
            {
                return new flash.geom.Rectangle(arg1, arg2, arg3, arg4);
            }
            loc1 = sRectangles.pop();
            loc1.setTo(arg1, arg2, arg3, arg4);
            return loc1;
        }

        public static function putRectangle(arg1:flash.geom.Rectangle):void
        {
            if (arg1) 
            {
                sRectangles[sRectangles.length] = arg1;
            }
            return;
        }

        
        {
            sPoints = new Vector.<flash.geom.Point>(0);
            sPoints3D = new Vector.<flash.geom.Vector3D>(0);
            sMatrices = new Vector.<flash.geom.Matrix>(0);
            sMatrices3D = new Vector.<flash.geom.Matrix3D>(0);
            sRectangles = new Vector.<flash.geom.Rectangle>(0);
        }

        internal static var sPoints:__AS3__.vec.Vector.<flash.geom.Point>;

        internal static var sPoints3D:__AS3__.vec.Vector.<flash.geom.Vector3D>;

        internal static var sMatrices:__AS3__.vec.Vector.<flash.geom.Matrix>;

        internal static var sMatrices3D:__AS3__.vec.Vector.<flash.geom.Matrix3D>;

        internal static var sRectangles:__AS3__.vec.Vector.<flash.geom.Rectangle>;
    }
}


//  class RectangleUtil
package starling.utils 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import starling.errors.*;
    
    public class RectangleUtil extends Object
    {
        public function RectangleUtil()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function intersect(arg1:flash.geom.Rectangle, arg2:flash.geom.Rectangle, arg3:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            if (arg3 == null) 
            {
                arg3 = new flash.geom.Rectangle();
            }
            var loc1:*=arg1.x > arg2.x ? arg1.x : arg2.x;
            var loc2:*=arg1.right < arg2.right ? arg1.right : arg2.right;
            var loc3:*=arg1.y > arg2.y ? arg1.y : arg2.y;
            var loc4:*=arg1.bottom < arg2.bottom ? arg1.bottom : arg2.bottom;
            if (loc1 > loc2 || loc3 > loc4) 
            {
                arg3.setEmpty();
            }
            else 
            {
                arg3.setTo(loc1, loc3, loc2 - loc1, loc4 - loc3);
            }
            return arg3;
        }

        public static function fit(arg1:flash.geom.Rectangle, arg2:flash.geom.Rectangle, arg3:String="showAll", arg4:Boolean=false, arg5:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            if (!starling.utils.ScaleMode.isValid(arg3)) 
            {
                throw new ArgumentError("Invalid scaleMode: " + arg3);
            }
            if (arg5 == null) 
            {
                arg5 = new flash.geom.Rectangle();
            }
            var loc1:*=arg1.width;
            var loc2:*=arg1.height;
            var loc3:*=arg2.width / loc1;
            var loc4:*=arg2.height / loc2;
            var loc5:*=1;
            if (arg3 != starling.utils.ScaleMode.SHOW_ALL) 
            {
                if (arg3 == starling.utils.ScaleMode.NO_BORDER) 
                {
                    loc5 = loc3 > loc4 ? loc3 : loc4;
                    if (arg4) 
                    {
                        loc5 = nextSuitableScaleFactor(loc5, true);
                    }
                }
            }
            else 
            {
                loc5 = loc3 < loc4 ? loc3 : loc4;
                if (arg4) 
                {
                    loc5 = nextSuitableScaleFactor(loc5, false);
                }
            }
            loc1 = loc1 * loc5;
            loc2 = loc2 * loc5;
            arg5.setTo(arg2.x + (arg2.width - loc1) / 2, arg2.y + (arg2.height - loc2) / 2, loc1, loc2);
            return arg5;
        }

        internal static function nextSuitableScaleFactor(arg1:Number, arg2:Boolean):Number
        {
            var loc1:*=1;
            if (arg2) 
            {
                if (arg1 >= 0.5) 
                {
                    return Math.ceil(arg1);
                }
                while (1 / (loc1 + 1) > arg1) 
                {
                    ++loc1;
                }
            }
            else 
            {
                if (arg1 >= 1) 
                {
                    return Math.floor(arg1);
                }
                while (1 / loc1 > arg1) 
                {
                    ++loc1;
                }
            }
            return 1 / loc1;
        }

        public static function normalize(arg1:flash.geom.Rectangle):void
        {
            if (arg1.width < 0) 
            {
                arg1.width = -arg1.width;
                arg1.x = arg1.x - arg1.width;
            }
            if (arg1.height < 0) 
            {
                arg1.height = -arg1.height;
                arg1.y = arg1.y - arg1.height;
            }
            return;
        }

        public static function extend(arg1:flash.geom.Rectangle, arg2:Number=0, arg3:Number=0, arg4:Number=0, arg5:Number=0):void
        {
            arg1.x = arg1.x - arg2;
            arg1.y = arg1.y - arg4;
            arg1.width = arg1.width + (arg2 + arg3);
            arg1.height = arg1.height + (arg4 + arg5);
            return;
        }

        public static function getBounds(arg1:flash.geom.Rectangle, arg2:flash.geom.Matrix, arg3:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            if (arg3 == null) 
            {
                arg3 = new flash.geom.Rectangle();
            }
            var loc1:*=Number.MAX_VALUE;
            var loc2:*=-Number.MAX_VALUE;
            var loc3:*=Number.MAX_VALUE;
            var loc4:*=-Number.MAX_VALUE;
            var loc5:*=getPositions(arg1, sPositions);
            var loc6:*=0;
            while (loc6 < 4) 
            {
                starling.utils.MatrixUtil.transformCoords(arg2, loc5[loc6].x, loc5[loc6].y, sPoint);
                if (loc1 > sPoint.x) 
                {
                    loc1 = sPoint.x;
                }
                if (loc2 < sPoint.x) 
                {
                    loc2 = sPoint.x;
                }
                if (loc3 > sPoint.y) 
                {
                    loc3 = sPoint.y;
                }
                if (loc4 < sPoint.y) 
                {
                    loc4 = sPoint.y;
                }
                ++loc6;
            }
            arg3.setTo(loc1, loc3, loc2 - loc1, loc4 - loc3);
            return arg3;
        }

        public static function getBoundsProjected(arg1:flash.geom.Rectangle, arg2:flash.geom.Matrix3D, arg3:flash.geom.Vector3D, arg4:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            var loc7:*=null;
            if (arg4 == null) 
            {
                arg4 = new flash.geom.Rectangle();
            }
            if (arg3 == null) 
            {
                throw new ArgumentError("camPos must not be null");
            }
            var loc1:*=Number.MAX_VALUE;
            var loc2:*=-Number.MAX_VALUE;
            var loc3:*=Number.MAX_VALUE;
            var loc4:*=-Number.MAX_VALUE;
            var loc5:*=getPositions(arg1, sPositions);
            var loc6:*=0;
            while (loc6 < 4) 
            {
                loc7 = loc5[loc6];
                if (arg2) 
                {
                    starling.utils.MatrixUtil.transformCoords3D(arg2, loc7.x, loc7.y, 0, sPoint3D);
                }
                else 
                {
                    sPoint3D.setTo(loc7.x, loc7.y, 0);
                }
                starling.utils.MathUtil.intersectLineWithXYPlane(arg3, sPoint3D, sPoint);
                if (loc1 > sPoint.x) 
                {
                    loc1 = sPoint.x;
                }
                if (loc2 < sPoint.x) 
                {
                    loc2 = sPoint.x;
                }
                if (loc3 > sPoint.y) 
                {
                    loc3 = sPoint.y;
                }
                if (loc4 < sPoint.y) 
                {
                    loc4 = sPoint.y;
                }
                ++loc6;
            }
            arg4.setTo(loc1, loc3, loc2 - loc1, loc4 - loc3);
            return arg4;
        }

        public static function getPositions(arg1:flash.geom.Rectangle, arg2:__AS3__.vec.Vector.<flash.geom.Point>=null):__AS3__.vec.Vector.<flash.geom.Point>
        {
            if (arg2 == null) 
            {
                arg2 = new Vector.<flash.geom.Point>(4, true);
            }
            var loc1:*=0;
            while (loc1 < 4) 
            {
                if (arg2[loc1] == null) 
                {
                    arg2[loc1] = new flash.geom.Point();
                }
                ++loc1;
            }
            arg2[0].x = arg1.left;
            arg2[0].y = arg1.top;
            arg2[1].x = arg1.right;
            arg2[1].y = arg1.top;
            arg2[2].x = arg1.left;
            arg2[2].y = arg1.bottom;
            arg2[3].x = arg1.right;
            arg2[3].y = arg1.bottom;
            return arg2;
        }

        public static function compare(arg1:flash.geom.Rectangle, arg2:flash.geom.Rectangle, arg3:Number=0.0001):Boolean
        {
            if (arg1 == null) 
            {
                return arg2 == null;
            }
            if (arg2 == null) 
            {
                return false;
            }
            return arg1.x > arg2.x - arg3 && arg1.x < arg2.x + arg3 && arg1.y > arg2.y - arg3 && arg1.y < arg2.y + arg3 && arg1.width > arg2.width - arg3 && arg1.width < arg2.width + arg3 && arg1.height > arg2.height - arg3 && arg1.height < arg2.height + arg3;
        }

        
        {
            new Vector.<flash.geom.Point>(4)[0] = new flash.geom.Point();
            new Vector.<flash.geom.Point>(4)[1] = new flash.geom.Point();
            new Vector.<flash.geom.Point>(4)[2] = new flash.geom.Point();
            new Vector.<flash.geom.Point>(4)[3] = new flash.geom.Point();
        }

        internal static const sPoint:flash.geom.Point=new flash.geom.Point();

        internal static const sPoint3D:flash.geom.Vector3D=new flash.geom.Vector3D();

        internal static const sPositions:__AS3__.vec.Vector.<flash.geom.Point>=new Vector.<flash.geom.Point>(4);
    }
}


//  class RenderUtil
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


//  class ScaleMode
package starling.utils 
{
    import starling.errors.*;
    
    public class ScaleMode extends Object
    {
        public function ScaleMode()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function isValid(arg1:String):Boolean
        {
            return arg1 == NONE || arg1 == NO_BORDER || arg1 == SHOW_ALL;
        }

        public static const NONE:String="none";

        public static const NO_BORDER:String="noBorder";

        public static const SHOW_ALL:String="showAll";
    }
}


//  class StringUtil
package starling.utils 
{
    import starling.errors.*;
    
    public class StringUtil extends Object
    {
        public function StringUtil()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function format(arg1:String, ... rest):String
        {
            var loc1:*=0;
            while (loc1 < rest.length) 
            {
                arg1 = arg1.replace(new RegExp("\\{" + loc1 + "\\}", "g"), rest[loc1]);
                ++loc1;
            }
            return arg1;
        }

        public static function clean(arg1:String):String
        {
            return ("_" + arg1).substr(1);
        }

        public static function trimStart(arg1:String):String
        {
            var loc1:*=0;
            var loc2:*=arg1.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                if (arg1.charCodeAt(loc1) > 32) 
                {
                    break;
                }
                ++loc1;
            }
            return arg1.substring(loc1, loc2);
        }

        public static function trimEnd(arg1:String):String
        {
            var loc1:*=(arg1.length - 1);
            while (loc1 >= 0) 
            {
                if (arg1.charCodeAt(loc1) > 32) 
                {
                    break;
                }
                --loc1;
            }
            return arg1.substring(0, loc1 + 1);
        }

        public static function trim(arg1:String):String
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=arg1.length;
            loc1 = 0;
            while (loc1 < loc3) 
            {
                if (arg1.charCodeAt(loc1) > 32) 
                {
                    break;
                }
                ++loc1;
            }
            loc2 = (arg1.length - 1);
            while (loc2 >= loc1) 
            {
                if (arg1.charCodeAt(loc2) > 32) 
                {
                    break;
                }
                --loc2;
            }
            return arg1.substring(loc1, loc2 + 1);
        }
    }
}


//  class SystemUtil
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


//  function execute
package starling.utils 
{
    public function execute(arg1:Function, ... rest):void
    {
        var loc1:*=0;
        var loc2:*=0;
        if (arg1 != null) 
        {
            loc2 = arg1.length;
            loc1 = rest.length;
            while (loc1 < loc2) 
            {
                rest[loc1] = null;
                ++loc1;
            }
            var loc3:*=loc2;
            switch (loc3) 
            {
                case 0:
                {
                    arg1();
                    break;
                }
                case 1:
                {
                    arg1(rest[0]);
                    break;
                }
                case 2:
                {
                    arg1(rest[0], rest[1]);
                    break;
                }
                case 3:
                {
                    arg1(rest[0], rest[1], rest[2]);
                    break;
                }
                case 4:
                {
                    arg1(rest[0], rest[1], rest[2], rest[3]);
                    break;
                }
                case 5:
                {
                    arg1(rest[0], rest[1], rest[2], rest[3], rest[4]);
                    break;
                }
                case 6:
                {
                    arg1(rest[0], rest[1], rest[2], rest[3], rest[4], rest[5]);
                    break;
                }
                case 7:
                {
                    arg1(rest[0], rest[1], rest[2], rest[3], rest[4], rest[5], rest[6]);
                    break;
                }
                default:
                {
                    arg1.apply(null, rest.slice(0, loc2));
                    break;
                }
            }
        }
        return;
    }
}


