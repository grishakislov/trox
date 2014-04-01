package ru.norobots.trox {

import flash.display.Sprite;
import flash.text.TextField;

import ru.norobots.trox.view.ApplicationView;

[SWF(width="800", height="600", frameRate="50", backgroundColor="0xAAAAAA")]
public class Trox extends Sprite {
    public function Trox() {
        Ticker.initialize(stage);


        var textField:TextField = new TextField();
        textField.text = "Trox preview";

//        addChild(textField);

        var view:ApplicationView = new ApplicationView();
        addChild(view);
    }
}
}
