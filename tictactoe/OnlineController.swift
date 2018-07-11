import UIKit
import SocketIO

class OnlineController: UIViewController {
    
    @IBOutlet weak var GridImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.sendSubview(toBack: GridImage)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
