package ru.norobots.trox.view.erythrocyte {
import flash.display.DisplayObject;
import flash.events.TimerEvent;
import flash.utils.Timer;

import ru.norobots.trox.animation.BaseAnimation;
import ru.norobots.trox.animation.ErythrocyteAnimation;
import ru.norobots.trox.view.BaseView;

public class Erythrocyte extends BaseView {

    private var hide:Boolean;
    private var step:uint;

    public function Erythrocyte(visual:DisplayObject) {
        super(visual);
        getVisual().alpha = 0.5;
    }

    override public function play(animation:BaseAnimation = null):void {
        super.play(animation);
    }

    public function randomizePosition():void {
        getVisual().gotoAndStop(Math.floor(Math.random() * (getVisual().totalFrames - 1)));
    }

    public function playDelayed(delayMillis:uint):void {
        if (delayMillis == 0) {
            onTimerComplete(null);
        } else {
            var timer:Timer = new Timer(delayMillis, 1);
            timer.addEventListener(TimerEvent.TIMER, onTimerComplete);
            timer.start();
        }
    }

    public function reset():void {
        stop();
        hide = false;
        getVisual().alpha = 0.5;
        getVisual().gotoAndStop(1);
    }

    private function getErythrocyteAnimation():ErythrocyteAnimation {
        return ErythrocyteAnimation(getAnimation());
    }

    public function setShowed(value:Boolean):void {
        if (getErythrocyteAnimation() != null) {
            getErythrocyteAnimation().setShowed(value);
        }
    }

    private function onTimerComplete(event:TimerEvent):void {
        var anim:ErythrocyteAnimation = new ErythrocyteAnimation();
        anim.addMovie(getVisual());
        anim.setStep(step);
        play(anim);
    }

    public function setStep(value:uint):void {
        step = value;
        if (getErythrocyteAnimation() != null) {
            getErythrocyteAnimation().setStep(value);
        }
    }

}
}
