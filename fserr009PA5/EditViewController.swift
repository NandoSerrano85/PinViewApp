// NAME: Fernando Serrano
// PANTHERID:   5642858
// CLASS:       COP 4655 01 Online
// INSTRUCTOR:  Steve Luis ECS 282
// ASSIGNMENT:  Programming assignment 5
// DUE:         Thursday 11/17/19

import UIKit

class EditViewController: UITableViewController, UINavigationControllerDelegate {
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.navigationItem.leftBarButtonItem = editButtonItem
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    
    @IBAction func saveChangesToPin(_ sender: UIButton) {
        for n in 0...9 {
            let cell = tableView.cellForRow(at: IndexPath(row: n, section: 0)) as! EditCellView
            PinDatabase.shared.validationCheckForChanges(index:n, key:cell.pinTextField.text!, value:cell.urlTextField.text!)
            
        }
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var title:String = ""
            let bounds:Bool = indexPath.row < PinDatabase.shared.sizeOfDB()
            if bounds {
                let editable = PinDatabase.shared.getPinAndURL(index: indexPath.row)
                title = "Delete \(editable.pin)?"
            } else {
                title = "Delete _ _ _ _ ?"
            }
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title,
                                       message: message,
                                       preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive,
                                             handler: { (action) -> Void in
                                                if bounds {
                                                    PinDatabase.shared.removeFromDB(index: indexPath.row)
                                                }
                                                let cell = self.tableView.cellForRow(at: indexPath) as! EditCellView
                                                cell.pinTextField.text = ""
                                                cell.urlTextField.text = ""
            })
            ac.addAction(deleteAction)
            
            present(ac, animated: true, completion: nil)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditCellView", for: indexPath) as! EditCellView
        if indexPath.row < PinDatabase.shared.sizeOfDB(){
            let editable = PinDatabase.shared.getPinAndURL(index: indexPath.row)
            
            cell.pinTextField.text = editable.pin
            cell.urlTextField.text = editable.url
            
        }
        
        return cell
    }

}
