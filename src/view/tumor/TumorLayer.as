package view.tumor {
import flash.display.DisplayObject;

public class TumorLayer {

    public function TumorLayer() {
    }

    public function addTumor(tumor:DisplayObject):void {
        Assert.notNull(tumor);
    }

}
}
