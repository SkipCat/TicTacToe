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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let castData = playersData[0] as! [String: Any]
        print(castData)
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
        
        TTTSocket.sharedInstance.socket.on("movement") { data, _ in
            let castData = data[0] as! [String: Any]
            let playerPlayed = (castData["player_played"] as? String)?.uppercased()
            
            if (castData["err"] == nil) {
                self.CurrentTurn.text = "Wrong move, please try again"
            } else if (playerPlayed != self.playerTurn) {
                self.CurrentTurn.text = "It is not your turn"
            } else {
                let buttonClicked = self.view.viewWithTag((castData["index"] as? Int)!) as? UIButton
                buttonClicked?.setTitle(playerPlayed!, for: .normal)
                buttonClicked?.isEnabled = false
                
                if ((castData["win"] as? Int) == 1) {
                    self.CurrentTurn.text = "Player \(playerPlayed!) won!"
                } else {
                    self.playerTurn = (self.playerTurn == "X" ? "O" : "X")
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func handleClick(_ sender: UIButton) {
        TTTSocket.sharedInstance.socket.emit("movement", sender.tag)
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
