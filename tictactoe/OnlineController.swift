import UIKit
import SocketIO

class OnlineController: UIViewController {
    
    @IBOutlet weak var GridImage: UIImageView!
    @IBOutlet weak var CurrentTurn: UITextField!
    @IBOutlet weak var PlayerNameX: UITextField!
    @IBOutlet weak var PlayerNameO: UITextField!
    
    var playersData: NSArray = []
    var playerX: String?
    var playerO: String?
    var playerTurn: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let castData = playersData[0] as! [String: Any]
        self.playerTurn = (castData["currentTurn"] as? String)?.uppercased()
        
        self.playerX = castData["playerX"] as? String
        self.PlayerNameX.text = "Player X: \(self.playerX!)"
        self.playerO = castData["playerO"] as? String
        self.PlayerNameO.text = "Player O: \(self.playerO!)"
        
        if (self.playerTurn == "O") {
            self.CurrentTurn.text = "Player \(self.playerO!) turn"
        } else {
            self.CurrentTurn.text = "Player \(self.playerX!) turn"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
