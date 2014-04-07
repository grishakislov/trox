package ru.norobots.trox.controller {
import flash.events.TimerEvent;
import flash.utils.Timer;

import ru.norobots.trox.view.PlainViewModel;

public class PhaseTwoController {

    private var view:PlainViewModel;
    private var completeCallback:Function;

    public function PhaseTwoController(view:PlainViewModel) {
        this.view = view;
        view.tumor.lock();
        view.valves.setIll();
        view.particles.moveBack();
        view.blister.setEnabled(true);
        view.blister.addActionCallback(onPillUsed);
    }

    private function onPillUsed():void {
        view.blister.setEnabled(false);
        handlePillUse();
        if (view.blister.hasMorePills()) {
            var timer:Timer = new Timer(3000, 1);
            timer.addEventListener(TimerEvent.TIMER, onTimerComplete);
            timer.start();
        }

    }

    private function handlePillUse():void {
        view.particles.moveFront();
        view.cure.play();
    }

    private function onTimerComplete(event:TimerEvent):void {
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
