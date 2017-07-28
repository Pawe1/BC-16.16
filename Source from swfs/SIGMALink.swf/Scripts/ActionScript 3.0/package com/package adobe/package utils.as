//package utils
//  class AGALMiniAssembler
package com.adobe.utils 
{
    import flash.display3D.*;
    import flash.utils.*;
    
    public class AGALMiniAssembler extends Object
    {
        public function AGALMiniAssembler(arg1:Boolean=false)
        {
            super();
            this.debugEnabled = arg1;
            if (!initialized) 
            {
                init();
            }
            return;
        }

        public function assemble(arg1:String, arg2:String, arg3:uint=1, arg4:Boolean=false):flash.utils.ByteArray
        {
            var loc6:*=0;
            var loc8:*=null;
            var loc9:*=0;
            var loc10:*=0;
            var loc11:*=null;
            var loc12:*=null;
            var loc13:*=null;
            var loc14:*=null;
            var loc15:*=false;
            var loc16:*=0;
            var loc17:*=0;
            var loc18:*=0;
            var loc19:*=false;
            var loc20:*=null;
            var loc21:*=null;
            var loc22:*=null;
            var loc23:*=null;
            var loc24:*=0;
            var loc25:*=0;
            var loc26:*=null;
            var loc27:*=false;
            var loc28:*=false;
            var loc29:*=0;
            var loc30:*=0;
            var loc31:*=0;
            var loc32:*=0;
            var loc33:*=0;
            var loc34:*=0;
            var loc35:*=null;
            var loc36:*=null;
            var loc37:*=null;
            var loc38:*=null;
            var loc39:*=0;
            var loc40:*=0;
            var loc41:*=NaN;
            var loc42:*=null;
            var loc43:*=null;
            var loc44:*=0;
            var loc45:*=0;
            var loc46:*=null;
            var loc1:*=flash.utils.getTimer();
            this._agalcode = new flash.utils.ByteArray();
            this._error = "";
            var loc2:*=false;
            if (arg1 != FRAGMENT) 
            {
                if (arg1 != VERTEX) 
                {
                    this._error = "ERROR: mode needs to be \"" + FRAGMENT + "\" or \"" + VERTEX + "\" but is \"" + arg1 + "\".";
                }
            }
            else 
            {
                loc2 = true;
            }
            this.agalcode.endian = flash.utils.Endian.LITTLE_ENDIAN;
            this.agalcode.writeByte(160);
            this.agalcode.writeUnsignedInt(arg3);
            this.agalcode.writeByte(161);
            this.agalcode.writeByte(loc2 ? 1 : 0);
            this.initregmap(arg3, arg4);
            var loc3:*=arg2.replace(new RegExp("[\\f\\n\\r\\v]+", "g"), "\n").split("\n");
            var loc4:*=0;
            var loc5:*=0;
            var loc7:*=loc3.length;
            loc6 = 0;
            while (loc6 < loc7 && this._error == "") 
            {
                loc8 = new String(loc3[loc6]);
                loc8 = loc8.replace(REGEXP_OUTER_SPACES, "");
                loc9 = loc8.search("//");
                if (loc9 != -1) 
                {
                    loc8 = loc8.slice(0, loc9);
                }
                loc10 = loc8.search(new RegExp("<.*>", "g"));
                if (loc10 != -1) 
                {
                    loc11 = loc8.slice(loc10).match(new RegExp("([\\w\\.\\-\\+]+)", "gi"));
                    loc8 = loc8.slice(0, loc10);
                }
                loc12 = loc8.match(new RegExp("^\\w{3}", "ig"));
                if (loc12) 
                {
                    loc13 = OPMAP[loc12[0]];
                    if (this.debugEnabled) 
                    {
                        trace(loc13);
                    }
                    if (loc13 != null) 
                    {
                        loc8 = loc8.slice(loc8.search(loc13.name) + loc13.name.length);
                        if (loc13.flags & OP_VERSION2 && arg3 < 2) 
                        {
                            this._error = "error: opcode requires version 2.";
                            break;
                        }
                        if (loc13.flags & OP_VERT_ONLY && loc2) 
                        {
                            this._error = "error: opcode is only allowed in vertex programs.";
                            break;
                        }
                        if (loc13.flags & OP_FRAG_ONLY && !loc2) 
                        {
                            this._error = "error: opcode is only allowed in fragment programs.";
                            break;
                        }
                        if (this.verbose) 
                        {
                            trace("emit opcode=" + loc13);
                        }
                        this.agalcode.writeUnsignedInt(loc13.emitCode);
                        ++loc5;
                        if (loc5 > MAX_OPCODES) 
                        {
                            this._error = "error: too many opcodes. maximum is " + MAX_OPCODES + ".";
                            break;
                        }
                        loc14 = loc8.match(new RegExp("vc\\[([vof][acostdip]?)(\\d*)?(\\.[xyzw](\\+\\d{1,3})?)?\\](\\.[xyzw]{1,4})?|([vof][acostdip]?)(\\d*)?(\\.[xyzw]{1,4})?", "gi"));
                        if (!loc14 || !(loc14.length == loc13.numRegister)) 
                        {
                            this._error = "error: wrong number of operands. found " + loc14.length + " but expected " + loc13.numRegister + ".";
                            break;
                        }
                        loc15 = false;
                        loc16 = 64 + 64 + 32;
                        loc17 = loc14.length;
                        loc18 = 0;
                        while (loc18 < loc17) 
                        {
                            loc19 = false;
                            loc20 = loc14[loc18].match(new RegExp("\\[.*\\]", "ig"));
                            if (loc20 && loc20.length > 0) 
                            {
                                loc14[loc18] = loc14[loc18].replace(loc20[0], "0");
                                if (this.verbose) 
                                {
                                    trace("IS REL");
                                }
                                loc19 = true;
                            }
                            loc21 = loc14[loc18].match(new RegExp("^\\b[A-Za-z]{1,2}", "ig"));
                            if (!loc21) 
                            {
                                this._error = "error: could not parse operand " + loc18 + " (" + loc14[loc18] + ").";
                                loc15 = true;
                                break;
                            }
                            loc22 = REGMAP[loc21[0]];
                            if (this.debugEnabled) 
                            {
                                trace(loc22);
                            }
                            if (loc22 == null) 
                            {
                                this._error = "error: could not find register name for operand " + loc18 + " (" + loc14[loc18] + ").";
                                loc15 = true;
                                break;
                            }
                            if (loc2) 
                            {
                                if (!(loc22.flags & REG_FRAG)) 
                                {
                                    this._error = "error: register operand " + loc18 + " (" + loc14[loc18] + ") only allowed in vertex programs.";
                                    loc15 = true;
                                    break;
                                }
                                if (loc19) 
                                {
                                    this._error = "error: register operand " + loc18 + " (" + loc14[loc18] + ") relative adressing not allowed in fragment programs.";
                                    loc15 = true;
                                    break;
                                }
                            }
                            else if (!(loc22.flags & REG_VERT)) 
                            {
                                this._error = "error: register operand " + loc18 + " (" + loc14[loc18] + ") only allowed in fragment programs.";
                                loc15 = true;
                                break;
                            }
                            loc14[loc18] = loc14[loc18].slice(loc14[loc18].search(loc22.name) + loc22.name.length);
                            loc23 = loc19 ? loc20[0].match(new RegExp("\\d+")) : loc14[loc18].match(new RegExp("\\d+"));
                            loc24 = 0;
                            if (loc23) 
                            {
                                loc24 = uint(loc23[0]);
                            }
                            if (loc22.range < loc24) 
                            {
                                this._error = "error: register operand " + loc18 + " (" + loc14[loc18] + ") index exceeds limit of " + (loc22.range + 1) + ".";
                                loc15 = true;
                                break;
                            }
                            loc25 = 0;
                            loc26 = loc14[loc18].match(new RegExp("(\\.[xyzw]{1,4})"));
                            loc27 = loc18 == 0 && !(loc13.flags & OP_NO_DEST);
                            loc28 = loc18 == 2 && loc13.flags & OP_SPECIAL_TEX;
                            loc29 = 0;
                            loc30 = 0;
                            loc31 = 0;
                            if (loc27 && loc19) 
                            {
                                this._error = "error: relative can not be destination";
                                loc15 = true;
                                break;
                            }
                            if (loc26) 
                            {
                                loc25 = 0;
                                loc33 = loc26[0].length;
                                loc34 = 1;
                                while (loc34 < loc33) 
                                {
                                    loc32 = loc26[0].charCodeAt(loc34) - "x".charCodeAt(0);
                                    if (loc32 > 2) 
                                    {
                                        loc32 = 3;
                                    }
                                    if (loc27) 
                                    {
                                        loc25 = loc25 | 1 << loc32;
                                    }
                                    else 
                                    {
                                        loc25 = loc25 | loc32 << (loc34 - 1) << 1;
                                    }
                                    ++loc34;
                                }
                                if (!loc27) 
                                {
                                    while (loc34 <= 4) 
                                    {
                                        loc25 = loc25 | loc32 << (loc34 - 1) << 1;
                                        ++loc34;
                                    }
                                }
                            }
                            else 
                            {
                                loc25 = loc27 ? 15 : 228;
                            }
                            if (loc19) 
                            {
                                loc35 = loc20[0].match(new RegExp("[A-Za-z]{1,2}", "ig"));
                                loc36 = REGMAP[loc35[0]];
                                if (loc36 == null) 
                                {
                                    this._error = "error: bad index register";
                                    loc15 = true;
                                    break;
                                }
                                loc29 = loc36.emitCode;
                                loc37 = loc20[0].match(new RegExp("(\\.[xyzw]{1,1})"));
                                if (loc37.length == 0) 
                                {
                                    this._error = "error: bad index register select";
                                    loc15 = true;
                                    break;
                                }
                                loc30 = loc37[0].charCodeAt(1) - "x".charCodeAt(0);
                                if (loc30 > 2) 
                                {
                                    loc30 = 3;
                                }
                                loc38 = loc20[0].match(new RegExp("\\+\\d{1,3}", "ig"));
                                if (loc38.length > 0) 
                                {
                                    loc31 = loc38[0];
                                }
                                if (loc31 < 0 || loc31 > 255) 
                                {
                                    this._error = "error: index offset " + loc31 + " out of bounds. [0..255]";
                                    loc15 = true;
                                    break;
                                }
                                if (this.verbose) 
                                {
                                    trace("RELATIVE: type=" + loc29 + "==" + loc35[0] + " sel=" + loc30 + "==" + loc37[0] + " idx=" + loc24 + " offset=" + loc31);
                                }
                            }
                            if (this.verbose) 
                            {
                                trace("  emit argcode=" + loc22 + "[" + loc24 + "][" + loc25 + "]");
                            }
                            if (loc27) 
                            {
                                this.agalcode.writeShort(loc24);
                                this.agalcode.writeByte(loc25);
                                this.agalcode.writeByte(loc22.emitCode);
                                loc16 = loc16 - 32;
                            }
                            else if (loc28) 
                            {
                                if (this.verbose) 
                                {
                                    trace("  emit sampler");
                                }
                                loc39 = 5;
                                loc40 = loc11 != null ? loc11.length : 0;
                                loc41 = 0;
                                loc34 = 0;
                                while (loc34 < loc40) 
                                {
                                    if (this.verbose) 
                                    {
                                        trace("    opt: " + loc11[loc34]);
                                    }
                                    loc42 = SAMPLEMAP[loc11[loc34]];
                                    if (loc42 != null) 
                                    {
                                        if (loc42.flag != SAMPLER_SPECIAL_SHIFT) 
                                        {
                                            loc39 = loc39 & ~(15 << loc42.flag);
                                        }
                                        loc39 = loc39 | uint(loc42.mask) << uint(loc42.flag);
                                    }
                                    else 
                                    {
                                        loc41 = Number(loc11[loc34]);
                                        if (this.verbose) 
                                        {
                                            trace("    bias: " + loc41);
                                        }
                                    }
                                    ++loc34;
                                }
                                this.agalcode.writeShort(loc24);
                                this.agalcode.writeByte(int(loc41 * 8));
                                this.agalcode.writeByte(0);
                                this.agalcode.writeUnsignedInt(loc39);
                                if (this.verbose) 
                                {
                                    trace("    bits: " + (loc39 - 5));
                                }
                                loc16 = loc16 - 64;
                            }
                            else 
                            {
                                if (loc18 == 0) 
                                {
                                    this.agalcode.writeUnsignedInt(0);
                                    loc16 = loc16 - 32;
                                }
                                this.agalcode.writeShort(loc24);
                                this.agalcode.writeByte(loc31);
                                this.agalcode.writeByte(loc25);
                                this.agalcode.writeByte(loc22.emitCode);
                                this.agalcode.writeByte(loc29);
                                this.agalcode.writeShort(loc19 ? loc30 | 1 << 15 : 0);
                                loc16 = loc16 - 64;
                            }
                            ++loc18;
                        }
                        loc18 = 0;
                        while (loc18 < loc16) 
                        {
                            this.agalcode.writeByte(0);
                            loc18 = loc18 + 8;
                        }
                        if (loc15) 
                        {
                            break;
                        }
                    }
                    else if (loc8.length >= 3) 
                    {
                        trace("warning: bad line " + loc6 + ": " + loc3[loc6]);
                    }
                }
                else if (loc8.length >= 3) 
                {
                    trace("warning: bad line " + loc6 + ": " + loc3[loc6]);
                }
                ++loc6;
            }
            if (this._error != "") 
            {
                this._error = this._error + ("\n  at line " + loc6 + " " + loc3[loc6]);
                this.agalcode.length = 0;
                trace(this._error);
            }
            if (this.debugEnabled) 
            {
                loc43 = "generated bytecode:";
                loc44 = this.agalcode.length;
                loc45 = 0;
                while (loc45 < loc44) 
                {
                    if (!(loc45 % 16)) 
                    {
                        loc43 = loc43 + "\n";
                    }
                    if (!(loc45 % 4)) 
                    {
                        loc43 = loc43 + " ";
                    }
                    loc46 = this.agalcode[loc45].toString(16);
                    if (loc46.length < 2) 
                    {
                        loc46 = "0" + loc46;
                    }
                    loc43 = loc43 + loc46;
                    ++loc45;
                }
                trace(loc43);
            }
            if (this.verbose) 
            {
                trace("AGALMiniAssembler.assemble time: " + (flash.utils.getTimer() - loc1) / 1000 + "s");
            }
            return this.agalcode;
        }

        internal function initregmap(arg1:uint, arg2:Boolean):void
        {
            REGMAP[VA] = new Register(VA, "vertex attribute", 0, arg2 ? 1024 : arg1 == 1 || arg1 == 2 ? 7 : 15, REG_VERT | REG_READ);
            REGMAP[VC] = new Register(VC, "vertex constant", 1, arg2 ? 1024 : arg1 != 1 ? 249 : 127, REG_VERT | REG_READ);
            REGMAP[VT] = new Register(VT, "vertex temporary", 2, arg2 ? 1024 : arg1 != 1 ? 25 : 7, REG_VERT | REG_WRITE | REG_READ);
            REGMAP[VO] = new Register(VO, "vertex output", 3, arg2 ? 1024 : 0, REG_VERT | REG_WRITE);
            REGMAP[VI] = new Register(VI, "varying", 4, arg2 ? 1024 : arg1 != 1 ? 9 : 7, REG_VERT | REG_FRAG | REG_READ | REG_WRITE);
            REGMAP[FC] = new Register(FC, "fragment constant", 1, arg2 ? 1024 : arg1 != 1 ? arg1 != 2 ? 199 : 63 : 27, REG_FRAG | REG_READ);
            REGMAP[FT] = new Register(FT, "fragment temporary", 2, arg2 ? 1024 : arg1 != 1 ? 25 : 7, REG_FRAG | REG_WRITE | REG_READ);
            REGMAP[FS] = new Register(FS, "texture sampler", 5, arg2 ? 1024 : 7, REG_FRAG | REG_READ);
            REGMAP[FO] = new Register(FO, "fragment output", 3, arg2 ? 1024 : arg1 != 1 ? 3 : 0, REG_FRAG | REG_WRITE);
            REGMAP[FD] = new Register(FD, "fragment depth output", 6, arg2 ? 1024 : arg1 != 1 ? 0 : -1, REG_FRAG | REG_WRITE);
            REGMAP["op"] = REGMAP[VO];
            REGMAP["i"] = REGMAP[VI];
            REGMAP["v"] = REGMAP[VI];
            REGMAP["oc"] = REGMAP[FO];
            REGMAP["od"] = REGMAP[FD];
            REGMAP["fi"] = REGMAP[VI];
            return;
        }

        internal static function init():void
        {
            initialized = true;
            OPMAP[MOV] = new OpCode(MOV, 2, 0, 0);
            OPMAP[ADD] = new OpCode(ADD, 3, 1, 0);
            OPMAP[SUB] = new OpCode(SUB, 3, 2, 0);
            OPMAP[MUL] = new OpCode(MUL, 3, 3, 0);
            OPMAP[DIV] = new OpCode(DIV, 3, 4, 0);
            OPMAP[RCP] = new OpCode(RCP, 2, 5, 0);
            OPMAP[MIN] = new OpCode(MIN, 3, 6, 0);
            OPMAP[MAX] = new OpCode(MAX, 3, 7, 0);
            OPMAP[FRC] = new OpCode(FRC, 2, 8, 0);
            OPMAP[SQT] = new OpCode(SQT, 2, 9, 0);
            OPMAP[RSQ] = new OpCode(RSQ, 2, 10, 0);
            OPMAP[POW] = new OpCode(POW, 3, 11, 0);
            OPMAP[LOG] = new OpCode(LOG, 2, 12, 0);
            OPMAP[EXP] = new OpCode(EXP, 2, 13, 0);
            OPMAP[NRM] = new OpCode(NRM, 2, 14, 0);
            OPMAP[SIN] = new OpCode(SIN, 2, 15, 0);
            OPMAP[COS] = new OpCode(COS, 2, 16, 0);
            OPMAP[CRS] = new OpCode(CRS, 3, 17, 0);
            OPMAP[DP3] = new OpCode(DP3, 3, 18, 0);
            OPMAP[DP4] = new OpCode(DP4, 3, 19, 0);
            OPMAP[ABS] = new OpCode(ABS, 2, 20, 0);
            OPMAP[NEG] = new OpCode(NEG, 2, 21, 0);
            OPMAP[SAT] = new OpCode(SAT, 2, 22, 0);
            OPMAP[M33] = new OpCode(M33, 3, 23, OP_SPECIAL_MATRIX);
            OPMAP[M44] = new OpCode(M44, 3, 24, OP_SPECIAL_MATRIX);
            OPMAP[M34] = new OpCode(M34, 3, 25, OP_SPECIAL_MATRIX);
            OPMAP[DDX] = new OpCode(DDX, 2, 26, OP_VERSION2 | OP_FRAG_ONLY);
            OPMAP[DDY] = new OpCode(DDY, 2, 27, OP_VERSION2 | OP_FRAG_ONLY);
            OPMAP[IFE] = new OpCode(IFE, 2, 28, OP_NO_DEST | OP_VERSION2 | OP_INCNEST | OP_SCALAR);
            OPMAP[INE] = new OpCode(INE, 2, 29, OP_NO_DEST | OP_VERSION2 | OP_INCNEST | OP_SCALAR);
            OPMAP[IFG] = new OpCode(IFG, 2, 30, OP_NO_DEST | OP_VERSION2 | OP_INCNEST | OP_SCALAR);
            OPMAP[IFL] = new OpCode(IFL, 2, 31, OP_NO_DEST | OP_VERSION2 | OP_INCNEST | OP_SCALAR);
            OPMAP[ELS] = new OpCode(ELS, 0, 32, OP_NO_DEST | OP_VERSION2 | OP_INCNEST | OP_DECNEST | OP_SCALAR);
            OPMAP[EIF] = new OpCode(EIF, 0, 33, OP_NO_DEST | OP_VERSION2 | OP_DECNEST | OP_SCALAR);
            OPMAP[KIL] = new OpCode(KIL, 1, 39, OP_NO_DEST | OP_FRAG_ONLY);
            OPMAP[TEX] = new OpCode(TEX, 3, 40, OP_FRAG_ONLY | OP_SPECIAL_TEX);
            OPMAP[SGE] = new OpCode(SGE, 3, 41, 0);
            OPMAP[SLT] = new OpCode(SLT, 3, 42, 0);
            OPMAP[SGN] = new OpCode(SGN, 2, 43, 0);
            OPMAP[SEQ] = new OpCode(SEQ, 3, 44, 0);
            OPMAP[SNE] = new OpCode(SNE, 3, 45, 0);
            SAMPLEMAP[RGBA] = new Sampler(RGBA, SAMPLER_TYPE_SHIFT, 0);
            SAMPLEMAP[DXT1] = new Sampler(DXT1, SAMPLER_TYPE_SHIFT, 1);
            SAMPLEMAP[DXT5] = new Sampler(DXT5, SAMPLER_TYPE_SHIFT, 2);
            SAMPLEMAP[VIDEO] = new Sampler(VIDEO, SAMPLER_TYPE_SHIFT, 3);
            SAMPLEMAP[D2] = new Sampler(D2, SAMPLER_DIM_SHIFT, 0);
            SAMPLEMAP[D3] = new Sampler(D3, SAMPLER_DIM_SHIFT, 2);
            SAMPLEMAP[CUBE] = new Sampler(CUBE, SAMPLER_DIM_SHIFT, 1);
            SAMPLEMAP[MIPNEAREST] = new Sampler(MIPNEAREST, SAMPLER_MIPMAP_SHIFT, 1);
            SAMPLEMAP[MIPLINEAR] = new Sampler(MIPLINEAR, SAMPLER_MIPMAP_SHIFT, 2);
            SAMPLEMAP[MIPNONE] = new Sampler(MIPNONE, SAMPLER_MIPMAP_SHIFT, 0);
            SAMPLEMAP[NOMIP] = new Sampler(NOMIP, SAMPLER_MIPMAP_SHIFT, 0);
            SAMPLEMAP[NEAREST] = new Sampler(NEAREST, SAMPLER_FILTER_SHIFT, 0);
            SAMPLEMAP[LINEAR] = new Sampler(LINEAR, SAMPLER_FILTER_SHIFT, 1);
            SAMPLEMAP[ANISOTROPIC2X] = new Sampler(ANISOTROPIC2X, SAMPLER_FILTER_SHIFT, 2);
            SAMPLEMAP[ANISOTROPIC4X] = new Sampler(ANISOTROPIC4X, SAMPLER_FILTER_SHIFT, 3);
            SAMPLEMAP[ANISOTROPIC8X] = new Sampler(ANISOTROPIC8X, SAMPLER_FILTER_SHIFT, 4);
            SAMPLEMAP[ANISOTROPIC16X] = new Sampler(ANISOTROPIC16X, SAMPLER_FILTER_SHIFT, 5);
            SAMPLEMAP[CENTROID] = new Sampler(CENTROID, SAMPLER_SPECIAL_SHIFT, 1 << 0);
            SAMPLEMAP[SINGLE] = new Sampler(SINGLE, SAMPLER_SPECIAL_SHIFT, 1 << 1);
            SAMPLEMAP[IGNORESAMPLER] = new Sampler(IGNORESAMPLER, SAMPLER_SPECIAL_SHIFT, 1 << 2);
            SAMPLEMAP[REPEAT] = new Sampler(REPEAT, SAMPLER_REPEAT_SHIFT, 1);
            SAMPLEMAP[WRAP] = new Sampler(WRAP, SAMPLER_REPEAT_SHIFT, 1);
            SAMPLEMAP[CLAMP] = new Sampler(CLAMP, SAMPLER_REPEAT_SHIFT, 0);
            SAMPLEMAP[CLAMP_U_REPEAT_V] = new Sampler(CLAMP_U_REPEAT_V, SAMPLER_REPEAT_SHIFT, 2);
            SAMPLEMAP[REPEAT_U_CLAMP_V] = new Sampler(REPEAT_U_CLAMP_V, SAMPLER_REPEAT_SHIFT, 3);
            return;
        }

        
        {
            initialized = false;
        }

        public function get error():String
        {
            return this._error;
        }

        public function get agalcode():flash.utils.ByteArray
        {
            return this._agalcode;
        }

        public function assemble2(arg1:flash.display3D.Context3D, arg2:uint, arg3:String, arg4:String):flash.display3D.Program3D
        {
            var loc1:*=this.assemble(VERTEX, arg3, arg2);
            var loc2:*=this.assemble(FRAGMENT, arg4, arg2);
            var loc3:*=arg1.createProgram();
            loc3.upload(loc1, loc2);
            return loc3;
        }

        internal static const DXT1:String="dxt1";

        internal static const DXT5:String="dxt5";

        internal static const VIDEO:String="video";

        internal static const ANISOTROPIC8X:String="anisotropic8x";

        protected static const REGEXP_OUTER_SPACES:RegExp=new RegExp("^\\s+|\\s+$", "g");

        internal static const OPMAP:flash.utils.Dictionary=new flash.utils.Dictionary();

        internal static const REGMAP:flash.utils.Dictionary=new flash.utils.Dictionary();

        internal static const SAMPLEMAP:flash.utils.Dictionary=new flash.utils.Dictionary();

        internal static const MAX_NESTING:int=4;

        internal static const MAX_OPCODES:int=2048;

        internal static const FRAGMENT:String="fragment";

        internal static const VERTEX:String="vertex";

        internal static const SAMPLER_TYPE_SHIFT:uint=8;

        internal static const SAMPLER_DIM_SHIFT:uint=12;

        internal static const SAMPLER_SPECIAL_SHIFT:uint=16;

        internal static const SAMPLER_REPEAT_SHIFT:uint=20;

        internal static const SAMPLER_MIPMAP_SHIFT:uint=24;

        internal static const SAMPLER_FILTER_SHIFT:uint=28;

        internal static const REG_WRITE:uint=1;

        internal static const REG_READ:uint=2;

        internal static const REG_FRAG:uint=32;

        internal static const REG_VERT:uint=64;

        internal static const OP_SCALAR:uint=1;

        internal static const OP_SPECIAL_TEX:uint=8;

        internal static const OP_SPECIAL_MATRIX:uint=16;

        internal static const OP_FRAG_ONLY:uint=32;

        internal static const OP_VERT_ONLY:uint=64;

        internal static const OP_NO_DEST:uint=128;

        internal static const OP_VERSION2:uint=256;

        internal static const OP_INCNEST:uint=512;

        internal static const OP_DECNEST:uint=1024;

        internal static const MOV:String="mov";

        internal static const ADD:String="add";

        internal static const SUB:String="sub";

        internal static const MUL:String="mul";

        internal static const DIV:String="div";

        internal static const RCP:String="rcp";

        internal static const MIN:String="min";

        internal static const MAX:String="max";

        internal static const FRC:String="frc";

        internal static const SQT:String="sqt";

        internal static const RSQ:String="rsq";

        internal static const POW:String="pow";

        internal static const LOG:String="log";

        internal static const EXP:String="exp";

        internal static const NRM:String="nrm";

        internal static const SIN:String="sin";

        internal static const COS:String="cos";

        internal static const CRS:String="crs";

        internal static const DP3:String="dp3";

        internal static const DP4:String="dp4";

        internal static const ABS:String="abs";

        internal static const NEG:String="neg";

        internal static const SAT:String="sat";

        internal static const M33:String="m33";

        internal static const M44:String="m44";

        internal static const M34:String="m34";

        internal static const DDX:String="ddx";

        internal static const DDY:String="ddy";

        internal static const IFE:String="ife";

        internal static const INE:String="ine";

        internal static const IFG:String="ifg";

        internal static const IFL:String="ifl";

        internal static const ELS:String="els";

        internal static const EIF:String="eif";

        internal static const TED:String="ted";

        internal static const KIL:String="kil";

        internal static const TEX:String="tex";

        internal static const SGE:String="sge";

        internal static const SLT:String="slt";

        internal static const SGN:String="sgn";

        internal static const SEQ:String="seq";

        internal static const SNE:String="sne";

        internal static const VA:String="va";

        internal static const VC:String="vc";

        internal static const VT:String="vt";

        internal static const VO:String="vo";

        internal static const VI:String="vi";

        internal static const FC:String="fc";

        internal static const FT:String="ft";

        internal static const FO:String="fo";

        internal static const FD:String="fd";

        internal static const D2:String="2d";

        internal static const D3:String="3d";

        internal static const CUBE:String="cube";

        internal static const MIPNEAREST:String="mipnearest";

        internal static const MIPLINEAR:String="miplinear";

        internal static const MIPNONE:String="mipnone";

        internal static const NOMIP:String="nomip";

        internal static const NEAREST:String="nearest";

        internal static const LINEAR:String="linear";

        internal static const ANISOTROPIC2X:String="anisotropic2x";

        internal static const ANISOTROPIC4X:String="anisotropic4x";

        internal static const FS:String="fs";

        internal static const ANISOTROPIC16X:String="anisotropic16x";

        internal static const CENTROID:String="centroid";

        internal static const SINGLE:String="single";

        internal static const IGNORESAMPLER:String="ignoresampler";

        internal static const REPEAT:String="repeat";

        internal static const WRAP:String="wrap";

        internal static const CLAMP:String="clamp";

        internal static const REPEAT_U_CLAMP_V:String="repeat_u_clamp_v";

        internal static const CLAMP_U_REPEAT_V:String="clamp_u_repeat_v";

        internal static const RGBA:String="rgba";

        internal var _agalcode:flash.utils.ByteArray=null;

        internal var _error:String="";

        internal var debugEnabled:Boolean=false;

        public var verbose:Boolean=false;

        internal static var initialized:Boolean=false;
    }
}


class OpCode extends Object
{
    public function OpCode(arg1:String, arg2:uint, arg3:uint, arg4:uint)
    {
        super();
        this._name = arg1;
        this._numRegister = arg2;
        this._emitCode = arg3;
        this._flags = arg4;
        return;
    }

    public function get emitCode():uint
    {
        return this._emitCode;
    }

    public function get flags():uint
    {
        return this._flags;
    }

    public function get name():String
    {
        return this._name;
    }

    public function get numRegister():uint
    {
        return this._numRegister;
    }

    public function toString():String
    {
        return "[OpCode name=\"" + this._name + "\", numRegister=" + this._numRegister + ", emitCode=" + this._emitCode + ", flags=" + this._flags + "]";
    }

    internal var _emitCode:uint;

    internal var _flags:uint;

    internal var _name:String;

    internal var _numRegister:uint;
}

class Register extends Object
{
    public function Register(arg1:String, arg2:String, arg3:uint, arg4:uint, arg5:uint)
    {
        super();
        this._name = arg1;
        this._longName = arg2;
        this._emitCode = arg3;
        this._range = arg4;
        this._flags = arg5;
        return;
    }

    public function get emitCode():uint
    {
        return this._emitCode;
    }

    public function get longName():String
    {
        return this._longName;
    }

    public function get name():String
    {
        return this._name;
    }

    public function get flags():uint
    {
        return this._flags;
    }

    public function get range():uint
    {
        return this._range;
    }

    public function toString():String
    {
        return "[Register name=\"" + this._name + "\", longName=\"" + this._longName + "\", emitCode=" + this._emitCode + ", range=" + this._range + ", flags=" + this._flags + "]";
    }

    internal var _emitCode:uint;

    internal var _name:String;

    internal var _longName:String;

    internal var _flags:uint;

    internal var _range:uint;
}

class Sampler extends Object
{
    public function Sampler(arg1:String, arg2:uint, arg3:uint)
    {
        super();
        this._name = arg1;
        this._flag = arg2;
        this._mask = arg3;
        return;
    }

    public function get flag():uint
    {
        return this._flag;
    }

    public function get mask():uint
    {
        return this._mask;
    }

    public function get name():String
    {
        return this._name;
    }

    public function toString():String
    {
        return "[Sampler name=\"" + this._name + "\", flag=\"" + this._flag + "\", mask=" + this.mask + "]";
    }

    internal var _flag:uint;

    internal var _mask:uint;

    internal var _name:String;
}

//  class StringUtil
package com.adobe.utils 
{
    public class StringUtil extends Object
    {
        public function StringUtil()
        {
            super();
            return;
        }

        public static function stringsAreEqual(arg1:String, arg2:String, arg3:Boolean):Boolean
        {
            if (arg3) 
            {
                return arg1 == arg2;
            }
            return arg1.toUpperCase() == arg2.toUpperCase();
        }

        public static function trim(arg1:String):String
        {
            return StringUtil.ltrim(StringUtil.rtrim(arg1));
        }

        public static function ltrim(arg1:String):String
        {
            var loc2:*=NaN;
            var loc1:*=arg1.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                if (arg1.charCodeAt(loc2) > 32) 
                {
                    return arg1.substring(loc2);
                }
                ++loc2;
            }
            return "";
        }

        public static function rtrim(arg1:String):String
        {
            var loc2:*=NaN;
            var loc1:*=arg1.length;
            loc2 = loc1;
            while (loc2 > 0) 
            {
                if (arg1.charCodeAt((loc2 - 1)) > 32) 
                {
                    return arg1.substring(0, loc2);
                }
                --loc2;
            }
            return "";
        }

        public static function beginsWith(arg1:String, arg2:String):Boolean
        {
            return arg2 == arg1.substring(0, arg2.length);
        }

        public static function endsWith(arg1:String, arg2:String):Boolean
        {
            return arg2 == arg1.substring(arg1.length - arg2.length);
        }

        public static function remove(arg1:String, arg2:String):String
        {
            return StringUtil.replace(arg1, arg2, "");
        }

        public static function replace(arg1:String, arg2:String, arg3:String):String
        {
            return arg1.split(arg2).join(arg3);
        }

        public static function stringHasValue(arg1:String):Boolean
        {
            return !(arg1 == null) && arg1.length > 0;
        }
    }
}


