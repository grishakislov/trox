package ru.norobots.trox.view {
import flash.display.DisplayObject;

import ru.norobots.trox.animation.GlowAnimation;

public class Glow extends BaseView {

    private var anim:GlowAnimation;

    public function Glow(visual:DisplayObject) {
        super(visual);
        anim = new GlowAnimation();
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
