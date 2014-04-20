package ru.norobots.trox.view.controls.blister {
import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;

import ru.norobots.trox.Callback;
import ru.norobots.trox.animation.OnceAnimation;
import ru.norobots.trox.view.Shining;
import ru.norobots.trox.view.controls.InteractiveView;

public class BlisterButton extends InteractiveView {

    private var shining:Shining;
    private var blisterEnabled:Boolean;
    private var pressCallback:Function;
    private var actionCallback:Function;
    private var outCallback:Function;
    private var overCallback:Function;
    private var over:Boolean;

    public function BlisterButton(visual:DisplayObject) {
        super(visual);
    }

    override public function setEnabled(value:Boolean):void {
        super.setEnabled(value);
        blisterEnabled = value;
        if (value) {
            shining.show();
        } else {
            shining.hide();
        }

        if (value) {
            getVisual().transform.colorTransform = new ColorTransform(1, 1, 1);
        } else {
            getVisual().transform.colorTransform = new ColorTransform(0.5, 0.5, 0.5);
        }
    }

    public function addShining(value:Shining):void {
        shining = value;
    }

    public function getShining():Shining {
        return shining;
    }

    public function reset():void {
        blisterEnabled = false;
    }

    override protected function onMouseUp(event:MouseEvent):void {
        if (!enabled) {
            return;
        }
        super.onMouseUp(event);
        if (blisterEnabled && mouseInside()) {
            Callback.fire(pressCallback);
            shining.hide();
            blisterEnabled = false;
            var once:OnceAnimation = new OnceAnimation();
            once.addCompleteCallback(onBlisterAnimationCompleted);
            play(once);
        }
    }

    override protected function onMouseMove(event:MouseEvent):void {
        super.onMouseMove(event);
        if (mouseInside()) {
            if (!over) {
                over = true;
                Callback.fire(overCallback);
            }
        } else {
            if (over) {
                over = false;
                Callback.fire(outCallback);
            }
        }
    }

    private function onBlisterAnimationCompleted():void {
        Callback.fire(actionCallback);
    }

    public function addActionCallback(value:Function):void {
        actionCallback = value;
    }

    public function addPressCallback(callback:Function):void {
        pressCallback = callback;
    }


    public function addOutCallback(callback:Function):void {
        outCallback = callback;
    }

    public function addOverCallback(callback:Function):void {
        overCallback = callback;
    }

    public function removeOutCallback():void {
        outCallback = null;
    }

    public function removeOverCallback():void {
        overCallback = null;
    }



}
}
