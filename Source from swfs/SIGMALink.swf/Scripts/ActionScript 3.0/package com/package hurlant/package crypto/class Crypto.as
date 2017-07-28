//class Crypto
package com.hurlant.crypto 
{
    import com.hurlant.crypto.hash.*;
    import com.hurlant.crypto.prng.*;
    import com.hurlant.crypto.rsa.*;
    import com.hurlant.crypto.symmetric.*;
    import com.hurlant.util.*;
    import flash.utils.*;
    
    public class Crypto extends Object
    {
        public function Crypto()
        {
            super();
            return;
        }

        public static function getCipher(arg1:String, arg2:flash.utils.ByteArray, arg3:com.hurlant.crypto.symmetric.IPad=null):com.hurlant.crypto.symmetric.ICipher
        {
            var loc2:*=null;
            var loc1:*=arg1.split("-");
            var loc3:*=loc1[0];
            switch (loc3) 
            {
                case "simple":
                {
                    loc1.shift();
                    arg1 = loc1.join("-");
                    loc2 = getCipher(arg1, arg2, arg3);
                    if (loc2 is com.hurlant.crypto.symmetric.IVMode) 
                    {
                        return new com.hurlant.crypto.symmetric.SimpleIVMode(loc2 as com.hurlant.crypto.symmetric.IVMode);
                    }
                    return loc2;
                }
                case "aes":
                case "aes128":
                case "aes192":
                case "aes256":
                {
                    loc1.shift();
                    if (arg2.length * 8 == loc1[0]) 
                    {
                        loc1.shift();
                    }
                    return getMode(loc1[0], new com.hurlant.crypto.symmetric.AESKey(arg2), arg3);
                }
                case "bf":
                case "blowfish":
                {
                    loc1.shift();
                    return getMode(loc1[0], new com.hurlant.crypto.symmetric.BlowFishKey(arg2), arg3);
                }
                case "des":
                {
                    loc1.shift();
                    if (!(loc1[0] == "ede") && !(loc1[0] == "ede3")) 
                    {
                        return getMode(loc1[0], new com.hurlant.crypto.symmetric.DESKey(arg2), arg3);
                    }
                    if (loc1.length == 1) 
                    {
                        loc1.push("ecb");
                    }
                }
                case "3des":
                case "des3":
                {
                    loc1.shift();
                    return getMode(loc1[0], new com.hurlant.crypto.symmetric.TripleDESKey(arg2), arg3);
                }
                case "xtea":
                {
                    loc1.shift();
                    return getMode(loc1[0], new com.hurlant.crypto.symmetric.XTeaKey(arg2), arg3);
                }
                case "rc4":
                {
                    loc1.shift();
                    return new com.hurlant.crypto.prng.ARC4(arg2);
                }
            }
            return null;
        }

        public static function getHash(arg1:String):com.hurlant.crypto.hash.IHash
        {
            var loc1:*=arg1;
            switch (loc1) 
            {
                case "md2":
                {
                    return new com.hurlant.crypto.hash.MD2();
                }
                case "md5":
                {
                    return new com.hurlant.crypto.hash.MD5();
                }
                case "sha":
                case "sha1":
                {
                    return new com.hurlant.crypto.hash.SHA1();
                }
                case "sha224":
                {
                    return new com.hurlant.crypto.hash.SHA224();
                }
                case "sha256":
                {
                    return new com.hurlant.crypto.hash.SHA256();
                }
            }
            return null;
        }

        public static function getRSA(arg1:String, arg2:String):com.hurlant.crypto.rsa.RSAKey
        {
            return com.hurlant.crypto.rsa.RSAKey.parsePublicKey(arg2, arg1);
        }

        internal static function getMode(arg1:String, arg2:com.hurlant.crypto.symmetric.ISymmetricKey, arg3:com.hurlant.crypto.symmetric.IPad=null):com.hurlant.crypto.symmetric.IMode
        {
            var loc1:*=arg1;
            switch (loc1) 
            {
                case "ecb":
                {
                    return new com.hurlant.crypto.symmetric.ECBMode(arg2, arg3);
                }
                case "cfb":
                {
                    return new com.hurlant.crypto.symmetric.CFBMode(arg2, arg3);
                }
                case "cfb8":
                {
                    return new com.hurlant.crypto.symmetric.CFB8Mode(arg2, arg3);
                }
                case "ofb":
                {
                    return new com.hurlant.crypto.symmetric.OFBMode(arg2, arg3);
                }
                case "ctr":
                {
                    return new com.hurlant.crypto.symmetric.CTRMode(arg2, arg3);
                }
                case "cbc":
                default:
                {
                    return new com.hurlant.crypto.symmetric.CBCMode(arg2, arg3);
                }
            }
        }

        public static function getKeySize(arg1:String):uint
        {
            var loc1:*=arg1.split("-");
            var loc2:*=loc1[0];
            switch (loc2) 
            {
                case "simple":
                {
                    loc1.shift();
                    return getKeySize(loc1.join("-"));
                }
                case "aes128":
                {
                    return 16;
                }
                case "aes192":
                {
                    return 24;
                }
                case "aes256":
                {
                    return 32;
                }
                case "aes":
                {
                    loc1.shift();
                    return parseInt(loc1[0]) / 8;
                }
                case "bf":
                case "blowfish":
                {
                    return 16;
                }
                case "des":
                {
                    loc1.shift();
                    loc2 = loc1[0];
                    switch (loc2) 
                    {
                        case "ede":
                        {
                            return 16;
                        }
                        case "ede3":
                        {
                            return 24;
                        }
                        default:
                        {
                            return 8;
                        }
                    }
                }
                case "3des":
                case "des3":
                {
                    return 24;
                }
                case "xtea":
                {
                    return 8;
                }
                case "rc4":
                {
                    if (parseInt(loc1[1]) > 0) 
                    {
                        return parseInt(loc1[1]) / 8;
                    }
                    return 16;
                }
            }
            return 0;
        }

        public static function getPad(arg1:String):com.hurlant.crypto.symmetric.IPad
        {
            var loc1:*=arg1;
            switch (loc1) 
            {
                case "null":
                {
                    return new com.hurlant.crypto.symmetric.NullPad();
                }
                case "pkcs5":
                default:
                {
                    return new com.hurlant.crypto.symmetric.PKCS5();
                }
            }
        }

        public static function getHMAC(arg1:String):com.hurlant.crypto.hash.HMAC
        {
            var loc1:*=arg1.split("-");
            if (loc1[0] == "hmac") 
            {
                loc1.shift();
            }
            var loc2:*=0;
            if (loc1.length > 1) 
            {
                loc2 = parseInt(loc1[1]);
            }
            return new com.hurlant.crypto.hash.HMAC(getHash(loc1[0]), loc2);
        }

        internal var b64:com.hurlant.util.Base64;
    }
}


