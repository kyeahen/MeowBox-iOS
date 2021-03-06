//
//  Order1ContainerViewController.swift
//  MeowBox
//
//  Created by 장한솔 on 2018. 7. 4..
//  Copyright © 2018년 yeen. All rights reserved.
//

import UIKit
import Kingfisher

class Order1ContainerViewController: UIViewController {
    
    let userDefault = UserDefaults.standard
    
    @IBOutlet weak var barBtn: UIBarButtonItem!
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var hiddenImageView: UIImageView!
    
    @IBOutlet weak var leadingC: NSLayoutConstraint!
    @IBOutlet weak var trailingC: NSLayoutConstraint!
    @IBOutlet weak var hiddenLeadingC: NSLayoutConstraint!
    @IBOutlet weak var hiddenTrailingC: NSLayoutConstraint!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var loginInfoLabel: UILabel!
    
    var myCatName = ""
    
    var sideBarIsVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginCheck()
        profileImageCheck()
        
        self.navigationItem.backBarButtonItem = barBtn
        hiddenImageView.isHidden = true
        
        //프로필 이미지 동그랗게
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.layer.frame.width/2
        profileImageView.kf.setImage(with: URL(string: gsno(userDefault.string(forKey: "image_profile"))), placeholder: UIImage())
        
        if userDefault.string(forKey: "cat_idx") == "-1"{
            add(asChildViewController: withInfoVC1)
        }else{
            add(asChildViewController: withInfoVC3)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loginCheck()
        profileImageCheck()
        
    }
    
    //MARK: 프로필 이미지 체크 함수
    func profileImageCheck() {
        let pImage = gsno(userDefault.string(forKey: "image_profile"))
        if pImage == "" {
            profileImageView.image = #imageLiteral(resourceName: "sidebar-default-img")
        }
    }
    
    //MARK: 로그인 체크 함수
    func loginCheck() {
        
        let name = gsno(userDefault.string(forKey: "name"))
        if name == "" {
            loginInfoLabel.text = "로그인이 필요합니다."
        }
        else {
            loginInfoLabel.text = "안녕하세요, \(name)님"
        }
    }
    
    private lazy var withInfoVC1: OrderWithInfoViewController = {
        var viewController = UIStoryboard(name: "Order", bundle: nil).instantiateViewController(withIdentifier: "OrderWithInfoViewController") as! OrderWithInfoViewController
        viewController.parentVC = self
        self.addChildViewController(viewController)
        return viewController
    }()
    
    private lazy var withInfoVC2: OrderWithInfo2ViewController = {
        var viewController = UIStoryboard(name: "Order", bundle: nil).instantiateViewController(withIdentifier: "OrderWithInfo2ViewController") as! OrderWithInfo2ViewController
        viewController.parentVC = self
        self.addChildViewController(viewController)
        return viewController
    }()
    
    private lazy var withInfoVC3: OrderWithInfo3ViewController = {
        var viewController = UIStoryboard(name: "Order", bundle: nil).instantiateViewController(withIdentifier: "OrderWithInfo3ViewController") as! OrderWithInfo3ViewController
        viewController.parentVC = self
        self.addChildViewController(viewController)
        return viewController
    }()
    
    private lazy var withInfoVC4: OrderWithInfo4ViewController = {
        var viewController = UIStoryboard(name: "Order", bundle: nil).instantiateViewController(withIdentifier: "OrderWithInfo4ViewController") as! OrderWithInfo4ViewController
        
        viewController.parentVC = self
        self.addChildViewController(viewController)
        return viewController
    }()
    
    private lazy var withInfoVC5: OrderCompleteViewController = {
        var viewController = UIStoryboard(name: "Order", bundle: nil).instantiateViewController(withIdentifier: "OrderCompleteViewController") as! OrderCompleteViewController
        viewController.parentVC = self
        self.addChildViewController(viewController)
        return viewController
    }()
    
    func changeVC(num : Int){
        switch num {
        case 1:
            remove(asChildViewController: withInfoVC2)
            add(asChildViewController: withInfoVC1)
            break
        case 2:
            remove(asChildViewController: withInfoVC1)
            add(asChildViewController: withInfoVC2)
            withInfoVC2.scrollView.setContentOffset(.zero, animated: true)
            break
        case 3:
            //            remove(asChildViewController: withInfoVC4)
            add(asChildViewController: withInfoVC3)
            withInfoVC3.scrollView.setContentOffset(.zero, animated: true)
            break
        case 4:
            remove(asChildViewController: withInfoVC3)
            add(asChildViewController: withInfoVC4)
            withInfoVC4.scrollView.setContentOffset(.zero, animated: true)
            break
        case 5:
            add(asChildViewController: withInfoVC5)
            break
        case 33:
            remove(asChildViewController: withInfoVC4)
            //add(asChildViewController: withInfoVC4)
            add(asChildViewController: withInfoVC3)
            withInfoVC3.scrollView.setContentOffset(.zero, animated: true)
        default:
            add(asChildViewController: withInfoVC1)
            break
        }
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        
        // Add Child View as Subview
        container.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = container.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
        
        
    }
    
    //MARK: 네비게이션 바 투명하게 하는 함수
    func setNavigationBar() {
        let bar: UINavigationBar! = self.navigationController?.navigationBar
        
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor.clear
    }
    
    @IBAction func sideBarAction(_ sender: Any) {
        
        if !sideBarIsVisible { //메뉴 보여줘야함
            
            hiddenImageView.isHidden = false
            hiddenLeadingC.constant = 258
            hiddenTrailingC.constant = -258
            
            leadingC.constant = 258
            trailingC.constant = -258
            
            sideBarIsVisible = true
            container.isUserInteractionEnabled = false
            
            self.navigationItem.leftBarButtonItem = nil
            self.navigationItem.title = nil
            
            setNavigationBar()
            
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("The animation is complete!")
        }
    }
    
    @IBAction func sideBarBackBtnAction(_ sender: Any) {
        
        hiddenImageView.isHidden = true
        
        hiddenLeadingC.constant = 0
        hiddenTrailingC.constant = 0
        leadingC.constant = 0
        trailingC.constant = 0
        
        sideBarIsVisible = false
        container.isUserInteractionEnabled = true
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("SideBar close")
        }
        
        //네비게이션바 투명 복원
        self.navigationController?.navigationBar.shadowImage = UIColor( red: CGFloat(112/255.0), green: CGFloat(112/255.0), blue: CGFloat(112/255.0), alpha: CGFloat(0.2) ).as1ptImage()
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationItem.leftBarButtonItem = self.barBtn
        self.navigationItem.title = "주문하기"
    }
    
    //MARK: 로그인 액션
    @IBAction func loginAction(_ sender: Any) {
        
        guard let hasToken = userDefault.string(forKey: "token") else { return }
        
        print("hasToken: "+hasToken)
        if hasToken == ""{
            let loginNaviVC = UIStoryboard(name: "Sign", bundle: nil).instantiateViewController(withIdentifier: "LoginNaviVC")
            
            self.present(loginNaviVC, animated: true, completion: nil)
        }else{
            let popUPVC = UIStoryboard(name: "Sign", bundle: nil).instantiateViewController(withIdentifier: "LoginMainPopUpViewController") as! LoginMainPopUpViewController
            self.addChildViewController(popUPVC)
            popUPVC.view.frame = self.view.frame
            self.view.addSubview(popUPVC.view)
            popUPVC.didMove(toParentViewController: self)
        }
        
    }
    
    //MARK: 홈 액션
    @IBAction func homeAcion(_ sender: Any) {
        
        let mainNaviVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainNaviVC")
        
        self.present(mainNaviVC, animated: true, completion: nil)
    }
    
    //MARK: 미유박스 이야기 액션
    @IBAction func storyAction(_ sender: Any) {
        
        let storyNaviVC = UIStoryboard(name: "MeowBox", bundle: nil).instantiateViewController(withIdentifier: "StoryNaviVC")
        
        self.present(storyNaviVC, animated: true, completion: nil)
    }
    
    //MARK: 생일축하해!박스 액션
    @IBAction func birthBoxAction(_ sender: Any) {
    
        let webtoonNaviVC = UIStoryboard(name: "MeowBox", bundle: nil).instantiateViewController(withIdentifier: "WebtoonNaviVC")
        
        self.present(webtoonNaviVC, animated: true, completion: nil)
    }
    
    //MARK: 주문하기 액션(기준)
    @IBAction func orderAction(_ sender: Any) {
        
        hiddenImageView.isHidden = true
        
        hiddenLeadingC.constant = 0
        hiddenTrailingC.constant = 0
        leadingC.constant = 0
        trailingC.constant = 0
        
        sideBarIsVisible = false
        container.isUserInteractionEnabled = true
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("SideBar close")
        }
        
        //네비게이션바 투명 복원
        self.navigationController?.navigationBar.shadowImage = UIColor( red: CGFloat(112/255.0), green: CGFloat(112/255.0), blue: CGFloat(112/255.0), alpha: CGFloat(0.2) ).as1ptImage()
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationItem.leftBarButtonItem = self.barBtn
        self.navigationItem.title = "주문하기"
    }
    
    
    //MARK: 집사들의 후기 액션
    @IBAction func reviewAction(_ sender: Any) {
        
        let reviewNaviVC = UIStoryboard(name: "MeowBox", bundle: nil).instantiateViewController(withIdentifier: "ReviewNaviVC")
        
        self.present(reviewNaviVC, animated: true, completion: nil)
    }
    
    
    //MARK: 마이페이지 액션
    @IBAction func myPageAction(_ sender: Any) {
        
        if userDefault.string(forKey: "token") != ""{ // 로그인이 되어 있다면
            let myPageNaviVC = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "MyPageNaviVC")
            
            self.present(myPageNaviVC, animated: true, completion: nil)
            
        }else{ // 로그인 안 된 상태
            let popUPVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: MyPagePopUpViewController.reuseIdentifier) as! MyPagePopUpViewController
            self.addChildViewController(popUPVC)
            popUPVC.view.frame = self.view.frame
            self.view.addSubview(popUPVC.view)
            popUPVC.didMove(toParentViewController: self)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    
    
    
}
