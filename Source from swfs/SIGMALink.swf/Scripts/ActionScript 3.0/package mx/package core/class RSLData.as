//class RSLData
package mx.core 
{
    use namespace mx_internal;
    
    public class RSLData extends Object
    {
        public function RSLData(arg1:String=null, arg2:String=null, arg3:String=null, arg4:String=null, arg5:Boolean=false, arg6:Boolean=false, arg7:String="default")
        {
            super();
            this._rslURL = arg1;
            this._policyFileURL = arg2;
            this._digest = arg3;
            this._hashType = arg4;
            this._isSigned = arg5;
            this._verifyDigest = arg6;
            this._applicationDomainTarget = arg7;
            this._moduleFactory = this.moduleFactory;
            return;
        }

        public function get applicationDomainTarget():String
        {
            return this._applicationDomainTarget;
        }

        public function get digest():String
        {
            return this._digest;
        }

        public function get hashType():String
        {
            return this._hashType;
        }

        public function get isSigned():Boolean
        {
            return this._isSigned;
        }

        public function get moduleFactory():mx.core.IFlexModuleFactory
        {
            return this._moduleFactory;
        }

        public function set moduleFactory(arg1:mx.core.IFlexModuleFactory):void
        {
            this._moduleFactory = arg1;
            return;
        }

        public function get policyFileURL():String
        {
            return this._policyFileURL;
        }

        public function get rslURL():String
        {
            return this._rslURL;
        }

        public function get verifyDigest():Boolean
        {
            return this._verifyDigest;
        }

        
        {
            mx_internal::VERSION = "4.14.0.0";
        }

        mx_internal static const VERSION:String="4.14.0.0";

        internal var _applicationDomainTarget:String;

        internal var _digest:String;

        internal var _hashType:String;

        internal var _isSigned:Boolean;

        internal var _moduleFactory:mx.core.IFlexModuleFactory;

        internal var _policyFileURL:String;

        internal var _rslURL:String;

        internal var _verifyDigest:Boolean;
    }
}


