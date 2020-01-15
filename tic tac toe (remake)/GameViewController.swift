//
//  GameViewController.swift
//  tic tac toe (remake)
//
//  Created by Андрей Журавлев on 12.01.2020.
//  Copyright © 2020 Андрей Журавлев. All rights reserved.
//

import UIKit

enum Players {
    case Cross, Circle, none
}

class GameViewController: UIViewController {
    
    //MARK: Properties
    var currPlayer: Players = .Cross
    
    var cellsState = Array(repeating: false, count: 9)
    
    var isActiveGame = true
    
    var crossCells = Set<Int>()
    
    var circleCells = Set<Int>()
    
    let winningCombs: Array<Set<Int>> = [[0, 1, 2], [0, 3, 6], [6, 7, 8],
                                         [2, 5, 8], [0, 4, 8], [2, 4, 6],
                                         [1, 4, 7], [3, 4, 5]]
    
    var settings: Settings! = Settings()
    
    
    //MARK: Outlets
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var restartButtonOutlet: UIButton!
    
    
    //MARK: Actions
    @IBAction func buttonPress(_ sender: UIButton) {
        if isActiveGame {
            if settings.isAI == .none {
                if currPlayer == .Cross {
                    sender.setImage(UIImage(named: "Cross.png"), for: UIControl.State())
                    turnLabel.text = "\(settings.circleName) Turn"
                    currPlayer = .Circle
                    crossCells.insert(sender.tag - 1)
                } else {
                    sender.setImage(UIImage(named: "Circle.png"), for: UIControl.State())
                    turnLabel.text = "\(settings.crossName) Turn"
                    currPlayer = .Cross
                    circleCells.insert(sender.tag - 1)
                }
            } else if settings.isAI == .Circle {
                sender.setImage(UIImage(named: "Cross.png"), for: UIControl.State())
                turnLabel.text = "Your turn"
                crossCells.insert(sender.tag - 1)
                let index = randChoice()
                aiAction(index)
                circleCells.insert(index)
            } else if settings.isAI == .Cross {
                sender.setImage(UIImage(named: "Circle.png"), for: UIControl.State())
                turnLabel.text = "Your turn"
                circleCells.insert(sender.tag - 1)
                let index = randChoice()
                aiAction(index)
                crossCells.insert(index)
            }
        }
        
        
        cellsState[sender.tag - 1] = true
        
        let isWin = winCheck()
        if isWin != .none {
            turnLabel.text = "\(isWin) Won!!"
            turnLabel.layer.backgroundColor = UIColor(red: 196/255, green: 27/255, blue: 7/255, alpha: 1.0).cgColor
            turnLabel.textColor = UIColor.white
            turnLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
            restartButtonOutlet.isHidden = false
            isActiveGame = false
            return
        }
        drawCheck()
    }
    
    @IBAction func restartButtonAction(_ sender: UIButton) {
        if !isActiveGame {
            restartButtonOutlet.isHidden = true
            cellsState = Array(repeating: false, count: 9)
            crossCells.removeAll()
            circleCells.removeAll()
            isActiveGame = true
            for i in 1...9 {
                let button = view.viewWithTag(i) as! UIButton
                button.setImage(nil, for: UIControl.State())
            }
            turnLabel.layer.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0).cgColor
            turnLabel.textColor = UIColor.black
            turnLabel.text = "Cross Turn"
            turnLabel.font = UIFont.systemFont(ofSize: 30.0)
        }
    }
    
    @IBAction func unwindToGameField(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? SettingsViewController,
            let settings = sourceViewController.settings {
            self.settings = settings
            restartButtonAction(UIButton())
        }
    }
    
    
    //MARK: Private Metods
    private func winCheck() -> Players {
        for comb in self.winningCombs {
            if comb.isSubset(of: crossCells) {
                return .Cross
            } else if comb.isSubset(of: circleCells) {
                return .Circle
            }
        }
        return .none
    }
    
    private func drawCheck() {
        if !cellsState.contains(false) {
            restartButtonOutlet.isHidden = false
            isActiveGame = false
            currPlayer = .Cross
            turnLabel.text = "Draw"
            turnLabel.layer.backgroundColor = UIColor(red: 196/255, green: 132/255, blue: 27/255, alpha: 1.0).cgColor
            turnLabel.textColor = UIColor.white
            turnLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        }
    }
    
    private func randChoice() -> Int {
        var res = -1
        while true {
            res = Int.random(in: 0..<cellsState.count)
            if cellsState[res] == false {
                break;
            }
        }
        return res
    }
    
    private func aiAction(_ index: Int) {
        let button = view.viewWithTag(index + 1) as! UIButton
        button.setImage(UIImage(named: "\(settings.isAI).png"), for: UIControl.State())
    }
    
    //MARK: Other
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

