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

    public function getViewModel():PlainViewModel {
        var result:PlainViewModel = new PlainViewModel();
        result.vein = vein;
        result.cure = vein.getCureLayer();
        result.particles = vein.getParticles();
        result.valves = vein.getValveLayer();
        result.tumor = vein.getTumorLayer();
        result.blister = blister;
        result.tube = tube;
        return result;
    }

    private function createScene():void {
        x = -267;
        y = -356;
        addChild(bg);

        vein.getVein().x = 657;
        vein.getVein().y = 631;
        vein.getVein().rotation = -21.6;
        addChild(vein.getVein())

        vein.getValveLayer().getLayer().x = 995;
        vein.getValveLayer().getLayer().y = 715;
        vein.getValveLayer().getLayer().rotation = -21.6;

        vein.getParticles().getLayer().x = 230;
        vein.getParticles().getLayer().y = 845;
        vein.getParticles().getLayer().rotation = -21.6;

        vein.getCureLayer().getLayer().x = 220;
        vein.getCureLayer().getLayer().y = 845;
        vein.getCureLayer().getLayer().rotation = -21.6;

        vein.getTumorLayer().getLayer().x = 665;
        vein.getTumorLayer().getLayer().y = 630;

        vein.getTumorLayer().getLayer().rotation = -21.6;

        addChild(vein.getParticles().getLayer());
        addChild(vein.getCureLayer().getLayer());
        addChild(vein.getValveLayer().getLayer());
        addChild(vein.getTumorLayer().getLayer());

        addChild(blister.getVisual());
        addChild(tube.getAll());
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

}
}
