//class Rox2010Decoder
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
    import init.*;
    import utils.*;
    import utils.converter.*;
    import utils.interfaces.*;
    
    public class Rox2010Decoder extends flash.events.EventDispatcher implements core.units.interfaces.ICodingSettings, core.activities.interfaces.ICodingLog
    {
        public function Rox2010Decoder()
        {
            super();
            com.logging.ErrorLogging.getInstance().addTarget(this);
            if (_instance) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10074, "ROXDecoder > Constructor: This is a Singleton. Use the getInstace() methode!"));
            }
            return;
        }

        public function decodeMemory(arg1:Object, arg2:core.units.Unit):__AS3__.vec.Vector.<core.activities.Activity>
        {
            var loc6:*=null;
            var loc7:*=NaN;
            _7infotripArray = arg1 as Array;
            var loc3:*=87;
            var loc5:*;
            var loc4:*=(loc5 = decodeTripList())[0];
            var loc8:*=loc5[1];
            var loc1:*=new __AS3__.vec.Vector.<core.activities.Activity>();
            var loc2:*=loc4;
            if (loc8 > 0) 
            {
                loc6 = decodeTrip(loc2 * loc3, arg2 as core.units.UnitROX2010);
                loc1[0] = loc6;
            }
            loc7 = 1;
            while (loc7 < loc8) 
            {
                if (loc2 != 0) 
                {
                    --loc2;
                }
                else 
                {
                    loc2 = 6;
                }
                loc6 = decodeTrip(loc2 * loc3, arg2 as core.units.UnitROX2010);
                loc1[loc7] = loc6;
                ++loc7;
            }
            return loc1;
        }

        public function decodeSettings(arg1:Object, arg2:core.units.Unit=null):core.settings.Settings
        {
            var loc164:*=false;
            var loc9:*=0;
            var loc10:*=0;
            var loc34:*=0;
            var loc40:*=0;
            var loc100:*=null;
            var loc129:*=0;
            var loc131:*=0;
            var loc98:*=0;
            var loc99:*=0;
            var loc77:*=null;
            var loc151:*=0;
            var loc154:*=0;
            var loc175:*=0;
            var loc173:*=0;
            var loc171:*=null;
            var loc78:*=0;
            var loc35:*=0;
            var loc56:*=0;
            var loc19:*=null;
            var loc75:*=0;
            var loc58:*=null;
            var loc42:*=0;
            var loc76:*=0;
            var loc153:*=false;
            var loc38:*=arg2 as core.units.UnitROX2010;
            var loc47:*;
            (loc47 = core.settings.SettingsFactory.createSettingsFromUnitType(arg2.type) as core.settings.SettingsROX2010).unitType = arg2.type;
            loc47.unit = arg2;
            var loc111:*;
            var loc36:*;
        }

        public function decodeTotals(arg1:Array, arg2:core.units.Unit):core.totals.Totals
        {
            var loc83:*=0;
            var loc95:*=0;
            var loc105:*=0;
            var loc103:*=0;
            var loc2:*=null;
            var loc80:*=0;
            var loc82:*=0;
            var loc78:*=0;
            var loc132:*=0;
            var loc157:*=null;
            var loc21:*=0;
            var loc179:*=false;
            var loc34:*;
            (loc34 = new core.totals.TotalsROX2010()).unitType = arg2.type;
            loc34.unit = arg2;
            var loc20:*=arg1[38] & 15;
            var loc50:*=(arg1[37] & 240) >> 4;
            var loc51:*=arg1[37] & 15;
            var loc74:*=(arg1[36] & 240) >> 4;
            var loc75:*=arg1[36] & 15;
            var loc91:*=(arg1[35] & 240) >> 4;
            var loc93:*=arg1[35] & 15;
            var loc3:*=(arg1[34] & 240) >> 4;
            var loc4:*=arg1[34] & 15;
            var loc15:*=(arg1[33] & 240) >> 4;
            var loc17:*=arg1[33] & 15;
            var loc11:*=(loc11 = (loc11 = (loc11 = (loc11 = (loc11 = loc20.toString()) + (loc50.toString() + loc51.toString())) + (loc74.toString() + loc75.toString())) + (loc91.toString() + loc93.toString())) + (loc3.toString() + loc4.toString())) + (loc15.toString() + loc17.toString());
            var loc25:*;
            (loc25 = new utils.converter.DistanceConverter()).inputFormat = core.MeasurementConfig.distanceFormat;
            loc25.outputFormat = "meter";
            loc34.totalDistance1 = loc25.convert(new Number(loc11) / 1000000);
            var loc19:*=(arg1[43] & 240) >> 4;
            var loc18:*=arg1[43] & 15;
            var loc5:*=(arg1[42] & 240) >> 4;
            var loc6:*=arg1[42] & 15;
            var loc96:*=(arg1[41] & 240) >> 4;
            var loc94:*=arg1[41] & 15;
            var loc76:*=(arg1[40] & 240) >> 4;
            var loc77:*=arg1[40] & 15;
            var loc54:*=(arg1[39] & 240) >> 4;
            var loc52:*=arg1[39] & 15;
            var loc37:*=(arg1[38] & 240) >> 4;
            var loc176:*=(loc176 = (loc176 = (loc176 = (loc176 = (loc176 = loc19.toString() + loc18.toString()) + (loc5.toString() + loc6.toString())) + (loc96.toString() + loc94.toString())) + (loc76.toString() + loc77.toString())) + (loc54.toString() + loc52.toString())) + loc37.toString();
            loc34.totalDistance2 = loc25.convert(new Number(loc176) / 1000000);
            var loc160:*=(arg1[53] & 240) >> 4;
            var loc159:*=arg1[53] & 15;
            var loc197:*=(arg1[52] & 240) >> 4;
            var loc199:*=arg1[52] & 15;
            var loc182:*=(arg1[51] & 240) >> 4;
            var loc180:*=arg1[51] & 15;
            var loc131:*=(arg1[50] & 240) >> 4;
            var loc133:*=arg1[50] & 15;
            var loc7:*=parseInt(loc160.toString() + loc159.toString() + loc197.toString() + loc199.toString());
            var loc181:*=parseInt(loc182.toString() + loc180.toString());
            var loc14:*=parseInt(loc131.toString() + loc133.toString());
            loc34.totalTrainingTime1 = (loc7 * 3600 + loc181 * 60 + loc14) * 100;
            var loc198:*=(arg1[57] & 240) >> 4;
            var loc196:*=arg1[57] & 15;
            var loc123:*=(arg1[56] & 240) >> 4;
            var loc122:*=arg1[56] & 15;
            var loc135:*=(arg1[55] & 240) >> 4;
            var loc134:*=arg1[55] & 15;
            var loc143:*=(arg1[54] & 240) >> 4;
            var loc142:*=arg1[54] & 15;
            var loc191:*=parseInt(loc198.toString() + loc196.toString() + loc123.toString() + loc122.toString());
            var loc12:*=parseInt(loc135.toString() + loc134.toString());
            var loc60:*=parseInt(loc143.toString() + loc142.toString());
            loc34.totalTrainingTime2 = (loc191 * 3600 + loc12 * 60 + loc60) * 100;
            var loc183:*;
            (loc183 = new utils.converter.AltitudeConverter()).inputFormat = core.MeasurementConfig.altitudeFormat;
            loc183.outputFormat = "millimeter";
            if ((arg1[76] & 240) >> 4 != 15) 
            {
                loc83 = (arg1[76] & 240) >> 4;
                loc95 = arg1[76] & 15;
                loc105 = (arg1[75] & 240) >> 4;
                loc103 = arg1[75] & 15;
                loc2 = loc83.toString() + loc95.toString() + loc105.toString() + loc103.toString();
            }
            else 
            {
                loc83 = arg1[76] & 15;
                loc105 = (arg1[75] & 240) >> 4;
                loc103 = arg1[75] & 15;
                loc2 = "-" + loc83.toString() + loc105.toString() + loc103.toString();
            }
            loc34.maxAltitude1 = loc183.convert(parseInt(loc2));
            if ((arg1[78] & 240) >> 4 != 15) 
            {
                loc80 = (arg1[78] & 240) >> 4;
                loc82 = arg1[78] & 15;
                loc78 = (arg1[77] & 240) >> 4;
                loc132 = arg1[77] & 15;
                loc157 = loc80.toString() + loc82.toString() + loc78.toString() + loc132.toString();
            }
            else 
            {
                loc80 = arg1[78] & 15;
                loc78 = (arg1[77] & 240) >> 4;
                loc132 = arg1[77] & 15;
                loc157 = "-" + loc80.toString() + loc78.toString() + loc132.toString();
            }
            loc34.maxAltitude2 = loc183.convert(parseInt(loc157));
            var loc84:*=arg1[82] & 15;
            var loc138:*=(arg1[81] & 240) >> 4;
            var loc139:*=arg1[81] & 15;
            var loc186:*=(arg1[80] & 240) >> 4;
            var loc187:*=arg1[80] & 15;
            var loc200:*=(arg1[79] & 240) >> 4;
            var loc202:*=arg1[79] & 15;
            var loc124:*=(loc124 = (loc124 = (loc124 = loc84.toString()) + (loc138.toString() + loc139.toString())) + (loc186.toString() + loc187.toString())) + (loc200.toString() + loc202.toString());
            loc34.totalClimbMeter1 = loc183.convert(parseInt(loc124) / 10);
            var loc170:*=(arg1[85] & 240) >> 4;
            var loc171:*=arg1[85] & 15;
            var loc163:*=(arg1[84] & 240) >> 4;
            var loc162:*=arg1[84] & 15;
            var loc201:*=(arg1[83] & 240) >> 4;
            var loc203:*=arg1[83] & 15;
            var loc149:*=(arg1[82] & 240) >> 4;
            var loc28:*=(loc28 = (loc28 = (loc28 = loc170.toString() + loc171) + (loc163.toString() + loc162.toString())) + (loc201.toString() + loc203.toString())) + loc149.toString();
            loc34.totalClimbMeter2 = loc183.convert(parseInt(loc28) / 10);
            var loc42:*=arg1[89] & 15;
            var loc67:*=(arg1[88] & 240) >> 4;
            var loc66:*=arg1[88] & 15;
            var loc43:*=(arg1[87] & 240) >> 4;
            var loc46:*=arg1[87] & 15;
            var loc110:*=(arg1[86] & 240) >> 4;
            var loc109:*=arg1[86] & 15;
            var loc193:*=(loc193 = (loc193 = (loc193 = loc42.toString()) + (loc67.toString() + loc66.toString())) + (loc43.toString() + loc46.toString())) + (loc110.toString() + loc109.toString());
            loc34.totalDescent1 = loc183.convert(parseInt(loc193) / 10);
            var loc48:*=(arg1[92] & 240) >> 4;
            var loc49:*=arg1[92] & 15;
            var loc86:*=(arg1[91] & 240) >> 4;
            var loc71:*=arg1[91] & 15;
            var loc107:*=(arg1[90] & 240) >> 4;
            var loc108:*=arg1[90] & 15;
            var loc98:*=(arg1[89] & 240) >> 4;
            var loc148:*=(loc148 = (loc148 = (loc148 = loc48.toString() + loc49.toString()) + (loc86.toString() + loc71.toString())) + (loc107.toString() + loc108.toString())) + loc98.toString();
            loc34.totalDescent2 = loc183.convert(parseInt(loc148) / 10);
            var loc87:*=(arg1[96] & 240) >> 4;
            var loc68:*=arg1[96] & 15;
            var loc65:*=(arg1[95] & 240) >> 4;
            var loc64:*=arg1[95] & 15;
            var loc45:*=(arg1[94] & 240) >> 4;
            var loc44:*=arg1[94] & 15;
            var loc155:*=(arg1[93] & 240) >> 4;
            var loc154:*=arg1[93] & 15;
            var loc166:*=(loc166 = (loc166 = parseInt(loc87.toString() + loc68.toString() + loc65.toString() + loc64.toString()) * 3600) + parseInt(loc45.toString() + loc44.toString()) * 60) + parseInt(loc155.toString() + loc154.toString());
            loc34.totalTimeUp1 = loc166 * 100;
            var loc114:*=(arg1[100] & 240) >> 4;
            var loc115:*=arg1[100] & 15;
            var loc153:*=(arg1[99] & 240) >> 4;
            var loc152:*=arg1[99] & 15;
            var loc144:*=(arg1[98] & 240) >> 4;
            var loc145:*=arg1[98] & 15;
            var loc61:*=(arg1[97] & 240) >> 4;
            var loc62:*=arg1[97] & 15;
            var loc146:*=(loc146 = (loc146 = parseInt(loc114.toString() + loc115.toString() + loc153.toString() + loc152.toString()) * 3600) + parseInt(loc144.toString() + loc145.toString()) * 60) + parseInt(loc61.toString() + loc62.toString());
            loc34.totalTimeUp2 = loc146 * 100;
            var loc174:*=(arg1[104] & 240) >> 4;
            var loc175:*=arg1[104] & 15;
            var loc127:*=(arg1[103] & 240) >> 4;
            var loc128:*=arg1[103] & 15;
            var loc111:*=(arg1[102] & 240) >> 4;
            var loc112:*=arg1[102] & 15;
            var loc151:*=(arg1[101] & 240) >> 4;
            var loc147:*=arg1[101] & 15;
            var loc119:*=(loc119 = (loc119 = parseInt(loc174.toString() + loc175.toString() + loc127.toString() + loc128.toString()) * 3600) + parseInt(loc111.toString() + loc112.toString()) * 60) + parseInt(loc151.toString() + loc147.toString());
            loc34.totalTimeDown1 = loc119 * 100;
            var loc167:*=(arg1[108] & 240) >> 4;
            var loc164:*=arg1[108] & 15;
            var loc178:*=(arg1[107] & 240) >> 4;
            var loc177:*=arg1[107] & 15;
            var loc194:*=(arg1[106] & 240) >> 4;
            var loc195:*=arg1[106] & 15;
            var loc117:*=(arg1[105] & 240) >> 4;
            var loc116:*=arg1[105] & 15;
            var loc188:*=(loc188 = (loc188 = parseInt(loc167.toString() + loc164.toString() + loc178.toString() + loc177.toString()) * 3600) + parseInt(loc194.toString() + loc195.toString()) * 60) + parseInt(loc117.toString() + loc116.toString());
            loc34.totalTimeDown2 = loc188 * 100;
            var loc8:*=arg1[114] & 15;
            var loc56:*=(arg1[113] & 240) >> 4;
            var loc58:*=arg1[113] & 15;
            var loc40:*=(arg1[112] & 240) >> 4;
            var loc41:*=arg1[112] & 15;
            var loc99:*=(arg1[111] & 240) >> 4;
            var loc101:*=arg1[111] & 15;
            var loc88:*=(arg1[110] & 240) >> 4;
            var loc79:*=arg1[110] & 15;
            var loc140:*=(arg1[109] & 240) >> 4;
            var loc141:*=arg1[109] & 15;
            var loc27:*=(loc27 = (loc27 = (loc27 = (loc27 = (loc27 = loc8.toString()) + (loc56.toString() + loc58.toString())) + (loc40.toString() + loc41.toString())) + (loc99.toString() + loc101.toString())) + (loc88.toString() + loc79.toString())) + (loc140.toString() + loc141.toString());
            loc34.totalTripDistUp1 = loc25.convert(new Number(loc27) / 1000000);
            var loc57:*=(arg1[119] & 240) >> 4;
            var loc59:*=arg1[119] & 15;
            var loc85:*=(arg1[118] & 240) >> 4;
            var loc81:*=arg1[118] & 15;
            var loc104:*=(arg1[117] & 240) >> 4;
            var loc106:*=arg1[117] & 15;
            var loc126:*=(arg1[116] & 240) >> 4;
            var loc125:*=arg1[116] & 15;
            var loc136:*=(arg1[115] & 240) >> 4;
            var loc137:*=arg1[115] & 15;
            var loc113:*=(arg1[114] & 240) >> 4;
            var loc120:*=(loc120 = (loc120 = (loc120 = (loc120 = (loc120 = loc57.toString() + loc59.toString()) + (loc85.toString() + loc81.toString())) + (loc104.toString() + loc106.toString())) + (loc126.toString() + loc125.toString())) + (loc136.toString() + loc137.toString())) + loc113.toString();
            loc34.totalTripDistUp2 = loc25.convert(new Number(loc120) / 1000000);
            var loc192:*=arg1[125] & 15;
            var loc16:*=(arg1[124] & 240) >> 4;
            var loc13:*=arg1[124] & 15;
            var loc69:*=(arg1[123] & 240) >> 4;
            var loc70:*=arg1[123] & 15;
            var loc89:*=(arg1[122] & 240) >> 4;
            var loc90:*=arg1[122] & 15;
            var loc35:*=(arg1[121] & 240) >> 4;
            var loc36:*=arg1[121] & 15;
            var loc63:*=(arg1[120] & 240) >> 4;
            var loc47:*=arg1[120] & 15;
            var loc121:*=(loc121 = (loc121 = (loc121 = (loc121 = (loc121 = loc192.toString()) + (loc16.toString() + loc13.toString())) + (loc69.toString() + loc70.toString())) + (loc89.toString() + loc90.toString())) + (loc35.toString() + loc36.toString())) + (loc63.toString() + loc47.toString());
            loc34.totalTripDistDown1 = loc25.convert(new Number(loc121) / 1000000);
            var loc55:*=(arg1[130] & 240) >> 4;
            var loc53:*=arg1[130] & 15;
            var loc38:*=(arg1[129] & 240) >> 4;
            var loc39:*=arg1[129] & 15;
            var loc92:*=(arg1[128] & 240) >> 4;
            var loc97:*=arg1[128] & 15;
            var loc72:*=(arg1[127] & 240) >> 4;
            var loc73:*=arg1[127] & 15;
            var loc130:*=(arg1[126] & 240) >> 4;
            var loc129:*=arg1[126] & 15;
            var loc29:*=(arg1[125] & 240) >> 4;
            var loc33:*=(loc33 = (loc33 = (loc33 = (loc33 = (loc33 = loc55.toString() + loc53.toString()) + (loc38.toString() + loc39.toString())) + (loc92.toString() + loc97.toString())) + (loc72.toString() + loc73.toString())) + (loc130.toString() + loc129.toString())) + loc29.toString();
            loc34.totalTripDistDown2 = loc25.convert(new Number(loc33) / 1000000);
            var loc31:*=(arg1[133] & 240) >> 4;
            var loc30:*=arg1[133] & 15;
            var loc26:*=(arg1[132] & 240) >> 4;
            var loc24:*=arg1[132] & 15;
            var loc173:*=(arg1[131] & 240) >> 4;
            var loc172:*=arg1[131] & 15;
            var loc100:*=(loc100 = (loc100 = loc31.toString() + loc30.toString()) + (loc26.toString() + loc24.toString())) + (loc173.toString() + loc172.toString());
            loc34.totalCal1 = parseInt(loc100);
            var loc161:*=(arg1[136] & 240) >> 4;
            var loc165:*=arg1[136] & 15;
            var loc169:*=(arg1[135] & 240) >> 4;
            var loc168:*=arg1[135] & 15;
            var loc184:*=(arg1[134] & 240) >> 4;
            var loc185:*=arg1[134] & 15;
            var loc150:*=(loc150 = (loc150 = loc161.toString() + loc165.toString()) + (loc169.toString() + loc168.toString())) + (loc184.toString() + loc185.toString());
            loc34.totalCal2 = parseInt(loc150);
            var loc102:*=arg1[165].toString(16) + arg1[164].toString(16);
            var loc156:*=0;
            loc21 = 0;
            while (loc21 < 164) 
            {
                loc156 = (loc156 = loc156 + arg1[loc21 + 2]) & 65535;
                ++loc21;
            }
            var loc158:*=loc156.toString(16);
            var loc189:*=(arg1[169] & 240) >> 4;
            var loc190:*=arg1[169] & 15;
            var loc23:*=(arg1[168] & 240) >> 4;
            var loc22:*=arg1[168] & 15;
            var loc9:*=(arg1[167] & 240) >> 4;
            var loc10:*=arg1[167] & 15;
            var loc1:*=(arg1[166] & 240) >> 4;
            var loc32:*=arg1[166] & 15;
            var loc118:*=(loc118 = (loc118 = (loc118 = loc189.toString() + loc190.toString()) + (loc23.toString() + loc22.toString())) + (loc9.toString() + loc10.toString())) + (loc1.toString() + loc32.toString());
            if (!loc179) 
            {
            };
            return loc34;
        }

        public function encodeUnitInformation(arg1:core.units.Unit):Array
        {
            var loc5:*=0;
            var loc6:*;
            if ((loc6 = arg1 as core.units.UnitROX2010).serialNumber == null || loc6.dateCode == null || loc6.maskingCode == null || loc6.initialWakeUpInfo == null || loc6.softwareRevision == null) 
            {
                return null;
            }
            var loc1:*=false;
            var loc3:*=[];
            var loc2:*=parseInt(loc6.serialNumber);
            var loc9:*=0;
            if (loc6 is core.units.UnitROX81) 
            {
                loc9 = loc2 - 10000000 + 1048576;
            }
            else 
            {
                loc9 = loc2 - 90000000 + 9437184;
            }
            loc3[0] = loc9 & 255;
            loc3[1] = (loc9 & 65280) >> 8;
            loc3[2] = (loc9 & 16711680) >> 16;
            var loc4:*=loc6.dateCode;
            loc3[3] = loc4.date / 10 << 4;
            var loc14:*=3;
            var loc15:*=loc3[loc14] | loc4.date % 10;
            loc3[loc14] = loc15;
            loc3[4] = (loc4.month + 1) / 10 << 4;
            loc15 = 4;
            loc14 = loc3[loc15] | (loc4.month + 1) % 10;
            loc3[loc15] = loc14;
            loc3[5] = loc4.fullYear % 100 / 10 << 4;
            loc14 = 5;
            loc15 = loc3[loc14] | loc4.fullYear % 100 % 10;
            loc3[loc14] = loc15;
            var loc12:*=parseInt("0x" + loc6.maskingCode);
            loc3[6] = loc12 & 255;
            loc3[7] = (loc12 & 65280) >> 8;
            loc3[8] = (loc12 & 16711680) >> 16;
            loc3[9] = (loc12 & 251658240) >> 24;
            var loc8:*=parseInt("0x" + loc6.initialWakeUpInfo);
            loc15 = 9;
            loc14 = loc3[loc15] | loc8 << 4;
            loc3[loc15] = loc14;
            var loc10:*=parseFloat(loc6.softwareRevision);
            var loc11:*=parseFloat(loc6.softwareRevision) * 10 % 10;
            var loc7:*=loc10 << 4;
            loc7 = loc7 | loc11;
            loc3[10] = loc7;
            var loc13:*=0;
            loc5 = 0;
            while (loc5 < 11) 
            {
                loc13 = loc13 + loc3[loc5];
                ++loc5;
            }
            loc13 = loc13 & 255;
            loc3[11] = loc13;
            loc3[12] = 212;
            loc3[13] = 116;
            loc3[14] = 148;
            loc3[15] = 53;
            if (!loc1) 
            {
            };
            return loc3;
        }

        public function encodeGhostRace(arg1:core.activities.Activity):Array
        {
            var loc34:*=NaN;
            var loc6:*=NaN;
            var loc16:*=NaN;
            var loc22:*=0;
            var loc36:*=NaN;
            var loc26:*=0;
            var loc31:*=NaN;
            var loc1:*=null;
            var loc35:*=NaN;
            var loc20:*=NaN;
            var loc13:*=NaN;
            var loc10:*=NaN;
            var loc24:*=0;
            var loc33:*=0;
            var loc17:*=0;
            var loc3:*=NaN;
            var loc12:*=0;
            var loc19:*=0;
            var loc32:*=0;
            var loc23:*=0;
            var loc4:*=[];
            if (arg1 != null) 
            {
                loc34 = 0;
                loc6 = 0;
                loc16 = 0;
                loc22 = 0;
                loc36 = 0;
                if ((loc26 = arg1.wheelSize) == 0) 
                {
                    loc26 = 2155;
                }
                loc31 = 0;
                loc23 = 0;
                while (loc23 < arg1.entries.length) 
                {
                    loc1 = arg1.entries[loc23];
                    loc36 = loc1.distance / (loc26 / 1000);
                    loc31 = loc1.trainingTime / 100;
                    loc35 = loc36 / loc31;
                    if (isNaN(loc35)) 
                    {
                        loc35 = 0;
                    }
                    loc20 = 0;
                    loc13 = 1;
                    loc10 = 0;
                    loc24 = loc13;
                    while (loc24 <= loc31) 
                    {
                        loc10 = loc13 * loc35 - loc20;
                        loc4[loc4.length] = loc10;
                        loc20 = loc20 + loc10;
                        loc34 = loc34 + loc10;
                        ++loc13;
                        ++loc24;
                    }
                    if (loc20 < loc36 || loc36 == 0) 
                    {
                        loc6 = loc6 + (loc36 - loc20);
                        loc16 = loc16 + loc31 % 1;
                    }
                    if (loc16 >= 1) 
                    {
                        loc4[loc4.length] = loc6;
                        loc34 = loc34 + loc6;
                        loc6 = 0;
                        --loc16;
                    }
                    ++loc23;
                }
                if (loc6 > 0) 
                {
                    var loc37:*=(loc4.length - 1);
                    var loc38:*=loc4[loc37] + loc6;
                    loc4[loc37] = loc38;
                    loc34 = loc34 + loc6;
                }
            }
            var loc7:*=(loc4.length - 1);
            loc23 = loc4.length;
            while (loc23 < 18182) 
            {
                loc4[loc23] = 0;
                ++loc23;
            }
            loc23 = 0;
            while (loc23 < loc7 + 1) 
            {
                loc33 = 0;
                loc17 = 0;
                while (loc17 < 8) 
                {
                    loc3 = 1 << loc17;
                    if (loc4[loc23] & loc3) 
                    {
                        ++loc33;
                    }
                    ++loc17;
                }
                loc12 = 0;
                loc19 = loc23 / 8 + 18182;
                if (loc33 % 2 != 1) 
                {
                    if (loc4[loc19] == undefined) 
                    {
                        loc4[loc19] = 0;
                    }
                }
                else 
                {
                    loc38 = loc19;
                    loc37 = loc4[loc38] | 1 << loc23 % 8;
                    loc4[loc38] = loc37;
                    if (loc12 != loc19) 
                    {
                        loc12 = loc19;
                    }
                }
                ++loc23;
            }
            loc23 = loc4.length;
            while (loc23 < 20455) 
            {
                loc4[loc23] = 0;
                ++loc23;
            }
            var loc15:*=loc4.length;
            loc4[loc4.length] = loc7 & 255;
            loc4[loc4.length] = loc7 >> 8;
            var loc2:*=loc26.toString();
            while (loc2.length < 4) 
            {
                loc2 = "0" + loc2;
            }
            var loc9:*=loc2.split("");
            loc4[loc4.length] = parseInt((loc9[2] + loc9[3]).toString(), 16);
            loc4[loc4.length] = parseInt((loc9[0] + loc9[1]).toString(), 16);
            var loc14:*=arg1.ghostName.split("");
            var loc8:*="";
            loc23 = 0;
            while (loc23 < 10) 
            {
                if (loc23 < loc14.length) 
                {
                    loc8 = loc14[loc23];
                }
                else 
                {
                    loc8 = " ";
                }
                loc32 = MY_NAME.indexOf(loc8);
                loc4[loc4.length] = loc32;
                ++loc23;
            }
            var loc30:*;
            var loc28:*=(loc30 = arg1.trainingTime / 100) / 3600;
            var loc25:*=(loc30 - loc28 * 3600) / 60;
            var loc29:*=loc30 - loc28 * 3600 - loc25 * 60;
            loc4[loc4.length] = parseInt(loc29.toString(), 16);
            loc4[loc4.length] = parseInt(loc25.toString(), 16);
            loc4[loc4.length] = parseInt(loc28.toString(), 16);
            var loc5:*;
            var loc27:*=(loc5 = init.BackendInitializer.getInstance().createGhostDistanceDecoderFormatter()).format(arg1.distance / 1000);
            while (loc27.length < 7) 
            {
                loc27 = "0" + loc27;
            }
            var loc18:*=loc27.split("");
            loc4[loc4.length] = parseInt((loc18[5] + loc18[6]).toString(), 16);
            loc4[loc4.length] = parseInt((loc18[2] + loc18[3]).toString(), 16);
            loc4[loc4.length] = parseInt((loc18[0] + loc18[1]).toString(), 16);
            var loc21:*=loc4.length;
            var loc11:*=0;
            loc23 = 20455;
            while (loc23 < 20475) 
            {
                loc11 = loc11 + (loc4[loc23] & 255);
                ++loc23;
            }
            loc11 = loc11 & 255;
            loc4[loc4.length] = loc11;
            loc4[loc4.length] = 212;
            loc4[loc4.length] = 116;
            loc4[loc4.length] = 148;
            loc4[loc4.length] = 53;
            return loc4;
        }

        public function encodeSettings(arg1:core.units.Unit):Array
        {
            var loc74:*=0;
            var loc44:*=0;
            var loc24:*=0;
            var loc36:*=0;
            var loc81:*=0;
            var loc82:*=null;
            var loc148:*=0;
            var loc35:*=0;
            var loc111:*=new Array(170);
            var loc40:*=arg1.currentSettings as core.settings.SettingsROX2010;
            var loc89:*=(arg1 as core.units.UnitROX2010).currentTotals as core.totals.TotalsROX2010;
            var loc31:*=arg1 as core.units.UnitROX2010;
            loc74 = 0;
            while (loc74 < loc111.length) 
            {
                loc111[loc74] = 0;
                ++loc74;
            }
            loc111[0] = 5;
            loc111[1] = 8;
            var loc154:*=1;
            var loc155:*=loc111[loc154] | 48;
            loc111[loc154] = loc155;
            loc111[2] = 100;
            loc111[3] = 80;
            loc111[4] = 100;
            var loc102:*=0;
            loc155 = (loc40 as core.settings.interfaces.IBikeType1).bikeType1;
            while ("raceDrop" === loc155) 
            {
                loc102 = 1;
            }
        }

        public function decodeNumberOfPages(arg1:Array):int
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
            var loc11:*=0;
            var loc23:*=null;
            var loc9:*=null;
            var loc91:*=null;
            var loc20:*=null;
            var loc75:*=NaN;
            var loc73:*=0;
            var loc66:*;
            (loc66 = core.activities.ActivityFactory.createActivityFromUnitType(arg2.type, "log")).unit = arg2;
            loc66.serialNumber = (arg2 as core.units.UnitROX2010).serialNumber;
            loc66.pageHeaderData = arg1;
            loc66.pageHeaderData = arg1;
            var loc36:*=(arg1[1] & 48) >> 4;
            var loc19:*=arg1[1] & 15;
            var loc21:*=(arg1[0] & 240) >> 4;
            var loc18:*=arg1[0] & 15;
            var loc44:*=loc36.toString() + loc19.toString() + loc21.toString() + loc18.toString();
            loc11 = parseInt(loc44, 10);
            loc66.wheelSize = loc11;
            var loc50:*;
            if ((loc50 = (arg1[1] & 64) >> 6) != 1) 
            {
                loc9 = "kmh";
            }
            else 
            {
                loc9 = "mph";
            }
            loc66.speedUnit = loc9;
            var loc45:*;
            if ((loc45 = (arg1[1] & 128) >> 7) != 1) 
            {
                loc23 = "bike1";
            }
            else 
            {
                loc23 = "bike2";
            }
            loc66.bike = loc23;
            var loc33:*;
            var loc24:*=(loc33 = arg1[2]).toString();
            var loc41:*=parseInt(loc24, 10);
            loc66.hrMax = loc41;
            var loc34:*;
            var loc38:*=(loc34 = arg1[3]).toString();
            var loc3:*=parseInt(loc38, 10);
            loc66.zone1Start = loc3;
            var loc1:*=arg1[4];
            var loc7:*=loc1.toString();
            var loc61:*=parseInt(loc7, 10);
            loc66.zone2Start = loc61;
            var loc74:*;
            var loc25:*=(loc74 = arg1[5]).toString();
            var loc46:*=parseInt(loc25, 10);
            loc66.zone3Start = loc46;
            var loc22:*;
            var loc57:*=(loc22 = arg1[6]).toString();
            var loc49:*=parseInt(loc57, 10);
            loc66.zone3End = loc49;
            var loc56:*=(arg1[7] & 240) >> 4;
            var loc48:*=arg1[7] & 15;
            var loc55:*=(arg1[8] & 240) >> 4;
            var loc77:*=arg1[8] & 15;
            var loc65:*;
            var loc92:*=(loc65 = arg1[9] & 15).toString() + loc55.toString() + loc77.toString() + loc56.toString() + loc48.toString();
            loc66.calories = parseInt(loc92);
            var loc10:*;
        }

        public function decodeLog(arg1:core.activities.Activity, arg2:Array):void
        {
            var loc6:*=null;
            var loc8:*=null;
            var loc10:*=NaN;
            var loc3:*=0;
            var loc5:*=0;
            var loc4:*=1;
            var loc9:*=0;
            arg1.entries = new __AS3__.vec.Vector.<core.activities.ActivityEntry>();
            arg1.markerList = new __AS3__.vec.Vector.<core.marker.Marker>();
            var loc1:*=new utils.converter.SpeedConverter();
            loc1.inputFormat = "kmh";
            loc1.outputFormat = "ms";
            loc5 = 0;
            for (;;) 
            {
                if (loc5 % 10 != 0) 
                {
                    loc6 = arg2.slice(loc3, loc3 + 10);
                    if (isPause(loc6)) 
                    {
                        loc8 = this.decodeRelLogPauseEntry(loc6, arg1);
                    }
                    else 
                    {
                        loc8 = this.decodeRelLogEntry(loc6, arg1);
                    }
                    loc8 = makeAbsolutEntry(loc8, arg1.entries[(loc5 - 1)]);
                    loc3 = loc3 + 10;
                }
                else 
                {
                    loc6 = arg2.slice(loc3, loc3 + 11);
                    if (isPause(loc6)) 
                    {
                        loc8 = this.decodeAbsLogPauseEntry(loc6, arg1);
                    }
                    else 
                    {
                        loc8 = this.decodeAbsLogEntry(loc6, arg1);
                    }
                    loc3 = loc3 + 11;
                }
                loc10 = loc8.speed / (2200 / arg1.wheelSize);
                loc10 = Math.round(loc10 * 100) / 100;
                loc8.speed = loc1.convert(loc10);
                if (loc8.speed > 0) 
                {
                    loc8.speedTime = Math.floor(1000 / loc8.speed);
                }
                else 
                {
                    loc8.speedTime = 1200;
                }
                if (loc8.speedTime > 1200) 
                {
                    loc8.speedTime = 1200;
                }
                arg1.entries.push(loc8);
                if (loc3 >= arg2.length) 
                {
                    break;
                }
                ++loc5;
            }
            var loc11:*;
        }

        internal function decodeTrip(arg1:int, arg2:core.units.UnitROX2010):core.activities.Activity
        {
            var loc167:*=null;
            var loc76:*=NaN;
            var loc150:*=null;
            var loc143:*=NaN;
            var loc44:*=null;
            var loc125:*=null;
            var loc78:*=null;
            var loc54:*=0;
            var loc168:*;
            (loc168 = core.activities.ActivityFactory.createActivityFromUnitType(arg2.type, "memory")).unit = arg2;
            loc168.serialNumber = arg2.serialNumber;
            var loc176:*=(_7infotripArray[arg1] & 240) >> 4;
            var loc158:*=_7infotripArray[arg1] & 15;
            var loc159:*=(_7infotripArray[arg1 + 1] & 240) >> 4;
            var loc199:*=_7infotripArray[arg1 + 1] & 15;
            var loc157:*=(_7infotripArray[arg1 + 2] & 240) >> 4;
            var loc177:*=_7infotripArray[arg1 + 2] & 15;
            var loc79:*=(_7infotripArray[arg1 + 3] & 240) >> 4;
            var loc89:*=_7infotripArray[arg1 + 3] & 15;
            var loc88:*=(_7infotripArray[arg1 + 4] & 112) >> 4;
            var loc35:*=_7infotripArray[arg1 + 4] & 15;
            loc168.startDate = new Date("20" + loc157.toString() + loc177.toString(), (parseInt(loc159.toString() + loc199.toString()) - 1), loc176.toString() + loc158.toString(), loc88.toString() + loc35.toString(), loc79.toString() + loc89.toString());
            loc168.dateCode = loc168.startDate.toString();
            if ((_7infotripArray[arg1 + 4] & 128) >> 7 != 1) 
            {
                loc168.bike = "bike1";
            }
            else 
            {
                loc168.bike = "bike2";
            }
            var loc106:*;
            if ((loc106 = (_7infotripArray[arg1 + 72] & 128) >> 7) != 1) 
            {
                loc168.speedUnit = "kmh";
            }
            else 
            {
                loc168.speedUnit = "mph";
            }
            var loc50:*=new utils.converter.DistanceConverter();
            if (loc168.speedUnit != "kmh") 
            {
                if (loc168.speedUnit == "mph") 
                {
                    loc50.inputFormat = "mile";
                }
            }
            else 
            {
                loc50.inputFormat = "kilometer";
            }
            loc50.outputFormat = "kilometer";
            var loc173:*=(_7infotripArray[arg1 + 5] & 240) >> 4;
            var loc121:*=_7infotripArray[arg1 + 5] & 15;
            var loc126:*=(_7infotripArray[arg1 + 6] & 240) >> 4;
            var loc99:*=_7infotripArray[arg1 + 6] & 15;
            var loc127:*=(_7infotripArray[arg1 + 7] & 240) >> 4;
            var loc17:*=_7infotripArray[arg1 + 7] & 15;
            var loc156:*=loc127.toString() + loc17.toString() + loc126.toString() + loc99.toString() + "." + loc173.toString() + loc121.toString();
            loc168.distance = loc50.convert(new Number(loc156)) * 1000;
            var loc130:*=(_7infotripArray[arg1 + 8] & 240) >> 4;
            var loc113:*=_7infotripArray[arg1 + 8] & 15;
            var loc112:*=(_7infotripArray[arg1 + 9] & 240) >> 4;
            var loc63:*=_7infotripArray[arg1 + 9] & 15;
            var loc115:*=(_7infotripArray[arg1 + 10] & 240) >> 4;
            var loc47:*=_7infotripArray[arg1 + 10] & 15;
            var loc114:*=(_7infotripArray[arg1 + 11] & 240) >> 4;
            var loc27:*=_7infotripArray[arg1 + 11] & 15;
            var loc104:*=parseInt(loc114.toString() + loc27.toString() + loc115.toString() + loc47.toString());
            var loc219:*=parseInt(loc112.toString() + loc63.toString());
            var loc51:*=parseInt(loc130.toString() + loc113.toString());
            loc168.trainingTime = (loc104 * 3600 + loc219 * 60 + loc51) * 100;
            var loc152:*=new utils.converter.SpeedConverter();
            if (loc168.speedUnit != "kmh") 
            {
                if (loc168.speedUnit == "mph") 
                {
                    loc152.inputFormat = "mph";
                }
            }
            else 
            {
                loc152.inputFormat = "kmh";
            }
            loc152.outputFormat = "ms";
            var loc64:*=(_7infotripArray[arg1 + 12] & 240) >> 4;
            var loc212:*=_7infotripArray[arg1 + 12] & 15;
            var loc49:*=(_7infotripArray[arg1 + 13] & 240) >> 4;
            var loc136:*=_7infotripArray[arg1 + 13] & 15;
            var loc30:*;
            var loc185:*=(loc30 = _7infotripArray[arg1 + 14] & 15).toString() + loc49.toString() + loc136.toString() + "." + loc64.toString() + loc212.toString();
            loc168.averageSpeed = loc152.convert(new Number(loc185));
            var loc36:*=(_7infotripArray[arg1 + 16] & 240) >> 4;
            var loc72:*=_7infotripArray[arg1 + 16] & 15;
            var loc74:*=(_7infotripArray[arg1 + 15] & 240) >> 4;
            var loc19:*=_7infotripArray[arg1 + 15] & 15;
            var loc69:*=(_7infotripArray[arg1 + 14] & 240) >> 4;
            var loc11:*=loc36.toString() + loc72.toString() + loc74.toString() + "." + loc19.toString() + loc69.toString();
            loc168.maximumSpeed = loc152.convert(new Number(loc11));
            var loc52:*=(_7infotripArray[arg1 + 17] & 240) >> 4;
            var loc24:*=_7infotripArray[arg1 + 17] & 15;
            var loc23:*=(_7infotripArray[arg1 + 18] & 240) >> 4;
            var loc218:*=_7infotripArray[arg1 + 18] & 15;
            var loc21:*=_7infotripArray[arg1 + 19] & 15;
            var loc37:*=(_7infotripArray[19] & 240) >> 4;
            if (loc21 != 15) 
            {
                loc150 = loc21 + loc23.toString() + loc218.toString() + "." + loc52.toString() + loc24.toString();
                loc143 = loc50.convert(new Number(loc150)) * 1000;
                if (loc37 != 1) 
                {
                    loc168.distancePlus = loc143;
                }
                else 
                {
                    loc168.distanceMinus = loc143;
                }
            }
            else 
            {
                loc167 = "-" + loc23.toString() + loc218.toString() + "." + loc52.toString() + loc24.toString();
                loc76 = loc50.convert(new Number(loc167)) * 1000;
                if (loc37 != 1) 
                {
                    loc168.distancePlus = loc173;
                }
                else 
                {
                    loc168.distanceMinus = loc173;
                }
            }
            var loc172:*=(_7infotripArray[arg1 + 22] & 240) >> 4;
            var loc70:*=_7infotripArray[arg1 + 22] & 15;
            var loc86:*=loc172.toString(16) + loc70.toString(16);
            loc168.averageCadence = parseInt(loc86, 16);
            var loc55:*=(_7infotripArray[arg1 + 23] & 240) >> 4;
            var loc107:*=_7infotripArray[arg1 + 23] & 15;
            var loc31:*=loc55.toString(16) + loc107.toString(16);
            loc168.maximumCadence = parseInt(loc31, 16);
            var loc108:*=(_7infotripArray[arg1 + 24] & 240) >> 4;
            var loc58:*=_7infotripArray[arg1 + 24] & 15;
            var loc77:*=loc108.toString(16) + loc58.toString(16);
            loc168.averageHeartrate = parseInt(loc77, 16);
            var loc7:*=(_7infotripArray[arg1 + 25] & 240) >> 4;
            var loc84:*=_7infotripArray[arg1 + 25] & 15;
            var loc97:*=loc7.toString(16) + loc84.toString(16);
            loc168.maximumHeartrate = parseInt(loc97, 16);
            var loc20:*=(_7infotripArray[arg1 + 26] & 240) >> 4;
            var loc189:*=_7infotripArray[arg1 + 26] & 15;
            var loc187:*=(_7infotripArray[arg1 + 27] & 240) >> 4;
            var loc100:*=_7infotripArray[arg1 + 27] & 15;
            var loc179:*=(_7infotripArray[arg1 + 28] & 240) >> 4;
            var loc82:*=_7infotripArray[arg1 + 28] & 15;
            var loc45:*=parseInt(loc179.toString() + loc82.toString());
            var loc32:*=parseInt(loc187.toString() + loc100.toString());
            var loc6:*=parseInt(loc20.toString() + loc189.toString());
            loc168.timeInZone1 = (loc45 * 3600 + loc32 * 60 + loc6) * 100;
            var loc75:*=(_7infotripArray[arg1 + 29] & 240) >> 4;
            var loc39:*=_7infotripArray[arg1 + 29] & 15;
            var loc41:*=(_7infotripArray[arg1 + 30] & 240) >> 4;
            var loc87:*=_7infotripArray[arg1 + 30] & 15;
            var loc43:*=(_7infotripArray[arg1 + 31] & 240) >> 4;
            var loc33:*=_7infotripArray[arg1 + 31] & 15;
            var loc198:*=parseInt(loc43.toString() + loc33.toString());
            var loc153:*=parseInt(loc41.toString() + loc87.toString());
            var loc135:*=parseInt(loc75.toString() + loc39.toString());
            loc168.timeInZone2 = (loc198 * 3600 + loc153 * 60 + loc135) * 100;
            var loc128:*=(_7infotripArray[arg1 + 32] & 240) >> 4;
            var loc122:*=_7infotripArray[arg1 + 32] & 15;
            var loc120:*=(_7infotripArray[arg1 + 33] & 240) >> 4;
            var loc62:*=_7infotripArray[arg1 + 33] & 15;
            var loc123:*=(_7infotripArray[arg1 + 34] & 240) >> 4;
            var loc8:*=_7infotripArray[arg1 + 34] & 15;
            var loc216:*=parseInt(loc123.toString() + loc8.toString());
            var loc102:*=parseInt(loc120.toString() + loc62.toString());
            var loc14:*=parseInt(loc128.toString() + loc122.toString());
            loc168.timeInZone3 = (loc216 * 3600 + loc102 * 60 + loc14) * 100;
            var loc169:*=(_7infotripArray[arg1 + 37] & 240) >> 4;
            var loc182:*=_7infotripArray[arg1 + 37] & 15;
            var loc183:*=(_7infotripArray[arg1 + 36] & 240) >> 4;
            var loc217:*=_7infotripArray[arg1 + 36] & 15;
            var loc178:*=(_7infotripArray[arg1 + 35] & 240) >> 4;
            var loc213:*=_7infotripArray[arg1 + 35] & 15;
            var loc59:*=loc169.toString() + loc182.toString() + loc183.toString() + loc217.toString() + loc178.toString() + loc213.toString();
            loc168.calories = parseInt(loc59, 10);
            var loc66:*=(_7infotripArray[arg1 + 39] & 240) >> 4;
            var loc28:*=_7infotripArray[arg1 + 39] & 15;
            var loc25:*=(_7infotripArray[arg1 + 38] & 240) >> 4;
            var loc163:*=_7infotripArray[arg1 + 38] & 15;
            var loc138:*;
            (loc138 = new utils.converter.TemperatureConverter()).inputFormat = core.MeasurementConfig.temperatureFormat;
            loc138.outputFormat = "celsius";
            if (loc66 != 15) 
            {
                loc168.minimumTemperature = loc138.convert(parseFloat(loc66.toString() + loc28.toString() + loc25.toString() + "." + loc163.toString()));
            }
            else 
            {
                loc44 = "-" + loc28.toString() + loc25.toString() + "." + loc163.toString();
                loc168.minimumTemperature = loc138.convert(new Number(loc44));
            }
            var loc61:*=(_7infotripArray[arg1 + 41] & 240) >> 4;
            var loc188:*=_7infotripArray[arg1 + 41] & 15;
            var loc192:*=(_7infotripArray[arg1 + 40] & 240) >> 4;
            var loc190:*=_7infotripArray[arg1 + 40] & 15;
            if (loc61 != 15) 
            {
                loc168.maximumTemperature = loc138.convert(parseFloat(loc61.toString() + loc188.toString() + loc192.toString() + "." + loc190.toString()));
            }
            else 
            {
                loc125 = "-" + loc188.toString() + loc192.toString() + "." + loc190.toString();
                loc168.maximumTemperature = loc138.convert(new Number(loc125));
            }
            var loc155:*=(_7infotripArray[arg1 + 43] & 240) >> 4;
            var loc200:*=_7infotripArray[arg1 + 43] & 15;
            var loc201:*=(_7infotripArray[arg1 + 42] & 240) >> 4;
            var loc191:*=_7infotripArray[arg1 + 42] & 15;
            var loc210:*;
            (loc210 = new utils.converter.AltitudeConverter()).inputFormat = core.MeasurementConfig.altitudeFormat;
            loc210.outputFormat = "millimeter";
            if (loc155 != 15) 
            {
                loc168.maximumAltitude = loc210.convert(parseInt(loc155.toString() + loc200.toString() + loc201.toString() + loc191.toString(), 10));
            }
            else 
            {
                loc78 = "-" + loc200.toString() + loc201.toString() + loc191.toString();
                loc168.maximumAltitude = loc210.convert(new Number(loc78));
            }
            var loc34:*=(_7infotripArray[arg1 + 44] & 240) >> 4;
            var loc95:*=_7infotripArray[arg1 + 44] & 15;
            var loc85:*=(_7infotripArray[arg1 + 45] & 240) >> 4;
            var loc18:*=_7infotripArray[arg1 + 45] & 15;
            var loc83:*=(_7infotripArray[arg1 + 46] & 240) >> 4;
            var loc2:*=_7infotripArray[arg1 + 46] & 15;
            var loc154:*=loc83.toString() + loc2.toString() + loc85.toString() + loc18.toString() + "." + loc34.toString() + loc95.toString();
            loc168.distanceUphill = loc50.convert(new Number(loc154)) * 1000;
            var loc194:*=_7infotripArray[arg1 + 50] & 15;
            var loc13:*=(_7infotripArray[arg1 + 49] & 240) >> 4;
            var loc193:*=_7infotripArray[arg1 + 49] & 15;
            var loc196:*=(_7infotripArray[arg1 + 48] & 240) >> 4;
            var loc57:*=_7infotripArray[arg1 + 48] & 15;
            var loc195:*=(_7infotripArray[arg1 + 47] & 240) >> 4;
            var loc73:*=_7infotripArray[arg1 + 47] & 15;
            var loc129:*=parseInt(loc194.toString() + loc13.toString() + loc193.toString());
            var loc56:*=parseInt(loc196.toString() + loc57.toString());
            var loc180:*=parseInt(loc195.toString() + loc73.toString());
            loc168.trainingTimeUphill = (loc129 * 3600 + loc56 * 60 + loc180) * 100;
            var loc165:*=(_7infotripArray[arg1 + 52] & 240) >> 4;
            var loc164:*=_7infotripArray[arg1 + 52] & 15;
            var loc162:*=(_7infotripArray[arg1 + 51] & 240) >> 4;
            var loc1:*=_7infotripArray[arg1 + 51] & 15;
            var loc161:*=(_7infotripArray[arg1 + 50] & 240) >> 4;
            var loc94:*=loc165.toString() + loc164.toString() + loc162.toString() + "." + loc1.toString() + loc161.toString();
            loc168.averageSpeedUphill = loc152.convert(new Number(loc94));
            var loc109:*=(_7infotripArray[arg1 + 53] & 240) >> 4;
            var loc110:*=_7infotripArray[arg1 + 53] & 15;
            var loc146:*=loc109.toString() + loc110.toString();
            loc168.averageInclineUphill = parseInt(loc146, 10);
            var loc202:*=(_7infotripArray[arg1 + 54] & 240) >> 4;
            var loc186:*=_7infotripArray[arg1 + 54] & 15;
            var loc184:*=loc202.toString() + loc186.toString();
            loc168.maximumInclineUphill = parseInt(loc184, 10);
            var loc60:*=(_7infotripArray[arg1 + 56] & 240) >> 4;
            var loc101:*=_7infotripArray[arg1 + 56] & 15;
            var loc103:*=(_7infotripArray[arg1 + 55] & 240) >> 4;
            var loc208:*=_7infotripArray[arg1 + 55] & 15;
            var loc98:*;
            var loc171:*=(loc98 = _7infotripArray[arg1 + 57] & 15).toString() + loc60.toString() + loc101.toString() + loc103.toString() + loc208.toString();
            loc168.altitudeDifferencesUphill = loc210.convert(parseInt(loc171, 10));
            var loc166:*=(_7infotripArray[arg1 + 59] & 240) >> 4;
            var loc10:*=_7infotripArray[arg1 + 59] & 15;
            var loc16:*=(_7infotripArray[arg1 + 58] & 240) >> 4;
            var loc96:*=_7infotripArray[arg1 + 58] & 15;
            var loc12:*=(_7infotripArray[arg1 + 57] & 240) >> 4;
            var loc124:*=loc166.toString() + loc10.toString() + loc16.toString() + loc96.toString() + loc12.toString();
            loc168.altitudeDifferencesDownhill = loc210.convert(parseInt(loc124, 10));
            var loc207:*=(_7infotripArray[arg1 + 62] & 240) >> 4;
            var loc133:*=_7infotripArray[arg1 + 62] & 15;
            var loc132:*=(_7infotripArray[arg1 + 61] & 240) >> 4;
            var loc197:*=_7infotripArray[arg1 + 61] & 15;
            var loc131:*=(_7infotripArray[arg1 + 60] & 240) >> 4;
            var loc174:*=_7infotripArray[arg1 + 60] & 15;
            var loc105:*=loc207.toString() + loc133.toString() + loc132.toString() + loc197.toString() + "." + loc131.toString() + loc174.toString();
            loc168.distanceDownhill = loc50.convert(new Number(loc105)) * 1000;
            var loc3:*=(_7infotripArray[arg1 + 63] & 240) >> 4;
            var loc141:*=_7infotripArray[arg1 + 63] & 15;
            var loc144:*=(_7infotripArray[arg1 + 64] & 240) >> 4;
            var loc26:*=_7infotripArray[arg1 + 64] & 15;
            var loc145:*=(_7infotripArray[arg1 + 65] & 240) >> 4;
            var loc46:*=_7infotripArray[arg1 + 65] & 15;
            var loc140:*=_7infotripArray[arg1 + 66] & 15;
            var loc206:*=parseInt(loc140.toString() + loc145.toString() + loc46.toString());
            var loc117:*=parseInt(loc144.toString() + loc26.toString());
            var loc137:*=parseInt(loc3.toString() + loc141.toString());
            loc168.trainingTimeDownhill = (loc206 * 3600 + loc117 * 60 + loc137) * 100;
            var loc149:*=(_7infotripArray[arg1 + 68] & 240) >> 4;
            var loc40:*=_7infotripArray[arg1 + 68] & 15;
            var loc42:*=(_7infotripArray[arg1 + 67] & 240) >> 4;
            var loc53:*=_7infotripArray[arg1 + 67] & 15;
            var loc38:*=(_7infotripArray[arg1 + 66] & 240) >> 4;
            var loc90:*=loc149.toString() + loc40.toString() + loc42.toString() + "." + loc53.toString() + loc38.toString();
            loc168.averageSpeedDownhill = loc152.convert(new Number(loc90));
            var loc181:*=(_7infotripArray[arg1 + 69] & 240) >> 4;
            var loc142:*=_7infotripArray[arg1 + 69] & 15;
            var loc148:*=loc181.toString() + loc142.toString();
            loc168.averageInclineDownhill = parseInt(loc148, 10);
            var loc65:*=(_7infotripArray[arg1 + 70] & 240) >> 4;
            var loc209:*=_7infotripArray[arg1 + 70] & 15;
            var loc160:*=loc65.toString() + loc209.toString();
            loc168.maximumInclineDownhill = parseInt(loc160, 10);
            var loc170:*=(_7infotripArray[arg1 + 72] & 112) >> 4;
            var loc67:*=_7infotripArray[arg1 + 72] & 15;
            var loc68:*=(_7infotripArray[arg1 + 71] & 240) >> 4;
            var loc139:*=_7infotripArray[arg1 + 71] & 15;
            var loc118:*=loc170.toString() + loc67.toString() + loc68.toString() + loc139.toString();
            loc168.wheelSize = parseInt(loc118);
            var loc205:*=(_7infotripArray[arg1 + 73] & 240) >> 4;
            var loc134:*=_7infotripArray[arg1 + 73] & 15;
            var loc91:*=loc205.toString(16) + loc134.toString(16);
            loc168.hrMax = parseInt(loc91, 16);
            var loc175:*=(_7infotripArray[arg1 + 74] & 240) >> 4;
            var loc48:*=_7infotripArray[arg1 + 74] & 15;
            var loc71:*=loc175.toString(16) + loc48.toString(16);
            loc168.zone1Start = parseInt(loc71, 16);
            var loc211:*=(_7infotripArray[arg1 + 75] & 240) >> 4;
            var loc22:*=_7infotripArray[arg1 + 75] & 15;
            var loc92:*=loc211.toString(16) + loc22.toString(16);
            loc168.zone2Start = parseInt(loc92, 16);
            var loc203:*=(_7infotripArray[arg1 + 76] & 240) >> 4;
            var loc214:*=_7infotripArray[arg1 + 76] & 15;
            var loc29:*=loc203.toString(16) + loc214.toString(16);
            loc168.zone3Start = parseInt(loc29, 16);
            var loc151:*=(_7infotripArray[arg1 + 77] & 240) >> 4;
            var loc93:*=_7infotripArray[arg1 + 77] & 15;
            var loc80:*=loc151.toString(16) + loc93.toString(16);
            loc168.zone3End = parseInt(loc80, 16);
            var loc15:*=_7infotripArray[arg1 + 79].toString(16);
            var loc4:*=_7infotripArray[arg1 + 78].toString(16);
            var loc147:*=parseFloat(loc15 + "." + loc4);
            var loc204:*=new utils.converter.ExpansionConverter();
            if (loc168.speedUnit != "kmh") 
            {
                if (loc168.speedUnit == "mph") 
                {
                    loc204.inputFormat = "feet";
                }
            }
            else 
            {
                loc204.inputFormat = "meter";
            }
            loc204.outputFormat = "meter";
            loc168.averageExpansion = loc204.convert(loc147);
            var loc116:*=parseInt(_7infotripArray[arg1 + 81].toString(16), 10);
            var loc119:*=parseInt(_7infotripArray[arg1 + 80].toString(16), 10);
            loc168.averagePower = loc116 * 100 + loc119;
            var loc5:*=parseInt(_7infotripArray[arg1 + 83].toString(16), 10);
            var loc9:*=parseInt(_7infotripArray[arg1 + 82].toString(16), 10);
            loc168.maximumPower = loc5 * 100 + loc9;
            var loc81:*=_7infotripArray[arg1 + 85].toString(16) + "." + _7infotripArray[arg1 + 84].toString(16);
            loc168.averageExpansionUphill = parseFloat(loc81);
            var loc111:*=_7infotripArray[arg1 + 86];
            var loc215:*=0;
            loc54 = 0;
            while (loc54 < 86) 
            {
                loc215 = loc215 + _7infotripArray[arg1 + loc54];
                ++loc54;
            }
            loc215 = loc215 & 255;
            if (loc111 == loc215) 
            {
            };
            return loc168;
        }

        internal function decodeTripList():Array
        {
            var loc2:*=_7infotripArray[609] & 15;
            var loc1:*=(_7infotripArray[609] & 240) >> 4;
            if (_7infotripArray[610] == _7infotripArray[609]) 
            {
            };
            if (!(!(_7infotripArray[611] == 212) || !(_7infotripArray[612] == 116) || !(_7infotripArray[613] == 148) || !(_7infotripArray[614] == 53))) 
            {
            };
            var loc3:*=new Array(2);
            loc3[0] = loc2;
            loc3[1] = loc1;
            return loc3;
        }

        internal function setFavIndex(arg1:String):int
        {
            if (core.general.FavoritesROX2010.FAVORITES_GUI.indexOf(arg1) == 53) 
            {
                return 9;
            }
            return core.general.FavoritesROX2010.FAVORITES.indexOf(arg1);
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

        internal function calcMinMaxValues(arg1:core.activities.Activity, arg2:core.activities.ActivityEntry, arg3:int):core.activities.Activity
        {
            if (arg1.minimumSpeed > arg2.speed || isNaN(arg1.minimumSpeed) || arg3 == 0) 
            {
                arg1.minimumSpeed = arg2.speed;
            }
            if (arg1.maximumSpeed < arg2.speed || isNaN(arg1.maximumSpeed) || arg3 == 0) 
            {
                arg1.maximumSpeed = arg2.speed;
            }
            if (arg1.minimumAltitude > arg2.altitude || isNaN(arg1.minimumAltitude) || arg3 == 0) 
            {
                arg1.minimumAltitude = arg2.altitude;
            }
            if (arg1.maximumAltitude < arg2.altitude || isNaN(arg1.maximumAltitude) || arg3 == 0) 
            {
                arg1.maximumAltitude = arg2.altitude;
            }
            if (arg1.minimumHeartrate > arg2.heartrate || isNaN(arg1.minimumHeartrate) || arg3 == 0) 
            {
                arg1.minimumHeartrate = arg2.heartrate;
            }
            if (arg1.maximumHeartrate < arg2.heartrate || isNaN(arg1.maximumHeartrate) || arg3 == 0) 
            {
                arg1.maximumHeartrate = arg2.heartrate;
            }
            if (arg1.minimumTemperature > arg2.temperature || isNaN(arg1.minimumTemperature) || arg3 == 0) 
            {
                arg1.minimumTemperature = arg2.temperature;
            }
            if (arg1.maximumTemperature < arg2.temperature || isNaN(arg1.maximumTemperature) || arg3 == 0) 
            {
                arg1.maximumTemperature = arg2.temperature;
            }
            if (arg1.minimumCadence > arg2.cadence || isNaN(arg1.minimumCadence) || arg3 == 0) 
            {
                arg1.minimumCadence = arg2.cadence;
            }
            if (arg1.maximumCadence < arg2.cadence || isNaN(arg1.maximumCadence) || arg3 == 0) 
            {
                arg1.maximumCadence = arg2.cadence;
            }
            if (arg1.minimumPower > arg2.power || isNaN(arg1.minimumPower) || arg3 == 0) 
            {
                arg1.minimumPower = arg2.power;
            }
            if (arg1.maximumPower < arg2.power || isNaN(arg1.maximumPower) || arg3 == 0) 
            {
                arg1.maximumPower = arg2.power;
            }
            if (arg1.minimumIncline > arg2.incline || isNaN(arg1.minimumIncline) || arg3 == 0) 
            {
                arg1.minimumIncline = arg2.incline;
            }
            if (arg1.maximumIncline < arg2.incline || isNaN(arg1.maximumIncline) || arg3 == 0) 
            {
                arg1.maximumIncline = arg2.incline;
            }
            if (arg1.minimumRiseRate > arg2.riseRate || isNaN(arg1.minimumRiseRate) || arg3 == 0) 
            {
                arg1.minimumRiseRate = arg2.riseRate;
            }
            if (arg1.maximumRiseRate < arg2.riseRate || isNaN(arg1.maximumRiseRate) || arg3 == 0) 
            {
                arg1.maximumRiseRate = arg2.riseRate;
            }
            return arg1;
        }

        internal function calcAverages(arg1:core.activities.Activity, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Number, arg7:Number, arg8:Number):core.activities.Activity
        {
            var loc1:*=arg8;
            arg1.averageAltitude = arg3 / loc1;
            arg1.averageHeartrate = arg4 / loc1;
            arg1.averageSpeed = arg2 / loc1;
            arg1.averageTemperature = arg5 / loc1;
            arg1.averageCadence = arg6 / loc1;
            arg1.averagePower = arg7 / loc1;
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

        internal function calculateRotations(arg1:Number, arg2:Number):int
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
            var loc7:*=0;
            var loc11:*=0;
            var loc3:*=0;
            var loc9:*;
            (loc9 = core.activities.ActivityFactory.createLogEntryFromLog(arg2)).isPause = false;
            var loc6:*;
            if ((loc6 = (arg1[0] & 2) >> 1) != 0) 
            {
                loc9.isWaypoint = true;
            }
            else 
            {
                loc9.isWaypoint = false;
            }
            var loc13:*;
            var loc14:*=(loc13 = (arg1[0] & 252) >> 2) - 10;
            loc9.temperature = loc14;
            var loc4:*;
            if ((loc4 = arg1[1]) == 20) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 504, "ROXDecoder > Decoding > Wrong heartrate value"));
            }
            loc9.heartrate = loc4;
            var loc10:*;
            if ((loc10 = arg1[2]) == 10) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 507, "ROX2010Decoder > Decoding > Wrong cadence value"));
            }
            loc9.cadence = loc10;
            var loc5:*=arg1[3] - 99;
            loc9.incline = loc5;
            if ((loc7 = (loc7 = (loc7 = (arg1[5] & 15) << 8) | arg1[4]) - 999) == 5000) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 502, "ROXDecoder > Decoding > Wrong altitude value"));
            }
            loc9.altitude = loc7 * 1000;
            var loc12:*=(loc12 = arg1[5] >> 5) | arg1[6] << 3;
            loc9.power = loc12;
            var loc8:*=0;
            loc8 = (loc8 = (arg1[8] & 3) << 8) | arg1[7];
            loc9.rotations = loc8;
            if ((loc11 = (loc11 = (arg1[9] & 15) << 6) | (arg1[8] & 252) >> 2) < 1 && loc11 > 0) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 503, "ROXDecoder > Decoding > Wrong speed value"));
            }
            loc9.speed = loc11 * 0.2;
            loc9.trainingTime = arg2.samplingRate * 100;
            var loc1:*=arg1[10];
            var loc2:*=0;
            loc3 = 0;
            while (loc3 < 10) 
            {
                loc2 = (loc2 = loc2 + arg1[loc3]) & 255;
                ++loc3;
            }
            if (loc2 == loc1) 
            {
            };
            return loc9;
        }

        internal function decodeAbsLogPauseEntry(arg1:Array, arg2:core.activities.Activity):core.activities.ActivityEntry
        {
            var loc4:*=0;
            var loc7:*;
            (loc7 = core.activities.ActivityFactory.createLogEntryFromLog(arg2)).isPause = true;
            var loc6:*;
            if ((loc6 = (arg1[0] & 2) >> 1) != 0) 
            {
                loc7.isWaypoint = true;
            }
            else 
            {
                loc7.isWaypoint = false;
            }
            var loc12:*;
            var loc14:*=(loc12 = (arg1[0] & 252) >> 2) - 10;
            loc7.temperature = loc14;
            var loc5:*;
            if ((loc5 = arg1[1]) == 20) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 504, "ROXDecoder > Decoding > Wrong heartrate value"));
            }
            loc7.heartrate = loc5;
            var loc8:*;
            if ((loc8 = arg1[2]) == 10) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 507, "ROX2010Decoder > Decoding > Wrong cadence value"));
            }
            loc7.cadence = loc8;
            var loc10:*;
            if ((loc10 = (loc10 = (loc10 = arg1[3]) | (arg1[4] & 31) << 8) - 999) == 5000) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 502, "ROXDecoder > Decoding > Wrong altitude value"));
            }
            loc7.altitude = loc10 * 1000;
            var loc11:*=(loc11 = (arg1[4] & 224) >> 5) | arg1[5] << 3;
            loc7.power = loc11;
            var loc2:*;
            if ((loc2 = arg1[6] & 63) != 63) 
            {
                loc7.trainingTime = loc2;
            }
            var loc13:*=(loc13 = arg1[7]) | (arg1[8] & 3) << 8;
            loc7.rotations = loc13;
            var loc9:*=(loc9 = (arg1[8] & 252) >> 2) | arg1[9] << 6;
            loc7.pauseTime = loc9 * 100;
            var loc1:*=arg1[10];
            var loc3:*=0;
            loc4 = 0;
            while (loc4 < 10) 
            {
                loc3 = (loc3 = loc3 + arg1[loc4]) & 31;
                ++loc4;
            }
            if (loc3 != loc1) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 505, "ROXDecoder > Decoding > Wrong checksum6"));
            }
            return loc7;
        }

        internal function decodeRelLogEntry(arg1:Array, arg2:core.activities.Activity):core.activities.ActivityEntry
        {
            var loc4:*=0;
            var loc1:*=core.activities.ActivityFactory.createLogEntryFromLog(arg2);
            loc1.isPause = false;
            var loc6:*;
            if ((loc6 = (arg1[0] & 2) >> 1) != 0) 
            {
                loc1.isWaypoint = true;
            }
            else 
            {
                loc1.isWaypoint = false;
            }
            var loc7:*=0;
            loc7 = (loc7 = (arg1[1] & 15) << 6) | (arg1[0] & 252) >> 2;
            loc1.rotations = loc7;
            var loc9:*;
            if ((loc9 = (loc9 = (arg1[1] & 240) >> 4) | (arg1[2] & 63) << 4) < 1 && loc9 > 0) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 503, "ROXDecoder > Decoding > Wrong speed value"));
            }
            loc1.speed = loc9 * 0.2;
            var loc5:*=arg1[3] - 99;
            loc1.incline = loc5;
            var loc8:*;
            if ((loc8 = arg1[4]) == 10) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 507, "ROX2010Decoder > Decoding > Wrong cadence value"));
            }
            loc1.cadence = loc8;
            var loc10:*=0;
            if ((loc10 = arg1[5]) == 20) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 504, "ROXDecoder > Decoding > Wrong heartrate value"));
            }
            loc1.heartrate = loc10;
            var loc11:*;
            if ((loc11 = (loc11 = (loc11 = (arg1[7] & 15) << 8) | arg1[6]) - 999) == 5000) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 502, "ROXDecoder > Decoding > Wrong altitude value"));
            }
            loc1.altitude = loc11 * 1000;
            var loc12:*=(loc12 = arg1[7] >> 5) | arg1[8] << 3;
            loc1.power = loc12;
            loc1.trainingTime = arg2.samplingRate * 100;
            var loc2:*=arg1[9];
            var loc3:*=0;
            loc4 = 0;
            while (loc4 < 9) 
            {
                loc3 = (loc3 = loc3 + arg1[loc4]) & 31;
                ++loc4;
            }
            if (loc3 == loc2) 
            {
            };
            return loc1;
        }

        internal function decodeRelLogPauseEntry(arg1:Array, arg2:core.activities.Activity):core.activities.ActivityEntry
        {
            var loc5:*=0;
            var loc1:*=core.activities.ActivityFactory.createLogEntryFromLog(arg2);
            loc1.isPause = true;
            var loc6:*;
            if ((loc6 = (arg1[0] & 2) >> 1) != 0) 
            {
                loc1.isWaypoint = true;
            }
            else 
            {
                loc1.isWaypoint = false;
            }
            var loc2:*;
            if ((loc2 = (arg1[0] & 252) >> 2) != 63) 
            {
                loc1.trainingTime = loc2;
            }
            var loc9:*=(loc9 = arg1[1]) | (arg1[2] & 63) << 8;
            loc1.pauseTime = loc9 * 100;
            var loc12:*=(loc12 = (arg1[2] & 192) >> 6) | arg1[3] << 2;
            loc1.rotations = loc12;
            var loc7:*;
            if ((loc7 = arg1[4]) == 10) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 507, "ROX2010Decoder > Decoding > Wrong cadence value"));
            }
            loc1.cadence = loc7;
            var loc8:*;
            if ((loc8 = arg1[5]) == 20) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 504, "ROXDecoder > Decoding > Wrong heartrate value"));
            }
            loc1.heartrate = loc8;
            var loc10:*;
            if ((loc10 = (loc10 = (loc10 = arg1[6]) | (arg1[7] & 31) << 8) - 999) == 5000) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 502, "ROXDecoder > Decoding > Wrong altitude value"));
            }
            loc1.altitude = loc10 * 1000;
            var loc11:*=(loc11 = (arg1[7] & 224) >> 5) | arg1[8] << 3;
            loc1.power = loc11;
            var loc3:*=arg1[9];
            var loc4:*=0;
            loc5 = 0;
            while (loc5 < 9) 
            {
                loc4 = (loc4 = loc4 + arg1[loc5]) & 31;
                ++loc5;
            }
            if (loc4 != loc3) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 506, "ROXDecoder > Decoding > Wrong checksum7"));
            }
            return loc1;
        }

        internal function smoothEntries_v1(arg1:core.activities.Activity):core.activities.Activity
        {
            var loc6:*=null;
            var loc18:*=null;
            var loc21:*=null;
            var loc5:*=null;
            var loc1:*=null;
            var loc10:*=NaN;
            var loc17:*=0;
            var loc14:*=0;
            var loc7:*=null;
            var loc8:*=null;
            var loc12:*=NaN;
            var loc16:*=arg1.entries;
            var loc20:*=0;
            var loc4:*=0;
            var loc19:*=0;
            var loc2:*=0;
            var loc13:*=0;
            var loc11:*=0;
            var loc3:*=0;
            var loc9:*=0;
            var loc15:*=0;
            loc10 = 0;
            while (loc10 < loc16.length) 
            {
                loc6 = loc16[loc10];
                if (loc10 > 0) 
                {
                    loc18 = loc16[(loc10 - 1)];
                    loc6.relativeRotations = calculateRotations(loc6.rotations, loc18.rotations);
                }
                if (loc10 < (loc16.length - 1)) 
                {
                    (loc5 = loc16[loc10 + 1]).relativeRotations = calculateRotations(loc5.rotations, loc6.rotations);
                }
                if (loc10 < loc16.length - 2) 
                {
                    loc1 = loc16[loc10 + 2];
                    loc1.relativeRotations = calculateRotations(loc1.rotations, loc5.rotations);
                }
                if (loc10 > 1) 
                {
                    loc21 = loc16[loc10 - 2];
                }
                if (loc6.speed < 0.5 && loc6.speed > 0) 
                {
                    if (loc18 == null) 
                    {
                        loc6.speed = 0;
                        loc6.riseRate = 0;
                    }
                    else 
                    {
                        loc6.speed = loc18.speed;
                    }
                }
                if (loc6.altitude == 5000) 
                {
                    if (loc18 == null) 
                    {
                        loc6.altitude = 0;
                        loc6.incline = 0;
                        loc6.riseRate = 0;
                    }
                    else 
                    {
                        loc6.altitude = loc18.altitude;
                        loc6.incline = loc18.incline;
                        loc6.riseRate = loc18.riseRate;
                    }
                }
                if (loc6.heartrate <= 20) 
                {
                    if (loc18 == null) 
                    {
                        loc6.heartrate = 0;
                    }
                    else 
                    {
                        loc6.heartrate = loc18.heartrate;
                    }
                }
                if (loc6.cadence == 10) 
                {
                    if (loc18 == null) 
                    {
                        loc6.cadence = 0;
                    }
                    else 
                    {
                        loc6.cadence = loc18.cadence;
                    }
                }
                if (loc10 == 0) 
                {
                    loc6.trainingTime = 0;
                }
                if (loc6.isPause && !(loc18 == null) && loc18.isPause) 
                {
                    loc18.pauseTime = loc18.pauseTime + loc6.pauseTime;
                    loc18.relativeRotations = loc18.relativeRotations + loc6.relativeRotations;
                    loc18.trainingTime = loc18.trainingTime + loc6.trainingTime;
                    loc18.speed = (loc18.speed + loc6.speed) / 2;
                    loc18.incline = (loc18.incline + loc6.incline) / 2;
                    loc18.riseRate = loc18.speed * 3.6 / 0.06 * loc18.incline / 100 * 1000;
                    loc18.altitude = (loc18.altitude + loc6.altitude) / 2;
                    loc18.temperature = (loc18.temperature + loc6.temperature) / 2;
                    loc18.heartrate = (loc18.heartrate + loc6.heartrate) / 2;
                    loc18.cadence = (loc18.cadence + loc6.cadence) / 2;
                    loc18.power = (loc18.power + loc6.power) / 2;
                    if (loc18.isWaypoint || loc6.isWaypoint) 
                    {
                        loc18.isWaypoint = true;
                    }
                    handler.ActivityCalculator.removeEntryFromEntriesVector(loc16[loc10], loc16);
                    --loc10;
                }
                else 
                {
                    if (!(loc18 == null) && !(loc21 == null) && loc18.isPause) 
                    {
                        loc17 = loc21.relativeRotations * 0.7 / arg1.samplingRate * 100 * loc18.trainingTime;
                        if (loc18.trainingTime > 0 && loc17 == 0) 
                        {
                            loc17 = 1;
                        }
                        if ((loc14 = loc6.relativeRotations - loc17) < 0) 
                        {
                            loc14 = 0;
                            loc18.relativeRotations = loc6.relativeRotations;
                        }
                        else 
                        {
                            loc18.relativeRotations = loc17;
                        }
                        loc6.relativeRotations = loc14;
                        if (!loc6.isPause) 
                        {
                            loc21.trainingTime = loc21.trainingTime + loc18.trainingTime;
                            loc21.trainingTimeAbsolute = loc21.trainingTimeAbsolute + loc18.trainingTime;
                            loc21.relativeRotations = loc21.relativeRotations + loc18.relativeRotations;
                            loc18.trainingTime = 0;
                            loc18.trainingTimeAbsolute = loc21.trainingTimeAbsolute;
                            loc18.trainingTimeDownhill = 0;
                            loc18.trainingTimeUphill = 0;
                            loc18.relativeRotations = 0;
                            loc18.altitudeDifferencesDownhill = 0;
                            loc18.altitudeDifferencesUphill = 0;
                            loc18.distance = 0;
                            loc18.distanceDownhill = 0;
                            loc18.distanceUphill = 0;
                            loc18.temperature = loc21.temperature;
                            loc18.incline = 0;
                            loc18.riseRate = 0;
                            loc18.speed = 0;
                            loc18.cadence = 0;
                            loc18.power = 0;
                        }
                    }
                    if (arg1.samplingRate != 4.5) 
                    {
                        if (arg1.samplingRate == 10.125) 
                        {
                            if (loc6.heartrate == 0 && loc5 && loc18) 
                            {
                                if (loc5.heartrate != 0) 
                                {
                                    if (loc18 != null) 
                                    {
                                        loc6.heartrate = loc18.heartrate;
                                        ++loc9;
                                    }
                                }
                            }
                        }
                    }
                    else if (loc6.heartrate == 0 && loc18 && loc5 && loc1) 
                    {
                        if (loc5.heartrate != 0) 
                        {
                            if (loc18 != null) 
                            {
                                loc6.heartrate = loc18.heartrate;
                                ++loc9;
                            }
                        }
                        else if (loc1.heartrate != 0) 
                        {
                            if (loc18 != null) 
                            {
                                loc6.heartrate = loc18.heartrate;
                                loc5.heartrate = loc18.heartrate;
                                loc9 = loc9 + 2;
                            }
                        }
                    }
                }
                loc6.riseRate = loc6.speed * 3.6 / 0.06 * loc6.incline / 100 * 1000;
                loc6.calories = utils.Calculations.calculateCalories(arg1, loc6);
                loc15 = loc15 + loc6.calories;
                ++loc10;
            }
            utils.Calculations.calculateCaloriesDifferenceFactor(arg1, arg1.calories, loc15);
            arg1.pauseTime = 0;
            arg1.trainingTime = 0;
            arg1.distance = 0;
            loc12 = 0;
            while (loc12 < loc16.length) 
            {
                loc7 = loc16[loc12];
                if (loc12 > 0) 
                {
                    loc8 = loc16[(loc12 - 1)];
                }
                if (!loc7.isPause) 
                {
                    loc20 = loc20 + loc7.speed;
                    loc4 = loc4 + loc7.altitude;
                    loc19 = loc19 + loc7.heartrate;
                    loc2 = loc2 + loc7.temperature;
                    loc13 = loc13 + loc7.cadence;
                    loc11 = loc11 + loc7.power;
                    ++loc3;
                }
                arg1 = calculateValuesFromBasisValues(arg1, loc7, loc8);
                arg1 = calcMinMaxValues(arg1, loc7, loc12);
                loc16[loc12].calories = loc16[loc12].calories - loc16[loc12].calories * arg1.caloriesDifferenceFactor;
                ++loc12;
            }
            arg1.entries = loc16;
            arg1 = calcAverages(arg1, loc20, loc4, loc19, loc2, loc13, loc11, loc3);
            return arg1;
        }

        public static function getInstance():decoder.Rox2010Decoder
        {
            if (_instance == null) 
            {
                _instance = new Rox2010Decoder();
            }
            return _instance;
        }

        public static const MY_NAME:Array=["*", "+", "-", "=", ".", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", " ", "♥"];

        internal var _7infotripArray:Array;

        internal static var _instance:decoder.Rox2010Decoder;
    }
}


