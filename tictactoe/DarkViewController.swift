import Foundation
import UIKit

class DarkViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1.0)
        self.tabBarController?.tabBar.barStyle = UIBarStyle.black
        
        // trying to set images on tab bar buttons
        /*
        let tabBar = self.tabBarController?.tabBar
        let tabOnline = tabBar?.items![0]
        let tabOffline = tabBar?.items![1]
        tabOnline?.image = UIImage(named: "online.png")?.withRenderingMode(.alwaysOriginal)
        tabOnline?.badgeColor = UIColor.blue
 */
        
        let labels = self.view.subviews.flatMap { $0 as? UILabel }
        for label in labels {
            label.textColor = UIColor.white
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
