//
//  GamesViewController.swift
//  MyGameLib
//
//  Created by Roy Welborn on 1/19/21.
//

import UIKit
import Firebase
import FirebaseFirestore

class GamesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var gamesTableView: UITableView!
    var db : Firestore!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gamesTableView.allowsSelectionDuringEditing = true
        gamesTableView.delegate = self
        gamesTableView.dataSource = self
        db = Firestore.firestore()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(GamesViewController.editTapped(_:)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    /* Method that handles the edit button when pressed */
    @IBAction func editTapped(_ sender: UIButton) {
         /* Enters and exits edit mode depending on the button press */
        gamesTableView.setEditing(!gamesTableView.isEditing, animated: true)
         
         if gamesTableView.isEditing == true {
             /* when edit mode is enabled, this will set the leftBarButton to .trash (trashcan icon), and calls the trash all method for the items selected */
             navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(GamesViewController.trashSelected))
              /* When edit mode is enabled, this will set the rightBarButton to .cancel */
             navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(GamesViewController.editTapped(_:)))
         }
         else {
             /* When edit mode is disabled the leftBarButton will not be shown */
             navigationItem.leftBarButtonItem = nil
             /* When edit mode is disabled the rightBarButton to the default .edit */
             navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(GamesViewController.editTapped(_:)))
         }
     }
    
    /* delete all the items and cells that have been selected */
    @objc func trashSelected() {
        /* build the custom alert for deleting items from the list */
        let deleteRowsAlert = UIAlertController(title: "Delete Lists", message: "Are you sure you want to delete the list(s)?", preferredStyle: .alert)
        /* add the delete button to the alert */
        deleteRowsAlert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (alert) in
            
            /* Grab the index of selected items */
            if var selectedRows = self.gamesTableView.indexPathsForSelectedRows {
                /* Sort the rows so we can delete the row from end to beginning */
                selectedRows.sort { (a, b) -> Bool in
                    a.row > b.row
                }
                for indexPath in selectedRows {
                    /* update the list(s) */
                    switch indexPath.section {
                    case 0:
                        gamesArray.remove(at: indexPath.row)

                    default:
                        print("Forbidden Zone, we should never be here")
                    }
                }
                
                /* Delete all the selected rows */
                self.gamesTableView.deleteRows(at: selectedRows, with: .left)
                // Update custom section header
            }
            self.gamesTableView.setEditing(false, animated: true)
            /* turn off edit mode, and reset the buttons */
            self.navigationItem.leftBarButtonItem = nil
             /* change the button back to edit */
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(GamesViewController.editTapped(_:)))
        }))
        /* add the cancel button to the alert */
        deleteRowsAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        /* show the custom alert */
        self.present(deleteRowsAlert, animated: true, completion: nil)
 
    }
    @IBAction func addNewList(_ sender: UIButton) {
        /* Make sure the header is correct */
 //       addToTheListAlert()
    }
    
    //Tableview setup
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("Tableview setup \(gamesArray.count)")
        return gamesArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = gamesTableView.dequeueReusableCell(withIdentifier: "gamesCell", for: indexPath) as! GamesTableViewCell
        cell.backgroundColor = UIColor.clear
        let name = gamesArray[indexPath.row].gameName
        let genre = gamesArray[indexPath.row].gameGenre
        let gamefinished = gamesArray[indexPath.row].finished
        let gameConsole = gamesArray[indexPath.row].console
        
        cell.gameNameLabel.text = "Game Name: \(name)"
        cell.gameGenreLabel.text = "Game Genre: \(genre)"
        cell.gameFinishedLabel.text = "Finished? \(gamefinished.description)"
        cell.gameConsoleLabel.text = "Game Console: \(gameConsole)"
        
        print("Array is populated \(gamesArray)")
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
    
    // TODO: alert window to add items to the consoles array and database
}
