import UIKit
import XCPlayground
import GameplayKit
import AVFoundation


public extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else {
            return nil
        }
        self.init(cgImage: cgImage)
    }
}




let cardWidth = CGFloat(120)
let cardHeight = CGFloat(141)

public class Card: UIImageView {
    public let x: Int
    public let y: Int
    public init(image: UIImage?, x: Int, y: Int) {
        self.x = x
        self.y = y
        super.init(image: image)
        self.backgroundColor = .white
        self.layer.cornerRadius = 10.0
        self.isUserInteractionEnabled = true
        
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


public class GameController: UIViewController {

    
    public var padding = CGFloat(20) {
        didSet {
            resetGrid()
        }
    }

    public var backImage: UIImage = UIImage(
        color: .red,
        size: CGSize(width: cardWidth, height: cardHeight))!

    var viewWidth: CGFloat {
        get {
            return 4 * cardWidth + 5 * padding
        }
    }

    var viewHeight: CGFloat {
        get {
            return 4 * cardHeight + 5 * padding
        }
    }

    var shuffledNumbers = [Int]()

    var firstCard: Card?
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        preferredContentSize = CGSize(width: viewWidth, height: viewHeight)
//        title3.text = "Welcome to COVID-19 LEARNING APP"
//        title3.textColor = UIColor.white
//        title3.font = UIFont(name:"Futura", size: 40)
//        title3.font = UIFont.boldSystemFont(ofSize: 20.0)
//        self.view.addSubview(title3)
//
//
//        let button2 = UIButton(frame: CGRect(x: 150, y: 400, width: 100, height: 50))
//        button2.backgroundColor = UIColor(hue: 0.4861, saturation: 1, brightness: 0.77, alpha: 1.0)
//          button2.setTitle("Start Game", for: .normal)
//          button2.addTarget(self, action: #selector(buttonAction2), for: .touchUpInside)
//          self.view.addSubview(button2)
    }
    
    
    @objc func buttonAction2(sender: UIButton!) {
        start_game()
        sender.isHidden = true
        title3.isHidden = true
        title4.isHidden = true
        title5.isHidden = true
    }
    
    
    
    func start_game(){
        
        preferredContentSize = CGSize(width: viewWidth, height: viewHeight)
        shuffle()
        setupGrid()
        for v in view.subviews {
            if let card = v as? Card {
                UIView.transition(
                    with: card,
                    duration: 1.0,
                    options: .transitionFlipFromLeft,
                    animations: {
                        card.image =  self.backImage
                }, completion: nil)
            }
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(GameController.handleTap(gr:)))
        view.addGestureRecognizer(tap)
        
        quickPeek()
        
        view.addSubview(label)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {
        view = UIView()
        view.backgroundColor = .black
        view.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
    }

    
    func shuffle() {
        let numbers = (1...8).flatMap{[$0, $0]}
        shuffledNumbers =
            GKRandomSource.sharedRandom().arrayByShufflingObjects(in: numbers) as! [Int]

    }

    
    func cardNumberAt(x: Int, _ y: Int) -> Int {
        assert(0 <= x && x < 4 && 0 <= y && y < 4)

        return shuffledNumbers[4 * x + y]
    }
   
    func centerOfCardAt(x: Int, _ y: Int) -> CGPoint {
        assert(0 <= x && x < 4 && 0 <= y && y < 4)
        let (w, h) = (cardWidth + padding, cardHeight + padding)
        return CGPoint(
            x: CGFloat(x) * w + w/2 + padding/2,
            y: CGFloat(y) * h + h/2 + padding/2)

    }

    
    func setupGrid() {
        for i in 0..<4 {
            for j in 0..<4 {
                let n = cardNumberAt(x: i, j)
                let card = Card(image: UIImage(named: String(n)), x: i, y: j)
                card.tag = n
                card.center = centerOfCardAt(x: i, j)
                view.addSubview(card)
            }
        }
    }

    
    func resetGrid() {
        view.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
        for v in view.subviews {
            if let card = v as? Card {
                card.center = centerOfCardAt(x: card.x, card.y)
            }
        }
        
    }
    var counter_c = 0
    var counter_a = 0
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 500, height: 200))
    let title3 = UILabel(frame: CGRect(x: 50, y: 100, width: 500, height: 150))
    let title4 = UILabel(frame: CGRect(x: 50, y: 350, width: 500, height: 200))
    let title5 = UILabel(frame: CGRect(x: 50, y: 450, width: 500, height: 200))
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        label.center = CGPoint(x: 200, y: 10)
//        label.textAlignment = .center
//        label.textColor = UIColor.white
//        label.text = "COVID-19 Prevention: Play to Learn, Total Flips: " + String(counter_a)
//        view.addSubview(label)
//        for v in view.subviews {
//            if let card = v as? Card {
//                UIView.transition(
//                    with: card,
//                    duration: 1.0,
//                    options: .transitionFlipFromLeft,
//                    animations: {
//                        card.image =  self.backImage
//                }, completion: nil)
//            }
//        }
        
        
        title3.text = "Welcome to COVID-19 LEARNING APP"
        title3.textColor = UIColor(red: 0.99, green: 0.80, blue: 0.00, alpha: 1.00)
        title3.font = UIFont(name:"Futura", size: 40)
        title3.font = UIFont.boldSystemFont(ofSize: 40)
        title3.textAlignment = NSTextAlignment.center
//        title3.sizeToFit()
        title3.numberOfLines = 0
        self.view.addSubview(title3)
        
        title4.text = "Rule: Start with turning two cards, if they match, you're good if not take another chance. once all the cards are disappeared, you win. Try to do it with least flips possible. Good Luck and Stay Home, Stay Safe. Hint: Long press for 2 seconds to Peek"
        title4.textColor = UIColor.white
//        title4.sizeToFit()
        title4.numberOfLines = 5
        title4.textAlignment = NSTextAlignment.center
        self.view.addSubview(title4)
        
        title5.text = "!!!!Play to Unlock some Tips!!!!!"
                title5.textColor = UIColor(red: 0.16, green: 0.64, blue: 0.21, alpha: 1.00)
        //        title4.sizeToFit()
                title5.numberOfLines = 0
                title5.textAlignment = NSTextAlignment.center
                self.view.addSubview(title5)
        
        
        let button2 = UIButton(frame: CGRect(x: 200, y: 300, width: 200, height: 50))
        button2.backgroundColor = UIColor(red: 0.07, green: 0.45, blue: 0.87, alpha: 1.00)
          button2.setTitle("Play to Learn", for: .normal)
          button2.addTarget(self, action: #selector(buttonAction2), for: .touchUpInside)
          self.view.addSubview(button2)
        
    }

    @objc func handleTap(gr: UITapGestureRecognizer) {
        let v = view.hitTest(gr.location(in: view), with: nil)!
        if let card = v as? Card {
            counter_a+=1
            playSound()
            label.center = CGPoint(x: 200, y: 10)
                label.textAlignment = .center
            label.font = UIFont(name: "BPreplay", size: 20)
            if(counter_a<=20){
                label.textColor = UIColor.green}
                    else if(counter_a>20 && counter_a<40){
                        label.textColor = UIColor.orange}
                    else{
                        label.textColor = UIColor.red
                
//                let alert_again = UIAlertController(title: "!!ALERT!!", message: "You've exceeded the number of flips than usuaul.", preferredStyle: UIAlertController.Style.alert)
//
//               
//                alert_again.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
//                alert_again.addAction(UIAlertAction(title: "Reset Game", style: UIAlertAction.Style.cancel, handler:{ action in
//                    self.reset_game()}))
//
//                
//                self.present(alert_again, animated: true, completion: nil)
//                
//                
                
                
            }
//                    label.textColor = UIColor(red: 0.16, green: 0.64, blue: 0.21, alpha: 1.00)
            label.text = "COVID-19 Prevention: Play to Learn, Total Flips: " + String(counter_a)
            print(counter_a)
            UIView.transition(
                with: card, duration: 0.5,
                options: .transitionFlipFromLeft,
                animations: {card.image = UIImage(named: String(card.tag))}) { // trailing completion handler:
                    _ in
                    card.isUserInteractionEnabled = false
                    
                    if let pCard = self.firstCard {
                        if pCard.tag == card.tag {
                            self.playSound2()
                            self.counter_c+=2
                            switch self.counter_c {
                            case 2:
                                let alert = UIAlertController(title: "COVID Preventive Measure", message: "Clean your hands often. Use soap and water, or an alcohol-based hand rub.", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "I WILL FOLLOW THIS", style: UIAlertAction.Style.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            case 4:
                                let alert = UIAlertController(title: "COVID Preventive Measure", message: "Maintain a safe distance from anyone who is coughing or sneezing.", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "I WILL FOLLOW THIS", style: UIAlertAction.Style.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            case 6:
                                let alert = UIAlertController(title: "COVID Preventive Measure", message: "Don’t touch your eyes, nose or mouth.", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "I WILL FOLLOW THIS", style: UIAlertAction.Style.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            case 8:
                                let alert = UIAlertController(title: "COVID Preventive Measure", message: "Cover your nose and mouth with your bent elbow or a tissue when you cough or sneeze.", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "I WILL FOLLOW THIS", style: UIAlertAction.Style.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            case 10:
                                let alert = UIAlertController(title: "COVID Preventive Measure", message: "Stay home if you feel unwell.", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "I WILL FOLLOW THIS", style: UIAlertAction.Style.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            case 12:
                                let alert = UIAlertController(title: "COVID Preventive Measure", message: "If you have a fever, cough and difficulty breathing, seek medical attention. Call in advance.", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "I WILL FOLLOW THIS", style: UIAlertAction.Style.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            case 14:
                                let alert = UIAlertController(title: "COVID Preventive Measure", message: "Follow the directions of your local health authority.", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "I WILL FOLLOW THIS", style: UIAlertAction.Style.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            case 16:
                                let alert = UIAlertController(title: "COVID Preventive Measure", message: "Avoiding unneeded visits to medical facilities allows healthcare systems to operate more effectively, therefore protecting you and others.", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "I WILL FOLLOW THIS", style: UIAlertAction.Style.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            default:
                                let alert = UIAlertController(title: "COVID Preventive Measure", message: "!!!!PLEASE STAY SAFE AT HOME!!!!!", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "I WILL FOLLOW THIS", style: UIAlertAction.Style.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            }
                            if(self.counter_c==16){
                                self.complete_game()
                            }
                            self.label.text = "Got " + String(self.counter_c/2) + " Tip at " + String(self.counter_a) + " flip"
                            UIView.animate(
                                withDuration: 0.5,
                                animations: {card.alpha = 0.0},
                                completion: {_ in card.removeFromSuperview()})
                            UIView.animate(
                                withDuration: 0.5,
                                animations: {pCard.alpha = 0.0},
                                completion: {_ in pCard.removeFromSuperview()})
                        
                        } else {
                            self.label.text = "COVID-19 Prevention: Play to Learn, Total Flips: " + String(self.counter_a)
                            UIView.transition(
                                with: card,
                                duration: 0.5,
                                options: .transitionFlipFromLeft,
                                animations: {card.image = self.backImage})
                            { _ in card.isUserInteractionEnabled = true }
                            UIView.transition(
                                with: pCard,
                                duration: 0.5,
                                options: .transitionFlipFromLeft,
                                animations: {pCard.image = self.backImage})
                            { _ in pCard.isUserInteractionEnabled = true }
                        }
                        self.firstCard = nil
                    } else {
                        self.firstCard = card
                    }
            }
        }
    }

    public func quickPeek() {
        for v in view.subviews {
            if let card = v as? Card {
                card.isUserInteractionEnabled = false
                UIView.transition(with: card, duration: 1.0, options: .transitionFlipFromLeft, animations: {card.image =  UIImage(named: String(card.tag))}) {
                    _ in
                    UIView.transition(with: card, duration: 1.0, options: .transitionFlipFromLeft, animations: {card.image =  self.backImage}) {
                        _ in
                        card.isUserInteractionEnabled = true
                    }

                }
            }
        }
    }
    let title2 = UILabel(frame: CGRect(x: 50, y: 400, width: 500, height: 50))
    func complete_game(){
        if(counter_a<=30){
            title2.numberOfLines = 0
            title2.textAlignment = NSTextAlignment.center
            title2.text = "That was amazing, you completed in " + String(counter_a) + " flips."
            title2.backgroundColor = UIColor.green
            self.view.addSubview(title2)
        }
        else if(counter_a>30 && counter_a<50)
        {
            title2.numberOfLines = 0
            title2.textAlignment = NSTextAlignment.center
            title2.text = "That was Good, you completed in " + String(counter_a) + " flips.You can do better!!!!"
            title2.backgroundColor = UIColor.orange
            self.view.addSubview(title2)
        }
        else{
            title2.numberOfLines = 0
            title2.textAlignment = NSTextAlignment.center
        title2.text = "Not Good!!! You completed in " + String(counter_a) + " flips.You can do better!!!!"
        title2.backgroundColor = UIColor.red
        self.view.addSubview(title2)
        }
        
        
        let button = UIButton(frame: CGRect(x: 250, y: 200, width: 100, height: 50))
        button.backgroundColor = UIColor(hue: 0.4861, saturation: 1, brightness: 0.77, alpha: 1.0)
          button.setTitle("Play Again", for: .normal)
          button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
          self.view.addSubview(button)
        }

    

@objc func buttonAction(sender: UIButton!) {
    preferredContentSize = CGSize(width: viewWidth, height: viewHeight)
    shuffle()
    setupGrid()
    for v in view.subviews {
        if let card = v as? Card {
            UIView.transition(
                with: card,
                duration: 1.0,
                options: .transitionFlipFromLeft,
                animations: {
                    card.image =  self.backImage
            }, completion: nil)
        }
    }
    let tap = UITapGestureRecognizer(target: self, action: #selector(GameController.handleTap(gr:)))
    view.addGestureRecognizer(tap)
    counter_c = 0
    counter_a = 0
    quickPeek()
    sender.isHidden = true
    title2.isHidden = true
}
    
    
    func reset_game(){
        resetGrid()
        preferredContentSize = CGSize(width: viewWidth, height: viewHeight)
        shuffle()
        setupGrid()
        for v in view.subviews {
            if let card = v as? Card {
                UIView.transition(
                    with: card,
                    duration: 1.0,
                    options: .transitionFlipFromLeft,
                    animations: {
                        card.image =  self.backImage
                }, completion: nil)
            }
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(GameController.handleTap(gr:)))
        view.addGestureRecognizer(tap)
        counter_c = 0
        counter_a = 0
        quickPeek()
    }
    
    
    var player: AVAudioPlayer?
    

    func playSound() {
        guard let url = Bundle.main.url(forResource: "soundName", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

           

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    var player2: AVAudioPlayer?
    func playSound2() {
        guard let url = Bundle.main.url(forResource: "soundName2", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            
            player2 = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            

            guard let player2 = player2 else { return }

            player2.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
