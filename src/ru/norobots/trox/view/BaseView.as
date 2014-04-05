package ru.norobots.trox.view {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.MovieClip;

import ru.norobots.trox.Assert;

import ru.norobots.trox.animation.BaseAnimation;
import ru.norobots.trox.animation.TranslationAnimation;

public class BaseView {

    private var visual:MovieClip;
    protected var animation:BaseAnimation;

    public function BaseView(visual:DisplayObject) {
        Assert.notNull(visual);
        this.visual = MovieClip(visual);
        this.visual.gotoAndStop(1);
    }

    public function play(animation:BaseAnimation = null):void {
        if (animation == null) {
            this.animation = new TranslationAnimation();
        } else {
            if (this.animation != null) {
                this.animation.clear();
            }
            this.animation = animation;
        }
        this.animation.addMovie(visual);
        this.animation.run();
    }

    public function stop():void {
        animation.clear();
    }

    public function reset():void {

    }

    public function setVisible(value:Boolean):void {
        visual.visible = value;
    }

    public function getVisual():MovieClip {
        return visual;
    }
}
}
