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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topText.isHidden = true
        bottomText.isHidden = true
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
        
        topText.textColor = UIColor.white
        bottomText.textColor = UIColor.white
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var newText = textField.text! as NSString
        newText = newText.replacingCharacters(in: range, with: string) as NSString
        
        return newText.length <= 25
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        shareButton.isEnabled = true
        return true;
    }
}

