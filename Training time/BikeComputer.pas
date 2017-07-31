unit BikeComputer;

interface

type
  TBikeComputer = class(TInterfacedObject)
  end;

  TTopline2016BikeComputer = class(TBikeComputer)
    serialNumber: byte;
  end;

  TBC1416 = class(TTopline2016BikeComputer)
  end;

  TBC1416STS = class(TBC1416)

  end;

  TBC1616 = class(TTopline2016BikeComputer)
  private
//    const MyNameMaxLength :uint = 9;
//
//   FBacklightActive: Boolean;
//   FBacklightTimeOff: Date;
//
//         FBacklightTimeOn:Date;
//
//        FClockMode:String="24";
//
//        FContrast:int=2;
//
//        FDateFormat:String="eu";
//
//        FEtaArivalFlag:Boolean=true;
//
//        FEtaDistance:Number=100000;
//
//        FFuelConsumption:Number=8.5;
//
//        FFuelConsumptionUnit:String="l/100km";
//
//        FTireSize2:core.general.TireSize;
//
//        FPowerSaveModeActive:Boolean=false;
//
//        FWheelSize2:int=1253;
//
//        FLanguage:String="en";
//
//        FNfcActive:Boolean=true;
//
//        FTemperatureUnit:String="";
//
//        FServiceInterval:int=750;
//
//        FWheelSize2Mode:core.general.WheelSizeSelectionMode;
//
//        FMyName:String="BC 16.16";
//
//        FServiceStatusOn: Boolean=false;
   public

  end;

  TBC1616STS = class(TBC1616)

  end;

  TBC2316STS = class(TTopline2016BikeComputer)

  end;

implementation

end.
