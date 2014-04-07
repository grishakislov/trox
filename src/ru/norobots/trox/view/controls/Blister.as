package ru.norobots.trox.view.controls {
import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.filters.ColorMatrixFilter;
import flash.geom.ColorTransform;

public class Blister extends InteractiveView {

    /**
     *
     * pill1
     *    use
     * pill2
     *    use
     * lock
     */

    private var enabled:Boolean;
    private var callback:Function;

    private var pill1:Pill;
    private var pill2:Pill;
    private var lock:DisplayObject;

    public function Blister(visual:DisplayObject) {
        super(visual);
        pill1 = new Pill(getVisual().getChildByName("pill1"));
        pill2 = new Pill(getVisual().getChildByName("pill2"));
        lock = getVisual().getChildByName("lock");
    }


    override protected function onMouseUp(event:MouseEvent):void {
        super.onMouseUp(event);
        if (enabled && mouseInside()) {
            usePill();
        }
    }

    private function usePill():void {
        if (!pill1.alreadyUsed()) {
            pill1.usePill();
            fireCallback();
        } else if (!pill2.alreadyUsed()) {
            pill2.usePill();
            fireCallback();
        }
    }

    private function fireCallback():void {
        if (callback != null) {
            callback();
        }
    }

    public function setEnabled(value:Boolean):void {
        enabled = value;
        lock.visible = !value;
        if (value) {
            getVisual().transform.colorTransform = new ColorTransform(1, 1, 1);
        } else {
            getVisual().transform.colorTransform = new ColorTransform(0.5, 0.5, 0.5);
        }
    }

    public function addActionCallback(value:Function):void {
        callback = value;
    }

    public function hasMorePills():Boolean {
        return !pill2.alreadyUsed();
    }
}
}
