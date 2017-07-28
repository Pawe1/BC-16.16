//class LevelTargetSetup
package org.as3commons.logging.setup 
{
    import org.as3commons.logging.api.*;
    
    public class LevelTargetSetup extends Object implements org.as3commons.logging.api.ILogSetup
    {
        public function LevelTargetSetup(arg1:org.as3commons.logging.setup.ILogTarget, arg2:org.as3commons.logging.setup.LogSetupLevel)
        {
            super();
            this._target = arg1;
            this._level = arg2;
            return;
        }

        public function applyTo(arg1:org.as3commons.logging.api.Logger):void
        {
            this._level.applyTo(arg1, this._target);
            return;
        }

        internal var _level:org.as3commons.logging.setup.LogSetupLevel;

        internal var _target:org.as3commons.logging.setup.ILogTarget;
    }
}


