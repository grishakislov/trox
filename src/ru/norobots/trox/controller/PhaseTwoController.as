package ru.norobots.trox.controller {
import flash.events.TimerEvent;
import flash.utils.Timer;

import ru.norobots.trox.Callback;

import ru.norobots.trox.GameSettings;
import ru.norobots.trox.animation.OnceAnimation;

import ru.norobots.trox.view.PlainViewModel;

public class PhaseTwoController {

    private var view:PlainViewModel;
    private var completeCallback:Function;

    public function PhaseTwoController(view:PlainViewModel) {
        this.view = view;
        view.tube.setShiningShowed(false);
        view.blister.addOverCallback(onBlisterRolledOver);
        view.blister.addOutCallback(onBlisterRolledOut);
        var timer:Timer = new Timer(GameSettings.BLISTER_ENABLE_DELAY_MILLIS, 1);
        timer.addEventListener(TimerEvent.TIMER, onBlisterTimerComplete);
        timer.start();
    }

    private function onBlisterRolledOut():void {
        view.tube.setCursorVisible(true);
    }

    private function onBlisterRolledOver():void {
        view.tube.setCursorVisible(false);
    }

    private function onBlisterTimerComplete(event:TimerEvent):void {
        view.tip.showBlisterTip();
        view.blister.setEnabled(true);
        view.blister.addPressCallback(onPillsPressed);
        view.blister.addActionCallback(onPillsUsed);
    }

    private function onPillsPressed():void {
        view.tube.setEnabled(false);
        view.tip.resumeBlisterHiding();
        view.blister.removeOutCallback();
        view.blister.removeOverCallback();
    }

    private function onPillsUsed():void {
        /*
        My cat wrote it here:
        n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n
         */
        handlePillUse();
    }

    private function handlePillUse():void {
        var cureAnim:OnceAnimation = new OnceAnimation();
        cureAnim.addCompleteCallback(onCureAnimationCompleted);
        view.cure.play(cureAnim);

        var timer:Timer = new Timer(GameSettings.CURE_DELAY, 1);
        timer.addEventListener(TimerEvent.TIMER, onCureTimerComplete);
        timer.start();
    }

    private function onCureAnimationCompleted():void {
        view.cure.getVisual().gotoAndStop(1);
    }

    private function onCureTimerComplete(event:TimerEvent):void {
        view.particles.setStep(1);
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
        Callback.fire(completeCallback);
    }

    public function addCompleteCallback(callback:Function):void {
        completeCallback = callback;
    }

}
}
