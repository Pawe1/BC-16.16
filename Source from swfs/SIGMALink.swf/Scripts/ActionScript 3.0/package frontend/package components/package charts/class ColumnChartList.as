//class ColumnChartList
package frontend.components.charts 
{
    import __AS3__.vec.*;
    import core.general.*;
    import debug.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.events.*;
    import flash.utils.*;
    import frontend.screen.statistic.tabs.*;
    import handler.*;
    import starling.animation.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import utils.sort.*;
    
    public class ColumnChartList extends feathers.controls.LayoutGroup
    {
        public function ColumnChartList()
        {
            this.bgGroup = new feathers.controls.LayoutGroup();
            this.labelGroup = new feathers.controls.LayoutGroup();
            this.shapesGroup = new feathers.controls.LayoutGroup();
            super();
            layoutData = new feathers.layout.AnchorLayoutData(HEADER_HEIGHT);
            addEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            return;
        }

        internal function drawBackground():void
        {
            var loc1:*=0;
            var loc2:*=null;
            debug.Debug.debug("drawBackground - " + this.item.title + ", " + this.item.type);
            if (this.rtBg) 
            {
                this.rtBg.clear();
            }
            else 
            {
                this.rtBg = new frontend.components.charts.CustomRenderTexture(width, height);
            }
            loc2 = new starling.display.Quad(width, FOOTER_LINES_HEIGHT, core.general.Colors.DARKGREY);
            loc2.x = 0;
            loc2.y = int(this._columnMaxHeight);
            this.rtBg.draw(loc2, null, 1, 3);
            loc1 = 1;
            while (loc1 <= this._gridLines) 
            {
                loc2 = new starling.display.Quad(width, COLUMN_BOTTOM_LINE_HEIGHT, core.general.Colors.LIGHTGREY);
                loc2.x = 0;
                loc2.y = int(this._columnMaxHeight - loc1 * this._gridGap);
                this.rtBg.draw(loc2, null, 1, 3);
                loc2.dispose();
                ++loc1;
            }
            this.disposeChildren(this.bgGroup);
            this.bgGroup.addChild(new starling.display.Image(this.rtBg));
            return;
        }

        internal function validateShapes():void
        {
            var loc1:*=0;
            var loc3:*=null;
            var loc4:*=null;
            var loc6:*=0;
            var loc7:*=0;
            var loc8:*=null;
            var loc9:*=NaN;
            var loc10:*=NaN;
            var loc11:*=null;
            var loc12:*=NaN;
            var loc13:*=NaN;
            var loc14:*=null;
            var loc16:*=false;
            var loc18:*=false;
            var loc19:*=null;
            debug.Debug.debug("validateShapes - " + this.item.title + ", " + this.item.type);
            var loc2:*=this.item.dataProvider.length;
            var loc5:*=0;
            var loc15:*=TWEEN_DURATION > 0;
            var loc17:*=0;
            this.shapes = new Vector.<Array>();
            if (this.rtLabels) 
            {
                this.rtLabels.clear();
            }
            else 
            {
                this.rtLabels = new frontend.components.charts.CustomRenderTexture(width, height);
            }
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc5 = loc1 * (this._columnWidth + COLUMN_H_GAP);
                loc3 = this.item.dataProvider.getItemAt(loc1) as frontend.components.charts.ColumnChartItem;
                loc7 = loc3.yValues.length;
                loc9 = this._columnMaxHeight;
                loc10 = this._columnPaddingSide;
                loc3.yValues.sort(sortOnSortField);
                loc16 = this.dropLabels ? (loc1 + 1) % (DROP_LABELS_MINIMUM + 1) == 0 : true;
                if (loc7 == 0 || this.item.hidden) 
                {
                    loc4 = new frontend.screen.statistic.tabs.CustomShape();
                    loc4.showLabel = loc16;
                    loc4.color = 16777215;
                    loc4.xFrom = loc10;
                    loc4.yFrom = this._columnMaxHeight;
                    loc4.widthFrom = this._columnQuadWidth;
                    loc4.heightFrom = 0.1;
                    loc4.label = loc3.label;
                    loc4.heightTo = 0.1;
                    loc4.yTo = this._columnMaxHeight;
                    this.shapes.push([loc4]);
                }
                else 
                {
                    loc19 = [];
                    loc6 = 0;
                    while (loc6 < loc7) 
                    {
                        loc14 = loc3.yValues[loc6] as frontend.components.charts.ColumnChartItemProps;
                        if (loc14.value != 0) 
                        {
                            loc12 = loc14.value * this._columnQuadHeightFactor;
                            loc13 = loc9 - loc12;
                            loc4 = new frontend.screen.statistic.tabs.CustomShape();
                            loc4.chartItem = loc3;
                            loc4.showLabel = loc16;
                            loc4.color = loc14.color;
                            loc4.xFrom = loc10;
                            loc4.yFrom = this._columnMaxHeight;
                            loc4.widthFrom = this._columnQuadWidth;
                            loc4.heightFrom = 0.1;
                            loc4.label = loc3.label;
                            loc4.heightTo = loc12;
                            loc4.yTo = loc13;
                            loc19.push(loc4);
                            loc9 = loc13;
                        }
                        ++loc6;
                    }
                    this.shapes.push(loc19);
                }
                loc18 = true;
                if (this.dropLabels) 
                {
                    loc18 = (loc1 + 1) % (DROP_LABELS_MINIMUM + 1) == 0;
                }
                if (loc18) 
                {
                    loc11 = new feathers.controls.Label();
                    loc11.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
                    loc11.text = loc3.label;
                    loc11.wordWrap = false;
                    loc11.validate();
                    loc11.x = loc5 + (this._columnWidth - loc11.width >> 1);
                    loc11.y = this._columnMaxHeight + COLUMN_BOTTOM_LINE_HEIGHT + (FOOTER_HEIGHT - loc11.height >> 1);
                    if (loc11.x < 0 && this.dropLabels) 
                    {
                        loc11.x = 0;
                    }
                    if (loc1 == (loc2 - 1) && this.dropLabels) 
                    {
                        loc11.x = loc5 + this._columnWidth - loc11.width;
                    }
                    if (loc11.x > loc17) 
                    {
                        this.rtLabels.draw(loc11, null, 1, 2);
                        loc17 = loc11.x + loc11.width;
                        loc11.dispose();
                    }
                }
                ++loc1;
            }
            this.disposeChildren(this.labelGroup);
            this.labelGroup.addChild(new starling.display.Image(this.rtLabels));
            return;
        }

        public function validateItem():void
        {
            this._columnWidth = width / this.item.dataProvider.length - COLUMN_H_GAP;
            this._columnMaxHeight = this.parentHeight - HEADER_HEIGHT - FOOTER_HEIGHT;
            this._columnPaddingSide = COLUMN_PADDING >> 1;
            this._columnQuadWidth = this._columnWidth - COLUMN_PADDING;
            this._columnQuadHeightFactor = this._columnMaxHeight / this.item.yMax;
            this._gridLines = Math.floor(this.item.yMax / this.item.yInterval);
            this._gridGap = this._columnMaxHeight / this._gridLines;
            this.drawBackground();
            this.validateShapes();
            this.drawWithQuads();
            return;
        }

        internal function onRemovedFromStage(arg1:starling.events.Event):void
        {
            if (this.item) 
            {
                this.item.dataChanged = true;
            }
            if (this.shapesGroup) 
            {
                this.shapesGroup.removeEventListener(starling.events.TouchEvent.TOUCH, this.onShapesGroupTouch);
            }
            return;
        }

        internal function disposeChildren(arg1:feathers.controls.LayoutGroup):void
        {
            var loc1:*=0;
            var loc3:*=null;
            debug.Debug.debug("disposeChilden");
            var loc2:*=arg1.numChildren;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = arg1.getChildAt(loc1);
                loc3.dispose();
                ++loc1;
            }
            arg1.removeChildren();
            return;
        }

        internal function onShapesGroupTouch(arg1:starling.events.TouchEvent):void
        {
            var loc2:*=null;
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            var loc1:*=arg1.target as starling.display.Image;
            if (loc1) 
            {
                loc2 = arg1.getTouch(loc1);
                loc3 = loc2.globalX;
                loc4 = loc2.globalY;
                var loc8:*=0;
                var loc9:*=this.calloutInfo;
                for (loc5 in loc9) 
                {
                    loc6 = this.calloutInfo[loc5];
                    if (!(loc3 >= int(loc5) && loc3 <= int(loc5) + this._columnWidth)) 
                    {
                        continue;
                    }
                    debug.Debug.debug("treffer");
                    this._calloutAnchor.x = int(loc5) + this._columnWidth / 2;
                    this._calloutAnchor.y = this._columnMaxHeight - this.calloutInfoY[loc5];
                    loc7 = new frontend.components.charts.StatisticColumnChartCallout();
                    loc7.applyitem(loc6);
                    feathers.controls.Callout.show(loc7, this._calloutAnchor, null, false, this.calloutFactory);
                    return;
                }
            }
            return;
        }

        internal function calloutFactory():feathers.controls.Callout
        {
            var loc1:*=new feathers.controls.Callout();
            loc1.closeOnTouchBeganOutside = true;
            return loc1;
        }

        internal function onAddedToStage(arg1:starling.events.Event):void
        {
            height = this.parentHeight;
            width = SIGMALink.appWidth;
            COLUMN_H_GAP = 0.5 * SIGMALink.scaleFactor;
            this.bgGroup.width = width;
            this.bgGroup.height = height;
            addChild(this.bgGroup);
            this.labelGroup.width = width;
            this.labelGroup.height = height;
            addChild(this.labelGroup);
            this.shapesGroup.width = width;
            this.shapesGroup.height = height;
            this.shapesGroup.addEventListener(starling.events.TouchEvent.TOUCH, this.onShapesGroupTouch);
            addChild(this.shapesGroup);
            this._calloutAnchor = new feathers.controls.LayoutGroup();
            this._calloutAnchor.width = 1;
            this._calloutAnchor.height = 1;
            addChild(this._calloutAnchor);
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            removeEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
            removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            if (this.labelGroup) 
            {
                this.disposeChildren(this.labelGroup);
            }
            if (this.bgGroup) 
            {
                this.disposeChildren(this.bgGroup);
            }
            if (this.shapesGroup) 
            {
                this.shapesGroup.removeEventListener(starling.events.TouchEvent.TOUCH, this.onShapesGroupTouch);
                this.disposeChildren(this.shapesGroup);
            }
            if (this.rtBg) 
            {
                this.rtBg.dispose();
                this.rtBg = null;
            }
            if (this.rtLabels) 
            {
                this.rtLabels.dispose();
                this.rtLabels = null;
            }
            if (this.rtShapes) 
            {
                this.rtShapes.dispose();
                this.rtShapes = null;
            }
            if (this._calloutAnchor) 
            {
                this.disposeChildren(this._calloutAnchor);
            }
            removeChildren();
            return;
        }

        internal static function sortOnSortField(arg1:frontend.components.charts.ColumnChartItemProps, arg2:frontend.components.charts.ColumnChartItemProps):Number
        {
            return utils.sort.SortUtil.sortOnString(arg1, arg2, frontend.components.charts.ColumnChartItemProps.SORT_FIELD_PROPERTY, true);
        }

        
        {
            HEADER_HEIGHT = 62 * SIGMALink.scaleFactor;
            COLUMN_H_GAP = 1 * SIGMALink.scaleFactor;
            COLUMN_PADDING = 6 * SIGMALink.scaleFactor;
        }

        public function scaleOut(arg1:flash.events.TimerEvent=null):void
        {
            debug.Debug.debug("remove - " + this.item.title + ", " + this.item.type);
            this.disposeChildren(this.shapesGroup);
            return;
        }

        public function scaleIn(arg1:flash.events.TimerEvent=null):void
        {
            var p_event:flash.events.TimerEvent=null;
            var targetHeight:Number;
            var ctween:starling.animation.Tween;

            var loc1:*;
            ctween = null;
            p_event = arg1;
            if (this._img) 
            {
                this.disposeChildren(this.shapesGroup);
                this.drawWithQuads();
            }
            if (!this._img) 
            {
                this.disposeChildren(this.shapesGroup);
                return;
            }
            debug.Debug.debug("scaleIn - " + this.item.title + ", " + this.item.type);
            this.disposeChildren(this.shapesGroup);
            this.shapesGroup.addChild(this._img);
            targetHeight = this._img.height;
            this._img.height = 0;
            this._img.y = this._columnMaxHeight;
            ctween = new starling.animation.Tween(this._img, 0.8, starling.animation.Transitions.EASE_IN_OUT);
            ctween.animate("height", targetHeight);
            ctween.animate("y", 0);
            ctween.onComplete = function ():void
            {
                starling.core.Starling.juggler.remove(ctween);
                return;
            }
            starling.core.Starling.juggler.add(ctween);
            return;
        }

        internal function drawWithQuads():void
        {
            var loc1:*=null;
            var loc3:*=null;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc9:*=NaN;
            var loc10:*=null;
            debug.Debug.debug("drawWithQuads - " + this.item.title + ", " + this.item.type);
            var loc2:*=this.shapes.length;
            var loc4:*=0;
            var loc5:*=0;
            var loc11:*=0;
            if (this.rtShapes) 
            {
                this.rtShapes.clear();
            }
            else 
            {
                this.rtShapes = new frontend.components.charts.CustomRenderTexture(width, height);
            }
            this.calloutInfo = new flash.utils.Dictionary();
            this.calloutInfoY = new flash.utils.Dictionary();
            loc4 = 0;
            while (loc4 < loc2) 
            {
                loc3 = this.shapes[loc4];
                loc5 = 0;
                while (loc5 < loc3.length) 
                {
                    loc1 = loc3[loc5] as frontend.screen.statistic.tabs.CustomShape;
                    if (loc1.heightTo > 0.1) 
                    {
                        loc6 = loc4 * this._columnWidth + loc1.xFrom;
                        loc7 = loc1.yTo;
                        loc8 = loc1.widthFrom;
                        loc9 = loc1.heightTo;
                        this.calloutInfo[loc6] = loc1.chartItem;
                        if (!this.calloutInfoY[loc6]) 
                        {
                            this.calloutInfoY[loc6] = 0;
                        }
                        this.calloutInfoY[loc6] = Math.max(loc1.yFrom - loc1.yTo, this.calloutInfoY[loc6]);
                        loc10 = new starling.display.Quad(loc8, loc9, loc1.color);
                        loc10.x = loc6;
                        loc10.y = loc7;
                        this.rtShapes.draw(loc10, null, 1, 3);
                        loc10.dispose();
                        ++loc11;
                    }
                    ++loc5;
                }
                ++loc4;
            }
            this._img = loc11 > 0 ? new starling.display.Image(this.rtShapes) : null;
            return;
        }

        internal static const FOOTER_LINES_HEIGHT:Number=3 * SIGMALink.scaleFactor;

        internal static const COLUMN_BOTTOM_LINE_HEIGHT:Number=2 * SIGMALink.scaleFactor;

        internal static const DP_CHANGED:String="dpChangedEvent";

        internal static const DROP_LABELS_MINIMUM:int=3;

        internal static const FOOTER_HEIGHT:Number=48 * SIGMALink.scaleFactor;

        internal static const FOOTER_LINES_LABEL_PADDING:Number=6 * SIGMALink.scaleFactor;

        internal static const LANDSCAPE_COLUMN_COUNT:int=16;

        internal static const TWEEN_DURATION:Number=0.75;

        public var bgGroup:feathers.controls.LayoutGroup;

        public var dropLabels:Boolean=false;

        public var item:frontend.screen.statistic.tabs.StatisticTabItem;

        public var labelGroup:feathers.controls.LayoutGroup;

        public var shapes:__AS3__.vec.Vector.<Array>;

        public var shapesGroup:feathers.controls.LayoutGroup;

        internal var _calloutAnchor:feathers.controls.LayoutGroup;

        internal var _columnMaxHeight:Number;

        internal var _gridGap:Number;

        internal var _columnWidth:Number;

        internal var _columnQuadWidth:Number;

        public static var HEADER_HEIGHT:Number;

        internal var rtShapes:frontend.components.charts.CustomRenderTexture;

        internal var _columnQuadHeightFactor:Number;

        internal static var COLUMN_PADDING:Number;

        internal var rtLabels:frontend.components.charts.CustomRenderTexture;

        internal var rtBg:frontend.components.charts.CustomRenderTexture;

        internal var calloutInfo:flash.utils.Dictionary;

        public var parentHeight:Number=0;

        internal var calloutInfoY:flash.utils.Dictionary;

        internal var _img:starling.display.Image;

        internal var _gridLines:int;

        internal var _columnPaddingSide:Number;

        internal static var COLUMN_H_GAP:Number;
    }
}


