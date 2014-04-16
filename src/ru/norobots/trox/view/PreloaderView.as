package ru.norobots.trox.view {
import flash.display.MovieClip;
import flash.display.Sprite;

public class PreloaderView extends Sprite {

    private var main:MovieClip;
    private var preloader:MovieClip;

    public function PreloaderView(mc:MovieClip) {
        main = mc;
        addChild(mc);
        var innerMc:MovieClip = MovieClip(mc.getChildByName("main"));
        preloader = MovieClip(innerMc.getChildByName("preloader"));
        preloader.gotoAndStop(1);
    }

    public function setProgress(value:Number):void {
        preloader.gotoAndStop(Math.ceil(value * 100));
    }
}
}
