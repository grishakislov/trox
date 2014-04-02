package ru.norobots.trox.view {
import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.utils.ByteArray;

import ru.norobots.trox.Resources;
import ru.norobots.trox.view.controls.Blister;
import ru.norobots.trox.view.controls.Tube;

public class ApplicationView extends Sprite {

    private var main:MovieClip;

    private var vein:Vein;
    private var blister:Blister;
    private var tube:Tube;
    private var loader:Loader;

    public function initialize():void {
        loader = new Loader();
        var veinMC:ByteArray = new Resources.TROX();
        loader.contentLoaderInfo.addEventListener(Event.INIT, loadCompleteListener);
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
        dispatchEvent(new Event(Event.INIT));
    }

    public function getViewModel():PlainViewModel {
        var result:PlainViewModel = new PlainViewModel();
        result.vein = vein;
        result.particles = vein.getParticles();
        result.valves = vein.getValveLayer();
        result.tumor = vein.getTumorLayer();
        result.blister = blister;
        result.tube = tube;
        return result;
    }

    public function getLoader():Loader {
        return loader;
    }
}
}
