//
//  Games.swift
//  MyGameLib
//
//  Created by Roy Welborn on 1/17/21.
//

import Foundation

class Games
{
    let gameName : String
    let gameGenre : String
    let finished : Bool
    let console : String
    
    init(gameName : String, gameGenre : String, finished: Bool, console : String)
    {
        self.gameName = gameName
        self.gameGenre = gameGenre
        self.finished = finished
        self.console = console
    }
    
}
