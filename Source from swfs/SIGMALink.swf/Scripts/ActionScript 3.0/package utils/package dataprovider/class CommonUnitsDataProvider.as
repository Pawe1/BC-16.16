//class CommonUnitsDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import core.general.*;
    
    public class CommonUnitsDataProvider extends Object
    {
        public function CommonUnitsDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER_ALL_DEVICES = new __AS3__.vec.Vector.<utils.dataprovider.UnitItemRendererData>();
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC512.getLabel(), core.general.UnitType.BC512));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC812.getLabel(), core.general.UnitType.BC812));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC1212.getLabel(), core.general.UnitType.BC1212));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC1412.getLabel(), core.general.UnitType.BC1412));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC1612.getLabel(), core.general.UnitType.BC1612));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC1612STS.getLabel(), core.general.UnitType.BC1612STS));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC812W.getLabel(), core.general.UnitType.BC812W));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC1212STS.getLabel(), core.general.UnitType.BC1212STS));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC416.getLabel(), core.general.UnitType.BC416));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC416ATS.getLabel(), core.general.UnitType.BC416ATS));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC516.getLabel(), core.general.UnitType.BC516));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC716.getLabel(), core.general.UnitType.BC716));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC716ATS.getLabel(), core.general.UnitType.BC716ATS));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC916.getLabel(), core.general.UnitType.BC916));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC916ATS.getLabel(), core.general.UnitType.BC916ATS));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC1416.getLabel(), core.general.UnitType.BC1416));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC1416STS.getLabel(), core.general.UnitType.BC1416STS));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC1616.getLabel(), core.general.UnitType.BC1616));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC1616STS.getLabel(), core.general.UnitType.BC1616STS));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC2316STS.getLabel(), core.general.UnitType.BC2316STS));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.ROX50.getLabel(), core.general.UnitType.ROX50));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.ROX60.getLabel(), core.general.UnitType.ROX60));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.ROX70.getLabel(), core.general.UnitType.ROX70));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.ROX100.getLabel(), core.general.UnitType.ROX100));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.ROX110.getLabel(), core.general.UnitType.ROX110));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.GPS10.getLabel(), core.general.UnitType.GPS10));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.RC1411.getLabel(), core.general.UnitType.RC1411));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.PC2814.getLabel(), core.general.UnitType.PC2814));
            return;
        }

        public static function isSupported(arg1:core.general.UnitType):Boolean
        {
            var loc2:*=0;
            var loc1:*=V_DATA_PROVIDER_ALL_DEVICES.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                if (V_DATA_PROVIDER_ALL_DEVICES[loc2].data == arg1) 
                {
                    return true;
                }
                ++loc2;
            }
            return false;
        }

        public static var V_DATA_PROVIDER_ALL_DEVICES:__AS3__.vec.Vector.<utils.dataprovider.UnitItemRendererData>;
    }
}


