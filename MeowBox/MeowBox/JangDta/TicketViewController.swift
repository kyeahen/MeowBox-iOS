//
//  TicketViewController.swift
//  MeowBox
//
//  Created by 장한솔 on 2018. 7. 5..
//  Copyright © 2018년 yeen. All rights reserved.
//

import UIKit

class TicketViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var usingTicketView: UIView!
    @IBOutlet weak var usingTicketNameLabel: UILabel!
    @IBOutlet weak var usingTicketTermLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        usingTicketView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "one-ticket-pink"))
        usingTicketNameLabel.text = "3개월 정기권"
        usingTicketTermLabel.text = "2018.04.26 - 2018.06.26"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(checkTicketAction))
        
        usingTicketView.addGestureRecognizer(tap)

    }
    
    @objc func checkTicketAction(){
        let checkVC = UIStoryboard(name: "Mypage2", bundle: nil).instantiateViewController(withIdentifier: "CheckTicketViewController") as! CheckTicketViewController
        
        checkVC.myTicketName = usingTicketNameLabel.text!
        checkVC.myTicketTerm = usingTicketTermLabel.text!
        
        self.navigationController?.pushViewController(checkVC, animated: true)
        
    }

    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: 정기권 취소 액션
    @IBAction func ticketCancelAction(_ sender: Any) {
        
        let cancelPopUp = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: TicketCancelPopUpViewController.reuseIdentifier) as! TicketCancelPopUpViewController
        
        self.addChildViewController(cancelPopUp)
        cancelPopUp.view.frame = self.view.frame
        self.view.addSubview(cancelPopUp.view)
        
        cancelPopUp.didMove(toParentViewController: self)
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TicketTableViewCell") as! TicketTableViewCell
        if indexPath.row == 0{
            cell.ticketView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "ticket-gray.png"))
            cell.ticketNameLabel.text = "6개월 정기권"
            cell.ticketTermLabel.text = "2018.08.26 - 2018.01.26"
        }else{
            cell.ticketView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "one-ticket-gray.png"))
            cell.ticketNameLabel.text = "생일축하해! 박스"
            cell.ticketTermLabel.text = "2018.06.26"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    

}
