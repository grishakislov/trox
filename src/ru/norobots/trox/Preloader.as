package ru.norobots.trox {
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.ProgressEvent;
import flash.utils.ByteArray;
import flash.utils.getDefinitionByName;

import ru.norobots.trox.view.PreloaderView;

[SWF(width="800", height="600", frameRate="60", backgroundColor="0xAAAAAA")]
public class Preloader extends MovieClip {

    private var view:PreloaderView;

    private var loader:Loader;

    public function Preloader() {
        loader = new Loader();
        var preloaderMC:ByteArray = new Resources.PRELOADER();
        loader.contentLoaderInfo.addEventListener(Event.INIT, preloaderLoadCompleteListener);
        loader.loadBytes(preloaderMC);
    }

    private function preloaderLoadCompleteListener(event:Event):void {
        var mc:MovieClip = MovieClip(loader.content);
        view = new PreloaderView(mc);
        addChild(view);
        this.loaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
        if (this.loaderInfo.bytesLoaded >= this.loaderInfo.bytesTotal) {
            onLoaded();
        }
    }

    private function onProgress(e:ProgressEvent):void {
        var progress:Number = e.bytesLoaded / e.bytesTotal;
        view.setProgress(progress)
        if (progress >= 1.0) {
            this.loaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
            onLoaded();
        }
    }

    private function onLoaded():void {
        removeChild(view);
        nextFrame();
        trace("Preloader")
        view.setProgress(1.0);
        var main:Class = getDefinitionByName("ru.norobots.trox.Main") as Class;
        addChild(new main(view) as DisplayObject);
        addChild(view);
    }

}
}
