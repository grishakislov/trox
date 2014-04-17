package ru.norobots.trox {

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.StageQuality;
import flash.events.Event;
import flash.events.MouseEvent;

import ru.norobots.trox.controller.AbstractController;
import ru.norobots.trox.controller.ControllerMode;
import ru.norobots.trox.view.ApplicationView;
import ru.norobots.trox.view.PreloaderView;

[SWF(width="800", height="600", frameRate="60", backgroundColor="0xAAAAAA")]
public class Main extends Sprite {

    private var view:ApplicationView;
    private var assetLoader:AssetLoader;
    private var preloader:PreloaderView;

    public function Main() {
        instance = this;
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function onAddedToStage(event:Event):void {

        stage.quality = StageQuality.HIGH;
        Ticker.initialize(stage);
        stage.scaleMode = "noScale";
        stage.align = "tl";

        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

        assetLoader = new AssetLoader();
        assetLoader.addEventListener(AssetLoaderEvent.PRELOADER_LOADED, onPreloaderLoaded);
        assetLoader.loadPreloader();
    }

    private function onPreloaderLoaded(event:AssetLoaderEvent):void {
        assetLoader.removeEventListener(AssetLoaderEvent.PRELOADER_LOADED, onPreloaderLoaded);
        preloader = new PreloaderView(assetLoader.getPreloader());
        addChild(preloader)
        assetLoader.addEventListener(AssetLoaderEvent.ASSET_PROGRESS, onProgress);
        assetLoader.addEventListener(AssetLoaderEvent.MAIN_ASSET_LOADED, onMainAssetLoaded);
        assetLoader.loadMain();
    }

    private function onProgress(event:AssetLoaderEvent):void {
        preloader.setProgress(event.getProgress())
    }

    private function onMainAssetLoaded(event:Event):void {
        assetLoader.removeEventListener(AssetLoaderEvent.ASSET_PROGRESS, onProgress);
        assetLoader.removeEventListener(AssetLoaderEvent.MAIN_ASSET_LOADED, onMainAssetLoaded);
        removeChild(preloader)
        initialize();
    }

    private function initialize():void {
        view = new ApplicationView();

        view.initialize(assetLoader.getMainView());
        addChild(view);

        AbstractController.create(view.getViewModel(), ControllerMode.INTRO);
    }

    public function getView():ApplicationView {
        return view;
    }

    private static var instance:Main;

    public static function getInstance():Main {
        return instance;
    }
}
}
