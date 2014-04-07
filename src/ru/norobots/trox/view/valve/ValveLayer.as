package ru.norobots.trox.view.valve {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.MovieClip;

import ru.norobots.trox.Assert;

public class ValveLayer {

    private var layer:MovieClip;
    private var valves:Vector.<Valve> = new Vector.<Valve>();

    public function ValveLayer(layer:DisplayObject) {
        this.layer = MovieClip(layer);
        this.layer.gotoAndStop(1);
        initializeChildren();
    }

    private function initializeChildren():void {
        const NUM_VALVES:uint = 6;
        for (var i:int = 1; i <= NUM_VALVES; i++) {
            addValve(layer.getChildByName("valve" + i));
        }
    }

    public function addValve(valve:DisplayObject):void {
        Assert.notNull(valve);
        valves.push(new Valve(valve));
    }

    public function getLayer():DisplayObject {
        return layer;
    }

    public function setIll():void {
        for (var i:int = 0; i < valves.length; i++) {
            valves[i].setIllDelayed();
        }
    }
}
}
