package ru.norobots.trox.view.controls {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.ui.Mouse;

import ru.norobots.trox.Ticker;
import ru.norobots.trox.UIState;

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
        if (mouseInside()) {
            setCursorVisible(!gelCursor.visible);
        }
    }

    private function setCursorVisible(value:Boolean):void {
        gelCursor.visible = value;
        UIState.tubeSelected = value;
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
            var global:Point = mainVisual.localToGlobal(point);
            gelCursor.x = mainVisual.stage.mouseX - global.x;
            gelCursor.y = mainVisual.stage.mouseY - global.y;
        }
    }

    public function getAll():MovieClip {
        return mainVisual;
    }
}
}
