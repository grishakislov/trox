package ru.norobots.trox.view.valve {
import flash.display.DisplayObject;
import flash.events.TimerEvent;
import flash.utils.Timer;

import ru.norobots.trox.GameSettings;

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
        var delayMillis:uint = Math.random() * GameSettings.MAX_VALVE_ILL_DELAY_MILLIS;
        var timer:Timer = new Timer(delayMillis, 1);
        timer.addEventListener(TimerEvent.TIMER, onIllTimerComplete);
        timer.start();
    }

    private function onIllTimerComplete(event:TimerEvent):void {
        valveAnimation.setIll();
    }

    public function setHealthy():void {
        valveAnimation.setHealthy();
    }

}
}
