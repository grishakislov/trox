package ru.norobots.trox.view.controls {
import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;

import ru.norobots.trox.animation.OnceAnimation;

import ru.norobots.trox.view.BaseView;
import ru.norobots.trox.view.Shining;

public class Blister extends InteractiveView {

    private var blisterEnabled:Boolean;
    private var callback:Function;
    private var animatedBlister:BaseView;
    private var lock:DisplayObject;
    private var shining:Shining;

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
        callback = value;
    }

    private function fireCallback():void {
        if (callback != null) {
            callback();
        }
    }

    override protected function onMouseUp(event:MouseEvent):void {
        if (!enabled) {
            return;
        }
        super.onMouseUp(event);
        if (blisterEnabled && mouseInside()) {
            shining.hide();
            blisterEnabled = false;
            var once:OnceAnimation = new OnceAnimation();
            once.addCompleteCallback(onBlisterAnimationCompleted);
            animatedBlister.play(once);
        }
    }

    private function onBlisterAnimationCompleted():void {
        fireCallback();
    }
}
}
