//
//  FirstPageVC.swift
//  Blessed
//
//  Created by woonKim on 2023/12/23.
//

import UIKit

class FirstPageVC: UIViewController {
    
    @IBOutlet weak var viewForContent: UIView!
    @IBOutlet weak var wordLbl: UILabel!
    @IBOutlet weak var wordChapterLbl: UILabel!
    var wordDataInFirstPageVC: WordData = WordData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wordLbl.font = UIFont(name: "Copperplate", size: 23)
        wordLbl.textAlignment = .center
        wordLbl.numberOfLines = 0
        wordLbl.text = wordDataInFirstPageVC.words[7]

        wordChapterLbl.font = UIFont(name: "Copperplate", size: 16)
        wordChapterLbl.textAlignment = .center
        wordChapterLbl.text = wordDataInFirstPageVC.wordChapter[0]
        
        NotificationCenter.default.addObserver(self, selector: #selector(resetWordLbl(_:)), name: Notification.Name("resetWordLblFirstPageVC"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(resetWordChapterLbl(_:)), name: Notification.Name("resetWordChapterLblFirstPageVC"), object: nil)
        
    }
    
    private func vcInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
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




