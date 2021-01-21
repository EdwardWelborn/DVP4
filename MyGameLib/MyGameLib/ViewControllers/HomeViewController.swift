//
//  HomeViewController.swift
//  MyGameLib
//
//  Created by Roy Welborn on 1/17/21.
//

import FirebaseFirestore

let nav = UINavigationItem()
var consoleArray = [Consoles]()
var gamesArray : [Games] = []

class HomeViewController: UIViewController
{
    
    
    let currentDate = Date()
    let userName = [Users]()
    var db: Firestore!
    var data: String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        nav.title = "Welcome \(data)"
        // Do any additional setup after loading the view
        db = Firestore.firestore()
//        alertButton.titleLabel?.adjustsFontSizeToFitWidth = true
//        fridgeButton.titleLabel?.adjustsFontSizeToFitWidth = true
//        freezerButton.titleLabel?.adjustsFontSizeToFitWidth = true
//        recipeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        // load data for all three arrays here
        loadConsoleData()
        loadGameData()
    }
    
    // MARK: Load Database Data
    func loadConsoleData() {
         
         db.collection("Consoles").getDocuments() {
             snapshot, error in
             if let error = error {
                 print("\(error.localizedDescription)")
             } else {
                 for document in snapshot!.documents {
                     
                     let data = document.data()
                     let name = data["consolename"] as? String ?? "None"
                     let serial = data["serialnumber"] as? String ?? "00"
                     let purchased = data["datepurchased"] as? Date ?? Date()
                     
                     /* testing */
                     print("ID: \(name.description) name: \(name)")
                     
                    let newSourse = Consoles(consoleName: name, serialNumber: serial, datePurchased: purchased)
                     consoleArray.append(newSourse)
                    print(consoleArray.count.description)
                 }
             }
         }
     }
    
    func loadGameData() {
            db.collection("Games").getDocuments() {
                snapshot, error in
                if let error = error {
                    print("\(error.localizedDescription)")
                } else {
                    for document in snapshot!.documents {

                        let data = document.data()
                        let name = data["name"] as? String ?? "N/A"
                        let genre = data["genre"] as? String ?? "N/A"
                        let finished = data["finished"] as? Bool ?? false
                        let console = data["console"] as? String ?? "N/A"

                        /* testing */
                        print("ID: \(name.description) name: \(name)")
                        let newSourse = Games(gameName: name, gameGenre: genre, finished: finished, console: console)
                        gamesArray.append(newSourse)
                    }
                }
            }
        }
    
    // MARK: End Load Database Data
}
