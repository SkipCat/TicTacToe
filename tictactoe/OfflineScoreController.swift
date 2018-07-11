import UIKit

class OfflineScoreController: UIViewController {
    
    @IBOutlet weak var player1: UITextField!
    @IBOutlet weak var player2: UITextField!
    @IBOutlet weak var draw: UITextField!
    
    let defaults: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let opened: Array<Int> = defaults.array(forKey: "winHistory") as! Array<Int>?{
            player1.text = "Player 1 score = \(opened.filter{$0 == 1}.count)"
            player2.text = "Player 2 score = \(opened.filter{$0 == 2}.count)"
            draw.text = "Games drawn = \(opened.filter{$0 == 0}.count)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
