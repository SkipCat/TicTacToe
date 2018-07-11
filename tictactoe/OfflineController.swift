import Foundation
import UIKit

class OfflineController: UIViewController {
    
    var values: Array = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var playerTurn: Int = 1
    
    @IBOutlet weak var winnerText: UITextField!
    
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func restartAction(_ sender: UIButton) {
        self.values = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        self.playerTurn = 1
        // TODO: set buttons invisible by default and then display x / o image
        bt0.setTitle("Button", for: .normal)
        bt1.setTitle("Button", for: .normal)
        bt2.setTitle("Button", for: .normal)
        bt3.setTitle("Button", for: .normal)
        bt4.setTitle("Button", for: .normal)
        bt5.setTitle("Button", for: .normal)
        bt6.setTitle("Button", for: .normal)
        bt7.setTitle("Button", for: .normal)
        bt8.setTitle("Button", for: .normal)
        winnerText.text = "Player \(self.playerTurn) turn"
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleClick(_ sender: UIButton) {
        sender.setTitle(String(self.playerTurn), for: .normal)
        sender.isEnabled = false
        self.values[sender.tag] = self.playerTurn
        
        if (
            (self.values[0] != 0 && self.values[0] == self.values[1] && self.values[1] == self.values[2]) ||
                (self.values[3] != 0 && self.values[3] == self.values[4] && self.values[4] == self.values[5]) ||
                (self.values[6] != 0 && self.values[6] == self.values[7] && self.values[7] == self.values[8]) ||
                (self.values[0] != 0 && self.values[0] == self.values[3] && self.values[3] == self.values[6]) ||
                (self.values[1] != 0 && self.values[1] == self.values[4] && self.values[4] == self.values[7]) ||
                (self.values[2] != 0 && self.values[2] == self.values[5] && self.values[5] == self.values[8]) ||
                (self.values[0] != 0 && self.values[0] == self.values[4] && self.values[4] == self.values[8]) ||
                (self.values[2] != 0 && self.values[2] == self.values[4] && self.values[4] == self.values[6])
            ) {
            winnerText.text = "\(self.playerTurn) won the game"
            
            if var opened:Array<Int> = defaults.array(forKey:"winHistory") as! Array<Int>?{
                opened.append(self.playerTurn)
                defaults.set(opened, forKey: "winHistory")
            } else {
                defaults.set([self.playerTurn], forKey: "winHistory")
            }
            
        } else if (!self.values.contains(0)) {
            winnerText.text = "NO WINNER"
            
            if var opened:Array<Int> = defaults.array(forKey:"winHistory") as! Array<Int>?{
                opened.append(0)
                defaults.set(opened, forKey: "winHistory")
            } else {
                defaults.set([0], forKey: "winHistory")
            }

        
        } else {
            self.playerTurn = (self.playerTurn == 1 ? 2 : 1)
            self.winnerText.text = "Player \(self.playerTurn) turn"
        }
    }
    
}
