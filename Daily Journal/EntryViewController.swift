//
//  EntryViewController.swift
//  Daily Journal
//
//  Created by Harris Zacharis on 4/5/21.
//

import UIKit

class EntryViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var entryTextView: UITextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var entry : Entry?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        if entry == nil {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                entry = Entry(context: context)
                entry?.date = datePicker.date
                entry?.text = "Today was ..."
                //entryTextView.becomeFirstResponder()
            }
        }
        
        entryTextView.text = entry?.text
        if let dateToBeShown = entry?.date {
            datePicker.date = dateToBeShown
        }
        
        entryTextView.delegate = self
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        entry?.date = datePicker.date
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        //Any time the user types something new, it is saved.
        entry?.text = entryTextView.text
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    @IBAction func deleteEntryTapped(_ sender: Any) {
        if entry != nil {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                context.delete(entry!)
                try? context.save()
            }
        }
        
        //Return to previous viewController
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            bottomConstraint.constant = keyboardHeight
        }
    }
}
