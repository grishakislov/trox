package ru.norobots.trox.view.controls {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.ui.Mouse;

import ru.norobots.trox.Ticker;
import ru.norobots.trox.UIState;

public class Tube extends InteractiveView {

    var point:Point = new Point(0,0);
    private var gelCursor:DisplayObject;
    private var mainVisual:MovieClip;

    public function Tube(visual:DisplayObject) {
        mainVisual = MovieClip (visual);
        super(mainVisual.getChildByName("tube_view"));
        gelCursor = mainVisual.getChildByName("gel");
        gelCursor.visible = false;
    }

    public function getAll():MovieClip {
        return mainVisual;
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

    override public function setEnabled(value:Boolean):void {
        super.setEnabled(value);
        if (!UIState.tubeSelected) {
            return;
        }
        setCursorVisible(value);
        if (value) {
            Ticker.addTickListener(onTick);
        } else {
            Ticker.removeTickListener(onTick);
        }
    }

    private function moveCursorToMouse():void {
        if (gelCursor.visible) {
            var global:Point = mainVisual.localToGlobal(point);
            gelCursor.x = mainVisual.stage.mouseX - global.x;
            gelCursor.y = mainVisual.stage.mouseY - global.y;
        }
    }

    override protected function onMouseDown(event:MouseEvent):void {
        if (mouseInside()) {
            setCursorVisible(!gelCursor.visible);
        }
    }
}
}
