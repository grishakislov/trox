package ru.norobots.trox.view.controls {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.ui.Mouse;

import ru.norobots.trox.Ticker;

public class Tube extends InteractiveView {

    private var gelCursor:DisplayObject;
    private var mainVisual:MovieClip;

    public function Tube(visual:DisplayObject) {
        mainVisual = MovieClip (visual);
        super(mainVisual.getChildByName("tube_view"));
        gelCursor = mainVisual.getChildByName("gel");
        gelCursor.visible = false;
    }

    override protected function onMouseDown(event:MouseEvent):void {
        if (getVisual().hitTestPoint(getVisual().stage.mouseX, getVisual().stage.mouseY)) {
            setCursorVisible(getVisual().visible);
        }
    }

    private function setCursorVisible(value:Boolean):void {
        gelCursor.visible = value;
        if (value) {
            Mouse.hide();
            Ticker.addTickListener(onTick);
        } else {
            Mouse.show();
            Ticker.removeTickListener(onTick);
        }
    }

    private function onTick(dt:uint):void {
        moveCursorToMouse();
    }

    var point:Point = new Point(0,0);

    private function moveCursorToMouse():void {
        if (gelCursor.visible) {
            var global:Point = getVisual().localToGlobal(point);
            gelCursor.x = getVisual().stage.mouseX - global.x;
            gelCursor.y = getVisual().stage.mouseY - global.y;
        }
    }

    override public function getVisual():MovieClip {
        return mainVisual;
    }
}
}
