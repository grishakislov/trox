package ru.norobots.trox.view.erythrocyte {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;

import ru.norobots.trox.animation.LoopAnimation;
import ru.norobots.trox.view.BaseView;

public class Erythrocyte extends BaseView {

    private var settings:ParticleSettings;

    public function Erythrocyte(visual:DisplayObject, settings:ParticleSettings) {
        super(visual);
        var particleAnimation:MovieClip = getVisual().getChildByName("particle_anim") as MovieClip;
        var anim:LoopAnimation = new LoopAnimation();
        anim.addMovie(particleAnimation);
        anim.run();
        this.settings = settings;
        getVisual().alpha = 0.5;
    }

    public function randomizePosition():void {
        getVisual().gotoAndStop(Math.floor(Math.random() * getVisual().totalFrames));
    }

    public function playDelayed(delayMillis:uint):void {
        if (animation != null) {
            animation.stop();
        }
        var timer:Timer = new Timer(delayMillis, 1);
        timer.addEventListener(TimerEvent.TIMER, onTimerComplete);
        timer.start();
    }

    private function onTimerComplete(event:TimerEvent):void {
        var animation:LoopAnimation = new LoopAnimation();
        animation.addMovie(getVisual());
        play(animation);
    }
}
}
