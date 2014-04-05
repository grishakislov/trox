package ru.norobots.trox.view.controls {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;

import ru.norobots.trox.view.BaseView;

public class InteractiveView extends BaseView {

    protected var state:InteractiveState = InteractiveState.IDLE;
    private var mouseDown:Boolean;

    public function InteractiveView(visual:DisplayObject) {
        super(visual);
        getVisual().addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

    }

    private function onAddedToStage(event:Event):void {
        getVisual().removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        getVisual().stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        getVisual().stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
        getVisual().stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
    }

    protected function onMouseDown(event:MouseEvent):void {
        mouseDown = true;
    }

    protected function onMouseUp(event:MouseEvent):void {
        mouseDown = false;
        state = InteractiveState.IDLE;
    }

    private function onMouseMove(event:MouseEvent):void {
        if (!mouseDown) {
            return;
        }

        if (mouseInside()) {
            state = InteractiveState.ACTIVE;
        } else {
            state = InteractiveState.IDLE;
        }
    }

    private function mouseInside():Boolean {
        var visual:MovieClip = getVisual();
        var rect:Rectangle = visual.getRect(visual.stage);
        return rect.contains(visual.stage.mouseX, visual.stage.mouseY);
    }
}
}
