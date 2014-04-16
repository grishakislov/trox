package ru.norobots.trox {

import flash.display.MovieClip;
import flash.display.StageQuality;
import flash.events.Event;

import ru.norobots.trox.controller.AbstractController;
import ru.norobots.trox.controller.ControllerMode;
import ru.norobots.trox.view.ApplicationView;
import ru.norobots.trox.view.PreloaderView;

[SWF(width="800", height="600", frameRate="60", backgroundColor="0xAAAAAA")]
[Frame(factoryClass='ru.norobots.trox.Preloader')]
public class Main extends MovieClip {

    private var view:ApplicationView;
    private var preloader:PreloaderView;

    public function Main(preloader:PreloaderView) {
        this.preloader = preloader;
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function onAddedToStage(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        initialize();
    }

    private function initialize():void {
        stage.quality = StageQuality.HIGH;
        Ticker.initialize(stage);
        view = new ApplicationView();
        view.addEventListener(Event.INIT, onInit)
        view.initialize();

        stage.scaleMode = "noScale";
        stage.align = "tl";
    }

    private function onInit(event:Event):void {
        preloader.parent.removeChild(preloader);
        addChild(view);
        AbstractController.create(view.getViewModel(), ControllerMode.INTRO);
    }

}
}
