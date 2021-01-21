//
//  ViewController.swift
//  MyGameLib
//
//  Created by Roy Welborn on 1/16/21.
//

import UIKit
import Firebase
import AVKit

class InitialViewController: UIViewController {
    
    /* Variable Declarations */
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var welcomeTextField: UITextView!
    
    var vplayer : AVPlayer?
    var vplayerLayer : AVPlayerLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        welcomeTextField.text = "Hello and Welcome to MyGameLib.\n Please login if you have an account.\n  If you do not have an accout, choose Sign-Up"
        setupElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupVideo()
    }
    
    func setupElements()
    {
        StyleUtilities.styleFilledButton(loginButton)
        StyleUtilities.styleFilledButton(signUpButton)
    }
    
    func setupVideo()
    {
        // get the path to the resource in the bundle
        let bundlePath = Bundle.main.path(forResource: "animation", ofType: "mp4")
        guard bundlePath != nil else { return }
        // create the url from the bundle
        let url = URL(fileURLWithPath: bundlePath!)
        
        // create the video player item
        let item = AVPlayerItem(url: url)
        // create the player
        vplayer = AVPlayer(playerItem: item)
        //create the layer
        vplayerLayer = AVPlayerLayer(player: vplayer!)
        // adjust size and frame
        vplayerLayer?.frame = CGRect(x: -self.view.frame.size.width, y: 0, width: self.view.frame.size.width*3, height: self.view.frame.size.height)
        // add to the view and play
        view.layer.insertSublayer(vplayerLayer!, at: 0)
        vplayer?.playImmediately(atRate: 2)
    }
    
    @IBAction func loginTapped(_ sender: Any)
    {
        // sends the user to the login screen
    }
    
    @IBAction func signUpTapped(_ sender: Any)
    {
        // sends user to the signUpScreen
    }
    
}

