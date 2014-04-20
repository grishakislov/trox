package ru.norobots.trox.view.controls {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

import ru.norobots.trox.Main;
import ru.norobots.trox.view.BaseView;

public class InteractiveView extends BaseView {

    protected var state:InteractiveState = InteractiveState.IDLE;
    protected var mouseDown:Boolean;
    protected var enabled:Boolean;

    public function InteractiveView(visual:DisplayObject) {
        super(visual);

        if (getVisual().stage == null) {
            getVisual().addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            getVisual().addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
        } else {
            onAddedToStage(null);
            setEnabled(true);
        }
    }

    private function onRemovedFromStage(event:Event):void {
        getVisual().addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        getVisual().parent.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        Main.getInstance().getView().removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        Main.getInstance().getView().removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        Main.getInstance().getView().removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);

    }

    protected function mouseInside():Boolean {
        var visual:MovieClip = getVisual();
        var rect:Rectangle = visual.getRect(visual.stage);
        return rect.contains(visual.stage.mouseX, visual.stage.mouseY);
    }

    protected function onMouseDown(event:MouseEvent):void {
        if (enabled) {
            mouseDown = true;
        }

    }

    protected function onMouseUp(event:MouseEvent):void {
        if (enabled) {
            mouseDown = false;
            state = InteractiveState.IDLE;
        }
    }

    private function onAddedToStage(event:Event):void {
        getVisual().removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        Main.getInstance().getView().addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        Main.getInstance().getView().addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        Main.getInstance().getView().addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
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
        enabled = value;
    }

}
}
