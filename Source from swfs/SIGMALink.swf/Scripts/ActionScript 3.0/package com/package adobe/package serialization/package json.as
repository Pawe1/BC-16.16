//package json
//  class JSON
package com.adobe.serialization.json 
{
    public class JSON extends Object
    {
        public function JSON()
        {
            super();
            return;
        }

        public static function decode(arg1:String, arg2:Boolean=true):*
        {
            return new com.adobe.serialization.json.JSONDecoder(arg1, arg2).getValue();
        }

        public static function encode(arg1:Object):String
        {
            return new com.adobe.serialization.json.JSONEncoder(arg1).getString();
        }
    }
}


//  class JSONDecoder
package com.adobe.serialization.json 
{
    public class JSONDecoder extends Object
    {
        public function JSONDecoder(arg1:String, arg2:Boolean)
        {
            super();
            this.strict = arg2;
            this.tokenizer = new com.adobe.serialization.json.JSONTokenizer(arg1, arg2);
            this.nextToken();
            this.value = this.parseValue();
            if (arg2 && !(this.nextToken() == null)) 
            {
                this.tokenizer.parseError("Unexpected characters left in input stream");
            }
            return;
        }

        internal function nextToken():com.adobe.serialization.json.JSONToken
        {
            var loc1:*;
            this.token = loc1 = this.tokenizer.getNextToken();
            return loc1;
        }

        internal function parseObject():Object
        {
            var loc2:*=null;
            var loc1:*=new Object();
            this.nextToken();
            if (this.token.type == com.adobe.serialization.json.JSONTokenType.RIGHT_BRACE) 
            {
                return loc1;
            }
            if (!this.strict && this.token.type == com.adobe.serialization.json.JSONTokenType.COMMA) 
            {
                this.nextToken();
                if (this.token.type == com.adobe.serialization.json.JSONTokenType.RIGHT_BRACE) 
                {
                    return loc1;
                }
                this.tokenizer.parseError("Leading commas are not supported.  Expecting \'}\' but found " + this.token.value);
            }
            for (;;) 
            {
                if (this.token.type == com.adobe.serialization.json.JSONTokenType.STRING) 
                {
                    loc2 = String(this.token.value);
                    this.nextToken();
                    if (this.token.type != com.adobe.serialization.json.JSONTokenType.COLON) 
                    {
                        this.tokenizer.parseError("Expecting : but found " + this.token.value);
                    }
                    else 
                    {
                        this.nextToken();
                        loc1[loc2] = this.parseValue();
                        this.nextToken();
                        if (this.token.type == com.adobe.serialization.json.JSONTokenType.RIGHT_BRACE) 
                        {
                            return loc1;
                        }
                        if (this.token.type != com.adobe.serialization.json.JSONTokenType.COMMA) 
                        {
                            this.tokenizer.parseError("Expecting } or , but found " + this.token.value);
                        }
                        else 
                        {
                            this.nextToken();
                            if (!this.strict) 
                            {
                                if (this.token.type == com.adobe.serialization.json.JSONTokenType.RIGHT_BRACE) 
                                {
                                    return loc1;
                                }
                            }
                        }
                    }
                    continue;
                }
                this.tokenizer.parseError("Expecting string but found " + this.token.value);
            }
            return null;
        }

        internal function parseArray():Array
        {
            var loc1:*=new Array();
            this.nextToken();
            if (this.token.type == com.adobe.serialization.json.JSONTokenType.RIGHT_BRACKET) 
            {
                return loc1;
            }
            if (!this.strict && this.token.type == com.adobe.serialization.json.JSONTokenType.COMMA) 
            {
                this.nextToken();
                if (this.token.type == com.adobe.serialization.json.JSONTokenType.RIGHT_BRACKET) 
                {
                    return loc1;
                }
                this.tokenizer.parseError("Leading commas are not supported.  Expecting \']\' but found " + this.token.value);
            }
            for (;;) 
            {
                loc1.push(this.parseValue());
                this.nextToken();
                if (this.token.type == com.adobe.serialization.json.JSONTokenType.RIGHT_BRACKET) 
                {
                    return loc1;
                }
                if (this.token.type == com.adobe.serialization.json.JSONTokenType.COMMA) 
                {
                    this.nextToken();
                    if (!this.strict) 
                    {
                        if (this.token.type == com.adobe.serialization.json.JSONTokenType.RIGHT_BRACKET) 
                        {
                            return loc1;
                        }
                    }
                    continue;
                }
                this.tokenizer.parseError("Expecting ] or , but found " + this.token.value);
            }
            return null;
        }

        public function getValue():*
        {
            return this.value;
        }

        internal function parseValue():Object
        {
            if (this.token == null) 
            {
                this.tokenizer.parseError("Unexpected end of input");
            }
            var loc1:*=this.token.type;
            switch (loc1) 
            {
                case com.adobe.serialization.json.JSONTokenType.LEFT_BRACE:
                {
                    return this.parseObject();
                }
                case com.adobe.serialization.json.JSONTokenType.LEFT_BRACKET:
                {
                    return this.parseArray();
                }
                case com.adobe.serialization.json.JSONTokenType.STRING:
                case com.adobe.serialization.json.JSONTokenType.NUMBER:
                case com.adobe.serialization.json.JSONTokenType.TRUE:
                case com.adobe.serialization.json.JSONTokenType.FALSE:
                case com.adobe.serialization.json.JSONTokenType.NULL:
                {
                    return this.token.value;
                }
                case com.adobe.serialization.json.JSONTokenType.NAN:
                {
                    if (!this.strict) 
                    {
                        return this.token.value;
                    }
                    this.tokenizer.parseError("Unexpected " + this.token.value);
                }
                default:
                {
                    this.tokenizer.parseError("Unexpected " + this.token.value);
                }
            }
            return null;
        }

        internal var strict:Boolean;

        internal var value:*;

        internal var tokenizer:com.adobe.serialization.json.JSONTokenizer;

        internal var token:com.adobe.serialization.json.JSONToken;
    }
}


//  class JSONEncoder
package com.adobe.serialization.json 
{
    import flash.utils.*;
    
    public class JSONEncoder extends Object
    {
        public function JSONEncoder(arg1:*)
        {
            super();
            this.jsonString = this.convertToString(arg1);
            return;
        }

        internal function escapeString(arg1:String):String
        {
            var loc2:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc1:*="";
            var loc3:*=arg1.length;
            var loc4:*=0;
            while (loc4 < loc3) 
            {
                loc2 = arg1.charAt(loc4);
                var loc7:*=loc2;
                switch (loc7) 
                {
                    case "\"":
                    {
                        loc1 = loc1 + "\\\"";
                        break;
                    }
                    case "\\":
                    {
                        loc1 = loc1 + "\\\\";
                        break;
                    }
                    case "":
                    {
                        loc1 = loc1 + "\\b";
                        break;
                    }
                    case "":
                    {
                        loc1 = loc1 + "\\f";
                        break;
                    }
                    case "\n":
                    {
                        loc1 = loc1 + "\\n";
                        break;
                    }
                    case "\r":
                    {
                        loc1 = loc1 + "\\r";
                        break;
                    }
                    case "\t":
                    {
                        loc1 = loc1 + "\\t";
                        break;
                    }
                    default:
                    {
                        if (loc2 < " ") 
                        {
                            loc5 = loc2.charCodeAt(0).toString(16);
                            loc6 = loc5.length != 2 ? "000" : "00";
                            loc1 = loc1 + ("\\u" + loc6 + loc5);
                        }
                        else 
                        {
                            loc1 = loc1 + loc2;
                        }
                    }
                }
                ++loc4;
            }
            return "\"" + loc1 + "\"";
        }

        internal function arrayToString(arg1:Array):String
        {
            var loc1:*="";
            var loc2:*=0;
            while (loc2 < arg1.length) 
            {
                if (loc1.length > 0) 
                {
                    loc1 = loc1 + ",";
                }
                loc1 = loc1 + this.convertToString(arg1[loc2]);
                ++loc2;
            }
            return "[" + loc1 + "]";
        }

        public function getString():String
        {
            return this.jsonString;
        }

        internal function objectToString(arg1:Object):String
        {
            var value:Object;
            var s:String;
            var classInfo:XML;
            var key:String;
            var v:XML;
            var o:Object;

            var loc1:*;
            value = null;
            key = null;
            v = null;
            o = arg1;
            s = "";
            classInfo = flash.utils.describeType(o);
            if (classInfo.@name.toString() != "Object") 
            {
                loc2 = 0;
                var loc5:*=0;
                var loc6:*=classInfo;
                var loc4:*=new XMLList("");
                for each (var loc7:* in loc6) 
                {
                    var loc8:*;
                    with (loc8 = loc7) 
                    {
                        if (name() == "variable" || name() == "accessor" && attribute("access").charAt(0) == "r") 
                        {
                            loc4[loc5] = loc7;
                        }
                    }
                }
                loc3 = loc4;
                for each (v in loc3) 
                {
                    if (v.metadata) 
                    {
                        v.metadata;
                        loc5 = 0;
                        loc6 = v.metadata;
                        loc4 = new XMLList("");
                        for each (loc7 in loc6) 
                        {
                            with (loc8 = loc7) 
                            {
                                if (@name == "Transient") 
                                {
                                    loc4[loc5] = loc7;
                                }
                            }
                        }
                    }
                    if (v.metadata) 
                    {
                        continue;
                    }
                    if (s.length > 0) 
                    {
                        s = s + ",";
                    }
                    s = s + (this.escapeString(v.@name.toString()) + ":" + this.convertToString(o[v.@name]));
                }
            }
            else 
            {
                var loc2:*=0;
                var loc3:*=o;
                for (key in loc3) 
                {
                    value = o[key];
                    if (value is Function) 
                    {
                        continue;
                    }
                    if (s.length > 0) 
                    {
                        s = s + ",";
                    }
                    s = s + (this.escapeString(key) + ":" + this.convertToString(value));
                }
            }
            return "{" + s + "}";
        }

        internal function convertToString(arg1:*):String
        {
            if (arg1 is String) 
            {
                return this.escapeString(arg1 as String);
            }
            if (arg1 is Number) 
            {
                return isFinite(arg1 as Number) ? arg1.toString() : "null";
            }
            if (arg1 is Boolean) 
            {
                return arg1 ? "true" : "false";
            }
            if (arg1 is Array) 
            {
                return this.arrayToString(arg1 as Array);
            }
            if (arg1 is Object && !(arg1 == null)) 
            {
                return this.objectToString(arg1);
            }
            return "null";
        }

        internal var jsonString:String;
    }
}


//  class JSONParseError
package com.adobe.serialization.json 
{
    public class JSONParseError extends Error
    {
        public function JSONParseError(arg1:String="", arg2:int=0, arg3:String="")
        {
            super(arg1);
            name = "JSONParseError";
            this._location = arg2;
            this._text = arg3;
            return;
        }

        public function get location():int
        {
            return this._location;
        }

        public function get text():String
        {
            return this._text;
        }

        internal var _location:int;

        internal var _text:String;
    }
}


//  class JSONToken
package com.adobe.serialization.json 
{
    public class JSONToken extends Object
    {
        public function JSONToken(arg1:int=-1, arg2:Object=null)
        {
            super();
            this._type = arg1;
            this._value = arg2;
            return;
        }

        public function get value():Object
        {
            return this._value;
        }

        public function get type():int
        {
            return this._type;
        }

        public function set type(arg1:int):void
        {
            this._type = arg1;
            return;
        }

        public function set value(arg1:Object):void
        {
            this._value = arg1;
            return;
        }

        internal var _value:Object;

        internal var _type:int;
    }
}


//  class JSONTokenType
package com.adobe.serialization.json 
{
    public class JSONTokenType extends Object
    {
        public function JSONTokenType()
        {
            super();
            return;
        }

        public static const FALSE:int=8;

        public static const RIGHT_BRACKET:int=4;

        public static const NULL:int=9;

        public static const NUMBER:int=11;

        public static const TRUE:int=7;

        public static const RIGHT_BRACE:int=2;

        public static const STRING:int=10;

        public static const LEFT_BRACKET:int=3;

        public static const LEFT_BRACE:int=1;

        public static const UNKNOWN:int=-1;

        public static const COMMA:int=0;

        public static const NAN:int=12;

        public static const COLON:int=6;
    }
}


//  class JSONTokenizer
package com.adobe.serialization.json 
{
    public class JSONTokenizer extends Object
    {
        public function JSONTokenizer(arg1:String, arg2:Boolean)
        {
            this.controlCharsRegExp = new RegExp("[\\x00-\\x1F]");
            super();
            this.jsonString = arg1;
            this.strict = arg2;
            this.loc = 0;
            this.nextChar();
            return;
        }

        internal function skipComments():void
        {
            if (this.ch == "/") 
            {
                this.nextChar();
                var loc1:*=this.ch;
                switch (loc1) 
                {
                    case "/":
                    {
                        do 
                        {
                            this.nextChar();
                        }
                        while (!(this.ch == "\n") && !(this.ch == ""));
                        this.nextChar();
                        break;
                    }
                    case "*":
                    {
                        this.nextChar();
                        for (;;) 
                        {
                            if (this.ch != "*") 
                            {
                                this.nextChar();
                            }
                            else 
                            {
                                this.nextChar();
                                if (this.ch == "/") 
                                {
                                    this.nextChar();
                                    break;
                                }
                            }
                            if (this.ch != "") 
                            {
                                continue;
                            }
                            this.parseError("Multi-line comment not closed");
                        }
                        break;
                    }
                    default:
                    {
                        this.parseError("Unexpected " + this.ch + " encountered (expecting \'/\' or \'*\' )");
                    }
                }
            }
            return;
        }

        internal function isDigit(arg1:String):Boolean
        {
            return arg1 >= "0" && arg1 <= "9";
        }

        internal function readNumber():com.adobe.serialization.json.JSONToken
        {
            var loc3:*=null;
            var loc1:*="";
            if (this.ch == "-") 
            {
                loc1 = loc1 + "-";
                this.nextChar();
            }
            if (!this.isDigit(this.ch)) 
            {
                this.parseError("Expecting a digit");
            }
            if (this.ch != "0") 
            {
                while (this.isDigit(this.ch)) 
                {
                    loc1 = loc1 + this.ch;
                    this.nextChar();
                }
            }
            else 
            {
                loc1 = loc1 + this.ch;
                this.nextChar();
                if (this.isDigit(this.ch)) 
                {
                    this.parseError("A digit cannot immediately follow 0");
                }
                else if (!this.strict && this.ch == "x") 
                {
                    loc1 = loc1 + this.ch;
                    this.nextChar();
                    if (this.isHexDigit(this.ch)) 
                    {
                        loc1 = loc1 + this.ch;
                        this.nextChar();
                    }
                    else 
                    {
                        this.parseError("Number in hex format require at least one hex digit after \"0x\"");
                    }
                    while (this.isHexDigit(this.ch)) 
                    {
                        loc1 = loc1 + this.ch;
                        this.nextChar();
                    }
                }
            }
            if (this.ch == ".") 
            {
                loc1 = loc1 + ".";
                this.nextChar();
                if (!this.isDigit(this.ch)) 
                {
                    this.parseError("Expecting a digit");
                }
                while (this.isDigit(this.ch)) 
                {
                    loc1 = loc1 + this.ch;
                    this.nextChar();
                }
            }
            if (this.ch == "e" || this.ch == "E") 
            {
                loc1 = loc1 + "e";
                this.nextChar();
                if (this.ch == "+" || this.ch == "-") 
                {
                    loc1 = loc1 + this.ch;
                    this.nextChar();
                }
                if (!this.isDigit(this.ch)) 
                {
                    this.parseError("Scientific notation number needs exponent value");
                }
                while (this.isDigit(this.ch)) 
                {
                    loc1 = loc1 + this.ch;
                    this.nextChar();
                }
            }
            var loc2:*=Number(loc1);
            if (isFinite(loc2) && !isNaN(loc2)) 
            {
                loc3 = new com.adobe.serialization.json.JSONToken();
                loc3.type = com.adobe.serialization.json.JSONTokenType.NUMBER;
                loc3.value = loc2;
                return loc3;
            }
            this.parseError("Number " + loc2 + " is not valid!");
            return null;
        }

        public function unescapeString(arg1:String):String
        {
            var loc5:*=undefined;
            var loc6:*=undefined;
            var loc7:*=undefined;
            var loc8:*=undefined;
            var loc9:*=undefined;
            if (this.strict && this.controlCharsRegExp.test(arg1)) 
            {
                this.parseError("String contains unescaped control character (0x00-0x1F)");
            }
            var loc1:*="";
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=arg1.length;
            do 
            {
                loc2 = arg1.indexOf("\\", loc3);
                if (loc2 >= 0) 
                {
                    loc1 = loc1 + arg1.substr(loc3, loc2 - loc3);
                    loc3 = loc2 + 2;
                    loc5 = loc2 + 1;
                    loc6 = arg1.charAt(loc5);
                    var loc10:*=loc6;
                    switch (loc10) 
                    {
                        case "\"":
                        {
                            loc1 = loc1 + "\"";
                            break;
                        }
                        case "\\":
                        {
                            loc1 = loc1 + "\\";
                            break;
                        }
                        case "n":
                        {
                            loc1 = loc1 + "\n";
                            break;
                        }
                        case "r":
                        {
                            loc1 = loc1 + "\r";
                            break;
                        }
                        case "t":
                        {
                            loc1 = loc1 + "\t";
                            break;
                        }
                        case "u":
                        {
                            loc7 = "";
                            if (loc3 + 4 > loc4) 
                            {
                                this.parseError("Unexpected end of input.  Expecting 4 hex digits after \\u.");
                            }
                            loc8 = loc3;
                            while (loc8 < loc3 + 4) 
                            {
                                loc9 = arg1.charAt(loc8);
                                if (!this.isHexDigit(loc9)) 
                                {
                                    this.parseError("Excepted a hex digit, but found: " + loc9);
                                }
                                loc7 = loc7 + loc9;
                                ++loc8;
                            }
                            loc1 = loc1 + String.fromCharCode(parseInt(loc7, 16));
                            loc3 = loc3 + 4;
                            break;
                        }
                        case "f":
                        {
                            loc1 = loc1 + "";
                            break;
                        }
                        case "/":
                        {
                            loc1 = loc1 + "/";
                            break;
                        }
                        case "b":
                        {
                            loc1 = loc1 + "";
                            break;
                        }
                        default:
                        {
                            loc1 = loc1 + ("\\" + loc6);
                        }
                    }
                }
                else 
                {
                    loc1 = loc1 + arg1.substr(loc3);
                    break;
                }
            }
            while (loc3 < loc4);
            return loc1;
        }

        internal function skipWhite():void
        {
            while (this.isWhiteSpace(this.ch)) 
            {
                this.nextChar();
            }
            return;
        }

        internal function isWhiteSpace(arg1:String):Boolean
        {
            if (arg1 == " " || arg1 == "\t" || arg1 == "\n" || arg1 == "\r") 
            {
                return true;
            }
            if (!this.strict && arg1.charCodeAt(0) == 160) 
            {
                return true;
            }
            return false;
        }

        public function parseError(arg1:String):void
        {
            throw new com.adobe.serialization.json.JSONParseError(arg1, this.loc, this.jsonString);
        }

        internal function readString():com.adobe.serialization.json.JSONToken
        {
            var loc3:*=undefined;
            var loc4:*=undefined;
            var loc1:*=this.loc;
            do 
            {
                loc1 = this.jsonString.indexOf("\"", loc1);
                if (loc1 >= 0) 
                {
                    loc3 = 0;
                    --loc4;
                    while (this.jsonString.charAt(loc4) == "\\") 
                    {
                        ++loc3;
                        --loc4;
                    }
                    if (loc3 % 2 == 0) 
                    {
                        break;
                    }
                    ++loc1;
                }
                else 
                {
                    this.parseError("Unterminated string literal");
                }
            }
            while (true);
            var loc2:*=new com.adobe.serialization.json.JSONToken();
            loc2.type = com.adobe.serialization.json.JSONTokenType.STRING;
            loc2.value = this.unescapeString(this.jsonString.substr(this.loc, loc1 - this.loc));
            this.loc = loc1 + 1;
            this.nextChar();
            return loc2;
        }

        internal function nextChar():String
        {
            var loc1:*;
            var loc2:*=((loc1 = this).loc + 1);
            loc1.loc = loc2;
            this.ch = loc1 = this.jsonString.charAt((loc1 = this).loc);
            return loc1;
        }

        internal function skipIgnored():void
        {
            var loc1:*=0;
            do 
            {
                loc1 = this.loc;
                this.skipWhite();
                this.skipComments();
            }
            while (loc1 != this.loc);
            return;
        }

        internal function isHexDigit(arg1:String):Boolean
        {
            return this.isDigit(arg1) || arg1 >= "A" && arg1 <= "F" || arg1 >= "a" && arg1 <= "f";
        }

        public function getNextToken():com.adobe.serialization.json.JSONToken
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*=new com.adobe.serialization.json.JSONToken();
            this.skipIgnored();
            var loc6:*=this.ch;
            switch (loc6) 
            {
                case "{":
                {
                    loc1.type = com.adobe.serialization.json.JSONTokenType.LEFT_BRACE;
                    loc1.value = "{";
                    this.nextChar();
                    break;
                }
                case "}":
                {
                    loc1.type = com.adobe.serialization.json.JSONTokenType.RIGHT_BRACE;
                    loc1.value = "}";
                    this.nextChar();
                    break;
                }
                case "[":
                {
                    loc1.type = com.adobe.serialization.json.JSONTokenType.LEFT_BRACKET;
                    loc1.value = "[";
                    this.nextChar();
                    break;
                }
                case "]":
                {
                    loc1.type = com.adobe.serialization.json.JSONTokenType.RIGHT_BRACKET;
                    loc1.value = "]";
                    this.nextChar();
                    break;
                }
                case ",":
                {
                    loc1.type = com.adobe.serialization.json.JSONTokenType.COMMA;
                    loc1.value = ",";
                    this.nextChar();
                    break;
                }
                case ":":
                {
                    loc1.type = com.adobe.serialization.json.JSONTokenType.COLON;
                    loc1.value = ":";
                    this.nextChar();
                    break;
                }
                case "t":
                {
                    loc2 = "t" + this.nextChar() + this.nextChar() + this.nextChar();
                    if (loc2 != "true") 
                    {
                        this.parseError("Expecting \'true\' but found " + loc2);
                    }
                    else 
                    {
                        loc1.type = com.adobe.serialization.json.JSONTokenType.TRUE;
                        loc1.value = true;
                        this.nextChar();
                    }
                    break;
                }
                case "f":
                {
                    loc3 = "f" + this.nextChar() + this.nextChar() + this.nextChar() + this.nextChar();
                    if (loc3 != "false") 
                    {
                        this.parseError("Expecting \'false\' but found " + loc3);
                    }
                    else 
                    {
                        loc1.type = com.adobe.serialization.json.JSONTokenType.FALSE;
                        loc1.value = false;
                        this.nextChar();
                    }
                    break;
                }
                case "n":
                {
                    loc4 = "n" + this.nextChar() + this.nextChar() + this.nextChar();
                    if (loc4 != "null") 
                    {
                        this.parseError("Expecting \'null\' but found " + loc4);
                    }
                    else 
                    {
                        loc1.type = com.adobe.serialization.json.JSONTokenType.NULL;
                        loc1.value = null;
                        this.nextChar();
                    }
                    break;
                }
                case "N":
                {
                    loc5 = "N" + this.nextChar() + this.nextChar();
                    if (loc5 != "NaN") 
                    {
                        this.parseError("Expecting \'NaN\' but found " + loc5);
                    }
                    else 
                    {
                        loc1.type = com.adobe.serialization.json.JSONTokenType.NAN;
                        loc1.value = NaN;
                        this.nextChar();
                    }
                    break;
                }
                case "\"":
                {
                    loc1 = this.readString();
                    break;
                }
                default:
                {
                    if (this.isDigit(this.ch) || this.ch == "-") 
                    {
                        loc1 = this.readNumber();
                    }
                    else 
                    {
                        if (this.ch == "") 
                        {
                            return null;
                        }
                        this.parseError("Unexpected " + this.ch + " encountered");
                    }
                }
            }
            return loc1;
        }

        internal var ch:String;

        internal var loc:int;

        internal var jsonString:String;

        internal var strict:Boolean;

        internal var controlCharsRegExp:RegExp;

        internal var obj:Object;
    }
}


