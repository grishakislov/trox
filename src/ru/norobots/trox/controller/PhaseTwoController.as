package ru.norobots.trox.controller {
import flash.events.TimerEvent;
import flash.utils.Timer;

import ru.norobots.trox.GameSettings;
import ru.norobots.trox.animation.OnceAnimation;

import ru.norobots.trox.view.PlainViewModel;

public class PhaseTwoController {

    private var view:PlainViewModel;
    private var completeCallback:Function;

    public function PhaseTwoController(view:PlainViewModel) {
        this.view = view;
        view.tumor.lock();
        view.valves.setIll();
        view.particles.moveBack();
        view.tube.setEnabled(false);

        var timer:Timer = new Timer(GameSettings.BLISTER_ENABLE_DELAY_MILLIS, 1);
        timer.addEventListener(TimerEvent.TIMER, onBlisterTimerComplete);
        timer.start();
    }

    private function onBlisterTimerComplete(event:TimerEvent):void {
        view.blister.setEnabled(true);
        view.blister.addActionCallback(onPillsUsed);
    }

    private function onPillsUsed():void {
        /*
        My cat wrote it here:
        n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n
         */
        handlePillUse();
    }

    private function handlePillUse():void {
        view.cure.play(new OnceAnimation());

        var timer:Timer = new Timer(GameSettings.CURE_DELAY, 1);
        timer.addEventListener(TimerEvent.TIMER, onCureTimerComplete);
        timer.start();
    }

    private function onCureTimerComplete(event:TimerEvent):void {
        view.particles.moveFront();
        view.valves.setHealthy();
        view.tumor.setHealthy();
        view.vein.shrink();


        var timer:Timer = new Timer(GameSettings.GAME_OVER_DELAY_MILLIS, 1);
        timer.addEventListener(TimerEvent.TIMER, onEndTimerComplete);
        timer.start();

    }

    private function onEndTimerComplete(event:TimerEvent):void {
        onComplete();
    }

    private function onComplete():void {
        if (completeCallback != null) {
            completeCallback();
        }
    }

    public function addCompleteCallback(callback:Function):void {
        completeCallback = callback;
    }

}
}
