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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @IBAction func send(_ sender: UIButton) {
        messageTextField.resignFirstResponder()
        if messageTextField.text.count == 0 ||
            messageTextField.text == "Write Your Message Here"{
        }else{
            
            messageTextField.text = "Write Your Message Here"
            messageTextField.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
}


extension ChatVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row % 2 == 0{
            let cell = messageTableView.dequeueReusableCell(withIdentifier: "fromcell", for: indexPath)
            return cell
        }
        else{
            let cell = messageTableView.dequeueReusableCell(withIdentifier: "tocell", for: indexPath)
            return cell
        }
            
    }
    
    
}
