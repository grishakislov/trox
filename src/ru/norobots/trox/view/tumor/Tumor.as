package ru.norobots.trox.view.tumor {
import flash.display.DisplayObject;
import flash.display.MovieClip;

import ru.norobots.trox.Ticker;
import ru.norobots.trox.UIState;
import ru.norobots.trox.view.TutorialArrow;
import ru.norobots.trox.view.controls.InteractiveState;
import ru.norobots.trox.view.controls.InteractiveView;

public class Tumor extends InteractiveView {

    private var tumor:MovieClip;
    private var arrow1:TutorialArrow;
    private var arrow2:TutorialArrow;

    private var currentStep:uint;
    private var framesPassed:uint;

    private var locked:Boolean;

    public function Tumor(tumor:DisplayObject) {
        var tumorMC:MovieClip = MovieClip(tumor);
        this.tumor = tumorMC.getChildByName("tumor") as MovieClip;
        super(this.tumor);
        arrow1 = new TutorialArrow(tumorMC.getChildByName("arrow1"));
        arrow2 = new TutorialArrow(tumorMC.getChildByName("arrow2"));
        setVisible(false);
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

    private function onTick(dt:uint):void {

        framesPassed++;
        tumorMore();

        if (locked || !UIState.tubeSelected) {
            return;
        }

        if (state == InteractiveState.ACTIVE) {
            cure();
        }
    }

    public function lock():void {
        locked = true;
    }

    private function cure():void {
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

    private function getBottomFrame():uint {
        return currentStep * 4;
    }

    private function getFramesToSkip():uint {
        //TODO: must be depended to currentSpeed or GameSettings.VEIN_STEP_SECONDS
        return 15;
    }
}
}
