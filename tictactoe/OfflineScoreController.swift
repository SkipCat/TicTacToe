import UIKit

class OfflineScoreController: UIViewController {
    
    @IBOutlet weak var Player1Score: UILabel!
    @IBOutlet weak var Player2Score: UILabel!
    @IBOutlet weak var DrawScore: UILabel!
    
    let defaults: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let opened: Array<String> = defaults.array(forKey: "offlineWinHistory") as! Array<String>? {
            self.Player1Score.text = "Player X score = \(opened.filter{$0 == "X"}.count)"
            self.Player2Score.text = "Player O score = \(opened.filter{$0 == "O"}.count)"
            self.DrawScore.text = "Games drawn = \(opened.filter{$0 == ""}.count)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
