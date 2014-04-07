package ru.norobots.trox.view.erythrocyte {
import flash.display.DisplayObject;
import flash.events.TimerEvent;
import flash.utils.Timer;

import ru.norobots.trox.animation.ErythrocyteAnimation;
import ru.norobots.trox.view.BaseView;

public class Erythrocyte extends BaseView {

    private var settings:ParticleSettings;
    private var anim:ErythrocyteAnimation;

    public function Erythrocyte(visual:DisplayObject, settings:ParticleSettings) {
        super(visual);
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
        if (anim != null) {
            anim.clear();
        }
        anim = new ErythrocyteAnimation();
        anim.addMovie(getVisual());
        play(anim);
    }
}
}
