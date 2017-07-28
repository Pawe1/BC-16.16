//class Program
package starling.rendering 
{
    import com.adobe.utils.*;
    import flash.display3D.*;
    import flash.events.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.errors.*;
    
    public class Program extends Object
    {
        public function Program(arg1:flash.utils.ByteArray, arg2:flash.utils.ByteArray)
        {
            super();
            this._vertexShader = arg1;
            this._fragmentShader = arg2;
            starling.core.Starling.current.stage3D.addEventListener(flash.events.Event.CONTEXT3D_CREATE, this.onContextCreated, false, 30, true);
            return;
        }

        public function dispose():void
        {
            starling.core.Starling.current.stage3D.removeEventListener(flash.events.Event.CONTEXT3D_CREATE, this.onContextCreated);
            this.disposeProgram();
            return;
        }

        public function activate(arg1:flash.display3D.Context3D=null):void
        {
            if (arg1 == null) 
            {
                arg1 = starling.core.Starling.context;
                if (arg1 == null) 
                {
                    throw new starling.errors.MissingContextError();
                }
            }
            if (this._program3D == null) 
            {
                this._program3D = arg1.createProgram();
                this._program3D.upload(this._vertexShader, this._fragmentShader);
            }
            arg1.setProgram(this._program3D);
            return;
        }

        internal function onContextCreated(arg1:flash.events.Event):void
        {
            this.disposeProgram();
            return;
        }

        internal function disposeProgram():void
        {
            if (this._program3D) 
            {
                this._program3D.dispose();
                this._program3D = null;
            }
            return;
        }

        public static function fromSource(arg1:String, arg2:String, arg3:uint=1):starling.rendering.Program
        {
            return new Program(sAssembler.assemble(flash.display3D.Context3DProgramType.VERTEX, arg1, arg3), sAssembler.assemble(flash.display3D.Context3DProgramType.FRAGMENT, arg2, arg3));
        }

        
        {
            sAssembler = new com.adobe.utils.AGALMiniAssembler();
        }

        internal var _vertexShader:flash.utils.ByteArray;

        internal var _fragmentShader:flash.utils.ByteArray;

        internal var _program3D:flash.display3D.Program3D;

        internal static var sAssembler:com.adobe.utils.AGALMiniAssembler;
    }
}


