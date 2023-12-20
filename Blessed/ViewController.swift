//
//  ViewController.swift
//  Blessed
//
//  Created by woonKim on 2023/12/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var wordLbl: UILabel!
    @IBOutlet weak var wordChapterLbl: UILabel!
    
    var words: [String] = ["The LORD bless you, and keep you. The LORD make his face to shine on you, and be gracious to you. The LORD lift up his face towards you, and give you peace.", "Blessed be the God and Father of our Lord Jesus Christ, who has blessed us with every spiritual blessing in the heavenly places in Christ.", "Blessed is the man who doesn’t walk in the counsel of the wicked, nor stand on the path of sinners, nor sit in the seat of scoffers.", "Blessed are the merciful, for they shall obtain mercy.", "My God will supply every need of yours according to his riches in glory in Christ Jesus.", "Blessed are those who hunger and thirst for righteousness, for they shall be filled.", "Blessed is the man who trusts in the LORD, and whose confidence is in the LORD.", "The LORD will command the blessing on you in your barns, and in all that you put your hand to. He will bless you in the land which the LORD your God gives you."]
    
    var wordChapter: [String] = ["Numbers 6:24-26", "Ephesians 1:3", "Psalms 1:1", "Matthew 5:7", "Philippians 4:19", "Matthew 5:6", "Jeremiah 17:7", "Deuteronomy 28:8"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordLbl.font = UIFont(name: "Copperplate", size: 24)
        wordLbl.textAlignment = .center
        wordLbl.numberOfLines = 0
        
        let randomElement = words.randomElement()!
        let index = words.firstIndex(of: randomElement)!
        
        wordLbl.text = randomElement

        wordChapterLbl.font = UIFont(name: "Copperplate", size: 16)
        wordChapterLbl.textAlignment = .center
        wordChapterLbl.text = wordChapter[index]
    }
}

