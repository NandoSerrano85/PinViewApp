// NAME: Fernando Serrano
// PANTHERID:   5642858
// CLASS:       COP 4655 01 Online
// INSTRUCTOR:  Steve Luis ECS 282
// ASSIGNMENT:  Programming assignment 5
// DUE:         Thursday 11/17/19

import UIKit

class PinViewController: UIViewController {

    @IBOutlet var pin1: UITextField!
    @IBOutlet var pin2: UITextField!
    @IBOutlet var pin3: UITextField!
    @IBOutlet var pin4: UITextField!
    
    @IBOutlet var currentPin: UILabel!
    
    var pinCode:[String] = ["0","0","0","0"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pin1.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        pin2.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        pin3.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        pin4.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pin1.becomeFirstResponder()
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        
        if text?.utf16.count == 1{
            switch textField {
                case pin1:
                    pin2.becomeFirstResponder()
                    pinCode[0] = text!
                case pin2:
                    pin3.becomeFirstResponder()
                    pinCode[1] = text!
                case pin3:
                    pin4.becomeFirstResponder()
                    pinCode[2] = text!
                case pin4:
                    pin4.resignFirstResponder()
                    pinCode[3] = text!
                    checkIfExistInDatabase(text: pinCode.joined())
                default:
                    break
            }
        }
    }
    
    func checkIfExistInDatabase(text:String){
        if PinDatabase.shared.validationCheckForKey(key: text) {
            let pin = pinCode.joined()
            let url = PinDatabase.shared.getURL(key: pin)
            currentPin.text = "Last pin entered was: \(pin)"
            PinDatabase.shared.setCache(key: pin, value: url)
        } else {
            let alertController = UIAlertController(title: "Incorrect PIN", message: "Please enter an assigned PIN", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
        pin1.text = ""
        pin2.text = ""
        pin3.text = ""
        pin4.text = ""
        pinCode = ["0","0","0","0"]
    }
    
}

