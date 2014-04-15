package ru.norobots.trox.view.valve {
import flash.display.DisplayObject;
import flash.display.MovieClip;

import ru.norobots.trox.Assert;

public class ValveLayer {

    private var layer:MovieClip;
    private var valves:Vector.<Valve> = new Vector.<Valve>();
    private var illValvesNum:uint = 0;

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
        shuffle();
    }

    private function shuffle():void {
        var shuffledValves:Vector.<Valve> = new Vector.<Valve>();
        var numValves:uint = valves.length;
        var index:uint;
        for (var i:int = 0; i < numValves; i++) {
            index = (valves.length) * Math.random();
            shuffledValves.push(valves.splice(index, 1)[0]);
        }
        valves = shuffledValves;
    }


    public function addValve(valve:DisplayObject):void {
        Assert.notNull(valve);
        valves.push(new Valve(valve));
    }

    public function getLayer():DisplayObject {
        return layer;
    }

    public function illMore():void {
        if (illValvesNum < valves.length) {
            valves[illValvesNum].setIllDelayed();
        }
        illValvesNum++;
    }

    public function setHealthy():void {
        for (var i:int = 0; i < valves.length; i++) {
            valves[i].setHealthy();
        }
    }
}
}
