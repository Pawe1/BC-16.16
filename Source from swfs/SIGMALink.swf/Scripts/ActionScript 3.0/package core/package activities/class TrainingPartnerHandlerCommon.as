//class TrainingPartnerHandlerCommon
package core.activities 
{
    import __AS3__.vec.*;
    import flash.events.*;
    
    public class TrainingPartnerHandlerCommon extends flash.events.EventDispatcher
    {
        public function TrainingPartnerHandlerCommon(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function validatePersons(arg1:__AS3__.vec.Vector.<core.participant.Person>):void
        {
            return;
        }

        public static function getInstance():core.activities.TrainingPartnerHandlerCommon
        {
            return _instance;
        }

        public static function setInstance(arg1:core.activities.TrainingPartnerHandlerCommon):void
        {
            _instance = arg1;
            return;
        }

        internal static var _instance:core.activities.TrainingPartnerHandlerCommon;
    }
}


