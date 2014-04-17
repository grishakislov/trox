package ru.norobots.trox.view.controls {
import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.ColorTransform;
import flash.utils.Timer;

import ru.norobots.trox.GameSettings;

import ru.norobots.trox.animation.OnceAnimation;

public class TroxButton extends InteractiveView{

    private var completeCallback:Function;
    private var anim:OnceAnimation;
    private var used:Boolean = false;

    public function TroxButton(visual:DisplayObject) {
        super(visual);
        setOut();
    }

    override protected function onMouseMove(event:MouseEvent):void {
        if (!enabled) {
            return;
        }
        super.onMouseMove(event);
        mouseInside() ? setOver() : setOut();
    }

    private function setOver():void {
        getVisual().transform.colorTransform = new ColorTransform(1.1, 1.1, 1.1);
    }

    private function setOut():void {
        getVisual().transform.colorTransform = new ColorTransform(0.9, 0.9, 0.9);
    }

    override protected function onMouseUp(event:MouseEvent):void {
        if (!enabled) {
            return;
        }
        super.onMouseUp(event);
        if (used) {
            return;
        }
        if (mouseInside()) {
            used = true;

            if (anim != null) {
                anim.clear();
                getVisual().gotoAndStop(1);
            }

            anim = new OnceAnimation();
            play(anim);

            var timer:Timer = new Timer(GameSettings.MILLIS_AFTER_BUTTON_CLICK, 1);
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

    public function setUsed(value:Boolean):void {
        used = value;
    }
}
}
