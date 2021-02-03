//
//  MemberListVC.swift
//  ViztarChatApp
//
//  Created by Jai Mataji on 02/02/21.
//

import UIKit

class MemberListVC: UIViewController {

    @IBOutlet weak var memberListTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }

    func getLastMessage()->String{
        do {
            let dictionary = try VLUtility.loadPropertyList()
            let chatDict = dictionary
            var chatKeys = Array(chatDict.keys)
            chatKeys.sort(by: <)
            
            return chatDict[chatKeys.last ?? ""] ?? ""
        } catch {
            return ""
        }
    }

}

extension MemberListVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = memberListTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! memberCell
        
        cell.messageLabel.text = getLastMessage()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "ChatVC")
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
}


class memberCell: UITableViewCell{
    @IBOutlet weak var messageLabel: UILabel!
}
