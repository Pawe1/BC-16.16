//class NfcProtocolCmd
package service.nfc 
{
    public class NfcProtocolCmd extends Object
    {
        public function NfcProtocolCmd()
        {
            super();
            return;
        }

        public static const NFC_CHECKSUM_CONST:uint=1;

        public static const NFC_GET_CMD:uint=250;

        public static const NFC_GET_LIST_PH_CMD:uint=1;

        public static const NFC_GET_LIST_PH_CMD_RQST_LEN:uint=9;

        public static const NFC_GET_LIST_PH_CMD_RSP_LEN:uint=7;

        public static const NFC_GET_LOG_DATA_CMD:uint=4;

        public static const NFC_GET_LOG_DATA_CMD_RQST_LEN:uint=9;

        public static const NFC_GET_PH_INFO_CMD:uint=3;

        public static const NFC_GET_PH_INFO_CMD_RQST_LEN:uint=9;

        public static const NFC_GET_PH_INFO_CMD_RSP_LEN:uint=71;
    }
}


