package ru.norobots.trox.view.tumor {
import flash.display.DisplayObject;
import flash.display.MovieClip;

import ru.norobots.trox.Callback;
import ru.norobots.trox.Ticker;
import ru.norobots.trox.animation.RewindAnimation;
import ru.norobots.trox.view.TutorialArrow;
import ru.norobots.trox.view.controls.InteractiveState;
import ru.norobots.trox.view.controls.InteractiveView;

public class Tumor extends InteractiveView {

    private var tumor:MovieClip;
    private var arrow1:TutorialArrow;
    private var arrow2:TutorialArrow;
    private var currentStep:uint;
    private var framesPassed:uint;
    private var cureCallback:Function;

    public function Tumor(tumor:DisplayObject) {
        var tumorMC:MovieClip = MovieClip(tumor);
        this.tumor = tumorMC.getChildByName("tumor") as MovieClip;
        super(this.tumor);
        arrow1 = new TutorialArrow(tumorMC.getChildByName("arrow1"));
        arrow2 = new TutorialArrow(tumorMC.getChildByName("arrow2"));
        setVisible(false);
        tumorMC.mouseEnabled = false;
    }


    override public function setVisible(value:Boolean):void {
        tumor.visible = value;
        arrow1.getVisual().visible = false; //TODO:
        arrow2.getVisual().visible = value;
    }

    public function showArrows():void {
        arrow1.playOnce();
        arrow2.playOnce();
    }

    public function startTumor():void {
        Ticker.addTickListener(onTick);
    }

    public function setStep(value:uint):void {
        currentStep = value;
    }

    public function reset():void {
        arrow2.getVisual().gotoAndStop(1);
    }

    private function onTick(dt:uint):void {
        framesPassed++;
        tumorMore();

        if (state == InteractiveState.ACTIVE) {
            cure();
        }
    }

    private function cure():void {
        Callback.fire(cureCallback);
        var bottomFrame:uint = getBottomFrame();
        if (tumor.currentFrame <= bottomFrame) {
            return;
        }
        if (tumor.currentFrame > bottomFrame) {
            tumor.gotoAndStop(tumor.currentFrame - 1);
        }
    }

    private function tumorMore():void {
        var framesToSkip:uint = getFramesToSkip();
        if (framesPassed >= framesToSkip) {
            if (tumor.currentFrame < tumor.totalFrames) {
                tumor.gotoAndStop(tumor.currentFrame + 1);
                framesPassed = 0;
            }
        }
    }

    public function addFirstCureCallback(callback:Function):void {
        cureCallback = callback;
    }

    public function removeFirstCureCallback():void {
        cureCallback = null;
    }

    public function setHealthy():void {
        Ticker.removeTickListener(onTick);
        play(new RewindAnimation());
    }

    private function getBottomFrame():uint {
//        return currentStep * 4;
        return 1;
    }

    private function getFramesToSkip():uint {
        //TODO: must be depended to currentSpeed or GameSettings.VEIN_STEP_SECONDS
        return 15;
    }
}
}
