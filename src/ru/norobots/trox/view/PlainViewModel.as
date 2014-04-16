package ru.norobots.trox.view {
import ru.norobots.trox.view.controls.Blister;
import ru.norobots.trox.view.controls.Tube;
import ru.norobots.trox.view.end.EndView;
import ru.norobots.trox.view.erythrocyte.ErythrocyteLayer;
import ru.norobots.trox.view.intro.IntroView;
import ru.norobots.trox.view.tumor.TumorLayer;
import ru.norobots.trox.view.valve.ValveLayer;

public class PlainViewModel {

    public var appView:ApplicationView;
    public var intro:IntroView;
    public var end:EndView;
    public var tip:Tip;
    public var vein:Vein;
    public var particles:ErythrocyteLayer;
    public var valves:ValveLayer;
    public var tumor:TumorLayer;
    public var cure:BaseView;
    public var blister:Blister;
    public var tube:Tube;

}
}
