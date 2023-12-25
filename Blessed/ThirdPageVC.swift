//
//  ThirdPageVC.swift
//  Blessed
//
//  Created by woonKim on 2023/12/23.
//

import UIKit

class ThirdPageVC: UIViewController {
    
    @IBOutlet weak var viewForContent: UIView!
    @IBOutlet weak var wordLbl: UILabel!
    @IBOutlet weak var wordChapterLbl: UILabel!
    var wordDataInThirdPageVC: WordData = WordData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wordLbl.font = UIFont(name: "Copperplate", size: 24)
        wordLbl.textAlignment = .center
        wordLbl.numberOfLines = 0
        wordLbl.text = wordDataInThirdPageVC.words[2]
        
        wordChapterLbl.font = UIFont(name: "Copperplate", size: 16)
        wordChapterLbl.textAlignment = .center
        wordChapterLbl.text = wordDataInThirdPageVC.wordChapter[2]
        
        NotificationCenter.default.addObserver(self, selector: #selector(resetWordLbl(_:)), name: Notification.Name("resetWordLblThirdPageVC"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(resetWordChapterLbl(_:)), name: Notification.Name("resetWordChapterLblThirdPageVC"), object: nil)
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
