//class CommonTimeZoneDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    
    public class CommonTimeZoneDataProvider extends Object
    {
        public function CommonTimeZoneDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"data":0, "label":"Almaty (GMT+06:00)"}, {"data":1, "label":"Athens (GMT+02:00)"}, {"data":2, "label":"Auckland (GMT+12:00)"}, {"data":3, "label":"Azores (GMT-01:00)"}, {"data":4, "label":"Baghdad (GMT+03:00)"}, {"data":5, "label":"Baku (GMT+04:00)"}, {"data":6, "label":"Bangkok (GMT+07:00)"}, {"data":7, "label":"Beijing (GMT+08:00)"}, {"data":8, "label":"Berlin (GMT+01:00)"}, {"data":9, "label":"Bern (GMT+01:00)"}, {"data":10, "label":"Brasilia (GMT-03:00)"}, {"data":11, "label":"Brussels (GMT+01:00)"}, {"data":12, "label":"Budapest (GMT+01:00)"}, {"data":13, "label":"BuenosAires (GMT-03:00)"}, {"data":14, "label":"Cairo (GMT+02:00)"}, {"data":15, "label":"Canberra (GMT+10:00)"}, {"data":16, "label":"CapeVerdeIs. (GMT-01:00)"}, {"data":17, "label":"Caracas (GMT-04:00)"}, {"data":18, "label":"Chennai (GMT+05:30)"}, {"data":19, "label":"Copenhageu (GMT+01:00)"}, {"data":20, "label":"Darwin (GMT+09:30)"}, {"data":21, "label":"Dublin (GMT+00:00)"}, {"data":22, "label":"Edinburgh (GMT+00:00)"}, {"data":23, "label":"Fiji (GMT+12:00)"}, {"data":24, "label":"Georgetown (GMT-03:00)"}, {"data":25, "label":"Greenland (GMT-03:00)"}, {"data":26, "label":"Guam (GMT+10:00)"}, {"data":27, "label":"Hanoi (GMT+07:00)"}, {"data":28, "label":"HongKong (GMT+08:00)"}, {"data":29, "label":"Islamabad (GMT+05:00)"}, {"data":30, "label":"Istanbul (GMT+02:00)"}, {"data":31, "label":"Jakarta (GMT+07:00)"}, {"data":32, "label":"Jerusalem (GMT+02:00)"}, {"data":33, "label":"Kabul (GMT+04:30)"}, {"data":34, "label":"Karachi (GMT+05:00)"}, {"data":35, "label":"Kuwaut (GMT+03:00)"}, {"data":36, "label":"Lima (GMT-05:00)"}, {"data":37, "label":"Lisbon (GMT+00:00)"}, {"data":38, "label":"London (GMT+00:00)"}, {"data":39, "label":"Madrid (GMT+01:00)"}, {"data":40, "label":"Magadan (GMT+11:00)"}, {"data":41, "label":"Melbourne (GMT+10:00)"}, {"data":42, "label":"Mexico (GMT-06:00)"}, {"data":43, "label":"Mid-Atlantic (GMT-02:00)"}, {"data":44, "label":"Monrovia (GMT+00:00)"}, {"data":45, "label":"Moscow (GMT+03:00)"}, {"data":46, "label":"Mumbai (GMT+05:30)"}, {"data":47, "label":"Muscat (GMT+04:00)"}, {"data":48, "label":"Newfoundland (GMT-03:30)"}, {"data":49, "label":"Paris (GMT+01:00)"}, {"data":50, "label":"Prague (GMT+01:00)"}, {"data":51, "label":"Quito (GMT-05:00)"}, {"data":52, "label":"Rome (GMT+01:00)"}, {"data":53, "label":"Samoa (GMT-11:00)"}, {"data":54, "label":"Santiago (GMT-04:00)"}, {"data":55, "label":"Seoul (GMT+09:00)"}, {"data":56, "label":"Singapore (GMT+08:00)"}, {"data":57, "label":"SolomonIs. (GMT+11:00)"}, {"data":58, "label":"Sydney (GMT+10:00)"}, {"data":59, "label":"Taipei (GMT+08:00)"}, {"data":60, "label":"Tashkent (GMT+05:00)"}, {"data":61, "label":"Tehran (GMT+03:30)"}, {"data":62, "label":"Tokyo (GMT+09:00)"}, {"data":63, "label":"US-Alaska (GMT-09:00)"}, {"data":64, "label":"US-Arizona (GMT-07:00)"}, {"data":65, "label":"US-Atlantic (GMT-04:00)"}, {"data":66, "label":"US-Central (GMT-06:00)"}, {"data":67, "label":"US-Eastern (GMT-05:00)"}, {"data":68, "label":"US-Hawaii (GMT-10:00)"}, {"data":69, "label":"US-Mountain (GMT-07:00)"}, {"data":70, "label":"US-Pacific (GMT-08:00)"}, {"data":71, "label":"Vienna (GMT+01:00)"}, {"data":72, "label":"Vladivostok (GMT+10:00)"}, {"data":73, "label":"Wellington (GMT+12:00)"}, {"data":74, "label":"Yangon (GMT+06:30)"}, {"data":75, "label":"Yerevan (GMT+04:00)"}, {"data":76, "label":"-14:00"}, {"data":77, "label":"-13:30"}, {"data":78, "label":"-13:00"}, {"data":79, "label":"-12:30"}, {"data":80, "label":"-12:00"}, {"data":81, "label":"-11:30"}, {"data":82, "label":"-11:00"}, {"data":83, "label":"-10:30"}, {"data":84, "label":"-10:00"}, {"data":85, "label":"-09:30"}, {"data":86, "label":"-09:00"}, {"data":87, "label":"-08:30"}, {"data":88, "label":"-08:00"}, {"data":89, "label":"-07:30"}, {"data":90, "label":"-07:00"}, {"data":91, "label":"-06:30"}, {"data":92, "label":"-06:00"}, {"data":93, "label":"-05:30"}, {"data":94, "label":"-05:00"}, {"data":95, "label":"-04:30"}, {"data":96, "label":"-04:00"}, {"data":97, "label":"-03:30"}, {"data":98, "label":"-03:00"}, {"data":99, "label":"-02:30"}, {"data":100, "label":"-02:00"}, {"data":101, "label":"-01:30"}, {"data":102, "label":"-01:00"}, {"data":103, "label":"00:30"}, {"data":104, "label":"00:00"}, {"data":105, "label":"00:30"}, {"data":106, "label":"01:00"}, {"data":107, "label":"01:30"}, {"data":108, "label":"02:00"}, {"data":109, "label":"02:30"}, {"data":110, "label":"03:00"}, {"data":111, "label":"03:30"}, {"data":112, "label":"04:00"}, {"data":113, "label":"04:30"}, {"data":114, "label":"05:00"}, {"data":115, "label":"05:30"}, {"data":116, "label":"06:00"}, {"data":117, "label":"06:30"}, {"data":118, "label":"07:00"}, {"data":119, "label":"07:30"}, {"data":120, "label":"08:00"}, {"data":121, "label":"08:30"}, {"data":122, "label":"09:00"}, {"data":123, "label":"09:30"}, {"data":124, "label":"10:00"}, {"data":125, "label":"10:30"}, {"data":126, "label":"11:00"}, {"data":127, "label":"11:30"}, {"data":128, "label":"12:00"}, {"data":129, "label":"12:30"}, {"data":130, "label":"13:00"}, {"data":131, "label":"13:30"}, {"data":132, "label":"14:00"}]);
            DATA_PROVIDER_GPS_10 = __AS3__.vec.Vector.<Object>([{"data":0, "label":"GMT -12:00"}, {"data":1, "label":"GMT -11:00"}, {"data":2, "label":"GMT -10:00"}, {"data":3, "label":"GMT -09:30"}, {"data":4, "label":"GMT -09:00"}, {"data":5, "label":"GMT -08:00"}, {"data":6, "label":"GMT -07:00"}, {"data":7, "label":"GMT -06:00"}, {"data":8, "label":"GMT -05:00"}, {"data":9, "label":"GMT -04:30"}, {"data":10, "label":"GMT -04:00"}, {"data":11, "label":"GMT -03:30"}, {"data":12, "label":"GMT -03:00"}, {"data":13, "label":"GMT -02:00"}, {"data":14, "label":"GMT -01:00"}, {"data":15, "label":"GMT +00:00"}, {"data":16, "label":"GMT +01:00"}, {"data":17, "label":"GMT +02:00"}, {"data":18, "label":"GMT +03:00"}, {"data":19, "label":"GMT +03:30"}, {"data":20, "label":"GMT +04:00"}, {"data":21, "label":"GMT +04:30"}, {"data":22, "label":"GMT +05:00"}, {"data":23, "label":"GMT +05:30"}, {"data":24, "label":"GMT +05:45"}, {"data":25, "label":"GMT +06:00"}, {"data":26, "label":"GMT +06:30"}, {"data":27, "label":"GMT +07:00"}, {"data":28, "label":"GMT +08:00"}, {"data":29, "label":"GMT +08:45"}, {"data":30, "label":"GMT +09:00"}, {"data":31, "label":"GMT +09:30"}, {"data":32, "label":"GMT +10:00"}, {"data":33, "label":"GMT +10:30"}, {"data":34, "label":"GMT +11:00"}, {"data":35, "label":"GMT +11:30"}, {"data":36, "label":"GMT +12:00"}, {"data":37, "label":"GMT +12:45"}, {"data":38, "label":"GMT +13:00"}, {"data":39, "label":"GMT +14:00"}]);
            return;
        }

        public static var DATA_PROVIDER:__AS3__.vec.Vector.<Object>;

        public static var DATA_PROVIDER_GPS_10:__AS3__.vec.Vector.<Object>;
    }
}


