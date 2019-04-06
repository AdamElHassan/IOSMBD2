//
//  GameDetailViewController.swift
//  IOSMBD2App
//
//  Created by Adam el Hassan on 03/04/2019.
//  Copyright © 2019 Adam el Hassan. All rights reserved.
//

import UIKit

class GameDetailViewController: UIViewController {
    
    var game : GameData?
    var gameViewController : GamesViewController?

    @IBOutlet weak var gameStatus: UILabel!
    @IBOutlet weak var gameID: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false;
        gameID.text = "Game ID: " + String(game?._id.suffix(4) ?? "Not Found")
        gameStatus.text = "Game status: " + (game?.status)!
        gameID.sizeToFit()
        gameStatus.sizeToFit()
    }


}

