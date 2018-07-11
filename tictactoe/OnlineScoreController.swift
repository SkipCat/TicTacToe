import UIKit

class OnlineScoreController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        TTTSocket.sharedInstance.socket.on("join_game") { data, _ in
            self.performSegue(withIdentifier: "onlineGame", sender: data)
        }
    }
}
