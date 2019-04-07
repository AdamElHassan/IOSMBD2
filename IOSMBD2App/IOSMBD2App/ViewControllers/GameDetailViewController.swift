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
    @IBOutlet weak var shareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameID.text = "Game ID: " + String(game?._id.suffix(4) ?? "Not Found")
        gameStatus.text = "Game status: " + (game?.status ?? "Not Found")
        gameID.sizeToFit()
        gameStatus.sizeToFit()
    }

    // Used to share the ID of a game
    @IBAction func shareGame(_ sender: Any) {
        let firstActivityItem = "Join this game ID! ID: " + String(game?._id.suffix(4) ?? "Not found")
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem], applicationActivities: nil)
        
        // Popover you need to show in iPad
        activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)
        
        // The arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        // Excluding different share methodes
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo
        ]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}

