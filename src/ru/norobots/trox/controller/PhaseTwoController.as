package ru.norobots.trox.controller {
import flash.events.TimerEvent;
import flash.utils.Timer;

import ru.norobots.trox.GameSettings;

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
        view.blister.setEnabled(true);
        view.blister.addActionCallback(onPillUsed);
    }

    private function onPillUsed():void {
        view.blister.setEnabled(false);
        handlePillUse();
        var timer:Timer;

        /*
        My cat wrote it here:
        n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n
         */

        if (view.blister.hasMorePills()) {
            timer = new Timer(2000, 1);
            timer.addEventListener(TimerEvent.TIMER, onPillTimerComplete);
            timer.start();

            timer = new Timer(GameSettings.GAME_OVER_DELAY_MILLIS, 1);
            timer.addEventListener(TimerEvent.TIMER, onEndTimerComplete);
            timer.start();
        }

    }

    private function onEndTimerComplete(event:TimerEvent):void {
        onComplete();
    }

    private function handlePillUse():void {
        view.particles.moveFront();
        view.valves.setHealthy();
        view.tumor.setHealthy();
        view.vein.shrink();
        view.cure.play();
    }

    private function onPillTimerComplete(event:TimerEvent):void {
        view.blister.setEnabled(true);
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
