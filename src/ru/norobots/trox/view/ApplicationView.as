package ru.norobots.trox.view {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.utils.ByteArray;

import ru.norobots.trox.Resources;
import ru.norobots.trox.view.controls.Blister;
import ru.norobots.trox.view.controls.Tube;
import ru.norobots.trox.view.end.EndView;
import ru.norobots.trox.view.intro.IntroView;

public class ApplicationView extends Sprite {

    private var intro:IntroView;
    private var end:EndView;
    private var main:MovieClip;
    private var tip:Tip;
    private var bg:MovieClip;
    private var vein:Vein;
    private var blister:Blister;
    private var tube:Tube;
    private var loader:Loader;

    [Embed(source="../../../../../assets/Trox8.swf", mimeType="application/octet-stream")]
    public static const TROX:Class;


    public function initialize():void {
        loader = new Loader();
        var veinMC:ByteArray = new TROX();
        loader.contentLoaderInfo.addEventListener(Event.INIT, loadCompleteListener);
        loader.loadBytes(veinMC);
        mask = new Bitmap(new BitmapData(800, 600));
    }

    public function getViewModel():PlainViewModel {
        var result:PlainViewModel = new PlainViewModel();
        result.appView = this;
        result.intro = intro;
        result.vein = vein;
        result.tip = tip;
        result.cure = vein.getCure();
        result.particles = vein.getParticles();
        result.valves = vein.getValveLayer();
        result.tumor = vein.getTumorLayer();
        result.blister = blister;
        result.tube = tube;
        return result;
    }

    public function attachIntro():void {
        attachBG();
        addChild(intro.getVisual());
        intro.setEnabled(true);
    }

    public function attachEnd():void {
        attachBG();
        addChild(end.getVisual());
        end.setEnabled(true);
    }

    private function attachBG():void {
        addChild(bg);
    }

    public function clear():void {
        tube.setEnabled(false);
        vein.getTumorLayer().setEnabled(false);
        blister.setEnabled(false);
        end.setEnabled(false);
        intro.setEnabled(false);
        removeChildren();
    }

    public function attachGame():void {
        attachBG();

        tip.getVisual().x += 10;
        tip.getVisual().y += 10;
        addChild(tip.getVisual());

        vein.getVein().x = 657;
        vein.getVein().y = 631;
        vein.getVein().rotation = -21.6;
        addChild(vein.getVein())

        vein.getValveLayer().getLayer().x = 990;
        vein.getValveLayer().getLayer().y = 715;
        vein.getValveLayer().getLayer().rotation = -21.6;

        vein.getParticles().getLayer().x = 230;
        vein.getParticles().getLayer().y = 845;
        vein.getParticles().getLayer().rotation = -21.6;

        vein.getCure().getVisual().x = 220;
        vein.getCure().getVisual().y = 855;
        vein.getCure().getVisual().rotation = -3;

        vein.getTumorLayer().getLayer().x = 665;
        vein.getTumorLayer().getLayer().y = 630;

        vein.getTumorLayer().getLayer().rotation = -21.6;

        addChild(vein.getParticles().getLayer());
        addChild(vein.getCure().getVisual());
        addChild(vein.getValveLayer().getLayer());
        addChild(vein.getTumorLayer().getLayer());

        addChild(blister.getVisual());
        addChild(tube.getAll());

        vein.getTumorLayer().setEnabled(true);
        tube.setEnabled(true);
        blister.setEnabled(true);
    }

    private function loadCompleteListener(e:Event):void {
        var mc:MovieClip = MovieClip(loader.content);
        main = MovieClip(mc.getChildByName("main"));
        intro = new IntroView(main.getChildByName("intro"));
        end = new EndView(main.getChildByName("end"));
        bg = MovieClip(main.getChildByName("bg"));
        tip = new Tip(main.getChildByName("tip"));
        vein = new Vein(main.getChildByName("vein_all"));
        blister = new Blister(main.getChildByName("blister"));
        tube = new Tube(main.getChildByName("tube"));

        x = -267;
        y = -356;

        trace("Assets initialized successfully")
        dispatchEvent(new Event(Event.INIT));
    }

    public function getIntro():IntroView {
        return intro;
    }

    public function getEnd():EndView {
        return end;
    }


}
}
