package ru.norobots.trox.view.intro {
import flash.display.DisplayObject;
import flash.display.MovieClip;

import ru.norobots.trox.view.BaseView;
import ru.norobots.trox.view.controls.TroxButton;

public class IntroView extends BaseView {

    private var window:MovieClip;
    private var playButton:TroxButton;

    public function IntroView(visual:DisplayObject) {
        super(visual);
        window = MovieClip(getVisual().getChildByName("intro_window"));
        playButton = new TroxButton(window.getChildByName("btn_play"));
    }

    public function getPlayButton():TroxButton {
        return playButton;
    }

    public function setEnabled(value:Boolean):void {
        playButton.setEnabled(value);
    }

}
}
