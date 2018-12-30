//
//  ViewController.swift
//  MemeMe!
//
//  Created by Jasmeet Singh on 2018-12-29.
//  Copyright © 2018 Jusmyth. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.yellow,
        NSAttributedString.Key.foregroundColor: UIColor.red,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: 5]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topText.isHidden = true
        bottomText.isHidden = true
        
        topText.defaultTextAttributes = memeTextAttributes
        bottomText.defaultTextAttributes = memeTextAttributes
        
        shareButton.isEnabled = false
        
        self.topText.delegate = self
        self.bottomText.delegate = self
        
    }

    @IBAction func PickImageAction(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        if (sender.tag == 0) {
            imagePicker.sourceType = .camera
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func shareImageAction(_ sender: UIBarButtonItem) {
        print("This is share image action")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imagePickerView.image = image
        }
        dismiss(animated: true, completion: nil)
        readyToAddText()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    func readyToAddText() {
        topText.isHidden = false
        bottomText.isHidden = false
        
        topText.isUserInteractionEnabled = true
        bottomText.isUserInteractionEnabled = true
        
        topText.text = ""
        bottomText.text = ""
        
        topText.backgroundColor = UIColor.lightText
        bottomText.backgroundColor = UIColor.lightText
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var newText = textField.text! as NSString
        newText = newText.replacingCharacters(in: range, with: string) as NSString
        
        
        return newText.length <= 25
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        shareButton.isEnabled = true
        
        if ((textField.text! as NSString).length == 0) {
            textField.backgroundColor = UIColor.lightText
        }
        return true;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor.clear
        textField.textAlignment = NSTextAlignment.center
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if ((textField.text! as NSString).length == 0) {
            textField.backgroundColor = UIColor.lightText
        }
    }
}

