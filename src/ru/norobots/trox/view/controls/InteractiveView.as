package ru.norobots.trox.view.controls {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

import ru.norobots.trox.view.BaseView;

public class InteractiveView extends BaseView {

    protected var state:InteractiveState = InteractiveState.IDLE;
    private var mouseDown:Boolean;
    private var listenersEnabled:Boolean;

    public function InteractiveView(visual:DisplayObject) {
        super(visual);
        if (getVisual().stage == null) {
            getVisual().addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        } else {
            setEnabled(true);
        }
    }

    protected function mouseInside():Boolean {
        var visual:MovieClip = getVisual();
        var rect:Rectangle = visual.getRect(visual.stage);
        return rect.contains(visual.stage.mouseX, visual.stage.mouseY);
    }

    protected function onMouseDown(event:MouseEvent):void {
        mouseDown = true;
    }

    protected function onMouseUp(event:MouseEvent):void {
        mouseDown = false;
        state = InteractiveState.IDLE;
    }

    private function onAddedToStage(event:Event):void {
        getVisual().removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        getVisual().stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        getVisual().stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
        getVisual().stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        listenersEnabled = true;
    }

    protected function onMouseMove(event:MouseEvent):void {
        if (!mouseDown) {
            return;
        }

        if (mouseInside()) {
            state = InteractiveState.ACTIVE;
        } else {
            state = InteractiveState.IDLE;
        }
    }

    public function setEnabled(value:Boolean):void {
        if (value) {
            if (!listenersEnabled) {
                getVisual().stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
                getVisual().stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
                getVisual().stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
                listenersEnabled = true;
            }
        } else {
            if (listenersEnabled) {
                getVisual().stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
                getVisual().stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
                getVisual().stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
                listenersEnabled = false;
            }
        }
    }

}
}
