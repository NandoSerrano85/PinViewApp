// NAME: Fernando Serrano
// PANTHERID:   5642858
// CLASS:       COP 4655 01 Online
// INSTRUCTOR:  Steve Luis ECS 282
// ASSIGNMENT:  Programming assignment 5
// DUE:         Thursday 11/17/19

import UIKit
import WebKit

class BrowserViewController: UIViewController, WKUIDelegate {

    @IBOutlet var pinLabel: UILabel!
    @IBOutlet var urlLabel: UILabel!
    
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let cache = PinDatabase.shared.getCache()
        if cache[0] == "" {
            pinLabel.text = "0000"
            urlLabel.text = PinDatabase.shared.getURL(key: "0000")
        } else {
            pinLabel.text = cache[0]
            urlLabel.text = cache[1]
        }
        let url:URL = URL(string: urlLabel.text!)!
        let request:URLRequest = URLRequest(url: url)
        webView.load(request)
    }

}

