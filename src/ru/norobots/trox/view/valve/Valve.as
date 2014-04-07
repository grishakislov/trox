package ru.norobots.trox.view.valve {
import flash.display.DisplayObject;
import flash.events.TimerEvent;
import flash.utils.Timer;

import ru.norobots.trox.animation.ValveAnimation;
import ru.norobots.trox.view.BaseView;

public class Valve extends BaseView {

    private var valveAnimation:ValveAnimation;

    public function Valve(visual:DisplayObject) {
        super(visual);
        valveAnimation = new ValveAnimation();
        play(valveAnimation);
    }


    public function setIllDelayed():void {
        var delayMillis:uint = Math.random() * 5000 + 500;

        var timer:Timer = new Timer(delayMillis, 1);
        timer.addEventListener(TimerEvent.TIMER, onTimerComplete);
        timer.start();
    }

    private function onTimerComplete(event:TimerEvent):void {
        valveAnimation.setIll();
    }

    public function setHealthy():void {
        valveAnimation.setHealthy();
    }


}
}
