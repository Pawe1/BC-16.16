//class LoggerFactory
package org.as3commons.logging.api 
{
    public class LoggerFactory extends Object
    {
        public function LoggerFactory(arg1:org.as3commons.logging.api.ILogSetup=null)
        {
            super();
            this.setup = arg1;
            return;
        }

        public function get setup():org.as3commons.logging.api.ILogSetup
        {
            return this._setup;
        }

        public function set setup(arg1:org.as3commons.logging.api.ILogSetup):void
        {
            var loc2:*=0;
            this._setup = arg1;
            var loc1:*=this._allLoggers.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                org.as3commons.logging.api.Logger(this._allLoggers[loc2]).allTargets = null;
                ++loc2;
            }
            if (arg1) 
            {
                loc2 = 0;
                this._duringSetup = true;
                while (loc2 < loc1) 
                {
                    while (loc2 < loc1) 
                    {
                        arg1.applyTo(org.as3commons.logging.api.Logger(this._allLoggers[loc2]));
                        ++loc2;
                    }
                    loc1 = this._allLoggers.length;
                }
                this._duringSetup = false;
            }
            return;
        }

        public function getNamedLogger(arg1:String=null, arg2:String=null):org.as3commons.logging.api.ILogger
        {
            arg1 = arg1 || "";
            var loc3:*;
            this._loggers[arg1] = loc3 = this._loggers[arg1] || {};
            var loc1:*=loc3;
            var loc2:*=loc1[arg2];
            if (!loc2) 
            {
                loc2 = new org.as3commons.logging.api.Logger(arg1, arg2);
                loc1[arg2] = loc2;
                this._allLoggers[this._allLoggers.length] = loc2;
                if (this._setup && !this._duringSetup) 
                {
                    this._setup.applyTo(loc2);
                }
            }
            return loc2;
        }

        internal const _allLoggers:Array=[];

        internal const _loggers:Object={};

        internal var _setup:org.as3commons.logging.api.ILogSetup;

        internal var _duringSetup:Boolean;
    }
}


