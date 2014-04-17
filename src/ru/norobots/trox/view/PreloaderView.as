package ru.norobots.trox.view {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;

public class PreloaderView extends Sprite {

    private var main:MovieClip;
    private var preloader:MovieClip;
    private var txtProgress:TextField;

    public function PreloaderView(mc:MovieClip) {
        main = mc;
        addChild(mc);
        var innerMc:MovieClip = MovieClip(mc.getChildByName("main"));
        preloader = MovieClip(innerMc.getChildByName("preloader"));
        txtProgress = TextField(innerMc.getChildByName("txt_progress"));
        preloader.gotoAndStop(1);
    }

    public function setProgress(value:Number):void {
        var percents:uint = Math.ceil(value * 100);
        preloader.gotoAndStop(percents);
        txtProgress.text = percents + "%";
    }
}
}
