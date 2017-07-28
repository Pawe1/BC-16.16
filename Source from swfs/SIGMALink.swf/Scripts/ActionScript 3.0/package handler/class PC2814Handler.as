//class PC2814Handler
package handler 
{
    import __AS3__.vec.*;
    import core.activities.*;
    import core.general.*;
    import core.settings.*;
    import core.training.*;
    import core.training.type.*;
    import core.units.*;
    import core.units.interfaces.*;
    import decoder.*;
    import flash.events.*;
    import flash.utils.*;
    import handler.event.*;
    import service.*;
    import service.usb.event.*;
    
    public class PC2814Handler extends handler.UnitHandler
    {
        public function PC2814Handler()
        {
            super();
            return;
        }

        internal function calculateDynamicCommandChecksum(arg1:String):String
        {
            var loc2:*=0;
            var loc3:*=arg1.split(" ");
            var loc1:*=0;
            loc2 = 0;
            while (loc2 <= 5) 
            {
                loc1 = loc1 + parseInt(loc3[loc2], 16);
                ++loc2;
            }
            loc1 = loc1 & 255;
            loc1 = loc1 ^ 255;
            arg1 = arg1 + (" " + loc1.toString(16));
            return arg1.toUpperCase();
        }

        public function set pageHeaderAddrList(arg1:Object):void
        {
            _pageHeaderAddrList = arg1;
            return;
        }

        public override function get unit():core.units.Unit
        {
            return _myUnit;
        }

        public override function set unit(arg1:core.units.Unit):void
        {
            _myUnit = arg1 as core.units.UnitPC2814;
            return;
        }

        internal function forwardProgressEvent(arg1:flash.events.ProgressEvent):void
        {
            dispatchEvent(new handler.event.ProgressStatusEvent("progressbarEvent", arg1.bytesLoaded / arg1.bytesTotal * 100, _currentLoadLog, _currentLoadLogTotal));
            return;
        }

        public override function destructor():void
        {
            super.destructor();
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded);
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
            service.DeviceCommunicationHandler.getInstance().addEventListener("progressReadWriteEvent", forwardProgressEvent, false, 0, false);
            if (arg1 != "loadTotalValues") 
            {
                if (arg1 != "loadUnitSettings") 
                {
                    if (arg1 != "loadUnitlogDataHeader") 
                    {
                        if (arg1 != "loadFreeLoggingTimeInformation") 
                        {
                            if (arg1 != "loadUnitlogData") 
                            {
                                if (arg1 == "loadPrograms") 
                                {
                                    (_myUnit as core.units.interfaces.ITrainingsList).trainingsOnDeviceList = new __AS3__.vec.Vector.<core.training.Training>();
                                    currentCommand = "83 00 00 00 EF 00 8D";
                                    currentBytesToReceive = 240;
                                    currentReceiveChecksumLength = 4;
                                }
                            }
                            else 
                            {
                                if (_currentLoadLogTotal == 0) 
                                {
                                    _currentLoadLogTotal = (unit as core.units.interfaces.IDataToDecode).activitiesToDecode.length;
                                }
                                ++_currentLoadLog;
                                activityToLoad = (unit as core.units.interfaces.IDataToDecode).activitiesToDecode.pop();
                                currentCommand = generateLogCommand(activityToLoad);
                                if (activityToLoad.trainingCategory != core.general.TrainingCategory.FREE) 
                                {
                                    if (activityToLoad.trainingCategory != core.general.TrainingCategory.INTERVAL) 
                                    {
                                        if (activityToLoad.trainingCategory == core.general.TrainingCategory.PROGRAM) 
                                        {
                                            currentBytesToReceive = activityToLoad.stopAdress - activityToLoad.programStartAddress + 1;
                                        }
                                    }
                                    else 
                                    {
                                        currentBytesToReceive = activityToLoad.stopAdress - activityToLoad.programStartAddress + 1;
                                    }
                                }
                                else 
                                {
                                    currentBytesToReceive = activityToLoad.stopAdress - activityToLoad.startAdress + 1;
                                }
                                currentReceiveChecksumLength = 4;
                            }
                        }
                        else 
                        {
                            currentCommand = "83 5A FF 00 15 00 0E";
                            currentBytesToReceive = 22;
                            currentReceiveChecksumLength = 4;
                        }
                    }
                    else if (logCount != -1) 
                    {
                        currentCommand = generatePageHeaderCommand();
                        currentBytesToReceive = logCount * 39;
                        currentReceiveChecksumLength = 4;
                        logCount = -1;
                    }
                    else 
                    {
                        currentCommand = "83 29 FF 00 06 00 4E";
                        currentBytesToReceive = 7;
                        currentReceiveChecksumLength = 4;
                    }
                }
                else 
                {
                    currentCommand = "83 70 FF 00 5E 00 AF";
                    currentBytesToReceive = 95;
                    currentReceiveChecksumLength = 4;
                }
            }
            else 
            {
                currentCommand = "";
                currentBytesToReceive = 0;
                currentReceiveChecksumLength = 4;
            }
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
            return;
        }

        internal function generateLogCommand(arg1:core.activities.Activity):String
        {
            var loc6:*=0;
            var loc1:*="83 60 02 00".split(" ");
            GET_LOG_COMMAND = loc1[0];
            var loc3:*=0;
            var loc5:*="";
            var loc4:*="";
            var loc7:*="";
            var loc2:*=new Array("00", "00", "00");
            if (arg1.trainingCategory != core.general.TrainingCategory.FREE) 
            {
                if (arg1.trainingCategory != core.general.TrainingCategory.INTERVAL) 
                {
                    if (arg1.trainingCategory != core.general.TrainingCategory.PROGRAM) 
                    {
                        return null;
                    }
                    else 
                    {
                        loc3 = arg1.stopAdress - arg1.programStartAddress + 1;
                        loc2[1] = (arg1.programStartAddress >> 8).toString(16);
                        loc2[0] = (arg1.programStartAddress & 255).toString(16);
                    }
                }
                else 
                {
                    loc3 = arg1.stopAdress - arg1.programStartAddress + 1;
                    loc2[1] = (arg1.programStartAddress >> 8).toString(16);
                    loc2[0] = (arg1.programStartAddress & 255).toString(16);
                }
            }
            else 
            {
                loc3 = arg1.stopAdress - arg1.startAdress + 1;
                loc2[1] = (arg1.startAdress >> 8).toString(16);
                loc2[0] = (arg1.startAdress & 255).toString(16);
            }
            loc6 = 0;
            while (loc6 < 3) 
            {
                if (loc2[loc6].length == 1) 
                {
                    loc2[loc6] = "0" + loc2[loc6];
                }
                ++loc6;
            }
            var loc8:*=--loc3 & 255;
            var loc9:*=loc3 >> 8;
            GET_LOG_COMMAND = GET_LOG_COMMAND + (" " + loc2[0] + " " + loc2[1] + " " + loc2[2] + " " + loc8.toString(16) + " " + loc9.toString(16));
            GET_LOG_COMMAND = calculateDynamicCommandChecksum(GET_LOG_COMMAND);
            return GET_LOG_COMMAND.toUpperCase();
        }

        internal function onLoaded(arg1:service.usb.event.DeviceDataCompleteEvent):void
        {
            var loc2:*=0;
            var loc6:*=null;
            var loc1:*=undefined;
            var loc4:*=0;
            var loc5:*=null;
            var loc3:*=null;
            var loc7:*=null;
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
            service.DeviceCommunicationHandler.getInstance().removeEventListener("progressReadWriteEvent", forwardProgressEvent);
            if (arg1.command != "") 
            {
                if (arg1.command != "83 70 FF 00 5E 00 AF") 
                {
                    if (arg1.command != "83 29 FF 00 06 00 4E") 
                    {
                        if (arg1.command != GET_LOG_HEADER_COMMAND) 
                        {
                            if (arg1.command != "83 5A FF 00 15 00 0E") 
                            {
                                if (arg1.command != GET_LOG_COMMAND) 
                                {
                                    if (arg1.command == "83 00 00 00 EF 00 8D") 
                                    {
                                        if ((loc7 = decoder.PC2814Decoder.getInstance().decodeTrainingProgram(arg1.data, _myUnit)) && loc7.phaseCount > 0) 
                                        {
                                            loc7.unit = _myUnit;
                                            (_myUnit as core.units.interfaces.ITrainingsList).trainingsOnDeviceList.push(loc7);
                                        }
                                        else 
                                        {
                                            (_myUnit as core.units.interfaces.ITrainingsList).trainingsOnDeviceList = new __AS3__.vec.Vector.<core.training.Training>();
                                        }
                                        dispatchEvent(new flash.events.Event("programLoadedFromUnitComplete"));
                                    }
                                }
                                else 
                                {
                                    if (activityToLoad.trainingCategory != core.general.TrainingCategory.FREE) 
                                    {
                                        if (activityToLoad.trainingCategory != core.general.TrainingCategory.INTERVAL) 
                                        {
                                            if (activityToLoad.trainingCategory == core.general.TrainingCategory.PROGRAM) 
                                            {
                                                activityToLoad.tempTraining = decoder.PC2814Decoder.getInstance().decodeTrainingProgram(arg1.data, _myUnit, true);
                                                loc3 = arg1.data.slice(activityToLoad.tempTraining.programDataLength);
                                                decoder.PC2814Decoder.getInstance().decodeLog(activityToLoad, loc3);
                                            }
                                        }
                                        else 
                                        {
                                            loc5 = decoder.PC2814Decoder.getInstance().decodeIntervalSettings(arg1.data.slice(0, 19));
                                            activityToLoad.tempTraining = mapIntervalSettingToPhases(loc5);
                                            decoder.PC2814Decoder.getInstance().decodeLog(activityToLoad, arg1.data.slice(19));
                                        }
                                    }
                                    else 
                                    {
                                        decoder.PC2814Decoder.getInstance().decodeLog(activityToLoad, arg1.data);
                                    }
                                    if ((unit as core.units.interfaces.IDataToDecode).activitiesToDecode.length > 0) 
                                    {
                                        loadFromDC("loadUnitlogData");
                                    }
                                    else 
                                    {
                                        _currentLoadLog = 0;
                                        _currentLoadLogTotal = 0;
                                        dispatchEvent(new handler.event.ProgressStatusEvent("progressbarEvent", 100, 1, 1, "", false, false));
                                        dispatchEvent(new flash.events.Event("logsLoadedFromUnitComplete", false, false));
                                    }
                                }
                            }
                            else 
                            {
                                decoder.PC2814Decoder.getInstance().decodeLogStatus(arg1.data, _myUnit);
                                dispatchEvent(new flash.events.Event("logStatusLoadedFromUnitComplete"));
                            }
                        }
                        else 
                        {
                            loc2 = arg1.data.length;
                            loc1 = new __AS3__.vec.Vector.<core.activities.Activity>();
                            loc4 = 0;
                            while (loc4 < loc2) 
                            {
                                loc6 = arg1.data.slice(loc4, loc4 + 39);
                                loc1.push(decoder.PC2814Decoder.getInstance().decodePageHeaderInformation(loc6, _myUnit));
                                loc4 = loc4 + 39;
                            }
                            (_myUnit as core.units.UnitPC2814).loadedLogs = loc1;
                            dispatchEvent(new flash.events.Event("pageHeaderChange"));
                        }
                    }
                    else 
                    {
                        logCount = decoder.PC2814Decoder.getInstance().decodeListOfAdressOfPageHeader(arg1.data);
                        if (logCount != 0) 
                        {
                            service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
                            service.DeviceCommunicationHandler.getInstance().addEventListener("progressReadWriteEvent", forwardProgressEvent);
                            service.DeviceCommunicationHandler.getInstance().addToCommandQueue("loadUnitlogDataHeader", "loadCommand", this);
                        }
                        else 
                        {
                            logCount = -1;
                            if (_myUnit != null) 
                            {
                                (_myUnit as core.units.UnitPC2814).loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
                            }
                            dispatchEvent(new flash.events.Event("pageHeaderChange", false, false));
                        }
                    }
                }
                else 
                {
                    _myUnit.currentSettings = decoder.PC2814Decoder.getInstance().decodeSettings(arg1.data);
                    if (_myUnit.currentSettings != null) 
                    {
                        _myUnit.currentSettings.unit = _myUnit;
                        dispatchEvent(new flash.events.Event("settingsLoadedFromUnitComplete"));
                    }
                }
            }
            service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
            return;
        }

        internal function mapIntervalSettingToPhases(arg1:core.settings.SettingsPC2814):core.training.Training
        {
            var loc4:*=null;
            var loc2:*=null;
            var loc1:*=new core.training.Training(_myUnit, false);
            loc1.name = "Interval";
            loc1.phaseCount = 0;
            if (arg1.intervalWarmUpTime > 0) 
            {
                (loc4 = new core.training.TrainingPhase()).loadDuration = arg1.intervalWarmUpTime;
                loc4.loadPhaseControl = core.training.type.PhaseControl.TIME;
                loc4.loadTargetMin = arg1.intervalWarmUpTargetZoneLowerLimit;
                loc4.loadTargetMax = arg1.intervalWarmUpTargetZoneUpperLimit;
                loc4.loadTargetType = core.training.type.PhaseTarget.HEARTFREQUENCY;
                loc4.loadRecovery = core.training.type.PhaseLoadRecovery.LOAD;
                loc4.titel = "Warm Up";
                loc4.type = core.training.type.PhaseCategory.SIMPLE;
                loc1.phaseCount = (loc1.phaseCount + 1);
                loc1.phasesList.push(loc4);
            }
            var loc3:*;
            (loc3 = new core.training.TrainingPhase()).loadDuration = arg1.intervalTime;
            loc3.loadTargetMin = arg1.intervalTargetZoneLowerLimit;
            loc3.loadTargetMax = arg1.intervalTargetZoneUpperLimit;
            loc3.loadPhaseControl = core.training.type.PhaseControl.TIME;
            loc3.loadTargetType = core.training.type.PhaseTarget.HEARTFREQUENCY;
            loc3.recoveryDuration = arg1.intervalRecoveryTime;
            loc3.recoveryPhaseControl = arg1.intervalRecoveryMode;
            loc3.recoveryTargetMin = arg1.intervalTargetZoneLowerLimit;
            loc3.recoveryTargetMax = arg1.intervalTargetZoneUpperLimit;
            loc3.recoveryTargetType = core.training.type.PhaseTarget.HEARTFREQUENCY;
            loc3.loadRecovery = core.training.type.PhaseLoadRecovery.RECOVERY;
            loc3.titel = "Interval";
            loc3.type = core.training.type.PhaseCategory.INTERVAL;
            loc1.phaseCount = (loc1.phaseCount + 1);
            loc1.phasesList.push(loc3);
            if (arg1.intervalRecoveryTime > 0) 
            {
                loc2 = new core.training.TrainingPhase();
                loc2.loadDuration = arg1.intervalCoolDownTime;
                loc2.loadPhaseControl = core.training.type.PhaseControl.TIME;
                loc2.loadTargetMin = arg1.intervalCoolDownTargetZoneLowerLimit;
                loc2.loadTargetMax = arg1.intervalCoolDownTargetZoneUpperLimit;
                loc2.loadTargetType = core.training.type.PhaseTarget.HEARTFREQUENCY;
                loc2.type = core.training.type.PhaseCategory.SIMPLE;
                loc2.titel = "Cool Down";
                loc2.loadRecovery = core.training.type.PhaseLoadRecovery.RECOVERY;
                loc1.phaseCount = (loc1.phaseCount + 1);
                loc1.phasesList.push(loc2);
            }
            return loc1;
        }

        public override function sendToDC(arg1:String):void
        {
            var loc2:*=0;
            var loc1:*=0;
            if (service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy) 
            {
                service.DeviceCommunicationHandler.getInstance().addToCommandQueue(arg1, "sendCommand", this);
                return;
            }
            service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
            if (arg1 != "writeUnitSettings") 
            {
                if (arg1 != "writeMyNameSettingToDevice") 
                {
                    if (arg1 != "writeFreeTrainingSettingToDevice") 
                    {
                        if (arg1 != "writeIntervalTrainingSettingToDevice") 
                        {
                            if (arg1 != "writeProgramDataFromDevice") 
                            {
                                if (arg1 == "deleteUnitlogData") 
                                {
                                    service.DeviceCommunicationHandler.getInstance().addEventListener("writeSuccessEvent", sendPageHeaderSize);
                                    service.DeviceCommunicationHandler.getInstance().addEventListener("commandOkEvent", sendPageHeaderSize);
                                    currentBytesToReceive = 4;
                                    currentCommand = "81 29 FF 00 01 55";
                                    waitForWriteSucsess = true;
                                    waitForCommandOk = true;
                                    service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
                                }
                            }
                            else 
                            {
                                service.DeviceCommunicationHandler.getInstance().addEventListener("writeSuccessEvent", sendProgrammToDevice);
                                service.DeviceCommunicationHandler.getInstance().addEventListener("commandOkEvent", sendProgrammToDevice);
                                currentBytesToReceive = 4;
                                currentCommand = "81 00 00 00";
                                data = decoder.PC2814Decoder.getInstance().encodeTrainingProgram(_myUnit.currentTrainingProgram);
                                loc2 = Math.ceil(data.length / dataPackageSize);
                                currentCommand = currentCommand + (" " + loc2.toString(16));
                                loc1 = 129 + loc2 & 255;
                                loc1 = loc1 ^ 255;
                                currentCommand = currentCommand + (" " + loc1.toString(16));
                                waitForWriteSucsess = true;
                                waitForCommandOk = true;
                                service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
                            }
                        }
                        else 
                        {
                            service.DeviceCommunicationHandler.getInstance().addEventListener("writeSuccessEvent", sendSettingsToDevice);
                            service.DeviceCommunicationHandler.getInstance().addEventListener("commandOkEvent", sendSettingsToDevice);
                            currentBytesToReceive = 4;
                            currentCommand = "81 7D FF 00 02 00";
                            waitForWriteSucsess = true;
                            waitForCommandOk = true;
                            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
                        }
                    }
                    else 
                    {
                        service.DeviceCommunicationHandler.getInstance().addEventListener("writeSuccessEvent", sendSettingsToDevice);
                        service.DeviceCommunicationHandler.getInstance().addEventListener("commandOkEvent", sendSettingsToDevice);
                        currentBytesToReceive = 4;
                        currentCommand = "81 94 FF 00 01 EA";
                        waitForWriteSucsess = true;
                        waitForCommandOk = true;
                        service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
                    }
                }
                else 
                {
                    service.DeviceCommunicationHandler.getInstance().addEventListener("writeSuccessEvent", sendSettingsToDevice);
                    service.DeviceCommunicationHandler.getInstance().addEventListener("commandOkEvent", sendSettingsToDevice);
                    currentBytesToReceive = 4;
                    currentCommand = "81 70 FF 00 01 0E";
                    waitForWriteSucsess = true;
                    waitForCommandOk = true;
                    service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
                }
            }
            else 
            {
                service.DeviceCommunicationHandler.getInstance().addEventListener("writeSuccessEvent", sendSettingsToDevice);
                service.DeviceCommunicationHandler.getInstance().addEventListener("commandOkEvent", sendSettingsToDevice);
                currentBytesToReceive = 4;
                currentCommand = "81 AA FF 00 03 D2";
                waitForWriteSucsess = true;
                waitForCommandOk = true;
                service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
            }
            return;
        }

        internal function sendPageHeaderSize(arg1:flash.events.Event):void
        {
            var loc1:*=null;
            var loc5:*=0;
            var loc6:*=0;
            var loc4:*=0;
            var loc3:*=0;
            var loc7:*=0;
            var loc2:*=null;
            if (waitForWriteSucsess || waitForCommandOk) 
            {
                if (arg1.type != "commandOkEvent") 
                {
                    if (arg1.type == "writeSuccessEvent") 
                    {
                        waitForWriteSucsess = false;
                    }
                }
                else 
                {
                    waitForCommandOk = false;
                }
                if (!waitForWriteSucsess && !waitForCommandOk) 
                {
                    loc1 = new Array(7);
                    loc1[0] = 0;
                    loc1[1] = 0;
                    loc1[2] = 0;
                    loc1[3] = 17;
                    loc1[4] = 32;
                    loc1[5] = 17;
                    loc1[6] = 20;
                    currentPackage = 0;
                    packageCount = Math.ceil(loc1.length / dataPackageSize);
                    packageData = [];
                    loc5 = 0;
                    while (loc5 < packageCount) 
                    {
                        packageData.push(loc1.slice(dataPackageSize * loc5, dataPackageSize * loc5 + dataPackageSize));
                        ++loc5;
                    }
                    service.DeviceCommunicationHandler.getInstance().dispatchEvent(new flash.events.Event("writeSuccessEvent"));
                }
            }
            else if (currentPackage < packageCount) 
            {
                loc6 = packageData[currentPackage].length;
                currentPackageData = [];
                currentPackageData.push(parseInt("82", 16));
                currentPackageData.push(currentPackage);
                currentPackageData.push((loc6 - 1));
                currentPackageData = currentPackageData.concat(packageData[currentPackage]);
                loc4 = currentPackageData.length;
                loc3 = 0;
                loc7 = 0;
                while (loc7 < loc4) 
                {
                    loc3 = loc3 + currentPackageData[loc7];
                    ++loc7;
                }
                loc3 = (loc3 = loc3 & 255) ^ 255;
                currentPackageData.push(loc3);
                ++currentPackage;
                service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer("", currentPackageData), this);
            }
            else 
            {
                service.DeviceCommunicationHandler.getInstance().removeEventListener("writeSuccessEvent", sendPageHeaderSize);
                service.DeviceCommunicationHandler.getInstance().removeEventListener("commandOkEvent", sendPageHeaderSize);
                loc2 = unit as core.units.UnitPC2814;
                loc2.loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
                loc2.logTime5Sec = 156840;
                loc2.logTime10Sec = 313680;
                loc2.logTime20Sec = 627360;
                loc2.logTime30Sec = 941100;
                loc2.freePackages = loc2.maxPackages;
                dispatchEvent(new flash.events.Event("logStatusLoadedFromUnitComplete"));
                dispatchEvent(new flash.events.Event("logDeleteCompleteEvent"));
            }
            return;
        }

        internal function sendSettingsToDevice(arg1:flash.events.Event):void
        {
            var loc1:*=null;
            var loc4:*=0;
            var loc5:*=0;
            var loc3:*=0;
            var loc2:*=0;
            var loc6:*=0;
            if (waitForWriteSucsess || waitForCommandOk) 
            {
                if (arg1.type != "commandOkEvent") 
                {
                    if (arg1.type == "writeSuccessEvent") 
                    {
                        waitForWriteSucsess = false;
                    }
                }
                else 
                {
                    waitForCommandOk = false;
                }
                if (!waitForWriteSucsess && !waitForCommandOk) 
                {
                    if (currentCommand != "81 AA FF 00 03 D2") 
                    {
                        if (currentCommand != "81 70 FF 00 01 0E") 
                        {
                            if (currentCommand != "81 7D FF 00 02 00") 
                            {
                                if (currentCommand == "81 94 FF 00 01 EA") 
                                {
                                    loc1 = data.slice(36, 48);
                                    dispatchEvent(new handler.event.ProgressStatusEvent("progressbarEvent", 75, 1, 1, "SET_SETTINGS_FREE_TRAINING_COMMAND", false, false));
                                }
                            }
                            else 
                            {
                                loc1 = data.slice(13, 32);
                            }
                        }
                        else 
                        {
                            loc1 = data.slice(0, 12);
                            dispatchEvent(new handler.event.ProgressStatusEvent("progressbarEvent", 50, 1, 1, "SET_SETTINGS_MYNAME_COMMAND", false, false));
                        }
                    }
                    else 
                    {
                        data = decoder.PC2814Decoder.getInstance().encodeSettings(_myUnit);
                        loc1 = data.slice(58);
                        dispatchEvent(new handler.event.ProgressStatusEvent("progressbarEvent", 25, 1, 1, "SET_SETTINGS_NORMAL_COMMAND", false, false));
                    }
                    currentPackage = 0;
                    packageCount = Math.ceil(loc1.length / dataPackageSize);
                    packageData = [];
                    loc4 = 0;
                    while (loc4 < packageCount) 
                    {
                        packageData.push(loc1.slice(dataPackageSize * loc4, dataPackageSize * loc4 + dataPackageSize));
                        ++loc4;
                    }
                    service.DeviceCommunicationHandler.getInstance().dispatchEvent(new flash.events.Event("writeSuccessEvent"));
                }
            }
            else if (currentPackage < packageCount) 
            {
                loc5 = packageData[currentPackage].length;
                currentPackageData = [];
                currentPackageData.push(parseInt("82", 16));
                currentPackageData.push(currentPackage);
                currentPackageData.push((loc5 - 1));
                currentPackageData = currentPackageData.concat(packageData[currentPackage]);
                loc3 = currentPackageData.length;
                loc2 = 0;
                loc6 = 0;
                while (loc6 < loc3) 
                {
                    loc2 = loc2 + currentPackageData[loc6];
                    ++loc6;
                }
                loc2 = loc2 & 255;
                loc2 = loc2 ^ 255;
                currentPackageData.push(loc2);
                ++currentPackage;
                service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer("", currentPackageData), this);
            }
            else 
            {
                service.DeviceCommunicationHandler.getInstance().removeEventListener("writeSuccessEvent", sendSettingsToDevice);
                service.DeviceCommunicationHandler.getInstance().removeEventListener("commandOkEvent", sendSettingsToDevice);
                if (currentCommand != "81 AA FF 00 03 D2") 
                {
                    if (currentCommand != "81 70 FF 00 01 0E") 
                    {
                        if (currentCommand != "81 94 FF 00 01 EA") 
                        {
                            if (currentCommand == "81 7D FF 00 02 00") 
                            {
                                dispatchEvent(new flash.events.Event("settingsSendComplete"));
                            }
                        }
                        else 
                        {
                            flash.utils.setTimeout(sendToDC, 3000, "writeIntervalTrainingSettingToDevice");
                        }
                    }
                    else 
                    {
                        flash.utils.setTimeout(sendToDC, 3000, "writeFreeTrainingSettingToDevice");
                    }
                }
                else 
                {
                    flash.utils.setTimeout(sendToDC, 3000, "writeMyNameSettingToDevice");
                }
            }
            return;
        }

        internal function sendProgrammToDevice(arg1:flash.events.Event):void
        {
            var loc1:*=null;
            var loc4:*=0;
            var loc5:*=0;
            var loc3:*=0;
            var loc2:*=0;
            var loc6:*=0;
            if (waitForWriteSucsess || waitForCommandOk) 
            {
                if (arg1.type != "commandOkEvent") 
                {
                    if (arg1.type == "writeSuccessEvent") 
                    {
                        waitForWriteSucsess = false;
                    }
                }
                else 
                {
                    waitForCommandOk = false;
                }
                if (!waitForWriteSucsess && !waitForCommandOk) 
                {
                    loc1 = data;
                    currentPackage = 0;
                    packageCount = Math.ceil(loc1.length / dataPackageSize);
                    packageData = [];
                    loc4 = 0;
                    while (loc4 < packageCount) 
                    {
                        packageData.push(loc1.slice(dataPackageSize * loc4, dataPackageSize * loc4 + dataPackageSize));
                        ++loc4;
                    }
                    service.DeviceCommunicationHandler.getInstance().dispatchEvent(new flash.events.Event("writeSuccessEvent"));
                }
            }
            else if (currentPackage < packageCount) 
            {
                loc5 = packageData[currentPackage].length;
                currentPackageData = [];
                currentPackageData.push(parseInt("82", 16));
                currentPackageData.push(currentPackage);
                currentPackageData.push((loc5 - 1));
                currentPackageData = currentPackageData.concat(packageData[currentPackage]);
                loc3 = currentPackageData.length;
                loc2 = 0;
                loc6 = 0;
                while (loc6 < loc3) 
                {
                    loc2 = loc2 + currentPackageData[loc6];
                    ++loc6;
                }
                loc2 = loc2 & 255;
                loc2 = loc2 ^ 255;
                currentPackageData.push(loc2);
                ++currentPackage;
                service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer("", currentPackageData), this);
            }
            else 
            {
                service.DeviceCommunicationHandler.getInstance().removeEventListener("writeSuccessEvent", sendProgrammToDevice);
                service.DeviceCommunicationHandler.getInstance().removeEventListener("commandOkEvent", sendProgrammToDevice);
                dispatchEvent(new flash.events.Event("programSendComplete"));
            }
            return;
        }

        protected function generateNativeProzessBuffer(arg1:String, arg2:Array=null):flash.utils.ByteArray
        {
            var loc5:*=null;
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=new flash.utils.ByteArray();
            if (arg1 != "") 
            {
                loc1 = (loc5 = arg1.split(" ")).length;
                loc2 = 0;
                while (loc2 < loc1) 
                {
                    loc4.writeByte(parseInt(loc5[loc2], 16));
                    ++loc2;
                }
            }
            if (arg2 != null) 
            {
                loc3 = 0;
                while (loc3 < arg2.length) 
                {
                    loc4.writeByte(arg2[loc3]);
                    ++loc3;
                }
            }
            return loc4;
        }

        internal function generatePageHeaderCommand():String
        {
            var loc1:*="83 29 FF 00".split(" ");
            GET_LOG_HEADER_COMMAND = loc1[0];
            var loc2:*=logCount * 39;
            var loc8:*=parseInt(loc1[2], 16) << 8 | parseInt(loc1[1], 16);
            loc8 = loc8 - loc2;
            var loc4:*="00";
            var loc3:*=(loc8 >> 8).toString(16);
            var loc5:*=(loc8 & 255).toString(16);
            --loc2;
            var loc6:*=loc2 & 255;
            var loc7:*=loc2 >> 8;
            GET_LOG_HEADER_COMMAND = GET_LOG_HEADER_COMMAND + (" " + loc5 + " " + loc3 + " " + loc4 + " " + loc6.toString(16) + " " + loc7.toString(16));
            GET_LOG_HEADER_COMMAND = calculateDynamicCommandChecksum(GET_LOG_HEADER_COMMAND);
            return GET_LOG_HEADER_COMMAND.toUpperCase();
        }

        public static const SET_LOG_HEADER_SIZE_BYTES_TO_RECEIVE:uint=4;

        public static const SET_LOG_HEADER_SIZE_COMMAND:String="81 29 FF 00 01 55";

        public static const SET_SETTINGS_BYTES_TO_RECEIVE:uint=4;

        public static const SET_SETTINGS_COMPLETE_COMMAND:String="81 70 FF 00 06 09";

        public static const GET_LOGGING_TIME_INFORMATION_BYTES_TO_RECEIVE:uint=22;

        public static const SET_SETTINGS_FREE_TRAINING_COMMAND:String="81 94 FF 00 01 EA";

        public static const SET_SETTINGS_INTERVAL_TRAINING_COMMAND:String="81 7D FF 00 02 00";

        public static const SET_SETTINGS_NORMAL_COMMAND:String="81 AA FF 00 03 D2";

        public static const SET_TOTALS_COMMAND:String="";

        public static const SET_TOTALS_COMMAND_BYTES_TO_RECEIVE:uint=4;

        public static const SET_TRAINING_PROGRAMM_BYTES_TO_RECEIVE:uint=4;

        public static const SET_TRAINING_PROGRAMM_COMMAND_FIX:String="81 00 00 00";

        internal static const WRITE_FREE_TRAINING_SETTINGS_TO_DEVICE:String="writeFreeTrainingSettingToDevice";

        internal static const WRITE_INTERVAL_TRAINING_SETTINGS_TO_DEVICE:String="writeIntervalTrainingSettingToDevice";

        internal static const WRITE_MYNAME_SETTINGS_TO_DEVICE:String="writeMyNameSettingToDevice";

        public static const SET_SETTINGS_MYNAME_COMMAND:String="81 70 FF 00 01 0E";

        public static const GET_LOGGING_TIME_INFORMATION_COMMAND:String="83 5A FF 00 15 00 0E";

        public static const GET_LOG_COMMAND_FIX:String="83 60 02 00";

        public static const GET_LOG_HEADER_COMMAND_FIX:String="83 29 FF 00";

        public static const GET_LOG_HEADER_SIZE_BYTES_TO_RECEIVE:uint=7;

        public static const GET_LOG_HEADER_SIZE_COMMAND:String="83 29 FF 00 06 00 4E";

        public static const GET_SETTINGS_BYTES_TO_RECEIVE:uint=95;

        public static const GET_SETTINGS_COMMAND:String="83 70 FF 00 5E 00 AF";

        public static const GET_TOTALS_COMMAND:String="";

        public static const GET_TOTALS_COMMAND_BYTES_TO_RECEIVE:uint=0;

        public static const GET_TRAINING_PROGRAMM_BYTES_TO_RECEIVE:uint=240;

        public static const GET_TRAINING_PROGRAMM_COMMAND:String="83 00 00 00 EF 00 8D";

        public static const LOAD_CHECKSUMM_BYTES_TO_RECEIVE:uint=4;

        public static const SEND_SETTING_DATA_PACKAGE:String="82";

        public static const SEND_TRAINING_DATA_PACKAGE:String="82";

        internal var _pageHeaderAddrList:Object;

        internal var _currentLoadLog:int=0;

        internal var _currentLoadLogTotal:int=0;

        internal var _myUnit:core.units.UnitPC2814;

        internal var currentPackage:uint=0;

        internal var currentPackageData:Array;

        internal var data:Array;

        internal var dataPackageSize:uint=16;

        internal var logCount:int=-1;

        internal var packageCount:uint=0;

        internal var packageData:Array;

        internal var settingStep:uint=0;

        internal var waitForCommandOk:Boolean=false;

        internal var waitForWriteSucsess:Boolean=false;

        internal var activityToLoad:core.activities.Activity;

        public static var GET_LOG_COMMAND:String="";

        public static var GET_LOG_HEADER_COMMAND:String="";
    }
}


