package ru.norobots.trox {
import flash.display.Loader;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.ProgressEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.system.SecurityDomain;

public class AssetLoader extends EventDispatcher {

    private static const PRELOADER_URL:String = "http://www.infernet.ru/flash/trox/preloader.swf";
    private static const MAIN_SWF_URL:String = "http://www.infernet.ru/flash/trox/main.swf";

    private var preloader:MovieClip;
    private var mainView:MovieClip;

    private var loader:URLLoader;

    public function AssetLoader() {

    }

    public function loadPreloader():void {
        loadSWF(PRELOADER_URL, onPreloaderLoaded, false);
    }

    public function loadMain():void {
        loadSWF(MAIN_SWF_URL, onMainSWFLoaded, true);
    }


    private function loadSWF(url:String, handler:Function, dispatchProgress:Boolean):void {
        var request:URLRequest = new URLRequest();
        request.url = url;
        var loader:Loader = new Loader();
        var appDomain:ApplicationDomain = ApplicationDomain.currentDomain;
        var loaderContext:Object = new LoaderContext(true, appDomain, SecurityDomain.currentDomain);
        if (dispatchProgress) {
            loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
        }
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handler);

        if (GameSettings.LOCAL) {
            loader.load(request);
        } else {
            loader.load(request, loaderContext as LoaderContext);
        }
    }

    private function onProgress(event:ProgressEvent):void {
        var progress:Number = event.bytesLoaded / event.bytesTotal;
        dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.ASSET_PROGRESS, progress));
    }

    private function onPreloaderLoaded(event:Event):void {
        preloader = event.target.content;
        dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.PRELOADER_LOADED));
    }

    private function onMainSWFLoaded(event:Event):void {
        mainView  = event.target.content;
        dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.MAIN_ASSET_LOADED));
    }


    private function complete():void {
        dispatchEvent(new Event(Event.INIT));
    }

    public function getMainView():MovieClip {
        return mainView;
    }

    public function getPreloader():MovieClip {
        return preloader;
    }


}
}
