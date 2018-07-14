import UIKit

class OnlineScoreController: UIViewController {
    
    @IBOutlet weak var PlayOnlineButton: UIButton!
    @IBOutlet weak var Spinner: UIActivityIndicatorView!
    @IBOutlet weak var PlayerXScore: UILabel!
    @IBOutlet weak var PlayerOScore: UILabel!
    
    let defaults: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let opened: Array<String> = defaults.array(forKey: "onlineWinHistory") as! Array<String>? {
            self.PlayerXScore.text = "Player X score = \(opened.filter{$0 == "X"}.count)"
            self.PlayerOScore.text = "Player O score = \(opened.filter{$0 == "O"}.count)"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "onlineGame") {
            let controller = segue.destination as! OnlineController
            controller.playersData = sender as! NSArray
        }
    }
    
    @IBAction func joinGame(_ sender: UIButton) {
        TTTSocket.sharedInstance.socket.emit("join_queue", "skipcat")
        self.Spinner.startAnimating()
        
        TTTSocket.sharedInstance.socket.on("join_game") { data, _ in
            self.performSegue(withIdentifier: "onlineGame", sender: data)
            self.Spinner.stopAnimating()
        }
    }

}
