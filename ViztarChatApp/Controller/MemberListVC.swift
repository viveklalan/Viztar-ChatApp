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


}

extension MemberListVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = memberListTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "ChatVC")
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
}
