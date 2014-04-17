package ru.norobots.trox.view {
import flash.display.DisplayObject;

import ru.norobots.trox.animation.OnceAnimation;

public class Tip extends BaseView {

    private var gelTip:BaseView;
    private var blisterTip:BaseView;

    public function Tip(visual:DisplayObject) {
        super(visual);
        gelTip = new BaseView(getVisual().getChildByName("tip_gel"));
        blisterTip = new BaseView(getVisual().getChildByName("tip_blister"));
        gelTip.setVisible(false);
        gelTip.getVisual().gotoAndStop(1);
        blisterTip.setVisible(false);
        blisterTip.getVisual().gotoAndStop(1);
    }

    public function showGelTip():void {
        gelTip.setVisible(true);
        gelTip.getVisual().gotoAndStop(1);
        var anim:OnceAnimation = new OnceAnimation();
        anim.addCompleteCallback(onGelAnimCompleted);
        gelTip.play(anim);
    }

    public function showBlisterTip():void {
        blisterTip.setVisible(true);
        blisterTip.getVisual().gotoAndStop(1);
        var anim:OnceAnimation = new OnceAnimation();
        anim.addCompleteCallback(onBlisterAnimCompleted);
        blisterTip.play(anim);
    }

    private function onGelAnimCompleted():void {
        gelTip.setVisible(false);
    }

    private function onBlisterAnimCompleted():void {
        blisterTip.setVisible(false);
    }

}
}
