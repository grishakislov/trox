package ru.norobots.trox.view.controls {
import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;

import ru.norobots.trox.animation.OnceAnimation;

public class TroxButton extends InteractiveView{

    private var completeCallback:Function;
    private var anim:OnceAnimation;

    public function TroxButton(visual:DisplayObject) {
        super(visual);
    }

    override protected function onMouseUp(event:MouseEvent):void {
        super.onMouseUp(event);
        if (mouseInside()) {

            if (anim != null) {
                anim.clear();
                getVisual().gotoAndStop(1);
            }

            anim = new OnceAnimation();
            play(anim);

            var timer:Timer = new Timer(500, 1);
            timer.addEventListener(TimerEvent.TIMER, onTimerComplete);
            timer.start();
        }
    }

    private function onTimerComplete(event:TimerEvent):void {
        fireCallback();
    }

    private function fireCallback():void {
        if (completeCallback != null) {
            completeCallback();
        }
    }

    public function addCallback(value:Function):void {
        completeCallback = value;
    }
}
}
