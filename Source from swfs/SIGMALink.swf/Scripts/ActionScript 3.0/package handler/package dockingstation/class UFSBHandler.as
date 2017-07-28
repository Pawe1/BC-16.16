//class UFSBHandler
package handler.dockingstation 
{
    import com.logging.*;
    import core.units.*;
    import flash.events.*;
    import flash.utils.*;
    import service.*;
    import service.usb.event.*;
    
    public class UFSBHandler extends handler.dockingstation.DockingStationHandler
    {
        public function UFSBHandler(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public override function loadFromDC(arg1:String):void
        {
            if (service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy) 
            {
                service.DeviceCommunicationHandler.getInstance().addToCommandQueue(arg1, "loadCommand", this);
                return;
            }
            service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
            if (arg1 != 115.toString()) 
            {
                if (arg1 != 101.toString()) 
                {
                    if (arg1 != 118.toString()) 
                    {
                        if (arg1 == 69.toString()) 
                        {
                            currentCommand = 69;
                            currentBytesToReceive = 1;
                        }
                    }
                    else 
                    {
                        currentCommand = 118;
                        currentBytesToReceive = 1;
                    }
                }
                else 
                {
                    currentCommand = 101;
                    currentBytesToReceive = 1;
                }
            }
            else 
            {
                currentCommand = 115;
                currentBytesToReceive = 1;
            }
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
            return;
        }

        protected function generateNativeProzessBuffer(arg1:uint, arg2:Array=null):flash.utils.ByteArray
        {
            var loc1:*=0;
            var loc2:*;
            (loc2 = new flash.utils.ByteArray()).writeByte(arg1);
            if (arg2 != null) 
            {
                loc1 = 0;
                while (loc1 < arg2.length) 
                {
                    loc2.writeByte(arg2[loc1]);
                    ++loc1;
                }
            }
            return loc2;
        }

        internal function onLoaded(arg1:service.usb.event.DeviceDataCompleteEvent):void
        {
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded);
            if (arg1.command != 115.toString()) 
            {
                if (arg1.command != 101.toString()) 
                {
                    if (arg1.command != 118.toString()) 
                    {
                        if (arg1.command != 69.toString()) 
                        {
                            if (arg1.command == 58.toString()) 
                            {
                                if (arg1.data[0] != 89) 
                                {
                                    service.DeviceCommunicationHandler.getInstance().dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 0, "SEND_A_LINE"));
                                }
                                else 
                                {
                                    service.DeviceCommunicationHandler.getInstance().dispatchEvent(new flash.events.Event("dc.units.handler.UFSBHandler.sendALineEvent"));
                                }
                            }
                        }
                        else if (arg1.data[0] != 89) 
                        {
                            service.DeviceCommunicationHandler.getInstance().dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 0, "END_PROG_AND_RUN"));
                        }
                        else 
                        {
                            service.DeviceCommunicationHandler.getInstance().dispatchEvent(new flash.events.Event("dc.units.handler.UFSBHandler.endProgAndRunEvent"));
                        }
                    }
                    else if (arg1.data[0] != 89) 
                    {
                        service.DeviceCommunicationHandler.getInstance().dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 0, "START_VERIFICATION"));
                    }
                    else 
                    {
                        service.DeviceCommunicationHandler.getInstance().dispatchEvent(new flash.events.Event("dc.units.handler.UFSBHandler.startVerificationEvent"));
                    }
                }
                else if (arg1.data[0] != 89) 
                {
                    service.DeviceCommunicationHandler.getInstance().dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 0, "ERASE_FLASH_ROM_SUCCESS"));
                }
                else 
                {
                    service.DeviceCommunicationHandler.getInstance().dispatchEvent(new flash.events.Event("dc.units.handler.UFSBHandler.eraseFlashRomEvent"));
                }
            }
            else if (arg1.data[0] != 89) 
            {
                service.DeviceCommunicationHandler.getInstance().dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 0, "START_PROGRAM"));
            }
            else 
            {
                service.DeviceCommunicationHandler.getInstance().dispatchEvent(new flash.events.Event("dc.units.handler.UFSBHandler.startProgramEvent"));
            }
            service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
            return;
        }

        public override function sendToDC(arg1:String):void
        {
            var loc3:*=null;
            var loc2:*=0;
            var loc1:*=null;
            if (service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy) 
            {
                service.DeviceCommunicationHandler.getInstance().addToCommandQueue(arg1, "sendCommand", this);
                return;
            }
            service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
            if (arg1.length == 43) 
            {
                currentCommand = 58;
                currentBytesToReceive = 1;
                loc1 = new flash.utils.ByteArray();
                loc1.writeUTFBytes(arg1);
                service.DeviceCommunicationHandler.getInstance().sendToDevice(loc1, this);
            }
            return;
        }

        public static const CHECKSUM_ERROR:uint=78;

        public static const END_PROG_AND_RUN:uint=69;

        public static const END_PROG_AND_RUN_BYTES_TO_RECEIVE:uint=1;

        public static const END_PROG_AND_RUN_EVENT:String="dc.units.handler.UFSBHandler.endProgAndRunEvent";

        public static const END_PROG_AND_RUN_SUCCESS:uint=89;

        public static const ERASE_FLASH_ROM:uint=101;

        public static const ERASE_FLASH_ROM_BYTES_TO_RECEIVE:uint=1;

        public static const ERASE_FLASH_ROM_EVENT:String="dc.units.handler.UFSBHandler.eraseFlashRomEvent";

        public static const ERASE_FLASH_ROM_SUCCESS:uint=89;

        public static const LOAD_CHECKSUMM_BYTES_TO_RECEIVE:uint=4;

        public static const LOAD_INITIALINFORMATION_BYTES_TO_RECEIVE:uint=8;

        public static const SEND_A_LINE:uint=58;

        public static const SEND_A_LINE_BYTES_TO_RECEIVE:uint=1;

        public static const SEND_A_LINE_EVENT:String="dc.units.handler.UFSBHandler.sendALineEvent";

        public static const SEND_A_LINE_LENGTH:int=43;

        public static const SEND_A_LINE_SUCCESS:uint=89;

        public static const START_PROGRAM:uint=115;

        public static const START_PROGRAM_BYTES_TO_RECEIVE:uint=1;

        public static const START_PROGRAM_EVENT:String="dc.units.handler.UFSBHandler.startProgramEvent";

        public static const START_PROGRAM_SUCCESS:uint=89;

        public static const START_VERIFICATION:uint=118;

        public static const START_VERIFICATION_BYTES_TO_RECEIVE:uint=1;

        public static const START_VERIFICATION_EVENT:String="dc.units.handler.UFSBHandler.startVerificationEvent";

        public static const START_VERIFICATION_SUCCESS:uint=89;

        internal var unit:core.units.Unit;
    }
}


