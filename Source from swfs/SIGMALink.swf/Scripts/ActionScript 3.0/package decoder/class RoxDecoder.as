//class RoxDecoder
package decoder 
{
    import __AS3__.vec.*;
    import com.logging.*;
    import core.*;
    import core.activities.*;
    import core.activities.interfaces.*;
    import core.general.*;
    import core.marker.*;
    import core.settings.*;
    import core.settings.interfaces.*;
    import core.totals.*;
    import core.units.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import handler.*;
    import utils.converter.*;
    
    public class RoxDecoder extends flash.events.EventDispatcher implements core.units.interfaces.ICodingSettings, core.activities.interfaces.ICodingLog, core.units.interfaces.ICodingUnitInformation
    {
        public function RoxDecoder()
        {
            super();
            com.logging.ErrorLogging.getInstance().addTarget(this);
            if (_instance) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10074, "ROXDecoder > Constructor: This is a Singleton. Use the getInstace() methode!"));
            }
            return;
        }

        public static function getInstance():decoder.RoxDecoder
        {
            if (_instance == null) 
            {
                _instance = new RoxDecoder();
            }
            return _instance;
        }

        public function decodeUnitInformation(arg1:Object):core.units.Unit
        {
            var loc33:*=NaN;
            var loc38:*=null;
            var loc7:*=false;
            var loc8:*=arg1 as Array;
            var loc9:*=0;
            loc33 = 0;
            while (loc33 < 11) 
            {
                loc9 = loc9 + loc8[loc33];
                ++loc33;
            }
            loc9 = loc9 & 255;
            var loc27:*=parseInt(loc8[11]);
            var loc15:*=0;
            loc15 = (loc15 = (loc15 = loc8[2] << 16) | loc8[1] << 8) | loc8[0];
            var loc30:*=0;
            var loc11:*;
            if ((loc11 = (loc8[2] & 128) >> 7) != 0) 
            {
                if (loc11 == 1) 
                {
                    loc38 = new core.units.UnitROX9();
                    loc30 = loc15 - 9437184 + 90000000;
                }
            }
            else 
            {
                loc38 = new core.units.UnitROX8();
                loc30 = loc15 - 1048576 + 10000000;
            }
            loc38.serialNumber = loc30.toString();
            var loc41:*;
            (loc41 = new core.settings.SettingsROX()).unitType = loc38.type;
            loc41.unit = loc38;
            loc38.currentSettings = loc41;
            var loc3:*=(loc8[5] & 240) >> 4;
            var loc24:*=loc8[5] & 15;
            var loc28:*=(loc8[4] & 240) >> 4;
            var loc31:*=loc8[4] & 15;
            var loc5:*=(loc8[3] & 240) >> 4;
            var loc2:*=loc8[3] & 15;
            var loc20:*=loc5.toString(10) + loc2.toString(10);
            var loc39:*=loc28.toString(10) + loc31.toString(10);
            var loc4:*=loc3.toString(10) + loc24.toString(10);
            var loc32:*=new Date(parseInt("20" + loc4), (parseInt(loc39) - 1), parseInt(loc20));
            loc38.dateCode = loc32;
            var loc12:*;
            var loc16:*=(loc12 = parseInt(loc8[9])) & 15;
            var loc37:*=(loc8[8] & 240) >> 4;
            var loc36:*=loc8[8] & 15;
            var loc10:*=(loc8[7] & 240) >> 4;
            var loc13:*=loc8[7] & 15;
            var loc35:*=(loc8[6] & 240) >> 4;
            var loc34:*=loc8[6] & 15;
            var loc29:*=(loc29 = (loc29 = (loc29 = loc16.toString(16)) + (loc37.toString(16) + loc36.toString(16))) + (loc10.toString(16) + loc13.toString(16))) + (loc35.toString(16) + loc34.toString(16));
            loc38.maskingCode = loc29;
            var loc19:*;
            var loc17:*;
            var loc1:*=(loc17 = ((loc19 = parseInt(loc8[9])) & 240) >> 4).toString(16);
            loc38.initialWakeUpInfo = loc1;
            var loc40:*;
            var loc18:*=((loc40 = loc8[10]) & 240) >> 4;
            var loc14:*=loc40 & 15;
            var loc6:*=loc18.toString() + "." + loc14.toString();
            loc38.softwareRevision = loc6;
            var loc21:*=loc8[15].toString(16).toUpperCase();
            var loc23:*=loc8[14].toString(16).toUpperCase();
            var loc22:*=loc8[13].toString(16).toUpperCase();
            var loc25:*=loc8[12].toString(16).toUpperCase();
            var loc26:*;
            if ((loc26 = loc21 + loc23 + loc22 + loc25) != "359474D4") 
            {
                if (loc26 != "46A585E5") 
                {
                    dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10120, "ROXDecoder > decodeUnitInformation: incorrect checksum1"));
                }
                else 
                {
                    dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10122, "ROXDecoder > decodeUnitInformation: ROX 8.1 / 9.1 on DS 2008 is not supported"));
                }
                return null;
            }
            if (!loc7) 
            {
            };
            return loc38;
        }

        public function decodeMemory(arg1:Object, arg2:core.units.UnitROX):__AS3__.vec.Vector.<core.activities.Activity>
        {
            var loc5:*=null;
            var loc6:*=NaN;
            _7infotripArray = arg1 as Array;
            var loc4:*;
            var loc3:*=(loc4 = decodeTripList())[0];
            var loc7:*=loc4[1];
            var loc1:*=new __AS3__.vec.Vector.<core.activities.Activity>();
            var loc2:*=loc3;
            if (loc7 > 0) 
            {
                loc5 = decodeTrip(loc2 * 79, arg2);
                loc1[0] = loc5;
            }
            loc6 = 1;
            while (loc6 < loc7) 
            {
                if (loc2 != 0) 
                {
                    --loc2;
                }
                else 
                {
                    loc2 = 6;
                }
                loc5 = decodeTrip(loc2 * 79, arg2);
                loc1[loc6] = loc5;
                ++loc6;
            }
            return loc1;
        }

        public function decodeSettings(arg1:Object, arg2:core.units.Unit=null):core.settings.Settings
        {
            var loc145:*=false;
            var loc8:*=0;
            var loc9:*=0;
            var loc28:*=0;
            var loc32:*=0;
            var loc87:*=null;
            var loc109:*=0;
            var loc111:*=0;
            var loc85:*=0;
            var loc86:*=0;
            var loc64:*=null;
            var loc131:*=0;
            var loc135:*=0;
            var loc154:*=0;
            var loc152:*=0;
            var loc151:*=null;
            var loc65:*=0;
            var loc29:*=0;
            var loc46:*=0;
            var loc62:*=0;
            var loc49:*=null;
            var loc63:*=0;
            var loc133:*=false;
            var loc37:*=new core.settings.SettingsROX();
            var loc31:*=arg2 as core.units.UnitROX;
            loc37.unitType = arg2.type;
            loc37.unit = arg2;
            var loc98:*;
            var loc39:*;
            if ((loc39 = (loc98 = arg1 as Array)[0] & 1) != 1) 
            {
                loc37.speedUnit = "kmh";
            }
            else 
            {
                loc37.speedUnit = "mph";
            }
            var loc18:*;
        }

        public function decodeTotals(arg1:Object, arg2:core.units.Unit):core.totals.Totals
        {
            var loc88:*=0;
            var loc100:*=0;
            var loc109:*=0;
            var loc107:*=0;
            var loc2:*=null;
            var loc85:*=0;
            var loc87:*=0;
            var loc83:*=0;
            var loc136:*=0;
            var loc160:*=null;
            var loc181:*=false;
            var loc37:*;
            (loc37 = new core.totals.TotalsROX()).unitType = arg2.type;
            loc37.unit = arg2;
            var loc10:*;
            var loc22:*=(loc10 = arg1 as Array)[10] & 15;
            var loc55:*=(loc10[9] & 240) >> 4;
            var loc56:*=loc10[9] & 15;
            var loc79:*=(loc10[8] & 240) >> 4;
            var loc80:*=loc10[8] & 15;
            var loc96:*=(loc10[7] & 240) >> 4;
            var loc98:*=loc10[7] & 15;
            var loc3:*=(loc10[6] & 240) >> 4;
            var loc4:*=loc10[6] & 15;
            var loc16:*=(loc10[5] & 240) >> 4;
            var loc18:*=loc10[5] & 15;
            var loc12:*=(loc12 = (loc12 = (loc12 = (loc12 = (loc12 = loc22.toString()) + (loc55.toString() + loc56.toString())) + (loc79.toString() + loc80.toString())) + (loc96.toString() + loc98.toString())) + (loc3.toString() + loc4.toString())) + (loc16.toString() + loc18.toString());
            var loc26:*;
            (loc26 = new utils.converter.DistanceConverter()).inputFormat = core.MeasurementConfig.distanceFormat;
            loc26.outputFormat = "meter";
            loc37.totalDistance1 = loc26.convert(new Number(loc12) / 1000000);
            var loc20:*=(loc10[15] & 240) >> 4;
            var loc19:*=loc10[15] & 15;
            var loc5:*=(loc10[14] & 240) >> 4;
            var loc6:*=loc10[14] & 15;
            var loc101:*=(loc10[13] & 240) >> 4;
            var loc99:*=loc10[13] & 15;
            var loc81:*=(loc10[12] & 240) >> 4;
            var loc82:*=loc10[12] & 15;
            var loc59:*=(loc10[11] & 240) >> 4;
            var loc57:*=loc10[11] & 15;
            var loc41:*=(loc10[10] & 240) >> 4;
            var loc178:*=(loc178 = (loc178 = (loc178 = (loc178 = (loc178 = loc20.toString() + loc19.toString()) + (loc5.toString() + loc6.toString())) + (loc101.toString() + loc99.toString())) + (loc81.toString() + loc82.toString())) + (loc59.toString() + loc57.toString())) + loc41.toString();
            loc37.totalDistance2 = loc26.convert(new Number(loc178) / 1000000);
            var loc162:*=(loc10[25] & 240) >> 4;
            var loc161:*=loc10[25] & 15;
            var loc199:*=(loc10[24] & 240) >> 4;
            var loc201:*=loc10[24] & 15;
            var loc184:*=(loc10[23] & 240) >> 4;
            var loc182:*=loc10[23] & 15;
            var loc135:*=(loc10[22] & 240) >> 4;
            var loc137:*=loc10[22] & 15;
            var loc7:*=parseInt(loc162.toString() + loc161.toString() + loc199.toString() + loc201.toString());
            var loc183:*=parseInt(loc184.toString() + loc182.toString());
            var loc15:*=parseInt(loc135.toString() + loc137.toString());
            loc37.totalTrainingTime1 = (loc7 * 3600 + loc183 * 60 + loc15) * 100;
            var loc200:*=(loc10[29] & 240) >> 4;
            var loc198:*=loc10[29] & 15;
            var loc127:*=(loc10[28] & 240) >> 4;
            var loc126:*=loc10[28] & 15;
            var loc139:*=(loc10[27] & 240) >> 4;
            var loc138:*=loc10[27] & 15;
            var loc147:*=(loc10[26] & 240) >> 4;
            var loc146:*=loc10[26] & 15;
            var loc193:*=parseInt(loc200.toString() + loc198.toString() + loc127.toString() + loc126.toString());
            var loc13:*=parseInt(loc139.toString() + loc138.toString());
            var loc65:*=parseInt(loc147.toString() + loc146.toString());
            loc37.totalTrainingTime2 = (loc193 * 3600 + loc13 * 60 + loc65) * 100;
            var loc185:*;
            (loc185 = new utils.converter.AltitudeConverter()).inputFormat = core.MeasurementConfig.altitudeFormat;
            loc185.outputFormat = "millimeter";
            if ((loc10[48] & 240) >> 4 != 15) 
            {
                loc88 = (loc10[48] & 240) >> 4;
                loc100 = loc10[48] & 15;
                loc109 = (loc10[47] & 240) >> 4;
                loc107 = loc10[47] & 15;
                loc2 = loc88.toString() + loc100.toString() + loc109.toString() + loc107.toString();
            }
            else 
            {
                loc88 = loc10[48] & 15;
                loc109 = (loc10[47] & 240) >> 4;
                loc107 = loc10[47] & 15;
                loc2 = "-" + loc88.toString() + loc109.toString() + loc107.toString();
            }
            loc37.maxAltitude1 = loc185.convert(parseInt(loc2));
            if ((loc10[50] & 240) >> 4 != 15) 
            {
                loc85 = (loc10[50] & 240) >> 4;
                loc87 = loc10[50] & 15;
                loc83 = (loc10[49] & 240) >> 4;
                loc136 = loc10[49] & 15;
                loc160 = loc85.toString() + loc87.toString() + loc83.toString() + loc136.toString();
            }
            else 
            {
                loc85 = loc10[50] & 15;
                loc83 = (loc10[49] & 240) >> 4;
                loc136 = loc10[49] & 15;
                loc160 = "-" + loc85.toString() + loc83.toString() + loc136.toString();
            }
            loc37.maxAltitude2 = loc185.convert(parseInt(loc160));
            var loc89:*=loc10[54] & 15;
            var loc142:*=(loc10[53] & 240) >> 4;
            var loc143:*=loc10[53] & 15;
            var loc188:*=(loc10[52] & 240) >> 4;
            var loc189:*=loc10[52] & 15;
            var loc202:*=(loc10[51] & 240) >> 4;
            var loc204:*=loc10[51] & 15;
            var loc128:*=(loc128 = (loc128 = (loc128 = loc89.toString()) + (loc142.toString() + loc143.toString())) + (loc188.toString() + loc189.toString())) + (loc202.toString() + loc204.toString());
            loc37.totalClimbMeter1 = loc185.convert(parseInt(loc128) / 10);
            var loc172:*=(loc10[57] & 240) >> 4;
            var loc173:*=loc10[57] & 15;
            var loc165:*=(loc10[56] & 240) >> 4;
            var loc164:*=loc10[56] & 15;
            var loc203:*=(loc10[55] & 240) >> 4;
            var loc205:*=loc10[55] & 15;
            var loc153:*=(loc10[54] & 240) >> 4;
            var loc29:*=(loc29 = (loc29 = (loc29 = loc172.toString() + loc173) + (loc165.toString() + loc164.toString())) + (loc203.toString() + loc205.toString())) + loc153.toString();
            loc37.totalClimbMeter2 = loc185.convert(parseInt(loc29) / 10);
            var loc47:*=loc10[61] & 15;
            var loc72:*=(loc10[60] & 240) >> 4;
            var loc71:*=loc10[60] & 15;
            var loc48:*=(loc10[59] & 240) >> 4;
            var loc51:*=loc10[59] & 15;
            var loc114:*=(loc10[58] & 240) >> 4;
            var loc113:*=loc10[58] & 15;
            var loc195:*=(loc195 = (loc195 = (loc195 = loc47.toString()) + (loc72.toString() + loc71.toString())) + (loc48.toString() + loc51.toString())) + (loc114.toString() + loc113.toString());
            loc37.totalDescent1 = loc185.convert(parseInt(loc195) / 10);
            var loc53:*=(loc10[64] & 240) >> 4;
            var loc54:*=loc10[64] & 15;
            var loc91:*=(loc10[63] & 240) >> 4;
            var loc76:*=loc10[63] & 15;
            var loc111:*=(loc10[62] & 240) >> 4;
            var loc112:*=loc10[62] & 15;
            var loc103:*=(loc10[61] & 240) >> 4;
            var loc152:*=(loc152 = (loc152 = (loc152 = loc53.toString() + loc54.toString()) + (loc91.toString() + loc76.toString())) + (loc111.toString() + loc112.toString())) + loc103.toString();
            loc37.totalDescent2 = loc185.convert(parseInt(loc152) / 10);
            var loc92:*=(loc10[68] & 240) >> 4;
            var loc73:*=loc10[68] & 15;
            var loc70:*=(loc10[67] & 240) >> 4;
            var loc69:*=loc10[67] & 15;
            var loc50:*=(loc10[66] & 240) >> 4;
            var loc49:*=loc10[66] & 15;
            var loc159:*=(loc10[65] & 240) >> 4;
            var loc158:*=loc10[65] & 15;
            var loc168:*=(loc168 = (loc168 = parseInt(loc92.toString() + loc73.toString() + loc70.toString() + loc69.toString()) * 3600) + parseInt(loc50.toString() + loc49.toString()) * 60) + parseInt(loc159.toString() + loc158.toString());
            loc37.totalTimeUp1 = loc168 * 100;
            var loc118:*=(loc10[72] & 240) >> 4;
            var loc119:*=loc10[72] & 15;
            var loc157:*=(loc10[71] & 240) >> 4;
            var loc156:*=loc10[71] & 15;
            var loc148:*=(loc10[70] & 240) >> 4;
            var loc149:*=loc10[70] & 15;
            var loc66:*=(loc10[69] & 240) >> 4;
            var loc67:*=loc10[69] & 15;
            var loc150:*=(loc150 = (loc150 = parseInt(loc118.toString() + loc119.toString() + loc157.toString() + loc156.toString()) * 3600) + parseInt(loc148.toString() + loc149.toString()) * 60) + parseInt(loc66.toString() + loc67.toString());
            loc37.totalTimeUp2 = loc150 * 100;
            var loc176:*=(loc10[76] & 240) >> 4;
            var loc177:*=loc10[76] & 15;
            var loc131:*=(loc10[75] & 240) >> 4;
            var loc132:*=loc10[75] & 15;
            var loc115:*=(loc10[74] & 240) >> 4;
            var loc116:*=loc10[74] & 15;
            var loc155:*=(loc10[73] & 240) >> 4;
            var loc151:*=loc10[73] & 15;
            var loc123:*=(loc123 = (loc123 = parseInt(loc176.toString() + loc177.toString() + loc131.toString() + loc132.toString()) * 3600) + parseInt(loc115.toString() + loc116.toString()) * 60) + parseInt(loc155.toString() + loc151.toString());
            loc37.totalTimeDown1 = loc123 * 100;
            var loc169:*=(loc10[80] & 240) >> 4;
            var loc166:*=loc10[80] & 15;
            var loc180:*=(loc10[79] & 240) >> 4;
            var loc179:*=loc10[79] & 15;
            var loc196:*=(loc10[78] & 240) >> 4;
            var loc197:*=loc10[78] & 15;
            var loc121:*=(loc10[77] & 240) >> 4;
            var loc120:*=loc10[77] & 15;
            var loc190:*=(loc190 = (loc190 = parseInt(loc169.toString() + loc166.toString() + loc180.toString() + loc179.toString()) * 3600) + parseInt(loc196.toString() + loc197.toString()) * 60) + parseInt(loc121.toString() + loc120.toString());
            loc37.totalTimeDown2 = loc190 * 100;
            var loc8:*=loc10[86] & 15;
            var loc61:*=(loc10[85] & 240) >> 4;
            var loc63:*=loc10[85] & 15;
            var loc45:*=(loc10[84] & 240) >> 4;
            var loc46:*=loc10[84] & 15;
            var loc104:*=(loc10[83] & 240) >> 4;
            var loc106:*=loc10[83] & 15;
            var loc93:*=(loc10[82] & 240) >> 4;
            var loc84:*=loc10[82] & 15;
            var loc144:*=(loc10[81] & 240) >> 4;
            var loc145:*=loc10[81] & 15;
            var loc28:*=(loc28 = (loc28 = (loc28 = (loc28 = (loc28 = loc8.toString()) + (loc61.toString() + loc63.toString())) + (loc45.toString() + loc46.toString())) + (loc104.toString() + loc106.toString())) + (loc93.toString() + loc84.toString())) + (loc144.toString() + loc145.toString());
            loc37.totalTripDistUp1 = loc26.convert(new Number(loc28) / 1000000);
            var loc62:*=(loc10[91] & 240) >> 4;
            var loc64:*=loc10[91] & 15;
            var loc90:*=(loc10[90] & 240) >> 4;
            var loc86:*=loc10[90] & 15;
            var loc108:*=(loc10[89] & 240) >> 4;
            var loc110:*=loc10[89] & 15;
            var loc130:*=(loc10[88] & 240) >> 4;
            var loc129:*=loc10[88] & 15;
            var loc140:*=(loc10[87] & 240) >> 4;
            var loc141:*=loc10[87] & 15;
            var loc117:*=(loc10[86] & 240) >> 4;
            var loc124:*=(loc124 = (loc124 = (loc124 = (loc124 = (loc124 = loc62.toString() + loc64.toString()) + (loc90.toString() + loc86.toString())) + (loc108.toString() + loc110.toString())) + (loc130.toString() + loc129.toString())) + (loc140.toString() + loc141.toString())) + loc117.toString();
            loc37.totalTripDistUp2 = loc26.convert(new Number(loc124) / 1000000);
            var loc194:*=loc10[97] & 15;
            var loc17:*=(loc10[96] & 240) >> 4;
            var loc14:*=loc10[96] & 15;
            var loc74:*=(loc10[95] & 240) >> 4;
            var loc75:*=loc10[95] & 15;
            var loc94:*=(loc10[94] & 240) >> 4;
            var loc95:*=loc10[94] & 15;
            var loc38:*=(loc10[93] & 240) >> 4;
            var loc39:*=loc10[93] & 15;
            var loc68:*=(loc10[92] & 240) >> 4;
            var loc52:*=loc10[92] & 15;
            var loc125:*=(loc125 = (loc125 = (loc125 = (loc125 = (loc125 = loc194.toString()) + (loc17.toString() + loc14.toString())) + (loc74.toString() + loc75.toString())) + (loc94.toString() + loc95.toString())) + (loc38.toString() + loc39.toString())) + (loc68.toString() + loc52.toString());
            loc37.totalTripDistDown1 = loc26.convert(new Number(loc125) / 1000000);
            var loc60:*=(loc10[102] & 240) >> 4;
            var loc58:*=loc10[102] & 15;
            var loc42:*=(loc10[101] & 240) >> 4;
            var loc43:*=loc10[101] & 15;
            var loc97:*=(loc10[100] & 240) >> 4;
            var loc102:*=loc10[100] & 15;
            var loc77:*=(loc10[99] & 240) >> 4;
            var loc78:*=loc10[99] & 15;
            var loc134:*=(loc10[98] & 240) >> 4;
            var loc133:*=loc10[98] & 15;
            var loc30:*=(loc10[97] & 240) >> 4;
            var loc36:*=(loc36 = (loc36 = (loc36 = (loc36 = (loc36 = loc60.toString() + loc58.toString()) + (loc42.toString() + loc43.toString())) + (loc97.toString() + loc102.toString())) + (loc77.toString() + loc78.toString())) + (loc134.toString() + loc133.toString())) + loc30.toString();
            loc37.totalTripDistDown2 = loc26.convert(new Number(loc36) / 1000000);
            var loc34:*=(loc10[105] & 240) >> 4;
            var loc33:*=loc10[105] & 15;
            var loc27:*=(loc10[104] & 240) >> 4;
            var loc25:*=loc10[104] & 15;
            var loc175:*=(loc10[103] & 240) >> 4;
            var loc174:*=loc10[103] & 15;
            var loc105:*=(loc105 = (loc105 = loc34.toString() + loc33.toString()) + (loc27.toString() + loc25.toString())) + (loc175.toString() + loc174.toString());
            loc37.totalCal1 = parseInt(loc105);
            var loc163:*=(loc10[108] & 240) >> 4;
            var loc167:*=loc10[108] & 15;
            var loc171:*=(loc10[107] & 240) >> 4;
            var loc170:*=loc10[107] & 15;
            var loc186:*=(loc10[106] & 240) >> 4;
            var loc187:*=loc10[106] & 15;
            var loc154:*=(loc154 = (loc154 = loc163.toString() + loc167.toString()) + (loc171.toString() + loc170.toString())) + (loc186.toString() + loc187.toString());
            loc37.totalCal2 = parseInt(loc154);
            var loc32:*=(loc10[137] & 240) >> 4;
            var loc31:*=loc10[137] & 15;
            var loc40:*=(loc10[136] & 240) >> 4;
            var loc44:*=loc10[136] & 15;
            var loc21:*=loc32.toString() + loc31.toString() + loc40.toString() + loc44.toString();
            var loc191:*=(loc10[141] & 240) >> 4;
            var loc192:*=loc10[141] & 15;
            var loc24:*=(loc10[140] & 240) >> 4;
            var loc23:*=loc10[140] & 15;
            var loc9:*=(loc10[139] & 240) >> 4;
            var loc11:*=loc10[139] & 15;
            var loc1:*=(loc10[138] & 240) >> 4;
            var loc35:*=loc10[138] & 15;
            var loc122:*=(loc122 = (loc122 = (loc122 = loc191.toString() + loc192.toString()) + (loc24.toString() + loc23.toString())) + (loc9.toString() + loc11.toString())) + (loc1.toString() + loc35.toString());
            if (!loc181) 
            {
            };
            return loc37;
        }

        public function encodeUnitInformation(arg1:core.units.UnitROX):Array
        {
            var loc5:*=0;
            if (arg1.serialNumber == null || arg1.dateCode == null || arg1.maskingCode == null || arg1.initialWakeUpInfo == null || arg1.softwareRevision == null) 
            {
                return null;
            }
            var loc1:*=false;
            var loc3:*=[];
            var loc2:*=parseInt(arg1.serialNumber);
            var loc8:*=0;
            if (arg1 is core.units.UnitROX8) 
            {
                loc8 = loc2 - 10000000 + 1048576;
            }
            else 
            {
                loc8 = loc2 - 90000000 + 9437184;
            }
            loc3[0] = loc8 & 255;
            loc3[1] = (loc8 & 65280) >> 8;
            loc3[2] = (loc8 & 16711680) >> 16;
            var loc4:*=arg1.dateCode;
            loc3[3] = loc4.date / 10 << 4;
            var loc13:*=3;
            var loc14:*=loc3[loc13] | loc4.date % 10;
            loc3[loc13] = loc14;
            loc3[4] = (loc4.month + 1) / 10 << 4;
            loc14 = 4;
            loc13 = loc3[loc14] | (loc4.month + 1) % 10;
            loc3[loc14] = loc13;
            loc3[5] = loc4.fullYear % 100 / 10 << 4;
            loc13 = 5;
            loc14 = loc3[loc13] | loc4.fullYear % 100 % 10;
            loc3[loc13] = loc14;
            var loc11:*=parseInt("0x" + arg1.maskingCode);
            loc3[6] = loc11 & 255;
            loc3[7] = (loc11 & 65280) >> 8;
            loc3[8] = (loc11 & 16711680) >> 16;
            loc3[9] = (loc11 & 251658240) >> 24;
            var loc7:*=parseInt("0x" + arg1.initialWakeUpInfo);
            loc14 = 9;
            loc13 = loc3[loc14] | loc7 << 4;
            loc3[loc14] = loc13;
            var loc9:*=parseFloat(arg1.softwareRevision);
            var loc10:*=parseFloat(arg1.softwareRevision) * 10 % 10;
            var loc6:*=loc9 << 4;
            loc6 = loc6 | loc10;
            loc3[10] = loc6;
            var loc12:*=0;
            loc5 = 0;
            while (loc5 < 11) 
            {
                loc12 = loc12 + loc3[loc5];
                ++loc5;
            }
            loc12 = loc12 & 255;
            loc3[11] = loc12;
            loc3[12] = 212;
            loc3[13] = 116;
            loc3[14] = 148;
            loc3[15] = 53;
            if (!loc1) 
            {
            };
            return loc3;
        }

        public function encodeSettings(arg1:core.units.Unit):Array
        {
            var loc63:*=0;
            var loc37:*=0;
            var loc21:*=0;
            var loc30:*=0;
            var loc71:*=0;
            var loc72:*=null;
            var loc128:*=0;
            var loc96:*=new Array(142);
            var loc34:*=arg1.currentSettings as core.settings.SettingsROX;
            var loc78:*=(arg1 as core.units.UnitROX).currentTotals as core.totals.TotalsROX;
            var loc28:*=arg1 as core.units.UnitROX;
            loc63 = 0;
            while (loc63 < 142) 
            {
                loc96[loc63] = 0;
                ++loc63;
            }
            if (loc34.speedUnit != "mph") 
            {
                loc37 = 0;
            }
            else 
            {
                loc37 = 1;
            }
            var loc133:*=0;
            var loc134:*=loc96[loc133] | loc37;
            loc96[loc133] = loc134;
            loc134 = loc34.language;
            while ("de" === loc134) 
            {
                loc21 = 0;
            }
        }

        public function decodeNumberOfPages(arg1:Array):uint
        {
            var loc3:*=arg1[1] << 8;
            var loc2:*=arg1[0];
            var loc1:*=loc3 | loc2;
            return loc1;
        }

        public function decodeAddressOfPageHeaders(arg1:Array):void
        {
            var loc1:*=0;
            var loc19:*=0;
            var loc2:*=0;
            var loc31:*=0;
            var loc3:*=0;
            var loc26:*;
            var loc8:*;
            var loc14:*=((loc8 = (loc26 = arg1 as Array).slice(65360, 65370))[0] & 240) >> 4;
            var loc13:*=loc8[0] & 15;
            var loc12:*=(loc8[1] & 240) >> 4;
            var loc15:*=loc8[1] & 15;
            var loc27:*=loc12.toString(16) + loc15.toString(16) + loc14.toString(16) + loc13.toString(16);
            loc2 = parseInt(loc27, 16);
            var loc7:*=(loc8[3] & 240) >> 4;
            var loc33:*=loc8[3] & 15;
            var loc34:*=(loc8[2] & 240) >> 4;
            var loc21:*=loc8[2] & 15;
            var loc4:*=loc7.toString(16) + loc33.toString(16) + loc34.toString(16) + loc21.toString(16);
            loc31 = parseInt(loc4, 16);
            var loc24:*=(loc8[5] & 240) >> 4;
            var loc5:*=loc8[5] & 15;
            var loc6:*=(loc8[4] & 240) >> 4;
            var loc9:*=loc8[4] & 15;
            var loc32:*=loc24.toString(16) + loc5.toString(16) + loc6.toString(16) + loc9.toString(16);
            loc3 = parseInt(loc32, 16);
            var loc16:*=(loc8[6] & 240) >> 4;
            var loc20:*=loc8[6] & 15;
            var loc28:*=loc16.toString(16) + loc20.toString(16);
            loc1 = parseInt(loc28, 16);
            var loc22:*=(loc8[10] & 240) >> 4;
            var loc10:*=loc8[10] & 15;
            var loc25:*=(loc8[9] & 240) >> 4;
            var loc29:*=loc8[9] & 15;
            var loc23:*=(loc8[8] & 240) >> 4;
            var loc11:*=loc8[8] & 15;
            var loc18:*=(loc8[7] & 240) >> 4;
            var loc30:*=loc8[7] & 15;
            var loc17:*=loc22.toString() + loc10.toString() + loc25.toString() + loc29.toString() + loc23.toString() + loc11.toString() + loc18.toString() + loc30.toString();
            loc19 = parseInt(loc17, 10);
            return;
        }

        public function decodePageHeaderInformation(arg1:Array, arg2:core.units.Unit):core.activities.Activity
        {
            var loc10:*=0;
            var loc24:*=null;
            var loc9:*=null;
            var loc66:*=NaN;
            var loc59:*;
            (loc59 = core.activities.ActivityFactory.createActivityFromUnitType(arg2.type, "log")).unit = arg2;
            loc59.serialNumber = arg2.serialNumber;
            loc59.pageHeaderData = arg1;
            var loc35:*=(arg1[1] & 48) >> 4;
            var loc20:*=arg1[1] & 15;
            var loc22:*=(arg1[0] & 240) >> 4;
            var loc19:*=arg1[0] & 15;
            var loc43:*=loc35.toString() + loc20.toString() + loc22.toString() + loc19.toString();
            loc10 = parseInt(loc43, 10);
            loc59.wheelSize = loc10;
            var loc49:*;
            if ((loc49 = (arg1[1] & 64) >> 6) != 1) 
            {
                loc9 = "kmh";
            }
            else 
            {
                loc9 = "mph";
            }
            loc59.speedUnit = loc9;
            var loc44:*;
            if ((loc44 = (arg1[1] & 128) >> 7) != 1) 
            {
                loc24 = "bike1";
            }
            else 
            {
                loc24 = "bike2";
            }
            loc59.bike = loc24;
            var loc31:*;
            var loc25:*=(loc31 = arg1[2]).toString();
            var loc41:*=parseInt(loc25, 10);
            loc59.hrMax = loc41;
            var loc32:*;
            var loc37:*=(loc32 = arg1[3]).toString();
            var loc3:*=parseInt(loc37, 10);
            loc59.zone1Start = loc3;
            var loc1:*=arg1[4];
            var loc6:*=loc1.toString();
            var loc57:*=parseInt(loc6, 10);
            loc59.zone2Start = loc57;
            var loc65:*;
            var loc26:*=(loc65 = arg1[5]).toString();
            var loc45:*=parseInt(loc26, 10);
            loc59.zone3Start = loc45;
            var loc23:*;
            var loc54:*=(loc23 = arg1[6]).toString();
            var loc48:*=parseInt(loc54, 10);
            loc59.zone3End = loc48;
            var loc53:*=(arg1[7] & 240) >> 4;
            var loc47:*=arg1[7] & 15;
            var loc52:*=(arg1[8] & 240) >> 4;
            var loc68:*=arg1[8] & 15;
            var loc58:*;
            var loc77:*=(loc58 = arg1[9] & 15).toString() + loc52.toString() + loc68.toString() + loc53.toString() + loc47.toString();
            loc59.calories = parseInt(loc77);
            var loc73:*=(arg1[12] & 48) >> 4;
            var loc30:*=arg1[12] & 15;
            var loc29:*=(arg1[11] & 240) >> 4;
            var loc34:*=arg1[11] & 15;
            var loc28:*=(arg1[10] & 240) >> 4;
            var loc11:*=arg1[10] & 15;
            var loc46:*=parseInt(loc73.toString() + loc30.toString());
            var loc36:*=parseInt(loc29.toString() + loc34.toString());
            var loc27:*=parseInt(loc28.toString() + loc11.toString());
            var loc42:*=(arg1[18] & 240) >> 4;
            var loc75:*=arg1[18] & 15;
            var loc71:*=(arg1[17] & 240) >> 4;
            var loc4:*=arg1[17] & 15;
            var loc72:*=(arg1[16] & 240) >> 4;
            var loc61:*=arg1[16] & 15;
            var loc40:*=parseInt("20" + loc42.toString(16) + loc75.toString(16));
            var loc38:*=parseInt(loc71.toString(16) + loc4.toString(16));
            var loc50:*=parseInt(loc72.toString(16) + loc61.toString(16));
            var loc8:*=new Date(loc40, (loc38 - 1), loc50, loc46, loc36, loc27);
            loc59.startDate = loc8;
            loc59.dateCode = loc59.startDate.toString();
            var loc62:*;
        }

        public function decodeLog(arg1:core.activities.Activity, arg2:Array):void
        {
            var loc9:*=null;
            var loc1:*=null;
            var loc5:*=NaN;
            var loc4:*=0;
            var loc8:*=0;
            var loc7:*=1;
            var loc2:*=0;
            arg1.entries = new __AS3__.vec.Vector.<core.activities.ActivityEntry>();
            arg1.markerList = new __AS3__.vec.Vector.<core.marker.Marker>();
            var loc3:*;
            (loc3 = new utils.converter.SpeedConverter()).inputFormat = "kmh";
            loc3.outputFormat = "ms";
            loc8 = 0;
            for (;;) 
            {
                if (loc8 % 10 != 0) 
                {
                    loc9 = arg2.slice(loc4, loc4 + 6);
                    if (isPause(loc9)) 
                    {
                        loc1 = this.decodeRelLogPauseEntry(loc9, arg1);
                    }
                    else 
                    {
                        loc1 = this.decodeRelLogEntry(loc9, arg1);
                    }
                    loc1 = makeAbsolutEntry(loc1, arg1.entries[(loc8 - 1)]);
                    loc4 = loc4 + 6;
                }
                else 
                {
                    loc9 = arg2.slice(loc4, loc4 + 7);
                    if (isPause(loc9)) 
                    {
                        loc1 = this.decodeAbsLogPauseEntry(loc9, arg1);
                    }
                    else 
                    {
                        loc1 = this.decodeAbsLogEntry(loc9, arg1);
                    }
                    loc4 = loc4 + 7;
                }
                loc5 = loc1.speed / (2200 / arg1.wheelSize);
                loc5 = Math.round(loc5 * 100) / 100;
                loc1.speed = loc3.convert(loc5);
                if (loc1.speed > 0) 
                {
                    loc1.speedTime = Math.floor(1000 / loc1.speed);
                }
                else 
                {
                    loc1.speedTime = 1200;
                }
                if (loc1.speedTime > 1200) 
                {
                    loc1.speedTime = 1200;
                }
                arg1.entries.push(loc1);
                if (loc4 >= arg2.length) 
                {
                    break;
                }
                ++loc8;
            }
            var loc6:*;
        }

        internal function decodeTrip(arg1:int, arg2:core.units.UnitROX):core.activities.Activity
        {
            var loc160:*=null;
            var loc142:*=null;
            var loc41:*=null;
            var loc119:*=null;
            var loc74:*=null;
            var loc161:*;
            (loc161 = core.activities.ActivityFactory.createActivityFromUnitType(arg2.type, "memory")).unit = arg2;
            loc161.serialNumber = arg2.serialNumber;
            var loc169:*=(_7infotripArray[arg1] & 240) >> 4;
            var loc151:*=_7infotripArray[arg1] & 15;
            var loc152:*=(_7infotripArray[arg1 + 1] & 240) >> 4;
            var loc193:*=_7infotripArray[arg1 + 1] & 15;
            var loc150:*=(_7infotripArray[arg1 + 2] & 240) >> 4;
            var loc170:*=_7infotripArray[arg1 + 2] & 15;
            var loc75:*=(_7infotripArray[arg1 + 3] & 240) >> 4;
            var loc84:*=_7infotripArray[arg1 + 3] & 15;
            var loc83:*=(_7infotripArray[arg1 + 4] & 112) >> 4;
            var loc33:*=_7infotripArray[arg1 + 4] & 15;
            loc161.startDate = new Date("20" + loc150.toString() + loc170.toString(), (parseInt(loc152.toString() + loc193.toString()) - 1), loc169.toString() + loc151.toString(), loc83.toString() + loc33.toString(), loc75.toString() + loc84.toString());
            loc161.dateCode = loc161.startDate.toString();
            if ((_7infotripArray[arg1 + 4] & 128) >> 7 != 1) 
            {
                loc161.bike = "bike1";
            }
            else 
            {
                loc161.bike = "bike2";
            }
            if ((_7infotripArray[arg1 + 72] & 128) >> 7 != 1) 
            {
                loc161.speedUnit = "kmh";
            }
            else 
            {
                loc161.speedUnit = "mph";
            }
            var loc47:*=new utils.converter.DistanceConverter();
            if (loc161.speedUnit != "kmh") 
            {
                if (loc161.speedUnit == "mph") 
                {
                    loc47.inputFormat = "mile";
                }
            }
            else 
            {
                loc47.inputFormat = "kilometer";
            }
            loc47.outputFormat = "kilometer";
            var loc166:*=(_7infotripArray[arg1 + 5] & 240) >> 4;
            var loc115:*=_7infotripArray[arg1 + 5] & 15;
            var loc120:*=(_7infotripArray[arg1 + 6] & 240) >> 4;
            var loc97:*=_7infotripArray[arg1 + 6] & 15;
            var loc121:*=(_7infotripArray[arg1 + 7] & 240) >> 4;
            var loc15:*=_7infotripArray[arg1 + 7] & 15;
            var loc149:*=loc121.toString() + loc15.toString() + loc120.toString() + loc97.toString() + "." + loc166.toString() + loc115.toString();
            loc161.distance = loc47.convert(new Number(loc149)) * 1000;
            var loc124:*=(_7infotripArray[arg1 + 8] & 240) >> 4;
            var loc109:*=_7infotripArray[arg1 + 8] & 15;
            var loc108:*=(_7infotripArray[arg1 + 9] & 240) >> 4;
            var loc59:*=_7infotripArray[arg1 + 9] & 15;
            var loc111:*=(_7infotripArray[arg1 + 10] & 240) >> 4;
            var loc44:*=_7infotripArray[arg1 + 10] & 15;
            var loc110:*=(_7infotripArray[arg1 + 11] & 240) >> 4;
            var loc25:*=_7infotripArray[arg1 + 11] & 15;
            var loc102:*=parseInt(loc110.toString() + loc25.toString() + loc111.toString() + loc44.toString());
            var loc212:*=parseInt(loc108.toString() + loc59.toString());
            var loc48:*=parseInt(loc124.toString() + loc109.toString());
            loc161.trainingTime = (loc102 * 3600 + loc212 * 60 + loc48) * 100;
            var loc144:*=new utils.converter.SpeedConverter();
            if (loc161.speedUnit != "kmh") 
            {
                if (loc161.speedUnit == "mph") 
                {
                    loc144.inputFormat = "mph";
                }
            }
            else 
            {
                loc144.inputFormat = "kmh";
            }
            loc144.outputFormat = "ms";
            var loc61:*=(_7infotripArray[arg1 + 12] & 240) >> 4;
            var loc206:*=_7infotripArray[arg1 + 12] & 15;
            var loc46:*=(_7infotripArray[arg1 + 13] & 240) >> 4;
            var loc130:*=_7infotripArray[arg1 + 13] & 15;
            var loc28:*;
            var loc178:*=(loc28 = _7infotripArray[arg1 + 14] & 15).toString() + loc46.toString() + loc130.toString() + "." + loc61.toString() + loc206.toString();
            loc161.averageSpeed = loc144.convert(new Number(loc178));
            var loc34:*=(_7infotripArray[arg1 + 16] & 240) >> 4;
            var loc69:*=_7infotripArray[arg1 + 16] & 15;
            var loc71:*=(_7infotripArray[arg1 + 15] & 240) >> 4;
            var loc17:*=_7infotripArray[arg1 + 15] & 15;
            var loc66:*=(_7infotripArray[arg1 + 14] & 240) >> 4;
            var loc10:*=loc34.toString() + loc69.toString() + loc71.toString() + "." + loc17.toString() + loc66.toString();
            loc161.maximumSpeed = loc144.convert(new Number(loc10));
            var loc49:*=(_7infotripArray[arg1 + 17] & 240) >> 4;
            var loc22:*=_7infotripArray[arg1 + 17] & 15;
            var loc21:*=(_7infotripArray[arg1 + 18] & 240) >> 4;
            var loc211:*=_7infotripArray[arg1 + 18] & 15;
            var loc19:*;
            if ((loc19 = _7infotripArray[arg1 + 19] & 15) != 15) 
            {
                loc142 = loc19 + loc21.toString() + loc211.toString() + "." + loc49.toString() + loc22.toString();
                loc161.distancePlus = loc47.convert(new Number(loc142)) * 1000;
            }
            else 
            {
                loc160 = "-" + loc21.toString() + loc211.toString() + "." + loc49.toString() + loc22.toString();
                loc161.distancePlus = loc47.convert(new Number(loc160)) * 1000;
            }
            var loc60:*=(_7infotripArray[arg1 + 21] & 240) >> 4;
            var loc96:*=_7infotripArray[arg1 + 21] & 15;
            var loc93:*=(_7infotripArray[arg1 + 20] & 240) >> 4;
            var loc196:*=_7infotripArray[arg1 + 20] & 15;
            var loc94:*=(_7infotripArray[arg1 + 19] & 240) >> 4;
            var loc145:*="";
            if (loc60 != 15) 
            {
                loc145 = loc60.toString() + loc96.toString() + loc93.toString() + "." + loc196.toString() + loc94.toString();
            }
            else 
            {
                loc145 = "-" + loc96.toString() + loc93.toString() + "." + loc196.toString() + loc94.toString();
            }
            loc161.distanceMinus = loc47.convert(new Number(loc145)) * 1000;
            var loc165:*=(_7infotripArray[arg1 + 22] & 240) >> 4;
            var loc67:*=_7infotripArray[arg1 + 22] & 15;
            var loc81:*=loc165.toString(16) + loc67.toString(16);
            loc161.averageCadence = parseInt(loc81, 16);
            var loc51:*=(_7infotripArray[arg1 + 23] & 240) >> 4;
            var loc104:*=_7infotripArray[arg1 + 23] & 15;
            var loc29:*=loc51.toString(16) + loc104.toString(16);
            loc161.maximumCadence = parseInt(loc29, 16);
            var loc105:*=(_7infotripArray[arg1 + 24] & 240) >> 4;
            var loc54:*=_7infotripArray[arg1 + 24] & 15;
            var loc73:*=loc105.toString(16) + loc54.toString(16);
            loc161.averageHeartrate = parseInt(loc73, 16);
            var loc7:*=(_7infotripArray[arg1 + 25] & 240) >> 4;
            var loc79:*=_7infotripArray[arg1 + 25] & 15;
            var loc92:*=loc7.toString(16) + loc79.toString(16);
            loc161.maximumHeartrate = parseInt(loc92, 16);
            var loc18:*=(_7infotripArray[arg1 + 26] & 240) >> 4;
            var loc182:*=_7infotripArray[arg1 + 26] & 15;
            var loc180:*=(_7infotripArray[arg1 + 27] & 240) >> 4;
            var loc98:*=_7infotripArray[arg1 + 27] & 15;
            var loc172:*=(_7infotripArray[arg1 + 28] & 240) >> 4;
            var loc77:*=_7infotripArray[arg1 + 28] & 15;
            var loc42:*=parseInt(loc172.toString() + loc77.toString());
            var loc30:*=parseInt(loc180.toString() + loc98.toString());
            var loc6:*=parseInt(loc18.toString() + loc182.toString());
            loc161.timeInZone1 = (loc42 * 3600 + loc30 * 60 + loc6) * 100;
            var loc72:*=(_7infotripArray[arg1 + 29] & 240) >> 4;
            var loc36:*=_7infotripArray[arg1 + 29] & 15;
            var loc38:*=(_7infotripArray[arg1 + 30] & 240) >> 4;
            var loc82:*=_7infotripArray[arg1 + 30] & 15;
            var loc40:*=(_7infotripArray[arg1 + 31] & 240) >> 4;
            var loc31:*=_7infotripArray[arg1 + 31] & 15;
            var loc192:*=parseInt(loc40.toString() + loc31.toString());
            var loc146:*=parseInt(loc38.toString() + loc82.toString());
            var loc129:*=parseInt(loc72.toString() + loc36.toString());
            loc161.timeInZone2 = (loc192 * 3600 + loc146 * 60 + loc129) * 100;
            var loc122:*=(_7infotripArray[arg1 + 32] & 240) >> 4;
            var loc116:*=_7infotripArray[arg1 + 32] & 15;
            var loc114:*=(_7infotripArray[arg1 + 33] & 240) >> 4;
            var loc58:*=_7infotripArray[arg1 + 33] & 15;
            var loc117:*=(_7infotripArray[arg1 + 34] & 240) >> 4;
            var loc8:*=_7infotripArray[arg1 + 34] & 15;
            var loc209:*=parseInt(loc117.toString() + loc8.toString());
            var loc100:*=parseInt(loc114.toString() + loc58.toString());
            var loc13:*=parseInt(loc122.toString() + loc116.toString());
            loc161.timeInZone3 = (loc209 * 3600 + loc100 * 60 + loc13) * 100;
            var loc162:*=(_7infotripArray[arg1 + 37] & 240) >> 4;
            var loc175:*=_7infotripArray[arg1 + 37] & 15;
            var loc176:*=(_7infotripArray[arg1 + 36] & 240) >> 4;
            var loc210:*=_7infotripArray[arg1 + 36] & 15;
            var loc171:*=(_7infotripArray[arg1 + 35] & 240) >> 4;
            var loc207:*=_7infotripArray[arg1 + 35] & 15;
            var loc55:*=loc162.toString() + loc175.toString() + loc176.toString() + loc210.toString() + loc171.toString() + loc207.toString();
            loc161.calories = parseInt(loc55, 10);
            var loc63:*=(_7infotripArray[arg1 + 39] & 240) >> 4;
            var loc26:*=_7infotripArray[arg1 + 39] & 15;
            var loc23:*=(_7infotripArray[arg1 + 38] & 240) >> 4;
            var loc156:*=_7infotripArray[arg1 + 38] & 15;
            var loc132:*;
            (loc132 = new utils.converter.TemperatureConverter()).outputFormat = "celsius";
            if (loc63 != 15) 
            {
                loc161.minimumTemperature = loc132.convert(parseFloat(loc63.toString() + loc26.toString() + loc23.toString() + "." + loc156.toString()));
            }
            else 
            {
                loc41 = "-" + loc26.toString() + loc23.toString() + "." + loc156.toString();
                loc161.minimumTemperature = loc132.convert(new Number(loc41));
            }
            var loc57:*=(_7infotripArray[arg1 + 41] & 240) >> 4;
            var loc181:*=_7infotripArray[arg1 + 41] & 15;
            var loc185:*=(_7infotripArray[arg1 + 40] & 240) >> 4;
            var loc183:*=_7infotripArray[arg1 + 40] & 15;
            if (loc57 != 15) 
            {
                loc161.maximumTemperature = loc132.convert(parseFloat(loc57.toString() + loc181.toString() + loc185.toString() + "." + loc183.toString()));
            }
            else 
            {
                loc119 = "-" + loc181.toString() + loc185.toString() + "." + loc183.toString();
                loc161.maximumTemperature = loc132.convert(new Number(loc119));
            }
            var loc148:*=(_7infotripArray[arg1 + 43] & 240) >> 4;
            var loc194:*=_7infotripArray[arg1 + 43] & 15;
            var loc195:*=(_7infotripArray[arg1 + 42] & 240) >> 4;
            var loc184:*=_7infotripArray[arg1 + 42] & 15;
            var loc204:*;
            (loc204 = new utils.converter.AltitudeConverter()).inputFormat = core.MeasurementConfig.altitudeFormat;
            loc204.outputFormat = "millimeter";
            if (loc148 != 15) 
            {
                loc161.maximumAltitude = loc204.convert(parseInt(loc148.toString() + loc194.toString() + loc195.toString() + loc184.toString(), 10));
            }
            else 
            {
                loc74 = "-" + loc194.toString() + loc195.toString() + loc184.toString();
                loc161.maximumAltitude = loc204.convert(new Number(loc74));
            }
            var loc32:*=(_7infotripArray[arg1 + 44] & 240) >> 4;
            var loc90:*=_7infotripArray[arg1 + 44] & 15;
            var loc80:*=(_7infotripArray[arg1 + 45] & 240) >> 4;
            var loc16:*=_7infotripArray[arg1 + 45] & 15;
            var loc78:*=(_7infotripArray[arg1 + 46] & 240) >> 4;
            var loc3:*=_7infotripArray[arg1 + 46] & 15;
            var loc147:*=loc78.toString() + loc3.toString() + loc80.toString() + loc16.toString() + "." + loc32.toString() + loc90.toString();
            loc161.distanceUphill = loc47.convert(new Number(loc147)) * 1000;
            var loc187:*=_7infotripArray[arg1 + 50] & 15;
            var loc12:*=(_7infotripArray[arg1 + 49] & 240) >> 4;
            var loc186:*=_7infotripArray[arg1 + 49] & 15;
            var loc190:*=(_7infotripArray[arg1 + 48] & 240) >> 4;
            var loc53:*=_7infotripArray[arg1 + 48] & 15;
            var loc189:*=(_7infotripArray[arg1 + 47] & 240) >> 4;
            var loc70:*=_7infotripArray[arg1 + 47] & 15;
            var loc123:*=parseInt(loc187.toString() + loc12.toString() + loc186.toString());
            var loc52:*=parseInt(loc190.toString() + loc53.toString());
            var loc173:*=parseInt(loc189.toString() + loc70.toString());
            loc161.trainingTimeUphill = (loc123 * 3600 + loc52 * 60 + loc173) * 100;
            var loc158:*=(_7infotripArray[arg1 + 52] & 240) >> 4;
            var loc157:*=_7infotripArray[arg1 + 52] & 15;
            var loc155:*=(_7infotripArray[arg1 + 51] & 240) >> 4;
            var loc1:*=_7infotripArray[arg1 + 51] & 15;
            var loc154:*=(_7infotripArray[arg1 + 50] & 240) >> 4;
            var loc89:*=loc158.toString() + loc157.toString() + loc155.toString() + "." + loc1.toString() + loc154.toString();
            loc161.averageSpeedUphill = loc144.convert(new Number(loc89));
            var loc106:*=(_7infotripArray[arg1 + 53] & 240) >> 4;
            var loc107:*=_7infotripArray[arg1 + 53] & 15;
            var loc139:*=loc106.toString() + loc107.toString();
            loc161.averageInclineUphill = parseInt(loc139, 10);
            var loc197:*=(_7infotripArray[arg1 + 54] & 240) >> 4;
            var loc179:*=_7infotripArray[arg1 + 54] & 15;
            var loc177:*=loc197.toString() + loc179.toString();
            loc161.maximumInclineUphill = parseInt(loc177, 10);
            var loc56:*=(_7infotripArray[arg1 + 56] & 240) >> 4;
            var loc99:*=_7infotripArray[arg1 + 56] & 15;
            var loc101:*=(_7infotripArray[arg1 + 55] & 240) >> 4;
            var loc202:*=_7infotripArray[arg1 + 55] & 15;
            var loc95:*;
            var loc164:*=(loc95 = _7infotripArray[arg1 + 57] & 15).toString() + loc56.toString() + loc99.toString() + loc101.toString() + loc202.toString();
            loc161.altitudeDifferencesUphill = loc204.convert(parseInt(loc164, 10));
            var loc159:*=(_7infotripArray[arg1 + 59] & 240) >> 4;
            var loc9:*=_7infotripArray[arg1 + 59] & 15;
            var loc14:*=(_7infotripArray[arg1 + 58] & 240) >> 4;
            var loc91:*=_7infotripArray[arg1 + 58] & 15;
            var loc11:*=(_7infotripArray[arg1 + 57] & 240) >> 4;
            var loc118:*=loc159.toString() + loc9.toString() + loc14.toString() + loc91.toString() + loc11.toString();
            loc161.altitudeDifferencesDownhill = loc204.convert(parseInt(loc118, 10));
            var loc201:*=(_7infotripArray[arg1 + 62] & 240) >> 4;
            var loc127:*=_7infotripArray[arg1 + 62] & 15;
            var loc126:*=(_7infotripArray[arg1 + 61] & 240) >> 4;
            var loc191:*=_7infotripArray[arg1 + 61] & 15;
            var loc125:*=(_7infotripArray[arg1 + 60] & 240) >> 4;
            var loc167:*=_7infotripArray[arg1 + 60] & 15;
            var loc103:*=loc201.toString() + loc127.toString() + loc126.toString() + loc191.toString() + "." + loc125.toString() + loc167.toString();
            loc161.distanceDownhill = loc47.convert(new Number(loc103)) * 1000;
            var loc4:*=(_7infotripArray[arg1 + 63] & 240) >> 4;
            var loc135:*=_7infotripArray[arg1 + 63] & 15;
            var loc137:*=(_7infotripArray[arg1 + 64] & 240) >> 4;
            var loc24:*=_7infotripArray[arg1 + 64] & 15;
            var loc138:*=(_7infotripArray[arg1 + 65] & 240) >> 4;
            var loc43:*=_7infotripArray[arg1 + 65] & 15;
            var loc134:*=_7infotripArray[arg1 + 66] & 15;
            var loc200:*=parseInt(loc134.toString() + loc138.toString() + loc43.toString());
            var loc112:*=parseInt(loc137.toString() + loc24.toString());
            var loc131:*=parseInt(loc4.toString() + loc135.toString());
            loc161.trainingTimeDownhill = (loc200 * 3600 + loc112 * 60 + loc131) * 100;
            var loc141:*=(_7infotripArray[arg1 + 68] & 240) >> 4;
            var loc37:*=_7infotripArray[arg1 + 68] & 15;
            var loc39:*=(_7infotripArray[arg1 + 67] & 240) >> 4;
            var loc50:*=_7infotripArray[arg1 + 67] & 15;
            var loc35:*=(_7infotripArray[arg1 + 66] & 240) >> 4;
            var loc85:*=loc141.toString() + loc37.toString() + loc39.toString() + "." + loc50.toString() + loc35.toString();
            loc161.averageSpeedDownhill = loc144.convert(new Number(loc85));
            var loc174:*=(_7infotripArray[arg1 + 69] & 240) >> 4;
            var loc136:*=_7infotripArray[arg1 + 69] & 15;
            var loc140:*=loc174.toString() + loc136.toString();
            loc161.averageInclineDownhill = parseInt(loc140, 10);
            var loc62:*=(_7infotripArray[arg1 + 70] & 240) >> 4;
            var loc203:*=_7infotripArray[arg1 + 70] & 15;
            var loc153:*=loc62.toString() + loc203.toString();
            loc161.maximumInclineDownhill = parseInt(loc153, 10);
            var loc163:*=(_7infotripArray[arg1 + 72] & 112) >> 4;
            var loc64:*=_7infotripArray[arg1 + 72] & 15;
            var loc65:*=(_7infotripArray[arg1 + 71] & 240) >> 4;
            var loc133:*=_7infotripArray[arg1 + 71] & 15;
            var loc113:*=loc163.toString() + loc64.toString() + loc65.toString() + loc133.toString();
            loc161.wheelSize = parseInt(loc113);
            var loc199:*=(_7infotripArray[arg1 + 73] & 240) >> 4;
            var loc128:*=_7infotripArray[arg1 + 73] & 15;
            var loc86:*=loc199.toString(16) + loc128.toString(16);
            loc161.hrMax = parseInt(loc86, 16);
            var loc168:*=(_7infotripArray[arg1 + 74] & 240) >> 4;
            var loc45:*=_7infotripArray[arg1 + 74] & 15;
            var loc68:*=loc168.toString(16) + loc45.toString(16);
            loc161.zone1Start = parseInt(loc68, 16);
            var loc205:*=(_7infotripArray[arg1 + 75] & 240) >> 4;
            var loc20:*=_7infotripArray[arg1 + 75] & 15;
            var loc87:*=loc205.toString(16) + loc20.toString(16);
            loc161.zone2Start = parseInt(loc87, 16);
            var loc198:*=(_7infotripArray[arg1 + 76] & 240) >> 4;
            var loc208:*=_7infotripArray[arg1 + 76] & 15;
            var loc27:*=loc198.toString(16) + loc208.toString(16);
            loc161.zone3Start = parseInt(loc27, 16);
            var loc143:*=(_7infotripArray[arg1 + 77] & 240) >> 4;
            var loc88:*=_7infotripArray[arg1 + 77] & 15;
            var loc76:*=loc143.toString(16) + loc88.toString(16);
            loc161.zone3End = parseInt(loc76, 16);
            var loc2:*=(_7infotripArray[arg1 + 78] & 240) >> 4;
            var loc188:*=_7infotripArray[arg1 + 78] & 15;
            var loc5:*=loc2.toString(16) + loc188.toString(16);
            return loc161;
        }

        internal function decodeTripList():Array
        {
            var loc2:*=_7infotripArray[553] & 15;
            var loc1:*=(_7infotripArray[553] & 240) >> 4;
            var loc3:*=new Array(2);
            loc3[0] = loc2;
            loc3[1] = loc1;
            return loc3;
        }

        internal function createChecksum3(arg1:Array):Number
        {
            var loc1:*=NaN;
            var loc2:*=null;
            var loc3:*=0;
            loc1 = 0;
            while (loc1 < 136) 
            {
                loc2 = arg1.slice(loc1, loc1 + 1);
                loc3 = loc3 + parseInt(loc2[0]);
                ++loc1;
            }
            return loc3;
        }

        internal function setFavIndex(arg1:String):uint
        {
            if (core.general.Favorites.FAVORITES_GUI.indexOf(arg1) == 40) 
            {
                return 9;
            }
            return core.general.Favorites.FAVORITES.indexOf(arg1);
        }

        internal function calculateValuesFromBasisValues(arg1:core.activities.Activity, arg2:core.activities.ActivityEntry, arg3:core.activities.ActivityEntry):core.activities.Activity
        {
            if (arg1.zone1Start <= arg2.heartrate && arg1.zone2Start > arg2.heartrate) 
            {
                arg2.targetZone = 1;
                arg1.timeInZone1 = arg1.timeInZone1 + arg2.trainingTime;
            }
            else if (arg1.zone2Start <= arg2.heartrate && arg1.zone3Start > arg2.heartrate) 
            {
                arg2.targetZone = 2;
                arg1.timeInZone2 = arg1.timeInZone2 + arg2.trainingTime;
            }
            else if (arg1.zone3Start <= arg2.heartrate && arg1.zone3End > arg2.heartrate) 
            {
                arg2.targetZone = 3;
                arg1.timeInZone3 = arg1.timeInZone3 + arg2.trainingTime;
            }
            else 
            {
                arg2.targetZone = 0;
                arg1.timeOutOfZone = arg1.timeOutOfZone + arg2.trainingTime;
            }
            if (arg3 != null) 
            {
                arg2.distance = calculateDistance(arg1.wheelSize, arg2.relativeRotations);
                if (arg1.entries.length > 0) 
                {
                    arg2.distanceAbsolute = arg3.distanceAbsolute + arg2.distance;
                    arg2.trainingTimeAbsolute = arg3.trainingTimeAbsolute + arg2.trainingTime;
                }
                if (arg3.altitude < arg2.altitude && !arg2.isPause) 
                {
                    arg2.altitudeDifferencesUphill = arg2.altitude - arg3.altitude;
                    arg2.distanceUphill = arg2.distance;
                    arg2.trainingTimeUphill = arg2.trainingTime;
                    arg1.distanceUphill = arg1.distanceUphill + arg2.distanceUphill;
                    arg1.trainingTimeUphill = arg1.trainingTimeUphill + arg2.trainingTimeUphill;
                    arg1.altitudeDifferencesUphill = arg1.altitudeDifferencesUphill + arg2.altitudeDifferencesUphill;
                }
                else if (arg3.altitude > arg2.altitude && !arg2.isPause) 
                {
                    arg2.altitudeDifferencesDownhill = arg3.altitude - arg2.altitude;
                    arg2.distanceDownhill = arg2.distance;
                    arg2.trainingTimeDownhill = arg2.trainingTime;
                    arg1.distanceDownhill = arg1.distanceDownhill + arg2.distanceDownhill;
                    arg1.trainingTimeDownhill = arg1.trainingTimeDownhill + arg2.trainingTimeDownhill;
                    arg1.altitudeDifferencesDownhill = arg1.altitudeDifferencesDownhill + arg2.altitudeDifferencesDownhill;
                }
                else 
                {
                    arg2.altitudeDifferencesDownhill = 0;
                    arg2.distanceDownhill = 0;
                    arg2.trainingTimeDownhill = 0;
                    arg2.altitudeDifferencesUphill = 0;
                    arg2.distanceUphill = 0;
                    arg2.trainingTimeUphill = 0;
                }
            }
            arg1.pauseTime = arg1.pauseTime + arg2.pauseTime;
            arg1.trainingTime = arg1.trainingTime + arg2.trainingTime;
            arg1.distance = arg1.distance + arg2.distance;
            return arg1;
        }

        internal function calcMinMaxValues(arg1:core.activities.Activity, arg2:core.activities.ActivityEntry):core.activities.Activity
        {
            if (arg1.minimumSpeed > arg2.speed || isNaN(arg1.minimumSpeed)) 
            {
                arg1.minimumSpeed = arg2.speed;
            }
            if (arg1.maximumSpeed < arg2.speed || isNaN(arg1.maximumSpeed)) 
            {
                arg1.maximumSpeed = arg2.speed;
            }
            if (arg1.minimumAltitude > arg2.altitude || isNaN(arg1.minimumAltitude)) 
            {
                arg1.minimumAltitude = arg2.altitude;
            }
            if (arg1.maximumAltitude < arg2.altitude || isNaN(arg1.maximumAltitude)) 
            {
                arg1.maximumAltitude = arg2.altitude;
            }
            if (arg1.maximumHeartrate < arg2.heartrate || isNaN(arg1.maximumHeartrate)) 
            {
                arg1.maximumHeartrate = arg2.heartrate;
            }
            if (arg1.minimumHeartrate > arg2.heartrate || isNaN(arg1.minimumHeartrate)) 
            {
                arg1.minimumHeartrate = arg2.heartrate;
            }
            if (arg1.minimumTemperature > arg2.temperature || isNaN(arg1.minimumTemperature)) 
            {
                arg1.minimumTemperature = arg2.temperature;
            }
            if (arg1.maximumTemperature < arg2.temperature || isNaN(arg1.maximumTemperature)) 
            {
                arg1.maximumTemperature = arg2.temperature;
            }
            if (arg1.minimumIncline > arg2.incline || isNaN(arg1.minimumIncline)) 
            {
                arg1.minimumIncline = arg2.incline;
            }
            if (arg1.maximumIncline < arg2.incline || isNaN(arg1.maximumIncline)) 
            {
                arg1.maximumIncline = arg2.incline;
            }
            if (arg1.minimumRiseRate > arg2.riseRate || isNaN(arg1.minimumRiseRate)) 
            {
                arg1.minimumRiseRate = arg2.riseRate;
            }
            if (arg1.maximumRiseRate < arg2.riseRate || isNaN(arg1.maximumRiseRate)) 
            {
                arg1.maximumRiseRate = arg2.riseRate;
            }
            return arg1;
        }

        internal function calcAverages(arg1:core.activities.Activity, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Number):core.activities.Activity
        {
            var loc1:*=arg6;
            arg1.averageAltitude = arg3 / loc1;
            arg1.averageHeartrate = arg4 / loc1;
            arg1.averageSpeed = arg2 / loc1;
            arg1.averageTemperature = arg5 / loc1;
            return arg1;
        }

        internal function makeAbsolutEntry(arg1:core.activities.ActivityEntry, arg2:core.activities.ActivityEntry):core.activities.ActivityEntry
        {
            arg1.temperature = arg2.temperature;
            if (!(arg1.temperature > 40)) 
            {
            };
            return arg1;
        }

        internal function calculateRotations(arg1:Number, arg2:Number):uint
        {
            var loc1:*=0;
            if (arg1 < arg2) 
            {
                loc1 = arg1 - arg2 + 1024;
            }
            else 
            {
                loc1 = arg1 - arg2;
            }
            return loc1;
        }

        internal function calculateIncline(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number):Number
        {
            var loc2:*=0;
            var loc1:*=0;
            arg1 = arg1 / 1000;
            arg2 = arg2 / 1000;
            loc2 = 100 * (arg1 - arg2) / Math.sqrt(Math.pow(arg4 * arg3 / 1000, 2) - Math.pow(arg1 - arg2, 2));
            loc2 = (loc2 = Math.round(loc2 * 100)) / 100;
            if (isNaN(loc2)) 
            {
                loc2 = 0;
            }
            return loc2;
        }

        internal function calculateInclineRel(arg1:Number, arg2:Number, arg3:Number, arg4:Number):Number
        {
            var loc1:*=0;
            arg1 = arg1 / 1000;
            arg2 = arg2 / 1000;
            loc1 = 100 * (arg1 - arg2) / Math.sqrt(Math.pow(arg4 * arg3 / 1000, 2) - Math.pow(arg1 - arg2, 2));
            loc1 = (loc1 = Math.round(loc1 * 100)) / 100;
            if (isNaN(loc1)) 
            {
                loc1 = 0;
            }
            return Math.round(loc1);
        }

        internal function calculateDistance(arg1:int, arg2:int):Number
        {
            return Math.round(arg1 * arg2) / 1000;
        }

        internal function isPause(arg1:Array):Boolean
        {
            if ((arg1[0] & 1) == 0) 
            {
                return false;
            }
            return true;
        }

        internal function decodeAbsLogEntry(arg1:Array, arg2:core.activities.Activity):core.activities.ActivityEntry
        {
            var loc8:*=0;
            var loc11:*=0;
            var loc5:*=0;
            var loc10:*;
            (loc10 = core.activities.ActivityFactory.createLogEntryFromLog(arg2)).isPause = false;
            var loc13:*;
            var loc14:*=(loc13 = (arg1[0] & 252) >> 2) - 10;
            loc10.temperature = loc14;
            var loc7:*;
            if ((loc7 = (arg1[0] & 2) >> 1) != 0) 
            {
                loc10.isWaypoint = true;
            }
            else 
            {
                loc10.isWaypoint = false;
            }
            var loc6:*;
            if ((loc6 = arg1[1]) == 20) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 504, "ROXDecoder > Decoding > Wrong heartrate value"));
            }
            loc10.heartrate = loc6;
            var loc1:*=(loc8 = (loc8 = (loc8 = (arg1[3] & 63) << 8) | arg1[2]) - 999) * 1000;
            if (loc1 == 5000000) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 502, "ROXDecoder > Decoding > Wrong altitude value"));
            }
            loc10.altitude = loc1;
            var loc9:*=0;
            var loc3:*=loc9 = (loc9 = (loc9 = (loc9 = (loc9 = arg1[5] & 1) << 8) | arg1[4]) << 1) | (arg1[3] & 128) >> 7;
            loc10.rotations = loc3;
            var loc12:*=0;
            if ((loc12 = (loc11 = (loc11 = (arg1[6] & 7) << 7) | arg1[5] >> 1) * 0.2) < 1 && loc12 > 0) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 503, "ROXDecoder > Decoding > Wrong speed value"));
            }
            loc10.speed = loc12;
            loc10.trainingTime = arg2.samplingRate * 100;
            var loc2:*=arg1[6] >> 3;
            var loc4:*=0;
            loc5 = 0;
            while (loc5 < 6) 
            {
                loc4 = (loc4 = loc4 + (arg1[loc5] & 15)) + ((arg1[loc5] & 240) >> 4);
                ++loc5;
            }
            if ((loc4 = (loc4 = loc4 + (arg1[6] & 7)) & 31) != loc2) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 505, "ROXDecoder > Decoding > Wrong checksum6"));
            }
            return loc10;
        }

        internal function decodeAbsLogPauseEntry(arg1:Array, arg2:core.activities.Activity):core.activities.ActivityEntry
        {
            var loc4:*=0;
            var loc7:*;
            (loc7 = core.activities.ActivityFactory.createLogEntryFromLog(arg2)).isPause = true;
            var loc11:*;
            var loc13:*=(loc11 = (arg1[0] & 252) >> 2) - 10;
            loc7.temperature = loc13;
            var loc6:*;
            if ((loc6 = (arg1[0] & 2) >> 1) != 0) 
            {
                loc7.isWaypoint = true;
            }
            else 
            {
                loc7.isWaypoint = false;
            }
            var loc5:*;
            if ((loc5 = arg1[1]) == 20) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 504, "ROXDecoder > Decoding > Wrong heartrate value"));
            }
            loc7.heartrate = loc5;
            var loc10:*=0;
            if ((loc10 = ((loc10 = (loc10 = (arg1[3] & 63) << 8) | arg1[2]) - 999) * 1000) == 5000000) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 502, "ROXDecoder > Decoding > Wrong altitude value"));
            }
            loc7.altitude = loc10;
            var loc2:*=0;
            var loc8:*;
            if ((loc8 = loc2 = (loc2 = (arg1[4] & 31) << 1) | (arg1[3] & 128) >> 7) != 63) 
            {
                loc7.trainingTime = loc8;
            }
            var loc9:*=0;
            var loc12:*=loc9 = (loc9 = (loc9 = (arg1[6] & 7) << 11) | arg1[5] << 3) | (arg1[4] & 224) >> 5;
            loc7.pauseTime = loc12 * 100;
            var loc1:*=arg1[6] >> 3;
            var loc3:*=0;
            loc4 = 0;
            while (loc4 < 6) 
            {
                loc3 = (loc3 = loc3 + (arg1[loc4] & 15)) + ((arg1[loc4] & 240) >> 4);
                ++loc4;
            }
            if ((loc3 = (loc3 = loc3 + (arg1[6] & 7)) & 31) != loc1) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 505, "ROXDecoder > Decoding > Wrong checksum6"));
            }
            return loc7;
        }

        internal function decodeRelLogEntry(arg1:Array, arg2:core.activities.Activity):core.activities.ActivityEntry
        {
            var loc8:*=0;
            var loc2:*;
            (loc2 = core.activities.ActivityFactory.createLogEntryFromLog(arg2)).isPause = false;
            var loc9:*;
            if ((loc9 = (arg1[0] & 2) >> 1) != 0) 
            {
                loc2.isWaypoint = true;
            }
            else 
            {
                loc2.isWaypoint = false;
            }
            var loc10:*=0;
            loc10 = (loc10 = (arg1[1] & 15) << 6) | (arg1[0] & 252) >> 2;
            loc2.rotations = loc10;
            var loc1:*=0;
            var loc5:*=0;
            loc1 = (arg1[2] & 63) << 4;
            loc1 = loc1 | (arg1[1] & 240) >> 4;
            if ((loc5 = loc1 * 0.2) < 1 && loc5 > 0) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 503, "ROXDecoder > Decoding > Wrong speed value"));
            }
            loc2.speed = loc5;
            var loc7:*;
            if ((loc7 = ((loc7 = (loc7 = (loc7 = (loc7 = (arg1[4] & 7) << 8) | arg1[3]) << 2) | (arg1[2] & 192) >> 6) - 999) * 1000) == 5000000) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 502, "ROXDecoder > Decoding > Wrong altitude value"));
            }
            loc2.altitude = loc7;
            var loc3:*=0;
            if ((loc3 = (loc3 = (arg1[5] & 7) << 5) | (arg1[4] & 248) >> 3) == 20) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 504, "ROXDecoder > Decoding > Wrong heartrate value"));
            }
            loc2.heartrate = loc3;
            loc2.trainingTime = arg2.samplingRate * 100;
            var loc4:*=arg1[5] >> 3;
            var loc6:*=0;
            loc8 = 0;
            while (loc8 < 5) 
            {
                loc6 = (loc6 = loc6 + (arg1[loc8] & 15)) + ((arg1[loc8] & 240) >> 4);
                ++loc8;
            }
            if ((loc6 = (loc6 = loc6 + (arg1[5] & 7)) & 31) != loc4) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 506, "ROXDecoder > Decoding > Wrong checksum7"));
            }
            return loc2;
        }

        internal function decodeRelLogPauseEntry(arg1:Array, arg2:core.activities.Activity):core.activities.ActivityEntry
        {
            var loc9:*=0;
            var loc1:*=core.activities.ActivityFactory.createLogEntryFromLog(arg2);
            loc1.isPause = true;
            var loc10:*;
            if ((loc10 = (arg1[0] & 2) >> 1) != 0) 
            {
                loc1.isWaypoint = true;
            }
            else 
            {
                loc1.isWaypoint = false;
            }
            var loc4:*;
            var loc2:*=(loc4 = (arg1[0] & 252) >> 2).toString();
            if (parseInt(loc2) != 63) 
            {
                loc1.trainingTime = parseInt(loc2);
            }
            var loc6:*=0;
            loc6 = (loc6 = (arg1[2] & 63) << 8) | arg1[1];
            loc1.pauseTime = loc6 * 100;
            var loc8:*;
            if ((loc8 = ((loc8 = (loc8 = (loc8 = (loc8 = (arg1[4] & 7) << 8) | arg1[3]) << 2) | (arg1[2] & 192) >> 6) - 999) * 1000) == 5000000) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 502, "ROXDecoder > Decoding > Wrong altitude value"));
            }
            loc1.altitude = loc8;
            var loc3:*=0;
            if ((loc3 = (loc3 = (arg1[5] & 7) << 5) | (arg1[4] & 248) >> 3) == 20) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 504, "ROXDecoder > Decoding > Wrong heartrate value"));
            }
            loc1.heartrate = loc3;
            var loc5:*=arg1[5] >> 3;
            var loc7:*=0;
            loc9 = 0;
            while (loc9 < 5) 
            {
                loc7 = (loc7 = loc7 + (arg1[loc9] & 15)) + ((arg1[loc9] & 240) >> 4);
                ++loc9;
            }
            if ((loc7 = (loc7 = loc7 + (arg1[5] & 7)) & 31) != loc5) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 506, "ROXDecoder > Decoding > Wrong checksum7"));
            }
            return loc1;
        }

        internal function smoothEntries_v1(arg1:core.activities.Activity):core.activities.Activity
        {
            var loc20:*=null;
            var loc28:*=null;
            var loc13:*=null;
            var loc18:*=null;
            var loc15:*=null;
            var loc22:*=NaN;
            var loc26:*=0;
            var loc6:*=0;
            var loc2:*=null;
            var loc21:*=null;
            var loc23:*=NaN;
            var loc24:*=arg1.entries;
            var loc34:*=0;
            var loc17:*=0;
            var loc30:*=0;
            var loc16:*=0;
            var loc1:*=0;
            var loc14:*=0;
            var loc12:*=0;
            var loc11:*=0;
            var loc10:*=0;
            var loc9:*=0;
            var loc19:*=0;
            var loc33:*=0;
            var loc32:*=0;
            var loc31:*=0;
            var loc29:*=0;
            var loc25:*=0;
            var loc27:*=0;
            var loc35:*=0;
            var loc36:*=0;
            var loc7:*=0;
            var loc8:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc3:*=0;
            loc22 = 0;
            while (loc22 < loc24.length) 
            {
                loc20 = loc24[loc22];
                if (loc22 > 0) 
                {
                    loc28 = loc24[(loc22 - 1)];
                    if (loc20.isPause) 
                    {
                        loc20.rotations = loc28.rotations;
                    }
                    loc20.relativeRotations = calculateRotations(loc20.rotations, loc28.rotations);
                }
                if (loc22 < (loc24.length - 1)) 
                {
                    if ((loc18 = loc24[loc22 + 1]).isPause) 
                    {
                        loc18.rotations = loc20.rotations;
                    }
                    loc18.relativeRotations = calculateRotations(loc18.rotations, loc20.rotations);
                }
                if (loc22 < loc24.length - 2) 
                {
                    if ((loc15 = loc24[loc22 + 2]).isPause) 
                    {
                        loc15.rotations = loc18.rotations;
                    }
                    loc15.relativeRotations = calculateRotations(loc15.rotations, loc18.rotations);
                }
                if (loc22 > 1) 
                {
                    loc13 = loc24[loc22 - 2];
                }
                if (loc20.speed < 0.5 && loc20.speed > 0) 
                {
                    if (loc28 == null) 
                    {
                        loc20.speed = 0;
                        loc20.riseRate = 0;
                    }
                    else 
                    {
                        loc20.speed = loc28.speed;
                        loc20.riseRate = loc28.riseRate;
                    }
                }
                if (loc20.altitude == 5000000) 
                {
                    if (loc28 == null) 
                    {
                        loc20.altitude = 0;
                        loc20.incline = 0;
                        loc20.riseRate = 0;
                    }
                    else 
                    {
                        loc20.altitude = loc28.altitude;
                        loc20.incline = loc28.incline;
                        loc20.riseRate = loc28.riseRate;
                    }
                }
                if (loc20.heartrate <= 20) 
                {
                    if (loc28 == null) 
                    {
                        loc20.heartrate = 0;
                    }
                    else 
                    {
                        loc20.heartrate = loc28.heartrate;
                    }
                }
                if (loc22 == 0) 
                {
                    loc20.trainingTime = 0;
                }
                if (loc20.isPause && !(loc28 == null) && loc28.isPause) 
                {
                    loc28.pauseTime = loc28.pauseTime + loc20.pauseTime;
                    loc28.relativeRotations = loc28.relativeRotations + loc20.relativeRotations;
                    loc28.trainingTime = loc28.trainingTime + loc20.trainingTime;
                    loc28.speed = (loc28.speed + loc20.speed) / 2;
                    loc28.altitude = (loc28.altitude + loc20.altitude) / 2;
                    loc28.temperature = (loc28.temperature + loc20.temperature) / 2;
                    loc28.heartrate = (loc28.heartrate + loc20.heartrate) / 2;
                    if (loc28.isWaypoint || loc20.isWaypoint) 
                    {
                        loc28.isWaypoint = true;
                    }
                    handler.ActivityCalculator.removeEntryFromEntriesVector(loc20, loc24);
                    --loc22;
                }
                else 
                {
                    if (!(loc28 == null) && !(loc13 == null) && loc28.isPause) 
                    {
                        loc26 = loc13.relativeRotations * 0.7 / arg1.samplingRate * 100 * loc28.trainingTime;
                        if (loc28.trainingTime > 0 && loc26 == 0) 
                        {
                            loc26 = 1;
                        }
                        if ((loc6 = loc20.relativeRotations - loc26) < 0) 
                        {
                            loc6 = 0;
                            loc28.relativeRotations = loc20.relativeRotations;
                        }
                        else 
                        {
                            loc28.relativeRotations = loc26;
                        }
                        loc20.relativeRotations = loc6;
                        if (!loc20.isPause) 
                        {
                            loc13.trainingTime = loc13.trainingTime + loc28.trainingTime;
                            loc13.trainingTimeAbsolute = loc13.trainingTimeAbsolute + loc28.trainingTime;
                            loc13.relativeRotations = loc13.relativeRotations + loc28.relativeRotations;
                            loc28.trainingTime = 0;
                            loc28.trainingTimeAbsolute = loc13.trainingTimeAbsolute;
                            loc28.trainingTimeDownhill = 0;
                            loc28.trainingTimeUphill = 0;
                            loc28.relativeRotations = 0;
                            loc28.altitudeDifferencesDownhill = 0;
                            loc28.altitudeDifferencesUphill = 0;
                            loc28.distance = 0;
                            loc28.distanceDownhill = 0;
                            loc28.distanceUphill = 0;
                            loc28.temperature = loc13.temperature;
                            loc28.incline = 0;
                            loc28.riseRate = 0;
                            loc28.speed = 0;
                        }
                    }
                    if (arg1.samplingRate != 4.5) 
                    {
                        if (arg1.samplingRate != 10.125) 
                        {
                            if (arg1.samplingRate != 20.25) 
                            {
                                if (arg1.samplingRate == 30.375) 
                                {
                                    if (loc28) 
                                    {
                                        loc20.incline = calculateIncline(loc20.altitude, loc28.altitude, arg1.wheelSize, loc20.relativeRotations, loc28.relativeRotations);
                                        loc20.riseRate = loc20.speed * 3.6 / 0.06 * loc20.incline / 100 * 1000;
                                    }
                                }
                            }
                            else if (loc28) 
                            {
                                loc20.incline = calculateIncline(loc20.altitude, loc28.altitude, arg1.wheelSize, loc20.relativeRotations, loc28.relativeRotations);
                                loc20.riseRate = loc20.speed * 3.6 / 0.06 * loc20.incline / 100 * 1000;
                            }
                        }
                        else 
                        {
                            if (loc20.heartrate == 0 && loc18 && loc28) 
                            {
                                if (loc18.heartrate != 0) 
                                {
                                    if (loc28 != null) 
                                    {
                                        loc20.heartrate = loc28.heartrate;
                                        ++loc3;
                                    }
                                }
                            }
                            if (loc22 == 0 && loc18) 
                            {
                                loc14 = loc20.altitude;
                                loc12 = loc18.altitude;
                                loc33 = loc19 = (loc14 + loc12) / 2;
                                loc29 = loc20.relativeRotations;
                                loc25 = loc18.relativeRotations;
                                loc8 = loc7 = (loc29 + loc25) / 2;
                            }
                            else if (loc22 == (loc24.length - 1) && loc28) 
                            {
                                loc14 = loc28.altitude;
                                loc12 = loc20.altitude;
                                loc32 = (loc14 + loc12) / 2;
                                loc29 = loc28.relativeRotations;
                                loc25 = loc20.relativeRotations;
                                loc4 = (loc29 + loc25) / 2;
                                loc28.incline = this.calculateInclineRel(loc33, loc19, arg1.wheelSize, loc25);
                                loc28.riseRate = loc28.speed * 3.6 / 0.06 * loc28.incline / 100 * 1000;
                                loc20.incline = this.calculateInclineRel(loc32, loc33, arg1.wheelSize, loc27);
                                loc20.riseRate = loc20.speed * 3.6 / 0.06 * loc20.incline / 100 * 1000;
                            }
                            else if (loc28 && loc18) 
                            {
                                loc14 = loc28.altitude;
                                loc12 = loc20.altitude;
                                loc11 = loc18.altitude;
                                loc29 = loc28.relativeRotations;
                                loc25 = loc20.relativeRotations;
                                loc27 = loc18.relativeRotations;
                                loc32 = (loc14 + loc12 + loc11) / 3;
                                loc4 = (loc29 + loc25 + loc27) / 3;
                                if (loc28.isPause) 
                                {
                                    loc19 = loc33 = loc32 = (loc20.altitude + loc18.altitude) / 2;
                                    loc7 = loc8 = loc4 = (loc20.relativeRotations + loc18.relativeRotations) / 2;
                                }
                                else 
                                {
                                    if (loc20.isPause) 
                                    {
                                        loc12 = loc11 = loc28.altitude;
                                        loc25 = loc27 = loc28.relativeRotations;
                                    }
                                    else if (loc18.isPause) 
                                    {
                                        loc11 = loc20.altitude;
                                        loc27 = loc20.relativeRotations;
                                    }
                                    loc32 = (loc14 + loc12 + loc11) / 3;
                                    loc4 = (loc29 + loc25 + loc27) / 3;
                                    loc28.incline = this.calculateInclineRel(loc33, loc19, arg1.wheelSize, loc25);
                                    loc28.riseRate = loc28.speed * 3.6 / 0.06 * loc28.incline / 100;
                                    loc19 = loc33;
                                    loc33 = loc32;
                                    loc7 = loc8;
                                    loc8 = loc4;
                                }
                            }
                        }
                    }
                    else 
                    {
                        if (loc20.heartrate == 0 && loc28 && loc18 && loc15) 
                        {
                            if (loc18.heartrate != 0) 
                            {
                                if (loc28 != null) 
                                {
                                    loc20.heartrate = loc28.heartrate;
                                    ++loc3;
                                }
                            }
                            else if (loc15.heartrate != 0) 
                            {
                                if (loc28 != null) 
                                {
                                    loc20.heartrate = loc28.heartrate;
                                    loc18.heartrate = loc28.heartrate;
                                    loc3 = loc3 + 2;
                                }
                            }
                        }
                        if (loc22 == 0 && loc18 && loc15) 
                        {
                            loc14 = loc20.altitude;
                            loc12 = loc18.altitude;
                            loc11 = loc15.altitude;
                            loc33 = loc19 = (loc14 + loc12 + loc11) / 3;
                            loc29 = loc20.relativeRotations;
                            loc25 = loc18.relativeRotations;
                            loc27 = loc15.relativeRotations;
                            loc8 = loc7 = (loc29 + loc25 + loc27) / 3;
                        }
                        else if (loc22 == 1 && loc28 && loc18 && loc15) 
                        {
                            loc14 = loc28.altitude;
                            loc12 = loc20.altitude;
                            loc11 = loc18.altitude;
                            loc10 = loc15.altitude;
                            loc32 = (loc14 + loc12 + loc11 + loc10) / 4;
                            loc29 = loc28.relativeRotations;
                            loc25 = loc20.relativeRotations;
                            loc27 = loc18.relativeRotations;
                            loc35 = loc15.relativeRotations;
                            loc4 = (loc29 + loc25 + loc27 + loc35) / 4;
                        }
                        else if (loc22 == (loc24.length - 1) && loc13 && loc28) 
                        {
                            loc14 = loc13.altitude;
                            loc12 = loc28.altitude;
                            loc11 = loc20.altitude;
                            loc31 = (loc14 + loc12 + loc11) / 3;
                            loc29 = loc13.relativeRotations;
                            loc25 = loc28.relativeRotations;
                            loc27 = loc20.relativeRotations;
                            loc5 = (loc29 + loc25 + loc27) / 3;
                            loc13.incline = this.calculateInclineRel(loc33, loc19, arg1.wheelSize, loc8);
                            loc13.riseRate = loc13.speed * 3.6 / 0.06 * loc13.incline / 100 * 1000;
                            loc28.incline = this.calculateInclineRel(loc32, loc33, arg1.wheelSize, loc4);
                            loc28.riseRate = loc28.speed * 3.6 / 0.06 * loc28.incline / 100 * 1000;
                            loc20.incline = this.calculateInclineRel(loc31, loc32, arg1.wheelSize, loc5);
                            loc20.riseRate = loc20.speed * 3.6 / 0.06 * loc20.incline / 100 * 1000;
                        }
                        else if (loc22 == loc24.length - 2 && loc13 && loc28 && loc18) 
                        {
                            loc14 = loc13.altitude;
                            loc12 = loc28.altitude;
                            loc11 = loc20.altitude;
                            loc10 = loc18.altitude;
                            loc31 = (loc14 + loc12 + loc11 + loc10) / 4;
                            loc29 = loc13.relativeRotations;
                            loc25 = loc28.relativeRotations;
                            loc27 = loc20.relativeRotations;
                            loc35 = loc18.relativeRotations;
                            loc5 = (loc29 + loc25 + loc27 + loc35) / 4;
                            loc13.incline = this.calculateInclineRel(loc33, loc19, arg1.wheelSize, loc8);
                            loc13.riseRate = loc13.speed * 3.6 / 0.06 * loc13.incline / 100 * 1000;
                            loc7 = loc8;
                            loc8 = loc4;
                            loc4 = loc5;
                            loc19 = loc33;
                            loc33 = loc32;
                            loc32 = loc31;
                        }
                        else if (loc13 && loc28 && loc18 && loc15) 
                        {
                            loc14 = loc13.altitude;
                            loc12 = loc28.altitude;
                            loc11 = loc20.altitude;
                            loc10 = loc18.altitude;
                            loc9 = loc15.altitude;
                            loc29 = loc13.relativeRotations;
                            loc25 = loc28.relativeRotations;
                            loc27 = loc20.relativeRotations;
                            loc35 = loc18.relativeRotations;
                            loc36 = loc15.relativeRotations;
                            loc31 = (loc14 + loc12 + loc11 + loc10 + loc9) / 5;
                            loc5 = (loc29 + loc25 + loc27 + loc35 + loc36) / 5;
                            if (loc13.isPause) 
                            {
                                loc19 = loc33 = loc32 = loc31 = (loc28.altitude + loc20.altitude + loc18.altitude + loc15.altitude) / 4;
                                loc7 = loc8 = loc4 = loc5 = (loc28.relativeRotations + loc20.relativeRotations + loc18.relativeRotations + loc15.relativeRotations) / 4;
                            }
                            else 
                            {
                                if (loc28.isPause) 
                                {
                                    loc12 = loc11 = loc10 = loc9 = loc13.altitude;
                                    loc25 = loc27 = loc35 = loc36 = loc13.relativeRotations;
                                }
                                else if (loc20.isPause) 
                                {
                                    loc11 = loc10 = loc9 = loc28.altitude;
                                    loc27 = loc35 = loc36 = loc28.relativeRotations;
                                }
                                else if (loc18.isPause) 
                                {
                                    loc10 = loc9 = loc20.altitude;
                                    loc35 = loc36 = loc20.relativeRotations;
                                }
                                else if (loc15.isPause) 
                                {
                                    loc9 = loc18.altitude;
                                    loc36 = loc18.relativeRotations;
                                }
                                loc31 = (loc14 + loc12 + loc11 + loc10 + loc9) / 5;
                                loc5 = (loc29 + loc25 + loc27 + loc35 + loc36) / 5;
                                loc13.incline = this.calculateInclineRel(loc33, loc19, arg1.wheelSize, loc8);
                                loc13.riseRate = loc13.speed * 3.6 / 0.06 * loc13.incline / 100 * 1000;
                                loc7 = loc8;
                                loc8 = loc4;
                                loc4 = loc5;
                                loc19 = loc33;
                                loc33 = loc32;
                                loc32 = loc31;
                            }
                        }
                    }
                }
                ++loc22;
            }
            arg1.pauseTime = 0;
            arg1.trainingTime = 0;
            arg1.distance = 0;
            loc23 = 0;
            while (loc23 < loc24.length) 
            {
                loc2 = loc24[loc23];
                if (loc23 > 0) 
                {
                    loc21 = loc24[(loc23 - 1)];
                }
                if (!loc2.isPause) 
                {
                    loc34 = loc34 + loc2.speed;
                    loc17 = loc17 + loc2.altitude;
                    loc30 = loc30 + loc2.heartrate;
                    loc16 = loc16 + loc2.temperature;
                    ++loc1;
                }
                loc2.calories = arg1.calories / loc24.length;
                arg1 = calculateValuesFromBasisValues(arg1, loc2, loc21);
                arg1 = calcMinMaxValues(arg1, loc2);
                ++loc23;
            }
            arg1 = calcAverages(arg1, loc34, loc17, loc30, loc16, loc1);
            return arg1;
        }

        public static const MY_NAME:Array=["*", "+", "-", "=", ".", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", " ", "♥"];

        internal var _7infotripArray:Array;

        internal static var _instance:decoder.RoxDecoder;
    }
}


