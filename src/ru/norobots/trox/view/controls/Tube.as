package ru.norobots.trox.view.controls {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.geom.Point;
import flash.ui.Mouse;

import ru.norobots.trox.Ticker;
import ru.norobots.trox.UIState;
import ru.norobots.trox.view.Shining;

public class Tube extends InteractiveView {

    var point:Point = new Point(0, 0);
    private var gelCursor:Sprite;
    private var mainVisual:MovieClip;
    private var shining:Shining;

    public function Tube(visual:DisplayObject) {
        mainVisual = MovieClip(visual);
        super(mainVisual.getChildByName("tube_view"));
        gelCursor = Sprite(mainVisual.getChildByName("gel"));
        gelCursor.visible = false;
        shining = new Shining(mainVisual.getChildByName("shining"));
    }

    public function getAll():MovieClip {
        return mainVisual;
    }

    public function setShiningShowed(value:Boolean):void {
        shining.setVisible(value);
    }

    public function setCursorVisible(value:Boolean):void {
        UIState.tubeSelected = value;
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

    override public function setEnabled(value:Boolean):void {
        super.setEnabled(value);
        if (value) {
            shining.show();
        } else {
            shining.hide();
        }
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

    public function reset():void {
        //TODO: ?
    }
}
}
