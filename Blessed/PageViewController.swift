//
//  PageViewController.swift
//  Blessed
//
//  Created by woonKim on 2023/12/23.
//

import UIKit
import SnapKit
import Then

class PageViewController: UIPageViewController {
        
    var wordData: WordData = WordData()
    
    lazy var vcArray: [UIViewController] = {
        return [self.vcInstance(name: "FirstPageVC"),
                self.vcInstance(name: "SecondPageVC"),
                self.vcInstance(name: "ThirdPageVC")]
    }()
    
    let pageControl = UIPageControl().then {
        _ in
    }
    
    let customizeColorStackView = UIStackView().then {
        $0.layer.borderWidth = 3
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.cornerRadius = 16
    }
    
    let textColorToBlackBtn = UIButton().then {
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 15
        $0.titleLabel?.font = UIFont(name: "Copperplate", size: 21)
        $0.setTitle("T", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
    }
    
    let textColorToWhiteBtn = UIButton().then {
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 15
        $0.titleLabel?.font = UIFont(name: "Copperplate", size: 21)
        $0.setTitle("T", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
    }
    
    let backgroundColorPicker = UIColorWell(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
    
    let resetWordBtn = UIButton().then {
        $0.setBackgroundImage(UIImage(systemName: "arrow.triangle.2.circlepath.circle.fill"), for: .normal)
        $0.backgroundColor = .clear
        $0.tintColor = UIColor.lightGray
        $0.addTarget(self, action: #selector(resetWordBtnTapped(_:)), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        if let firstVC = vcArray.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        view.addSubview(pageControl)
        pageControl.isEnabled = false
        pageControl.numberOfPages = vcArray.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        
        pageControl.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(65)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(resetWordBtn)
        resetWordBtn.snp.makeConstraints {
            $0.width.equalTo(35)
            $0.height.equalTo(35)
            $0.bottom.equalToSuperview().inset(170)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(customizeColorStackView)
        customizeColorStackView.axis = .horizontal
        customizeColorStackView.snp.makeConstraints {
            $0.width.equalTo(150)
            $0.height.equalTo(45)
            $0.bottom.equalToSuperview().inset(70)
            $0.centerX.equalToSuperview()
        }
        customizeColorStackView.addSubview(textColorToBlackBtn)
        textColorToBlackBtn.snp.makeConstraints {
            $0.width.equalTo(30)
            $0.height.equalTo(30)
            $0.leading.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
        customizeColorStackView.addSubview(textColorToWhiteBtn)
        textColorToWhiteBtn.snp.makeConstraints {
            $0.width.equalTo(30)
            $0.height.equalTo(30)
            $0.center.equalToSuperview()
        }
        customizeColorStackView.addSubview(backgroundColorPicker)
        backgroundColorPicker.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func vcInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    @objc func resetWordBtnTapped(_ sender: Any) {
        
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        // pi = 180도
        rotation.toValue = Double.pi
        // 1바퀴 도는데 걸리는 시간
        rotation.duration = 0.5
        // 반복 횟수 = infinity(무한대)
        rotation.repeatCount = 1
        resetWordBtn.layer.add(rotation, forKey: "rotationAnimation")
        
        wordData.resetWordDictionaryData = Dictionary(uniqueKeysWithValues: wordData.wordDictionary.shuffled())
        
        NotificationCenter.default.post(name: Notification.Name("resetWordLblFirstPageVC"), object: Array(wordData.resetWordDictionaryData.values)[0])
        NotificationCenter.default.post(name: Notification.Name("resetWordChapterLblFirstPageVC"), object: Array(wordData.resetWordDictionaryData.keys)[0])
        
        NotificationCenter.default.post(name: Notification.Name("resetWordLblSecondPageVC"), object: Array(wordData.resetWordDictionaryData.values)[1])
        NotificationCenter.default.post(name: Notification.Name("resetWordChapterLblSecondPageVC"), object: Array(wordData.resetWordDictionaryData.keys)[1])
        
        NotificationCenter.default.post(name: Notification.Name("resetWordLblThirdPageVC"), object: Array(wordData.resetWordDictionaryData.values)[2])
        NotificationCenter.default.post(name: Notification.Name("resetWordChapterLblThirdPageVC"), object: Array(wordData.resetWordDictionaryData.keys)[2])
    }
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // 배열에서 현재 페이지의 컨트롤러를 찾아서 해당 인덱스를 현재 인덱스로 기록
        guard let vcIndex = vcArray.firstIndex(of: viewController) else {
            return nil
        }
        
        // 이전 페이지 인덱스
        let prevIndex = vcIndex - 1
        
        // 인덱스가 0 이상이라면 그냥 놔둠
        guard prevIndex >= 0 else {
            return nil
        }
        
        // 인덱스는 vcArray.count 이상이 될 수 없음
        guard vcArray.count > prevIndex else { return nil }
        
        return vcArray[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = vcArray.firstIndex(of: viewController) else { return nil }
        
        // 다음 페이지 인덱스
        let nextIndex = vcIndex + 1
        
        guard nextIndex < vcArray.count else {
            return nil
        }
        
        guard vcArray.count > nextIndex else { return nil }
        
        return vcArray[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = vcArray.firstIndex(of: pageContentViewController)!
    }
}

public extension UIView {
    
    func fadeIn(duration: TimeInterval = 0.3) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    
    func fadeOut(duration: TimeInterval = 0.3) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
}
