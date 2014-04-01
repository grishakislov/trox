package ru.norobots.trox.view {
import flash.display.DisplayObject;
import flash.display.MovieClip;

import ru.norobots.trox.Ticker;

public class ViewBase {

    protected var visual:MovieClip;
    protected var animationType:AnimationType;

    //Animation
    private var forward:Boolean = true;

    public function ViewBase(visual:DisplayObject) {
        this.visual = MovieClip(visual);
        this.visual.gotoAndStop(1);
    }

    public function play(type:AnimationType = null):void {
        if (type == null) {
            this.animationType = AnimationType.TRANSLATION;
        } else {
            this.animationType = animationType;
        }
        Ticker.addTickListener(onTick);
    }

    public function stop():void {
        Ticker.removeTickListener(onTick);
    }

    public function reset():void {

    }

    protected function onTick(dt:int):void {
        switch (animationType.getType()) {
            case AnimationType.LOOPED.getType():
                handleLoopedAnimation();
                break;
            case AnimationType.TRANSLATION.getType():
                handleTranslationAnimation();
                break;
            case AnimationType.ONCE.getType():
                handleOnceAnimation();
                break;
        }
    }

    private function handleLoopedAnimation():void {

    }

    private function handleTranslationAnimation():void {
        if (visual.currentFrame <= 1) {
            forward = true;
        }

        if (visual.currentFrame >= visual.totalFrames) {
            forward = false;
        }

        var currentFrame:int = visual.currentFrame;
        var frame:int = forward ? currentFrame + 1 : currentFrame - 1;
        visual.gotoAndStop(frame);
    }

    private function handleOnceAnimation():void {

    }


}
}
