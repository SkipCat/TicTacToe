import UIKit

class OfflineScoreController: DarkViewController {
    
    @IBOutlet weak var PlayerXScore: UILabel!
    @IBOutlet weak var PlayerOScore: UILabel!
    @IBOutlet weak var DrawScore: UILabel!
    
    let defaults: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let opened: Array<String> = defaults.array(forKey: "offlineWinHistory") as! Array<String>? {
            self.PlayerXScore.text = "Player X score = \(opened.filter{$0 == "X"}.count)"
            self.PlayerOScore.text = "Player O score = \(opened.filter{$0 == "O"}.count)"
            self.DrawScore.text = "Draws score = \(opened.filter{$0 == "D"}.count)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
