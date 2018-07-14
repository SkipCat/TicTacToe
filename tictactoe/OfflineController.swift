import Foundation
import UIKit

class OfflineController: UIViewController {
    
    var values: Array<String> = ["", "", "", "", "", "", "", "", ""]
    var playerTurn: String = "X"
    
    @IBOutlet weak var WinnerText: UILabel!
    
    @IBOutlet weak var bt0: UIButton!
    @IBOutlet weak var bt1: UIButton!
    @IBOutlet weak var bt2: UIButton!
    @IBOutlet weak var bt3: UIButton!
    @IBOutlet weak var bt4: UIButton!
    @IBOutlet weak var bt5: UIButton!
    @IBOutlet weak var bt6: UIButton!
    @IBOutlet weak var bt7: UIButton!
    @IBOutlet weak var bt8: UIButton!
    
    let defaults: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        bt0.setTitleColor(UIColor.clear, for: .normal)
        bt1.setTitleColor(UIColor.clear, for: .normal)
        bt2.setTitleColor(UIColor.clear, for: .normal)
        bt3.setTitleColor(UIColor.clear, for: .normal)
        bt4.setTitleColor(UIColor.clear, for: .normal)
        bt5.setTitleColor(UIColor.clear, for: .normal)
        bt6.setTitleColor(UIColor.clear, for: .normal)
        bt7.setTitleColor(UIColor.clear, for: .normal)
        bt8.setTitleColor(UIColor.clear, for: .normal)
 */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func restartAction(_ sender: UIButton) {
        self.values = ["", "", "", "", "", "", "", "", ""]
        self.playerTurn = "X"
        
        bt0.setTitle("Button", for: .normal)
        bt1.setTitle("Button", for: .normal)
        bt2.setTitle("Button", for: .normal)
        bt3.setTitle("Button", for: .normal)
        bt4.setTitle("Button", for: .normal)
        bt5.setTitle("Button", for: .normal)
        bt6.setTitle("Button", for: .normal)
        bt7.setTitle("Button", for: .normal)
        bt8.setTitle("Button", for: .normal)
        
        self.WinnerText.text = "Player \(self.playerTurn) turn"
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleClick(_ sender: UIButton) {
        
        //let btnImageName = (self.playerTurn == "X" ? "cross-flat.png" : "circle-flat.png")
        //sender.setImage(UIImage(named: btnImageName), for: .normal)
        
        //sender.imageEdgeInsets = UIEdgeInsetsMake(25,25,25,25)
        //sender.imageView?.contentMode = .scaleToFill
        //sender.imageView?.semanticContentAttribute = .forceLeftToRight
        //[sender sizeToFit];
        //sender.titleEdgeInsets = UIEdgeInsetsMake(0, -(sender.imageView?.frame.size.width)!, 0, (sender.imageView?.frame.size.width)!);
        //sender.imageEdgeInsets = UIEdgeInsetsMake(0, (sender.titleLabel?.frame.size.width)!, 0, -(sender.titleLabel?.frame.size.width)!);
        
        sender.setTitle(String(self.playerTurn), for: .normal)
        sender.isEnabled = false
        
        self.values[sender.tag] = self.playerTurn
        
        if (
            (self.values[0] != "" && self.values[0] == self.values[1] && self.values[1] == self.values[2]) ||
                (self.values[3] != "" && self.values[3] == self.values[4] && self.values[4] == self.values[5]) ||
                (self.values[6] != "" && self.values[6] == self.values[7] && self.values[7] == self.values[8]) ||
                (self.values[0] != "" && self.values[0] == self.values[3] && self.values[3] == self.values[6]) ||
                (self.values[1] != "" && self.values[1] == self.values[4] && self.values[4] == self.values[7]) ||
                (self.values[2] != "" && self.values[2] == self.values[5] && self.values[5] == self.values[8]) ||
                (self.values[0] != "" && self.values[0] == self.values[4] && self.values[4] == self.values[8]) ||
                (self.values[2] != "" && self.values[2] == self.values[4] && self.values[4] == self.values[6])
            ) {
            self.WinnerText.text = "\(self.playerTurn) won the game"
            
            if var opened: Array<String> = defaults.array(forKey: "offlineWinHistory") as! Array<String>? {
                opened.append(self.playerTurn)
                defaults.set(opened, forKey: "offlineWinHistory")
            } else {
                defaults.set([self.playerTurn], forKey: "offlineWinHistory")
            }
            
        } else if (!self.values.contains("")) {
            self.WinnerText.text = "NO WINNER"
            
            if var opened: Array<String> = defaults.array(forKey: "offlineWinHistory") as! Array<String>? {
                opened.append("")
                defaults.set(opened, forKey: "offlineWinHistory")
            } else {
                defaults.set([""], forKey: "offlineWinHistory")
            }
            
        } else {
            self.playerTurn = (self.playerTurn == "X" ? "O" : "X")
            self.WinnerText.text = "Player \(self.playerTurn) turn"
        }
    }
    
}
