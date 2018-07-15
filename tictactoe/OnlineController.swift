import UIKit
import SocketIO

class OnlineController: UIViewController {
    
    @IBOutlet weak var GridImage: UIImageView!
    @IBOutlet weak var CurrentTurn: UILabel!
    @IBOutlet weak var PlayerNameX: UILabel!
    @IBOutlet weak var PlayerNameO: UILabel!
    
    @IBOutlet weak var Btn1: UIButton!
    @IBOutlet weak var Btn2: UIButton!
    @IBOutlet weak var Btn3: UIButton!
    @IBOutlet weak var Btn4: UIButton!
    @IBOutlet weak var Btn5: UIButton!
    @IBOutlet weak var Btn6: UIButton!
    @IBOutlet weak var Btn7: UIButton!
    @IBOutlet weak var Btn8: UIButton!
    @IBOutlet weak var Btn9: UIButton!
    
    var playersData: NSArray = []
    var playerX: String?
    var playerO: String?
    var playerTurn: String?
    
    let defaults: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Btn1.setTitle("", for: .normal)
        self.Btn2.setTitle("", for: .normal)
        self.Btn3.setTitle("", for: .normal)
        self.Btn4.setTitle("", for: .normal)
        self.Btn5.setTitle("", for: .normal)
        self.Btn6.setTitle("", for: .normal)
        self.Btn7.setTitle("", for: .normal)
        self.Btn8.setTitle("", for: .normal)
        self.Btn9.setTitle("", for: .normal)
        
        let castData = playersData[0] as! [String: Any]
        self.playerTurn = (castData["currentTurn"] as? String)?.uppercased()
        
        self.playerX = castData["playerX"] as? String
        self.PlayerNameX.text = "Player X: \(self.playerX!)"
        self.playerO = castData["playerO"] as? String
        self.PlayerNameO.text = "Player O: \(self.playerO!)"
        
        if (self.playerTurn == "O") {
            self.CurrentTurn.text = "It is \(self.playerO!) turn"
        } else {
            self.CurrentTurn.text = "It is \(self.playerX!) turn"
        }
        
        playGame()
    }
    
    func playGame() {
        TTTSocket.sharedInstance.socket.on("movement") { data, _ in
            let castData = data[0] as! [String: Any]
            print(castData)
            let playerPlayed = (castData["player_played"] as? String)?.uppercased()
            
            //if (castData["err"] != nil) {
              //  self.CurrentTurn.text = "An error occurred"
            //} else {
                let tagReceived: Int = (castData["index"] as? Int)! + 1
                let buttonClicked = self.view.viewWithTag(tagReceived) as? UIButton
                
                buttonClicked?.setTitle(playerPlayed!, for: .normal)
                buttonClicked?.isEnabled = false
                
                if ((castData["win"] as? Int) == 1) {
                    var winner: String?
                    if (playerPlayed == "X") {
                        self.CurrentTurn.text = "Player \(self.playerX!) won!"
                        winner = "Player \(self.playerX!) won!"
                    } else {
                        self.CurrentTurn.text = "Player \(self.playerO!) won!"
                        winner = "Player \(self.playerO!) won!"
                    }
                    self.addScoreToHistory(score: self.playerTurn!)
                    self.quitOrReplay(title: winner!)
                    
                } else {
                    let grid = (castData["grid"] as? NSArray)!
                    if (!grid.contains(0)) {
                        self.CurrentTurn.text = "Draw!"
                        self.addScoreToHistory(score: "D")
                        self.quitOrReplay(title: "Draw!")
                    } else {
                        if (self.playerTurn == "O") {
                            self.CurrentTurn.text = "It is \(self.playerX!) turn"
                            self.playerTurn = "X"
                        } else {
                            self.CurrentTurn.text = "It is \(self.playerO!) turn"
                            self.playerTurn = "O"
                        }
                    }
                }
            //}
        }
    }
    
    func addScoreToHistory(score: String) {
        if var opened: Array<String> = self.defaults.array(forKey: "onlineWinHistory") as! Array<String>? {
            opened.append(score)
            self.defaults.set(opened, forKey: "onlineWinHistory")
        } else {
            self.defaults.set([score], forKey: "onlineWinHistory")
        }
    }
    
    func quitOrReplay(title: String) {
        let alert = UIAlertController(title: title, message: "What do you want to do now?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Quit", style: .destructive, handler: { (action: UIAlertAction!) in
            self.dismiss(sender: (Any).self)
        }))
        
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { (action: UIAlertAction!) in
            print("you clicked on 'try again'")
            
            // get the username used first
            TTTSocket.sharedInstance.socket.emit("join_queue", "skipcat")
            TTTSocket.sharedInstance.socket.on("join_game") { data, _ in
                print("in join_game event")
                self.resetView()
                self.replay()
                /*
                DispatchQueue.main.async { [weak self] in
                    self?.view.setNeedsDisplay()
                    self?.resetView()
                }
 */
             }
        }))
        
        present(alert, animated: true)
    }
    
    func resetView() {
        self.Btn1.setTitle("Button", for: .normal)
        self.Btn1.isEnabled = true
        self.Btn2.setTitle("Button", for: .normal)
        self.Btn2.isEnabled = true
        self.Btn3.setTitle("Button", for: .normal)
        self.Btn3.isEnabled = true
        self.Btn4.setTitle("Button", for: .normal)
        self.Btn4.isEnabled = true
        self.Btn5.setTitle("Button", for: .normal)
        self.Btn5.isEnabled = true
        self.Btn6.setTitle("Button", for: .normal)
        self.Btn6.isEnabled = true
        self.Btn7.setTitle("Button", for: .normal)
        self.Btn7.isEnabled = true
        self.Btn8.setTitle("Button", for: .normal)
        self.Btn8.isEnabled = true
        self.Btn9.setTitle("Button", for: .normal)
        self.Btn9.isEnabled = true
    }
    
    func replay() {
        let castData = playersData[0] as! [String: Any]
        self.playerTurn = (castData["currentTurn"] as? String)?.uppercased()
        
        self.playerX = castData["playerX"] as? String
        self.PlayerNameX.text = "Player X: \(self.playerX!)"
        self.playerO = castData["playerO"] as? String
        self.PlayerNameO.text = "Player O: \(self.playerO!)"
        
        if (self.playerTurn == "O") {
            self.CurrentTurn.text = "It is \(self.playerO!) turn"
        } else {
            self.CurrentTurn.text = "It is \(self.playerX!) turn"
        }
        
        playGame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func handleClick(_ sender: UIButton) {
        TTTSocket.sharedInstance.socket.emit("movement", sender.tag - 1)
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
