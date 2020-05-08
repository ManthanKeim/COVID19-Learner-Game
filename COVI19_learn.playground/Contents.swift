import PlaygroundSupport
import UIKit

let gc = GameController()
PlaygroundPage.current.liveView = gc


gc.backImage = UIImage(named: "b")!


class LPGR {
    static var counter = 0
    @objc static func longPressed(lp: UILongPressGestureRecognizer) {
        if lp.state == .began {
            gc.quickPeek()
            counter += 1
            print("You peeked \(counter) time(s).")
        }
    }
}

let longPress = UILongPressGestureRecognizer(target: LPGR.self, action: #selector(LPGR.longPressed))
longPress.minimumPressDuration = 2.0
gc.view.addGestureRecognizer(longPress)
