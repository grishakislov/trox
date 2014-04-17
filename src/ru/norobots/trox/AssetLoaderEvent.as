package ru.norobots.trox {
import flash.events.Event;

public class AssetLoaderEvent extends Event {

    public static const PRELOADER_LOADED:String = "preloader_loaded";
    public static const MAIN_ASSET_LOADED:String = "main_asset_loaded";
    public static const ASSET_PROGRESS:String = "main_asset_progress";

    private var progress:Number;

    public function AssetLoaderEvent(type:String, progress:Number = 0.0) {
        super(type);
        this.progress = progress;
    }

    public function getProgress():Number {
        return progress;
    }
}
}
