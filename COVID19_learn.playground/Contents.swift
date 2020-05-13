import PlaygroundSupport
import UIKit

let startg = GameController()
PlaygroundPage.current.liveView = startg


startg.backImage = UIImage(named: "b")!


class longP {
    static var counter = 0
    @objc static func longPressed(lp: UILongPressGestureRecognizer) {
        if lp.state == .began {
            startg.quickPeek()
            counter += 1
        }
    }
}

let longPress = UILongPressGestureRecognizer(target: longP.self, action: #selector(longP.longPressed))
longPress.minimumPressDuration = 2.0
startg.view.addGestureRecognizer(longPress)
