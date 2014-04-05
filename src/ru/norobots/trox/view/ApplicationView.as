package ru.norobots.trox.view {
import flash.display.DisplayObject;
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
    private var bg:MovieClip;

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
        bg = MovieClip(main.getChildByName("bg"));
        vein = new Vein(main.getChildByName("vein_all"));
        blister = new Blister(main.getChildByName("blister"));
        tube = new Tube(main.getChildByName("tube"));

        createScene();

        trace("Assets initialized successfully")
        dispatchEvent(new Event(Event.INIT));
    }

    private function createScene():void {
        x = -267;
        y = -356;
        addChild(bg);

        vein.getVein().y = 631;
        vein.getVein().x = 660;

        addChild(vein.getVein())

        vein.getValveLayer().getLayer().x = 925;
        vein.getValveLayer().getLayer().y = 830;

        vein.getParticles().getLayer().x = 200;
        vein.getParticles().getLayer().y = 680;

        vein.getTumorLayer().getLayer().x = 660;
        vein.getTumorLayer().getLayer().y = 633;

        addChild(vein.getParticles().getLayer());
        addChild(vein.getValveLayer().getLayer());
        addChild(vein.getTumorLayer().getLayer());
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
