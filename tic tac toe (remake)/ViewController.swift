//
//  ViewController.swift
//  tic tac toe (remake)
//
//  Created by Андрей Журавлев on 12.01.2020.
//  Copyright © 2020 Андрей Журавлев. All rights reserved.
//

import UIKit

enum Players {
    case Cross, Circle, none
}

class ViewController: UIViewController {
    
    //MARK: Properties
    var currPlayer: Players = .Cross
    
    var cellsState = Array(repeating: false, count: 9)
    
    var isActiveGame = true
    
    var crossCells = Set<Int>()
    
    var circleCells = Set<Int>()
    
    let winningCombs: Array<Set<Int>> = [[0, 1, 2], [0, 3, 6], [6, 7, 8],
                                         [2, 5, 8], [0, 4, 8], [2, 4, 6],
                                         [1, 4, 7], [3, 4, 5]]
    
    
    //MARK: Outlets
    @IBOutlet weak var turnLabel: UILabel!
    
    //MARK: Actions
    @IBAction func buttonPress(_ sender: UIButton) {
        if isActiveGame {
            if currPlayer == .Cross {
                sender.setImage(UIImage(named: "Cross.png"), for: UIControl.State())
                turnLabel.text = "Circle Turn"
                currPlayer = .Circle
                crossCells.insert(sender.tag - 1)
            } else {
                sender.setImage(UIImage(named: "Circle.png"), for: UIControl.State())
                turnLabel.text = "Cross Turn"
                currPlayer = .Cross
                circleCells.insert(sender.tag - 1)
            }
        }
        cellsState[sender.tag - 1] = true
        
        let isWin = winCheck()
        if isWin != .none {
            turnLabel.text = "\(isWin) Won!!"
            turnLabel.layer.backgroundColor = UIColor(red: 196/255, green: 27/255, blue: 7/255, alpha: 1.0).cgColor
            turnLabel.textColor = UIColor.white
            turnLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
//            retartButtonOutlet.isHidden = false
            isActiveGame = false
            return
        }
        drawCheck()
    }
    
    
    
    //MARK: Private Metods
    func winCheck() -> Players {
        for comb in self.winningCombs {
            if comb.isSubset(of: crossCells) {
                return .Cross
            } else if comb.isSubset(of: circleCells) {
                return .Circle
            }
        }
        return .none
    }
    
    func drawCheck() {
        if !cellsState.contains(false) {
//            restartButtonOutlet.isHidden = false
            isActiveGame = false
            turnLabel.text = "Draw"
            turnLabel.layer.backgroundColor = UIColor(red: 196/255, green: 132/255, blue: 27/255, alpha: 1.0).cgColor
            turnLabel.textColor = UIColor.white
            turnLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        }
    }
    
    
    //MARK: Other
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

