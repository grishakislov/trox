package ru.norobots.trox.view.tumor {
import flash.display.DisplayObject;

import ru.norobots.trox.view.TutorialArrow;
import ru.norobots.trox.view.controls.InteractiveView;

public class Tumor extends InteractiveView {

    private var arrow1:TutorialArrow;
    private var arrow2:TutorialArrow;

    public function Tumor(tumor:DisplayObject) {
        super(tumor);
        arrow1 = new TutorialArrow(visual.getChildByName("arrow1"));
        arrow2 = new TutorialArrow(visual.getChildByName("arrow2"));
        play();
    }
}
}
