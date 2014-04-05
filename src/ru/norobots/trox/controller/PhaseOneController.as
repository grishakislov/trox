package ru.norobots.trox.controller {
import ru.norobots.trox.GameSettings;
import ru.norobots.trox.Ticker;
import ru.norobots.trox.view.PlainViewModel;
import ru.norobots.trox.view.Vein;

public class PhaseOneController {

    private var view:PlainViewModel;
    private var completeCallback:Function;

    private var millisElapsed:uint;
    private var millisFromLastExpand:uint = 0;
    private var millisTotal:uint;
    private var currentVeinStep:uint = 0;

    public function PhaseOneController(view:PlainViewModel) {
        this.view = view;
        millisTotal = GameSettings.VEIN_STEP_SECONDS * GameSettings.VEIN_STEPS * 1000;
        Ticker.addTickListener(onTick);
    }

    private function onTick(dt:uint):void {
        millisElapsed += dt;
        millisFromLastExpand += dt;

        if (currentStepTimeOut()) {
            expandNext();
            millisFromLastExpand = 0;
        }

        if (phaseCompleted()) {
            onComplete();
        }
    }

    private function currentStepTimeOut():Boolean {
        if (currentVeinStep == 0) {
            return millisFromLastExpand >= (GameSettings.VEIN_STEP_SECONDS * 1000) / 4;
        } else {
            return millisFromLastExpand >= GameSettings.VEIN_STEP_SECONDS * 1000
        }
    }

    private function expandNext():void {
        currentVeinStep ++;

        if (currentVeinStep <= GameSettings.VEIN_STEPS) {
            view.vein.expand();
            view.particles.setStep(currentVeinStep);
            view.tumor.setStep(currentVeinStep);
        } else {
            onComplete();
        }

    }

    private function onComplete():void {
        Ticker.removeTickListener(onTick);
        if (completeCallback != null) {
            completeCallback();
        }
    }

    private function phaseCompleted():Boolean {
        return millisElapsed >= millisTotal;
    }

    public function addCompleteCallback(callback:Function):void {
        completeCallback = callback;
    }
}
}
