package ru.norobots.trox.view {
import flash.display.DisplayObject;

import ru.norobots.trox.animation.LoopAnimation;
import ru.norobots.trox.animation.OnceAnimation;

public class TutorialArrow extends BaseView {

    public function TutorialArrow(visual:DisplayObject) {
        super(visual);
    }

    public function playOnce():void {
        var anim:OnceAnimation = new OnceAnimation();
        anim.addMovie(getVisual());
        anim.addCompleteCallback(onOnceAnimCompleted);
        play(anim);
    }

    private function onOnceAnimCompleted():void {
        getVisual().visible = false;
    }

    public function playLooped():void {
        var anim:LoopAnimation = new LoopAnimation();
        anim.addMovie(getVisual());
        play(anim);
    }
}
}
