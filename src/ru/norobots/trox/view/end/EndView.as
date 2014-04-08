package ru.norobots.trox.view.end {
import flash.display.DisplayObject;
import flash.display.MovieClip;

import ru.norobots.trox.view.BaseView;
import ru.norobots.trox.view.controls.TroxButton;

public class EndView extends BaseView {

    private var window:MovieClip;
    private var replayButton:TroxButton;

    public function EndView(visual:DisplayObject) {
        super(visual);
        window = MovieClip(getVisual().getChildByName("end_window"));
        replayButton = new TroxButton(window.getChildByName("btn_replay"));
    }

    public function getReplayButton():TroxButton {
        return replayButton;
    }

    public function setEnabled(value:Boolean):void {
        replayButton.setEnabled(false);
    }


}
}
