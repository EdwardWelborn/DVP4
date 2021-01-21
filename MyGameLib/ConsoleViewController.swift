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
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
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
        let purchased = consoleArray[indexPath.row].datePurchased
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        cell.consoleName.text = name
        cell.serialNumber.text = serial
        cell.datePurchased.text = dateFormatter.description
        
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
