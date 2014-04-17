package ru.norobots.trox.view {
import flash.display.DisplayObject;

import ru.norobots.trox.animation.ShiningAnimation;

public class Shining extends BaseView {

    private var anim:ShiningAnimation;

    public function Shining(visual:DisplayObject) {
        super(visual);
        getVisual().gotoAndPlay(1);
        anim = new ShiningAnimation();
        play(anim);
    }

    public function show():void {
        anim.show();
    }

    public function hide():void {
        anim.hide();
    }

    override public function setVisible(value:Boolean):void {
        getVisual().alpha = value ? 1.0 : 0.0;
    }
}
}
