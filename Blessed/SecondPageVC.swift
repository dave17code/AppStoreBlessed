//
//  SecondPageVC.swift
//  Blessed
//
//  Created by woonKim on 2023/12/23.
//

import UIKit

class SecondPageVC: UIViewController {
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var wordChapterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wordLabel.font = UIFont(name: "Copperplate", size: 24)
        wordLabel.textAlignment = .center
        wordLabel.numberOfLines = 0
        
        wordChapterLabel.font = UIFont(name: "Copperplate", size: 16)
        wordChapterLabel.textAlignment = .center
        
        wordLabel.text = WordData().words[1]
        wordChapterLabel.text = WordData().wordChapter[1]
    }
    
    
    
    
}
