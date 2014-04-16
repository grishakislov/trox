package ru.norobots.trox.view {
import flash.display.DisplayObject;

public class Tip extends BaseView {

    private var gelTip:BaseView;
    private var blisterTip:BaseView;

    public function Tip(visual:DisplayObject) {
        super(visual);
        gelTip = new BaseView(getVisual().getChildByName("tip_gel"));
        blisterTip = new BaseView(getVisual().getChildByName("tip_blister"));
        gelTip.setVisible(false);
        blisterTip.setVisible(false);
    }

    public function showGelTip():void {
        gelTip.setVisible(true);
    }

    public function hideGelTip():void {
        gelTip.setVisible(false);
    }

    public function showBlisterTip():void {
        blisterTip.setVisible(true);
    }

    public function hideBlisterTip():void {
        blisterTip.setVisible(false);
    }
}
}
