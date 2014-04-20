package ru.norobots.trox.view.controls {
import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;

import ru.norobots.trox.Callback;

import ru.norobots.trox.animation.OnceAnimation;

import ru.norobots.trox.view.BaseView;
import ru.norobots.trox.view.Shining;

public class Blister extends InteractiveView {

    private var blisterEnabled:Boolean;
    private var pressCallback:Function;
    private var actionCallback:Function;
    private var outCallback:Function;
    private var overCallback:Function;
    private var animatedBlister:BaseView;
    private var lock:DisplayObject;
    private var shining:Shining;

    private var over:Boolean;

    public function Blister(visual:DisplayObject) {
        super(visual);
        animatedBlister = new BaseView(getVisual().getChildByName("blister_anim"));
        lock = getVisual().getChildByName("lock");
        shining = new Shining(getVisual().getChildByName("shining"));
    }

    override public function setEnabled(value:Boolean):void {
        super.setEnabled(value);
        blisterEnabled = value;
        if (value) {
            shining.show();
        } else {
            shining.hide();
        }
        lock.visible = !value;
        if (value) {
            getVisual().transform.colorTransform = new ColorTransform(1, 1, 1);
        } else {
            getVisual().transform.colorTransform = new ColorTransform(0.5, 0.5, 0.5);
        }
    }

    public function setShiningShowed(value:Boolean):void {
        shining.setVisible(value);
    }

    public function reset():void {
        animatedBlister.stop();
        animatedBlister.getVisual().gotoAndStop(1);
        blisterEnabled = false;
        lock.visible = true;
    }

    public function addActionCallback(value:Function):void {
        actionCallback = value;
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
            animatedBlister.play(once);
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
