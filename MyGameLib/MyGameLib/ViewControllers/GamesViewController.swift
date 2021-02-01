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
    
    
}
