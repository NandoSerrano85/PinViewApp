// NAME: Fernando Serrano
// PANTHERID:   5642858
// CLASS:       COP 4655 01 Online
// INSTRUCTOR:  Steve Luis ECS 282
// ASSIGNMENT:  Programming assignment 5
// DUE:         Thursday 11/17/19

import UIKit

class EditCellView: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet var pinTextField: UITextField!
    @IBOutlet var urlTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pinTextField.smartInsertDeleteType = UITextSmartInsertDeleteType.no
        pinTextField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = pinTextField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 4
    }
}
