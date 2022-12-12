//
//  TextInputView.swift
//  TextStrock
//
//  Created by PosterMaker on 12/1/22.
//

import UIKit

protocol TextInputViewDelegate{
    func buttonAction(text:String?)
}

class TextInputView: UIView, NibLoadable {
    @IBOutlet weak var textInputView: UITextView!
    var delegate:TextInputViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
        configureView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFromNib()
        //inputTextView.delegate = self
        configureView()
    }
    
    func configureView(){
    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        hideKeyboard()
        delegate?.buttonAction(text: textInputView.text)
    }
    @IBAction func cancelButtonAction(_ sender: Any) {
        hideKeyboard()
        delegate?.buttonAction(text: nil)
    }
    
    
    func setText(text: String) {
        textInputView.becomeFirstResponder()
    }
    
    private func hideKeyboard() {
        textInputView.resignFirstResponder()
    }

}

extension TextInputView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
}


