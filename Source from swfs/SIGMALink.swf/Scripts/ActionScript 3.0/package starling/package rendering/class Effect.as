//class Effect
package starling.rendering 
{
    import flash.display3D.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.errors.*;
    import starling.utils.*;
    
    public class Effect extends Object
    {
        public function Effect()
        {
            super();
            this._mvpMatrix3D = new flash.geom.Matrix3D();
            this._programBaseName = flash.utils.getQualifiedClassName(this);
            starling.core.Starling.current.stage3D.addEventListener(flash.events.Event.CONTEXT3D_CREATE, this.onContextCreated, false, 20, true);
            return;
        }

        public function get vertexFormat():starling.rendering.VertexDataFormat
        {
            return VERTEX_FORMAT;
        }

        public function get mvpMatrix3D():flash.geom.Matrix3D
        {
            return this._mvpMatrix3D;
        }

        public function set mvpMatrix3D(arg1:flash.geom.Matrix3D):void
        {
            this._mvpMatrix3D.copyFrom(arg1);
            return;
        }

        protected function get indexBuffer():flash.display3D.IndexBuffer3D
        {
            return this._indexBuffer;
        }

        protected function get indexBufferSize():int
        {
            return this._indexBufferSize;
        }

        protected function get vertexBuffer():flash.display3D.VertexBuffer3D
        {
            return this._vertexBuffer;
        }

        protected function get vertexBufferSize():int
        {
            return this._vertexBufferSize;
        }

        
        {
            sProgramNameCache = new flash.utils.Dictionary();
        }

        public function dispose():void
        {
            starling.core.Starling.current.stage3D.removeEventListener(flash.events.Event.CONTEXT3D_CREATE, this.onContextCreated);
            this.purgeBuffers();
            return;
        }

        internal function onContextCreated(arg1:flash.events.Event):void
        {
            this.purgeBuffers();
            starling.utils.execute(this._onRestore, this);
            return;
        }

        public function purgeBuffers(arg1:Boolean=true, arg2:Boolean=true):void
        {
            if (this._vertexBuffer && arg1) 
            {
                try 
                {
                    this._vertexBuffer.dispose();
                }
                catch (e:Error)
                {
                };
                this._vertexBuffer = null;
            }
            if (this._indexBuffer && arg2) 
            {
                try 
                {
                    this._indexBuffer.dispose();
                }
                catch (e:Error)
                {
                };
                this._indexBuffer = null;
            }
            return;
        }

        public function uploadIndexData(arg1:starling.rendering.IndexData, arg2:String="staticDraw"):void
        {
            var loc1:*=arg1.numIndices;
            var loc2:*=arg1.useQuadLayout;
            var loc3:*=this._indexBufferUsesQuadLayout;
            if (this._indexBuffer) 
            {
                if (loc1 <= this._indexBufferSize) 
                {
                    if (!loc2 || !loc3) 
                    {
                        arg1.uploadToIndexBuffer(this._indexBuffer);
                        this._indexBufferUsesQuadLayout = loc2 && loc1 == this._indexBufferSize;
                    }
                }
                else 
                {
                    this.purgeBuffers(false, true);
                }
            }
            if (this._indexBuffer == null) 
            {
                this._indexBuffer = arg1.createIndexBuffer(true, arg2);
                this._indexBufferSize = loc1;
                this._indexBufferUsesQuadLayout = loc2;
            }
            return;
        }

        public function uploadVertexData(arg1:starling.rendering.VertexData, arg2:String="staticDraw"):void
        {
            if (this._vertexBuffer) 
            {
                if (arg1.size <= this._vertexBufferSize) 
                {
                    arg1.uploadToVertexBuffer(this._vertexBuffer);
                }
                else 
                {
                    this.purgeBuffers(true, false);
                }
            }
            if (this._vertexBuffer == null) 
            {
                this._vertexBuffer = arg1.createVertexBuffer(true, arg2);
                this._vertexBufferSize = arg1.size;
            }
            return;
        }

        public function render(arg1:int=0, arg2:int=-1):void
        {
            if (arg2 < 0) 
            {
                arg2 = this._indexBufferSize / 3;
            }
            if (arg2 == 0) 
            {
                return;
            }
            var loc1:*=starling.core.Starling.context;
            if (loc1 == null) 
            {
                throw new starling.errors.MissingContextError();
            }
            this.beforeDraw(loc1);
            loc1.drawTriangles(this.indexBuffer, arg1, arg2);
            this.afterDraw(loc1);
            return;
        }

        protected function beforeDraw(arg1:flash.display3D.Context3D):void
        {
            this.program.activate(arg1);
            this.vertexFormat.setVertexBufferAt(0, this.vertexBuffer, "position");
            arg1.setProgramConstantsFromMatrix(flash.display3D.Context3DProgramType.VERTEX, 0, this.mvpMatrix3D, true);
            return;
        }

        protected function afterDraw(arg1:flash.display3D.Context3D):void
        {
            arg1.setVertexBufferAt(0, null);
            return;
        }

        protected function createProgram():starling.rendering.Program
        {
            var loc1:*=["m44 op, va0, vc0", "seq v0, va0, va0"].join("\n");
            var loc2:*="mov oc, v0";
            return starling.rendering.Program.fromSource(loc1, loc2);
        }

        protected function get programVariantName():uint
        {
            return 0;
        }

        protected function get programBaseName():String
        {
            return this._programBaseName;
        }

        protected function set programBaseName(arg1:String):void
        {
            this._programBaseName = arg1;
            return;
        }

        protected function get programName():String
        {
            var loc1:*=this.programBaseName;
            var loc2:*=this.programVariantName;
            var loc3:*=sProgramNameCache[loc1];
            if (loc3 == null) 
            {
                loc3 = new flash.utils.Dictionary();
                sProgramNameCache[loc1] = loc3;
            }
            var loc4:*=loc3[loc2];
            if (loc4 == null) 
            {
                if (loc2) 
                {
                    loc4 = loc1 + "#" + loc2.toString(16);
                }
                else 
                {
                    loc4 = loc1;
                }
                loc3[loc2] = loc4;
            }
            return loc4;
        }

        protected function get program():starling.rendering.Program
        {
            var loc1:*=this.programName;
            var loc2:*=starling.core.Starling.painter;
            var loc3:*=loc2.getProgram(loc1);
            if (loc3 == null) 
            {
                loc3 = this.createProgram();
                loc2.registerProgram(loc1, loc3);
            }
            return loc3;
        }

        public function get onRestore():Function
        {
            return this._onRestore;
        }

        public function set onRestore(arg1:Function):void
        {
            this._onRestore = arg1;
            return;
        }

        public static const VERTEX_FORMAT:starling.rendering.VertexDataFormat=starling.rendering.VertexDataFormat.fromString("position:float2");

        internal var _vertexBuffer:flash.display3D.VertexBuffer3D;

        internal var _vertexBufferSize:int;

        internal var _indexBuffer:flash.display3D.IndexBuffer3D;

        internal var _indexBufferSize:int;

        internal var _indexBufferUsesQuadLayout:Boolean;

        internal var _mvpMatrix3D:flash.geom.Matrix3D;

        internal var _onRestore:Function;

        internal var _programBaseName:String;

        internal static var sProgramNameCache:flash.utils.Dictionary;
    }
}


