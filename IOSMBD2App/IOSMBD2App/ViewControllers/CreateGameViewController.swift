//
//  CreateGameViewController.swift
//  IOSMBD2App
//
//  Created by Adam el Hassan on 06/04/2019.
//  Copyright © 2019 Adam el Hassan. All rights reserved.
//

import UIKit

class CreateGameViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var statusPicker: UIPickerView!
    var pickerData: [String] = []
    private var apiGamesController: ApiGamesController = ApiGamesController()
    private var selectedPick : String = "In lobby" // Starts at the first item in the list
    var gameViewController : GamesViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.statusPicker.delegate = self
        self.statusPicker.dataSource = self
        
        pickerData = ["In lobby", "In game", "Game over"]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPick = pickerData[row]
    }
    
    @IBAction func createGameClick(_ sender: Any) {
        createGame()
    }
    func createGame(){
        self.apiGamesController.createGame(status: selectedPick) { game in
            if (game != nil) {
                self.gameViewController.addGame(game: game!)
                // Removing current screen to go back to the previous screen (Overview in this case)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
