//class HandlerFactory
package handler 
{
    import com.logging.*;
    import core.general.*;
    import core.units.*;
    import flash.utils.*;
    import handler.dockingstation.*;
    
    public class HandlerFactory extends Object
    {
        public function HandlerFactory()
        {
            super();
            return;
        }

        public static function getImplementationFromDS(arg1:String):handler.dockingstation.DockingStationHandler
        {
            var loc1:*=null;
            if (handlers[arg1] != null) 
            {
                return handlers[arg1];
            }
            if (arg1 != "DS08") 
            {
                if (arg1 != "DS_ROX_2011") 
                {
                    if (arg1 != "DS09") 
                    {
                        if (arg1 != "DS_RC_2011") 
                        {
                            if (arg1 != "DS12") 
                            {
                                if (arg1 != "DS16") 
                                {
                                    if (arg1 != "ROX_10") 
                                    {
                                        if (arg1 != "GPS_10") 
                                        {
                                            if (arg1 != "ROX_11") 
                                            {
                                                if (arg1 != "ROX_7") 
                                                {
                                                    if (arg1 != "DS_BLE") 
                                                    {
                                                        if (arg1 != "DS_BLE_ROX_11") 
                                                        {
                                                            if (arg1 != "DS_NFC") 
                                                            {
                                                                if (arg1 != "UFSB") 
                                                                {
                                                                    loc1 = new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10093, "Not the same Unit", "HandlerFactory");
                                                                    com.logging.ErrorLogging.getInstance().receiveMessageFromStaticFunction(loc1);
                                                                    return null;
                                                                }
                                                                else 
                                                                {
                                                                    handlers[arg1] = new handler.dockingstation.UFSBHandler();
                                                                }
                                                            }
                                                            else 
                                                            {
                                                                handlers[arg1] = new handler.dockingstation.NFCDSHandler();
                                                            }
                                                        }
                                                        else 
                                                        {
                                                            handlers[arg1] = new handler.dockingstation.BLERox11DSHandler();
                                                        }
                                                    }
                                                    else 
                                                    {
                                                        handlers[arg1] = new handler.dockingstation.BLEDSHandler();
                                                    }
                                                }
                                                else 
                                                {
                                                    handlers[arg1] = new handler.dockingstation.Rox70DSHandler();
                                                }
                                            }
                                            else 
                                            {
                                                handlers[arg1] = new handler.dockingstation.Rox110DSHandler();
                                            }
                                        }
                                        else 
                                        {
                                            handlers[arg1] = new handler.dockingstation.Gps10DSHandler();
                                        }
                                    }
                                    else 
                                    {
                                        handlers[arg1] = new handler.dockingstation.Rox100DSHandler();
                                    }
                                }
                                else 
                                {
                                    handlers[arg1] = new handler.dockingstation.Topline2016DSHandler();
                                }
                            }
                            else 
                            {
                                handlers[arg1] = new handler.dockingstation.Topline2012DSHandler();
                            }
                        }
                        else 
                        {
                            handlers[arg1] = new handler.dockingstation.RCDS2011Handler();
                        }
                    }
                    else 
                    {
                        handlers[arg1] = new handler.dockingstation.Topline2009DSHandler();
                    }
                }
                else 
                {
                    handlers[arg1] = new handler.dockingstation.RoxDS2010Handler();
                }
            }
            else 
            {
                handlers[arg1] = new handler.dockingstation.RoxDS2008Handler();
            }
            return handlers[arg1];
        }

        public static function getImplementation(arg1:core.units.Unit):handler.UnitHandler
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=arg1.type.toString();
            while (core.general.UnitType.ROX80.toString() === loc3) 
            {
                if (handlers[arg1] == null) 
                {
                    loc1 = new handler.RoxHandler();
                    loc1.unit = arg1;
                    handlers[arg1] = loc1;
                }
                else 
                {
                    loc1 = handlers[arg1];
                }
                return loc1;
            }
        }

        public static function changeUnit(arg1:core.units.Unit, arg2:core.units.Unit):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (handlers[arg1] != null) 
            {
                if (arg2.type.toString() != arg1.type.toString()) 
                {
                    loc2 = new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10092, "Not the same Unit", "HandlerFactory");
                    com.logging.ErrorLogging.getInstance().receiveMessageFromStaticFunction(loc2);
                }
                else 
                {
                    loc1 = handlers[arg1];
                    loc1.unit = arg2;
                    delete handlers[arg1];
                    handlers[arg2] = loc1;
                }
            }
            return;
        }

        public static function deleteUnitHandler(arg1:core.units.Unit):void
        {
            if (handlers[arg1] != null) 
            {
                (handlers[arg1] as handler.UnitHandler).destructor();
                delete handlers[arg1];
            }
            return;
        }

        
        {
            handlers = new flash.utils.Dictionary();
        }

        public static var handlers:flash.utils.Dictionary;
    }
}


