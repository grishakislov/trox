package ru.norobots.trox.view.valve {
import flash.display.DisplayObject;

import ru.norobots.trox.Assert;

public class ValveLayer {

    private var valves:Vector.<Valve> = new Vector.<Valve>();

    public function ValveLayer() {
    }

    public function addValve(valve:DisplayObject):void {
        Assert.notNull(valve);
        valves.push(new Valve(valve));
    }
}
}