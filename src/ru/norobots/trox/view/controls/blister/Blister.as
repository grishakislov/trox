package ru.norobots.trox.view.controls.blister {
import flash.display.DisplayObject;

import ru.norobots.trox.view.BaseView;
import ru.norobots.trox.view.Shining;

public class Blister extends BaseView {

    private var animatedBlister:BlisterButton;
    private var lock:DisplayObject;


    public function Blister(visual:DisplayObject) {
        super(visual);
        animatedBlister = new BlisterButton(getVisual().getChildByName("blister_anim"));
        lock = getVisual().getChildByName("lock");
        animatedBlister.addShining(new Shining(getVisual().getChildByName("shining")));
    }

    public function setEnabled(value:Boolean):void {
        lock.visible = !value;
        animatedBlister.setEnabled(value);
    }

    public function setShiningShowed(value:Boolean):void {
        animatedBlister.getShining().setVisible(value);
    }

    public function reset():void {
        animatedBlister.stop();
        animatedBlister.getVisual().gotoAndStop(1);
        animatedBlister.setEnabled(false);
        lock.visible = true;
    }

    public function addActionCallback(callback:Function):void {
        animatedBlister.addActionCallback(callback);
    }


    public function addPressCallback(callback:Function):void {
        animatedBlister.addPressCallback(callback);
    }


    public function addOutCallback(callback:Function):void {
        animatedBlister.addOutCallback(callback);
    }

    public function addOverCallback(callback:Function):void {
        animatedBlister.addOverCallback(callback);
    }

    public function removeOutCallback():void {
        animatedBlister.removeOutCallback();
    }

    public function removeOverCallback():void {
        animatedBlister.removeOverCallback();
    }
}
}
