//
//  SecondPageVC.swift
//  Blessed
//
//  Created by woonKim on 2023/12/23.
//

import UIKit

class SecondPageVC: UIViewController {
    
    @IBOutlet weak var viewForContent: UIView!
    @IBOutlet weak var wordLbl: UILabel!
    @IBOutlet weak var wordChapterLbl: UILabel!
    var wordDataInSecondPageVC: WordData = WordData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wordLbl.font = UIFont(name: "Copperplate", size: 24)
        wordLbl.textAlignment = .center
        wordLbl.numberOfLines = 0
        wordLbl.text = wordDataInSecondPageVC.words[1]
        
        wordChapterLbl.font = UIFont(name: "Copperplate", size: 16)
        wordChapterLbl.textAlignment = .center
        wordChapterLbl.text = wordDataInSecondPageVC.wordChapter[1]
        
        NotificationCenter.default.addObserver(self, selector: #selector(resetWordLbl(_:)), name: Notification.Name("resetWordLblSecondPageVC"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(resetWordChapterLbl(_:)), name: Notification.Name("resetWordChapterLblSecondPageVC"), object: nil)
    }
    
    @objc func resetWordLbl(_ notification: Notification) {
        viewForContent.fadeOut()
        if let text = notification.object as? String {
            wordLbl.text = text
        }
        viewForContent.fadeIn()
    }
    
    @objc func resetWordChapterLbl(_ notification: Notification) {
        viewForContent.fadeOut()
        if let text = notification.object as? String {
            wordChapterLbl.text = text
        }
        viewForContent.fadeIn()
    }
}
