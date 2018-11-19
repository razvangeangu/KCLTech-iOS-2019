//
//  AddReminderViewController.swift
//  iRemember
//
//  Created by Răzvan-Gabriel Geangu on 12/11/2018.
//  Copyright © 2018 Răzvan-Gabriel Geangu. All rights reserved.
//

import UIKit

class AddReminderViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(with:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        textView.becomeFirstResponder()
    }
    
    @objc func keyboardWillShow(with notification: Notification) {
        let key = "UIKeyboardFrameEndUserInfoKey"
        guard let keyboardFrame = notification.userInfo?[key] as? NSValue else { return }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        bottomConstraint.constant = keyboardHeight
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func didPressDone(_ sender: Any) {
    }
    
    @IBAction func didPressCancel(_ sender: Any) {
        dismiss(animated: true)
        textView.resignFirstResponder()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddReminderViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        if doneButton.isHidden {
            textView.text.removeAll()
            textView.textColor = .white
            doneButton.isHidden = false
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
}
