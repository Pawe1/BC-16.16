//class AssetManager
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


