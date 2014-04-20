package ru.norobots.trox.view {
import flash.display.DisplayObject;

import ru.norobots.trox.animation.OnceAnimation;

public class Tip extends BaseView {

    private var gelTip:BaseView;
    private var blisterTip:BaseView;
    private static var STOP_FRAME:uint = 180;

    private var gelAnimation:OnceAnimation;
    private var blisterAnimation:OnceAnimation;

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
        gelAnimation = new OnceAnimation();
        gelAnimation.addFrameHandler(STOP_FRAME, gelFrameHandler);
        gelAnimation.addCompleteCallback(onGelAnimCompleted);
        gelTip.play(gelAnimation);
    }

    private function gelFrameHandler():void {
        gelTip.getAnimation().stop();
    }

    public function showBlisterTip():void {
        blisterTip.setVisible(true);
        blisterTip.getVisual().gotoAndStop(1);
        blisterAnimation = new OnceAnimation();
        blisterAnimation.addFrameHandler(STOP_FRAME, blisterFrameHandler);
        blisterAnimation.addCompleteCallback(onBlisterAnimCompleted);
        blisterTip.play(blisterAnimation);
    }

    private function blisterFrameHandler():void {
        blisterTip.getAnimation().stop();
    }

    private function onGelAnimCompleted():void {
        gelTip.setVisible(false);
    }

    private function onBlisterAnimCompleted():void {
        blisterTip.setVisible(false);
    }

    public function resumeGelHiding():void {
        gelAnimation.removeFrameHandler();
        gelAnimation.resume();
    }

    public function resumeBlisterHiding():void {
        blisterAnimation.removeFrameHandler();
        blisterAnimation.resume();
    }
}
}
