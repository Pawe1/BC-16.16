//class Painter
package starling.rendering 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.display3D.*;
    import flash.display3D.textures.*;
    import flash.errors.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace starling_internal;
    
    public class Painter extends Object
    {
        public function Painter(arg1:flash.display.Stage3D)
        {
            super();
            this._stage3D = arg1;
            this._stage3D.addEventListener(starling.events.Event.CONTEXT3D_CREATE, this.onContextCreated, false, 40, true);
            this._context = this._stage3D.context3D;
            this._shareContext = this._context && !(this._context.driverInfo == "Disposed");
            this._backBufferWidth = this._context ? this._context.backBufferWidth : 0;
            this._backBufferHeight = this._context ? this._context.backBufferHeight : 0;
            var loc1:*;
            this._pixelSize = loc1 = 1;
            this._backBufferScaleFactor = loc1;
            this._stencilReferenceValues = new flash.utils.Dictionary(true);
            this._clipRectStack = new Vector.<flash.geom.Rectangle>(0);
            this._batchProcessorCurr = new BatchProcessor();
            this._batchProcessorCurr.onBatchComplete = this.drawBatch;
            this._batchProcessorPrev = new BatchProcessor();
            this._batchProcessorPrev.onBatchComplete = this.drawBatch;
            this._batchProcessorSpec = new BatchProcessor();
            this._batchProcessorSpec.onBatchComplete = this.drawBatch;
            this._batchProcessor = this._batchProcessorCurr;
            this._batchCacheExclusions = new Vector.<starling.display.DisplayObject>();
            this._state = new starling.rendering.RenderState();
            this._state.onDrawRequired = this.finishMeshBatch;
            this._stateStack = new Vector.<starling.rendering.RenderState>(0);
            this._stateStackPos = -1;
            this._stateStackLength = 0;
            return;
        }

        public function set drawCount(arg1:int):void
        {
            this._drawCount = arg1;
            return;
        }

        public function get stencilReferenceValue():uint
        {
            var loc1:*=this._state.renderTarget ? this._state.renderTargetBase : this;
            if (loc1 in this._stencilReferenceValues) 
            {
                return this._stencilReferenceValues[loc1];
            }
            return 0;
        }

        public function set stencilReferenceValue(arg1:uint):void
        {
            var loc1:*=this._state.renderTarget ? this._state.renderTargetBase : this;
            this._stencilReferenceValues[loc1] = arg1;
            if (this.contextValid) 
            {
                this._context.setStencilReferenceValue(arg1);
            }
            return;
        }

        public function get cacheEnabled():Boolean
        {
            return this._batchProcessor == this._batchProcessorCurr;
        }

        public function set cacheEnabled(arg1:Boolean):void
        {
            if (arg1 != this.cacheEnabled) 
            {
                this.finishMeshBatch();
                if (arg1) 
                {
                    this._batchProcessor = this._batchProcessorCurr;
                }
                else 
                {
                    this._batchProcessor = this._batchProcessorSpec;
                }
            }
            return;
        }

        public function get state():starling.rendering.RenderState
        {
            return this._state;
        }

        public function get stage3D():flash.display.Stage3D
        {
            return this._stage3D;
        }

        public function get context():flash.display3D.Context3D
        {
            return this._context;
        }

        public function set frameID(arg1:uint):void
        {
            this._frameID = arg1;
            return;
        }

        public function get frameID():uint
        {
            return this._batchProcessor != this._batchProcessorCurr ? 0 : this._frameID;
        }

        public function nextFrame():void
        {
            this._batchProcessor = this.swapBatchProcessors();
            this._batchProcessor.clear();
            this._batchProcessorSpec.clear();
            this._actualBlendMode = null;
            this._actualCulling = null;
            this._context.setDepthTest(false, flash.display3D.Context3DCompareMode.ALWAYS);
            this.stencilReferenceValue = 0;
            this._clipRectStack.length = 0;
            this._drawCount = 0;
            this._stateStackPos = -1;
            this._state.reset();
            return;
        }

        public function get pixelSize():Number
        {
            return this._pixelSize;
        }

        public function set pixelSize(arg1:Number):void
        {
            this._pixelSize = arg1;
            return;
        }

        public function get shareContext():Boolean
        {
            return this._shareContext;
        }

        public function set shareContext(arg1:Boolean):void
        {
            this._shareContext = arg1;
            return;
        }

        public function get enableErrorChecking():Boolean
        {
            return this._enableErrorChecking;
        }

        public function set enableErrorChecking(arg1:Boolean):void
        {
            this._enableErrorChecking = arg1;
            if (this._context) 
            {
                this._context.enableErrorChecking = arg1;
            }
            return;
        }

        public function get backBufferWidth():int
        {
            return this._backBufferWidth;
        }

        public function get backBufferHeight():int
        {
            return this._backBufferHeight;
        }

        public function get backBufferScaleFactor():Number
        {
            return this._backBufferScaleFactor;
        }

        public function get contextValid():Boolean
        {
            var loc1:*=null;
            if (this._context) 
            {
                loc1 = this._context.driverInfo;
                return !(loc1 == null) && !(loc1 == "") && !(loc1 == "Disposed");
            }
            return false;
        }

        public function get profile():String
        {
            if (this._context) 
            {
                return this._context.profile;
            }
            return null;
        }

        internal function get programs():flash.utils.Dictionary
        {
            var loc1:*=this.sharedData[PROGRAM_DATA_NAME] as flash.utils.Dictionary;
            if (loc1 == null) 
            {
                loc1 = new flash.utils.Dictionary();
                this.sharedData[PROGRAM_DATA_NAME] = loc1;
            }
            return loc1;
        }

        
        {
            sSharedData = new flash.utils.Dictionary();
            sMatrix = new flash.geom.Matrix();
            sPoint3D = new flash.geom.Vector3D();
            sMatrix3D = new flash.geom.Matrix3D();
            sClipRect = new flash.geom.Rectangle();
            sBufferRect = new flash.geom.Rectangle();
            sScissorRect = new flash.geom.Rectangle();
            sMeshSubset = new starling.utils.MeshSubset();
        }

        public function dispose():void
        {
            this._batchProcessorCurr.dispose();
            this._batchProcessorPrev.dispose();
            this._batchProcessorSpec.dispose();
            if (!this._shareContext) 
            {
                this._context.dispose(false);
                sSharedData = new flash.utils.Dictionary();
            }
            return;
        }

        public function requestContext3D(arg1:String, arg2:*):void
        {
            starling.utils.RenderUtil.requestContext3D(this._stage3D, arg1, arg2);
            return;
        }

        internal function onContextCreated(arg1:Object):void
        {
            this._context = this._stage3D.context3D;
            this._context.enableErrorChecking = this._enableErrorChecking;
            this._context.setDepthTest(false, flash.display3D.Context3DCompareMode.ALWAYS);
            this._actualBlendMode = null;
            this._actualCulling = null;
            return;
        }

        public function configureBackBuffer(arg1:flash.geom.Rectangle, arg2:Number, arg3:int, arg4:Boolean):void
        {
            if (!this._shareContext) 
            {
                arg4 = arg4 && starling.utils.SystemUtil.supportsDepthAndStencil;
                if (this._context.profile == "baselineConstrained") 
                {
                    this._context.configureBackBuffer(32, 32, arg3, arg4);
                }
                if (arg1.width * arg2 > this._context.maxBackBufferWidth || arg1.height * arg2 > this._context.maxBackBufferHeight) 
                {
                    arg2 = 1;
                }
                this._stage3D.x = arg1.x;
                this._stage3D.y = arg1.y;
                this._context.configureBackBuffer(arg1.width, arg1.height, arg3, arg4, !(arg2 == 1));
            }
            this._backBufferWidth = arg1.width;
            this._backBufferHeight = arg1.height;
            this._backBufferScaleFactor = arg2;
            return;
        }

        public function registerProgram(arg1:String, arg2:starling.rendering.Program):void
        {
            this.deleteProgram(arg1);
            this.programs[arg1] = arg2;
            return;
        }

        public function deleteProgram(arg1:String):void
        {
            var loc1:*=this.getProgram(arg1);
            if (loc1) 
            {
                loc1.dispose();
                delete this.programs[arg1];
            }
            return;
        }

        public function getProgram(arg1:String):starling.rendering.Program
        {
            return this.programs[arg1] as starling.rendering.Program;
        }

        public function hasProgram(arg1:String):Boolean
        {
            return arg1 in this.programs;
        }

        public function pushState(arg1:starling.rendering.BatchToken=null):void
        {
            var loc1:*;
            var loc2:*=((loc1 = this)._stateStackPos + 1);
            loc1._stateStackPos = loc2;
            if (this._stateStackLength < this._stateStackPos + 1) 
            {
                var loc3:*=((loc2 = this)._stateStackLength + 1);
                loc2._stateStackLength = loc3;
                loc1 = (loc2 = this)._stateStackLength;
                this._stateStack[loc1] = new starling.rendering.RenderState();
            }
            if (arg1) 
            {
                this._batchProcessor.fillToken(arg1);
            }
            this._stateStack[this._stateStackPos].copyFrom(this._state);
            return;
        }

        public function setStateTo(arg1:flash.geom.Matrix, arg2:Number=1, arg3:String="auto"):void
        {
            if (arg1) 
            {
                starling.utils.MatrixUtil.prependMatrix(this._state._modelviewMatrix, arg1);
            }
            if (arg2 != 1) 
            {
                this._state._alpha = this._state._alpha * arg2;
            }
            if (arg3 != starling.display.BlendMode.AUTO) 
            {
                this._state.blendMode = arg3;
            }
            return;
        }

        public function popState(arg1:starling.rendering.BatchToken=null):void
        {
            if (this._stateStackPos < 0) 
            {
                throw new flash.errors.IllegalOperationError("Cannot pop empty state stack");
            }
            this._state.copyFrom(this._stateStack[this._stateStackPos]);
            var loc1:*;
            var loc2:*=((loc1 = this)._stateStackPos - 1);
            loc1._stateStackPos = loc2;
            if (arg1) 
            {
                this._batchProcessor.fillToken(arg1);
            }
            return;
        }

        public function drawMask(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject=null):void
        {
            if (this._context == null) 
            {
                return;
            }
            this.finishMeshBatch();
            if (this.isRectangularMask(arg1, arg2, sMatrix)) 
            {
                arg1.getBounds(arg1, sClipRect);
                starling.utils.RectangleUtil.getBounds(sClipRect, sMatrix, sClipRect);
                this.pushClipRect(sClipRect);
            }
            else 
            {
                this._context.setStencilActions(flash.display3D.Context3DTriangleFace.FRONT_AND_BACK, flash.display3D.Context3DCompareMode.EQUAL, flash.display3D.Context3DStencilAction.INCREMENT_SATURATE);
                this.renderMask(arg1);
                var loc1:*;
                var loc2:*=((loc1 = this).stencilReferenceValue + 1);
                loc1.stencilReferenceValue = loc2;
                this._context.setStencilActions(flash.display3D.Context3DTriangleFace.FRONT_AND_BACK, flash.display3D.Context3DCompareMode.EQUAL, flash.display3D.Context3DStencilAction.KEEP);
            }
            this.excludeFromCache(arg2);
            return;
        }

        public function eraseMask(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject=null):void
        {
            if (this._context == null) 
            {
                return;
            }
            this.finishMeshBatch();
            if (this.isRectangularMask(arg1, arg2, sMatrix)) 
            {
                this.popClipRect();
            }
            else 
            {
                this._context.setStencilActions(flash.display3D.Context3DTriangleFace.FRONT_AND_BACK, flash.display3D.Context3DCompareMode.EQUAL, flash.display3D.Context3DStencilAction.DECREMENT_SATURATE);
                this.renderMask(arg1);
                var loc1:*;
                var loc2:*=((loc1 = this).stencilReferenceValue - 1);
                loc1.stencilReferenceValue = loc2;
                this._context.setStencilActions(flash.display3D.Context3DTriangleFace.FRONT_AND_BACK, flash.display3D.Context3DCompareMode.EQUAL, flash.display3D.Context3DStencilAction.KEEP);
            }
            return;
        }

        internal function renderMask(arg1:starling.display.DisplayObject):void
        {
            var loc1:*=this.cacheEnabled;
            this.pushState();
            this.cacheEnabled = false;
            this._state.alpha = 0;
            var loc2:*=null;
            var loc3:*=null;
            if (arg1.stage) 
            {
                this._state.setModelviewMatricesToIdentity();
                if (arg1.is3D) 
                {
                    loc3 = arg1.getTransformationMatrix3D(null, sMatrix3D);
                }
                else 
                {
                    loc2 = arg1.getTransformationMatrix(null, sMatrix);
                }
            }
            else if (arg1.is3D) 
            {
                loc3 = arg1.transformationMatrix3D;
            }
            else 
            {
                loc2 = arg1.transformationMatrix;
            }
            if (loc3) 
            {
                this._state.transformModelviewMatrix3D(loc3);
            }
            else 
            {
                this._state.transformModelviewMatrix(loc2);
            }
            arg1.render(this);
            this.finishMeshBatch();
            this.cacheEnabled = loc1;
            this.popState();
            return;
        }

        internal function pushClipRect(arg1:flash.geom.Rectangle):void
        {
            var loc1:*=this._clipRectStack;
            var loc2:*=loc1.length;
            var loc3:*=starling.utils.Pool.getRectangle();
            if (loc2) 
            {
                starling.utils.RectangleUtil.intersect(loc1[(loc2 - 1)], arg1, loc3);
            }
            else 
            {
                loc3.copyFrom(arg1);
            }
            loc1[loc2] = loc3;
            this._state.clipRect = loc3;
            return;
        }

        internal function popClipRect():void
        {
            var loc1:*=this._clipRectStack;
            var loc2:*=loc1.length;
            if (loc2 == 0) 
            {
                throw new Error("Trying to pop from empty clip rectangle stack");
            }
            --loc2;
            starling.utils.Pool.putRectangle(loc1.pop());
            this._state.clipRect = loc2 ? loc1[(loc2 - 1)] : null;
            return;
        }

        internal function isRectangularMask(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject, arg3:flash.geom.Matrix):Boolean
        {
            var loc1:*=arg1 as starling.display.Quad;
            var loc2:*=arg1.is3D || arg2 && arg2.is3D && arg1.stage == null;
            if (loc1 && !loc2 && loc1.texture == null) 
            {
                if (arg1.stage) 
                {
                    arg1.getTransformationMatrix(null, arg3);
                }
                else 
                {
                    arg3.copyFrom(arg1.transformationMatrix);
                    arg3.concat(this._state.modelviewMatrix);
                }
                return starling.utils.MathUtil.isEquivalent(arg3.a, 0) && starling.utils.MathUtil.isEquivalent(arg3.d, 0) || starling.utils.MathUtil.isEquivalent(arg3.b, 0) && starling.utils.MathUtil.isEquivalent(arg3.c, 0);
            }
            return false;
        }

        public function batchMesh(arg1:starling.display.Mesh, arg2:starling.utils.MeshSubset=null):void
        {
            this._batchProcessor.addMesh(arg1, this._state, arg2);
            return;
        }

        public function finishMeshBatch():void
        {
            this._batchProcessor.finishBatch();
            return;
        }

        public function finishFrame():void
        {
            if (this._frameID % 99 == 0) 
            {
                this._batchProcessorCurr.trim();
            }
            if (this._frameID % 150 == 0) 
            {
                this._batchProcessorSpec.trim();
            }
            this._batchProcessor.finishBatch();
            this._batchProcessor = this._batchProcessorSpec;
            this.processCacheExclusions();
            return;
        }

        internal function processCacheExclusions():void
        {
            var loc1:*=0;
            var loc2:*=this._batchCacheExclusions.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                this._batchCacheExclusions[loc1].starling_internal::excludeFromCache();
                ++loc1;
            }
            this._batchCacheExclusions.length = 0;
            return;
        }

        public function get sharedData():flash.utils.Dictionary
        {
            var loc1:*=sSharedData[this.stage3D] as flash.utils.Dictionary;
            if (loc1 == null) 
            {
                loc1 = new flash.utils.Dictionary();
                sSharedData[this.stage3D] = loc1;
            }
            return loc1;
        }

        internal function swapBatchProcessors():BatchProcessor
        {
            var loc1:*=this._batchProcessorPrev;
            this._batchProcessorPrev = this._batchProcessorCurr;
            var loc2:*;
            this._batchProcessorCurr = loc2 = loc1;
            return loc2;
        }

        public function drawFromCache(arg1:starling.rendering.BatchToken, arg2:starling.rendering.BatchToken):void
        {
            var loc1:*=null;
            var loc3:*=0;
            var loc2:*=sMeshSubset;
            if (!arg1.equals(arg2)) 
            {
                this.pushState();
                loc3 = arg1.batchID;
                while (loc3 <= arg2.batchID) 
                {
                    loc1 = this._batchProcessorPrev.getBatchAt(loc3);
                    loc2.setTo();
                    if (loc3 == arg1.batchID) 
                    {
                        loc2.vertexID = arg1.vertexID;
                        loc2.indexID = arg1.indexID;
                        loc2.numVertices = loc1.numVertices - loc2.vertexID;
                        loc2.numIndices = loc1.numIndices - loc2.indexID;
                    }
                    if (loc3 == arg2.batchID) 
                    {
                        loc2.numVertices = arg2.vertexID - loc2.vertexID;
                        loc2.numIndices = arg2.indexID - loc2.indexID;
                    }
                    if (loc2.numVertices) 
                    {
                        this._state.alpha = 1;
                        this._state.blendMode = loc1.blendMode;
                        this._batchProcessor.addMesh(loc1, this._state, loc2, true);
                    }
                    ++loc3;
                }
                this.popState();
            }
            return;
        }

        public function excludeFromCache(arg1:starling.display.DisplayObject):void
        {
            if (arg1) 
            {
                this._batchCacheExclusions[this._batchCacheExclusions.length] = arg1;
            }
            return;
        }

        internal function drawBatch(arg1:starling.display.MeshBatch):void
        {
            this.pushState();
            this.state.blendMode = arg1.blendMode;
            this.state.modelviewMatrix.identity();
            this.state.alpha = 1;
            arg1.render(this);
            this.popState();
            return;
        }

        public function prepareToDraw():void
        {
            this.applyBlendMode();
            this.applyRenderTarget();
            this.applyClipRect();
            this.applyCulling();
            return;
        }

        public function clear(arg1:uint=0, arg2:Number=0):void
        {
            this.applyRenderTarget();
            this.stencilReferenceValue = 0;
            starling.utils.RenderUtil.clear(arg1, arg2);
            return;
        }

        public function present():void
        {
            this._state.renderTarget = null;
            this._actualRenderTarget = null;
            this._context.present();
            return;
        }

        internal function applyBlendMode():void
        {
            var loc1:*=this._state.blendMode;
            if (loc1 != this._actualBlendMode) 
            {
                starling.display.BlendMode.get(this._state.blendMode).activate();
                this._actualBlendMode = loc1;
            }
            return;
        }

        internal function applyCulling():void
        {
            var loc1:*=this._state.culling;
            if (loc1 != this._actualCulling) 
            {
                this._context.setCulling(loc1);
                this._actualCulling = loc1;
            }
            return;
        }

        internal function applyRenderTarget():void
        {
            var loc2:*=0;
            var loc3:*=false;
            var loc1:*=this._state.renderTargetBase;
            if (loc1 != this._actualRenderTarget) 
            {
                if (loc1) 
                {
                    loc2 = this._state.renderTargetAntiAlias;
                    loc3 = this._state.renderTargetSupportsDepthAndStencil;
                    this._context.setRenderToTexture(loc1, loc3, loc2);
                }
                else 
                {
                    this._context.setRenderToBackBuffer();
                }
                this._context.setStencilReferenceValue(this.stencilReferenceValue);
                this._actualRenderTarget = loc1;
            }
            return;
        }

        internal function applyClipRect():void
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*=this._state.clipRect;
            if (loc1) 
            {
                loc4 = this._state.projectionMatrix3D;
                loc5 = this._state.renderTarget;
                if (loc5) 
                {
                    loc2 = loc5.root.nativeWidth;
                    loc3 = loc5.root.nativeHeight;
                }
                else 
                {
                    loc2 = this._backBufferWidth;
                    loc3 = this._backBufferHeight;
                }
                starling.utils.MatrixUtil.transformCoords3D(loc4, loc1.x, loc1.y, 0, sPoint3D);
                sPoint3D.project();
                sClipRect.x = (sPoint3D.x * 0.5 + 0.5) * loc2;
                sClipRect.y = (0.5 - sPoint3D.y * 0.5) * loc3;
                starling.utils.MatrixUtil.transformCoords3D(loc4, loc1.right, loc1.bottom, 0, sPoint3D);
                sPoint3D.project();
                sClipRect.right = (sPoint3D.x * 0.5 + 0.5) * loc2;
                sClipRect.bottom = (0.5 - sPoint3D.y * 0.5) * loc3;
                sBufferRect.setTo(0, 0, loc2, loc3);
                starling.utils.RectangleUtil.intersect(sClipRect, sBufferRect, sScissorRect);
                if (sScissorRect.width < 1 || sScissorRect.height < 1) 
                {
                    sScissorRect.setTo(0, 0, 1, 1);
                }
                this._context.setScissorRectangle(sScissorRect);
            }
            else 
            {
                this._context.setScissorRectangle(null);
            }
            return;
        }

        public function get drawCount():int
        {
            return this._drawCount;
        }

        internal static const PROGRAM_DATA_NAME:String="starling.rendering.Painter.Programs";

        internal var _context:flash.display3D.Context3D;

        internal var _shareContext:Boolean;

        internal var _drawCount:int;

        internal var _frameID:uint;

        internal var _pixelSize:Number;

        internal var _enableErrorChecking:Boolean;

        internal var _stencilReferenceValues:flash.utils.Dictionary;

        internal var _clipRectStack:__AS3__.vec.Vector.<flash.geom.Rectangle>;

        internal var _batchCacheExclusions:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        internal var _batchProcessorCurr:BatchProcessor;

        internal var _batchProcessorPrev:BatchProcessor;

        internal var _batchProcessorSpec:BatchProcessor;

        internal var _actualRenderTarget:flash.display3D.textures.TextureBase;

        internal var _actualCulling:String;

        internal var _actualBlendMode:String;

        internal var _backBufferWidth:Number;

        internal var _backBufferHeight:Number;

        internal var _backBufferScaleFactor:Number;

        internal var _state:starling.rendering.RenderState;

        internal var _stateStack:__AS3__.vec.Vector.<starling.rendering.RenderState>;

        internal var _stateStackPos:int;

        internal var _stateStackLength:int;

        internal var _stage3D:flash.display.Stage3D;

        internal static var sSharedData:flash.utils.Dictionary;

        internal static var sMatrix:flash.geom.Matrix;

        internal static var sPoint3D:flash.geom.Vector3D;

        internal static var sMatrix3D:flash.geom.Matrix3D;

        internal static var sClipRect:flash.geom.Rectangle;

        internal static var sBufferRect:flash.geom.Rectangle;

        internal static var sScissorRect:flash.geom.Rectangle;

        internal static var sMeshSubset:starling.utils.MeshSubset;

        internal var _batchProcessor:BatchProcessor;
    }
}


