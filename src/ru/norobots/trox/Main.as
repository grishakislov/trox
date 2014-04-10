package ru.norobots.trox {

import flash.display.Sprite;
import flash.display.StageQuality;
import flash.events.Event;

import ru.norobots.trox.controller.AbstractController;
import ru.norobots.trox.controller.ControllerMode;
import ru.norobots.trox.view.ApplicationView;

[SWF(width="800", height="600", frameRate="60", backgroundColor="0xAAAAAA")]
public class Main extends Sprite {

    private var view:ApplicationView;

    public function Main() {
        Ticker.initialize(stage);
        stage.quality = StageQuality.HIGH;
        view = new ApplicationView();
        view.addEventListener(Event.INIT, onInit)
        view.initialize();
        addChild(view);
        stage.scaleMode = "noScale";
        stage.align = "tl";
    }

    private function onInit(event:Event):void {
        var controller:AbstractController = AbstractController.create(view.getViewModel(), ControllerMode.INTRO);
    }
}
}
