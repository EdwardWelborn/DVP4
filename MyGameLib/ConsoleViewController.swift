//
//  ConsoleViewController.swift
//  MyGameLib
//
//  Created by Roy Welborn on 1/19/21.
//

import UIKit
import Firebase
import FirebaseFirestore

class ConsoleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    var db : Firestore!
    
    @IBOutlet weak var consoleTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        consoleTableView.allowsSelectionDuringEditing = true
        consoleTableView.delegate = self
        consoleTableView.dataSource = self
        db = Firestore.firestore()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(ConsoleViewController.editTapped(_:)))
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    /* Method that handles the edit button when pressed */
    @IBAction func editTapped(_ sender: UIButton) {
         /* Enters and exits edit mode depending on the button press */
        consoleTableView.setEditing(!consoleTableView.isEditing, animated: true)
         
         if consoleTableView.isEditing == true {
             /* when edit mode is enabled, this will set the leftBarButton to .trash (trashcan icon), and calls the trash all method for the items selected */
             navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(ConsoleViewController.trashSelected))
              /* When edit mode is enabled, this will set the rightBarButton to .cancel */
             navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(ConsoleViewController.editTapped(_:)))
         }
         else {
             /* When edit mode is disabled the leftBarButton will not be shown */
             navigationItem.leftBarButtonItem = nil
             /* When edit mode is disabled the rightBarButton to the default .edit */
             navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(ConsoleViewController.editTapped(_:)))
         }
     }
    /* delete all the items and cells that have been selected */
    @objc func trashSelected() {
        /* build the custom alert for deleting items from the list */
        let deleteRowsAlert = UIAlertController(title: "Delete Lists", message: "Are you sure you want to delete the list(s)?", preferredStyle: .alert)
        /* add the delete button to the alert */
        deleteRowsAlert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (alert) in
            
            /* Grab the index of selected items */
            if var selectedRows = self.consoleTableView.indexPathsForSelectedRows {
                /* Sort the rows so we can delete the row from end to beginning */
                selectedRows.sort { (a, b) -> Bool in
                    a.row > b.row
                }
                for indexPath in selectedRows {
                    /* update the list(s) */
                    switch indexPath.section {
                    case 0:
                        consoleArray.remove(at: indexPath.row)

                    default:
                        print("Forbidden Zone, we should never be here")
                    }
                }
                
                /* Delete all the selected rows */
                self.consoleTableView.deleteRows(at: selectedRows, with: .left)
                // Update custom section header
            }
            self.consoleTableView.setEditing(false, animated: true)
            /* turn off edit mode, and reset the buttons */
            self.navigationItem.leftBarButtonItem = nil
             /* change the button back to edit */
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(ConsoleViewController.editTapped(_:)))
        }))
        /* add the cancel button to the alert */
        deleteRowsAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        /* show the custom alert */
        self.present(deleteRowsAlert, animated: true, completion: nil)
 
    }
    @IBAction func addNewList(_ sender: UIButton) {
        /* Make sure the header is correct */
        addToTheListAlert()
    }
    
    func addToTheListAlert() {
         /*  build custom alert to create a new list */
         let addItemAlert = UIAlertController(title: "Add a New Item", message: "Please enter the name of the Item", preferredStyle: .alert)
         /* add textfield for user input */
         addItemAlert.addTextField { (textField) in
             /* set a place holder example for the user */
             textField.placeholder = "Enter Item Name"
         }
         /* add the create button */
         addItemAlert.addAction(UIAlertAction(title: "Add Item", style: .default, handler: { (alert) in
             /*  read the user input */
             let textField = addItemAlert.textFields![0]
             /* // verify that the input from the text field is valid and not empy */
             if !(textField.text?.isEmpty)!, let newListItem = textField.text {
                 /* build the new list from the text field input */
                self.itemList.listItems.append(newListItem)
                 /* reload the table data */
                 self.tableView.reloadData()
             }
            self.tableView.setEditing(false, animated: true)
             /* disable left button  */
             self.navigationItem.leftBarButtonItem = nil
              /* set the right button back to edit */
             self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(ItemsTableViewController.editTapped(_:)))
         }))
         /* add cancel button */
         addItemAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
         /* show the alert */
         self.present(addItemAlert, animated: true, completion: nil)

     }
    
    //Tableview setup
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("Tableview setup \(consoleArray.count)")
        return consoleArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = consoleTableView.dequeueReusableCell(withIdentifier: "consoleCell", for: indexPath) as! ConsoleTableViewCell
        cell.backgroundColor = UIColor.clear
        let name = consoleArray[indexPath.row].consoleName
        let serial = consoleArray[indexPath.row].serialNumber
        let purchased = consoleArray[indexPath.row].datePurchased!
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let newDate = dateFormatter.string(from: purchased)
        cell.consoleName.text = "Console Name: \(name.description)"
        cell.serialNumber.text = "Serial Number: \(serial ?? "N/A")"
        cell.datePurchased.text = "Date Purchased: \(newDate.description)"
        
        print("Array is populated \(consoleArray)")
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
