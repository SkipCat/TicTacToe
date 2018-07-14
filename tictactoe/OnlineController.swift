import UIKit
import SocketIO

class OnlineController: UIViewController {
    
    @IBOutlet weak var GridImage: UIImageView!
    @IBOutlet weak var CurrentTurn: UILabel!
    @IBOutlet weak var PlayerNameX: UILabel!
    @IBOutlet weak var PlayerNameO: UILabel!
    
    var playersData: NSArray = []
    var playerX: String?
    var playerO: String?
    var playerTurn: String?
    
    let defaults: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            let playerPlayed = (castData["player_played"] as? String)?.uppercased()
            
            if (castData["err"] == nil) {
                self.CurrentTurn.text = "Wrong move, please try again"
            } else {
                let tagReceived: Int = (castData["index"] as? Int)! + 1
                let buttonClicked = self.view.viewWithTag(tagReceived) as? UIButton
                
                buttonClicked?.setTitle(playerPlayed!, for: .normal)
                buttonClicked?.isEnabled = false
                
                if ((castData["win"] as? Int) == 1) {
                    if (playerPlayed == "X") {
                        self.CurrentTurn.text = "Player \(self.playerX!) won!"
                    } else {
                        self.CurrentTurn.text = "Player \(self.playerO!) won!"
                    }
                    self.addScoreToHistory()
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
        }
    }
    
    func addScoreToHistory() {
        if var opened: Array<String> = self.defaults.array(forKey: "onlineWinHistory") as! Array<String>? {
            opened.append(self.playerTurn!)
            self.defaults.set(opened, forKey: "onlineWinHistory")
        } else {
            self.defaults.set([self.playerTurn], forKey: "onlineWinHistory")
        }
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
