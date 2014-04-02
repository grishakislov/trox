package ru.norobots.trox.view {
import flash.display.DisplayObject;
import flash.display.MovieClip;

import ru.norobots.trox.Assert;

import ru.norobots.trox.animation.BaseAnimation;
import ru.norobots.trox.animation.TranslationAnimation;

public class BaseView {

    protected var visual:MovieClip;
    protected var animation:BaseAnimation;

    public function BaseView(visual:DisplayObject) {
        Assert.notNull(visual);
        visual.cacheAsBitmap = true;
        this.visual = MovieClip(visual);
        this.visual.gotoAndStop(1);
    }

    public function play(animation:BaseAnimation = null):void {
        if (animation == null) {
            this.animation = new TranslationAnimation();
        } else {
            this.animation = animation;
        }
        this.animation.start(visual);
    }

    public function stop():void {
        animation.stop();
    }

    public function reset():void {

    }

    public function setVisible(value:Boolean):void {
        visual.visible = value;
    }

}
}
