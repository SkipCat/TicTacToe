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
    
    @IBAction func joinGame(_ sender: UIButton) {
        TTTSocket.sharedInstance.socket.emit("join_queue", "skipcat")
        TTTSocket.sharedInstance.socket.on("join_game") {data, _ in
            print(data)
            self.performSegue(withIdentifier: "onlineGame", sender: nil)
        }
    }
}
