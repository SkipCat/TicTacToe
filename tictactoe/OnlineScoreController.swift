import UIKit

class OnlineScoreController: UIViewController {
    
    @IBOutlet weak var PlayOnlineButton: UIButton!
    @IBOutlet weak var Spinner: UIActivityIndicatorView!
    @IBOutlet weak var PlayerXScore: UILabel!
    @IBOutlet weak var PlayerOScore: UILabel!
    @IBOutlet weak var DrawScore: UILabel!
    
    let defaults: UserDefaults = UserDefaults.standard
    var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let opened: Array<String> = defaults.array(forKey: "onlineWinHistory") as! Array<String>? {
            self.PlayerXScore.text = "Player X score = \(opened.filter{$0 == "X"}.count)"
            self.PlayerOScore.text = "Player O score = \(opened.filter{$0 == "O"}.count)"
            self.DrawScore.text = "Draws score = \(opened.filter{$0 == "D"}.count)"
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
    
    @IBAction func chooseUsername(_ sender: UIButton) {
        let alert = UIAlertController(title: "Enter a username to join the game", message: "", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            self.username = ((alert.textFields![0]).text as String?)!
            self.joinGame()
        })
        OKAction.isEnabled = false
        alert.addAction(OKAction)
        
        alert.addTextField { (textField) in
            NotificationCenter.default.addObserver(forName: .UITextFieldTextDidChange, object: textField, queue: OperationQueue.main, using:
                {_ in
                    // get the count of the non whitespace characters
                    let textCount = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
                    let textIsNotEmpty = textCount > 0
                    
                    // If the text contains non whitespace characters, enables the OK Button
                    OKAction.isEnabled = textIsNotEmpty
            })
        }
    
        present(alert, animated: true)
    }
    
    func joinGame() {
        TTTSocket.sharedInstance.socket.emit("join_queue", self.username!)
        self.Spinner.startAnimating()
        
        TTTSocket.sharedInstance.socket.on("join_game") { data, _ in
            self.performSegue(withIdentifier: "onlineGame", sender: data)
            self.Spinner.stopAnimating()
        }
    }

}
