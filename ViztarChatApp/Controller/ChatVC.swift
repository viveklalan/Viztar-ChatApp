//
//  ChatVC.swift
//  ViztarChatApp
//
//  Created by Jai Mataji on 02/02/21.
//

import UIKit

class ChatVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var messageTextField: UITextView!
    @IBOutlet weak var messageTableView: UITableView!
    
    var chatDict = [String:String]()
    var chatKeys = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewOnLoad()
        loadData()
    }
    
    func setupViewOnLoad(){
        messageTextField.center = self.view.center
        messageTextField.textAlignment = .justified
        messageTextField.layer.cornerRadius = 8
        messageTextField.layer.borderWidth = 1
        messageTextField.layer.borderColor = UIColor.gray.cgColor
        messageTextField.delegate = self
        messageTextField.text = "Write Your Message Here"
        messageTextField.textColor = UIColor.lightGray
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 50
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func loadData(){
        do {
            let dictionary = try VLUtility.loadPropertyList()
            chatDict = dictionary
            chatKeys = Array(chatDict.keys)
            chatKeys.sort(by: <)
            messageTableView.reloadData()
            scrollToBottom()
            
        } catch {
            print(error)
        }
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.chatKeys.count-1, section: 0)
            indexPath.row >= 0 ? self.messageTableView.scrollToRow(at: indexPath, at: .bottom, animated: false) : nil
        }
    }
    
    //MARK:Keyboard events
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    //MARK:TextView Delegates
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write Your Message Here"
            textView.textColor = UIColor.lightGray
        }
    }
    
    //MARK:Button Actions
    @IBAction func send(_ sender: UIButton) {
        messageTextField.resignFirstResponder()
        if messageTextField.text.count == 0 ||
            messageTextField.text == "Write Your Message Here"{
        }else{
            
            do {
                var dictionary = try VLUtility.loadPropertyList()
                dictionary.updateValue(messageTextField.text, forKey: "\(Date().timeIntervalSince1970)")
                try VLUtility.savePropertyList(dictionary)
                loadData()
            } catch {
                print(error)
            }
            messageTextField.text = "Write Your Message Here"
            messageTextField.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
}

//MARK:TableView Delegates
extension ChatVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0{
            let cell = messageTableView.dequeueReusableCell(withIdentifier: "tocell", for: indexPath) as! toCell
            
            cell.messageView.layer.cornerRadius = 4
            cell.messageLabel.text = chatDict[chatKeys[indexPath.row]]
            cell.messageTimeLabel.text = VLUtility.dateForTimestamp(ts: chatKeys[indexPath.row])
            return cell
        }
        else{
            let cell = messageTableView.dequeueReusableCell(withIdentifier: "fromcell", for: indexPath) as! fromCell
            
            cell.messageView.layer.cornerRadius = 4
            cell.messageLabel.text = chatDict[chatKeys[indexPath.row]]
            cell.messageTimeLabel.text = VLUtility.dateForTimestamp(ts: chatKeys[indexPath.row])
            return cell
        }
    }
}


class fromCell: UITableViewCell{
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageTimeLabel: UILabel!
}

class toCell: UITableViewCell{
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageTimeLabel: UILabel!
}
