package view {
import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.utils.ByteArray;

import view.controls.Blister;
import view.controls.Tube;

public class ApplicationView extends Sprite {

    private var main:MovieClip;

    private var vein:Vein;
    private var blister:Blister;
    private var tube:Tube;
    private var loader:Loader;

    public function ApplicationView() {
        var veinMC:ByteArray = new Resources.TROX();
        loader = new Loader();
        loader.contentLoaderInfo.addEventListener(Event.INIT, loadCompleteListener, false, 0, true);
        loader.loadBytes(veinMC);
    }

    private function loadCompleteListener(e:Event):void {
        var mc:MovieClip = MovieClip(loader.content);
        main = MovieClip(mc.getChildByName("main"));
        vein = new Vein(main.getChildByName("vein"));
        blister = new Blister(main.getChildByName("blister"));
        tube = new Tube(main.getChildByName("tube"));
        addChild(mc);
        trace("Assets initialized successfully")
    }
}
}
