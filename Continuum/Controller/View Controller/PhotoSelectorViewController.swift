//
//  PhotoSelectorViewController.swift
//  Continuum
//
//  Created by Victor Monteiro on 7/2/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

protocol PhotoSelectorDelegate: AnyObject {
    func photoPickerSelected(image: UIImage)
}


class PhotoSelectorViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var selectImageButton: UIButton!
    
    //MARK: - Variables
    var pickerController = UIImagePickerController()
    weak var delegate: PhotoSelectorDelegate?
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        postImageView.image = nil
        selectImageButton.setTitle("Select image", for: .normal)
    }
    
    //MARK: - IBActions
    @IBAction func selectImageButtonTapped(_ sender: UIButton) {
        pickingImage()
    }
    
    //MARK: Methods
    func setupView() {
        self.pickerController.delegate = self
    }
    
    func showAlertWhenThereIsNoImage(alertType: String) {
        
        var title: String = ""
        var message: String = ""
        
        if alertType == "image" {
            title = "No image"
            message = "You need to select an image"
        } else {
            title = "No caption"
            message = "Your post has no caption"
        }
        
        let alert = UIAlertController(title:title , message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func pickingImage() {
        
        let alertController = UIAlertController(title: "Select a picture", message: "how would you like to choose a picture?", preferredStyle: .actionSheet)
        let pickFromLibraryAction = UIAlertAction(title: "Library", style: .default) { (_) in
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.pickerController.sourceType = .photoLibrary
                self.pickerController.allowsEditing = true
                self.present(self.pickerController, animated: true, completion: nil)
            } else {
                print("Library is not available in this device")
            }
        }
        
        let takePictureAction = UIAlertAction(title: "Take Picture", style: .default) { (_) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.pickerController.sourceType = .camera
                self.pickerController.isEditing = true
                self.pickerController.cameraCaptureMode = .photo
                self.pickerController.cameraDevice = .rear
                self.present(self.pickerController, animated: true, completion: nil)
            }
        }
        
        alertController.addAction(pickFromLibraryAction)
        alertController.addAction(takePictureAction)
        self.present(alertController, animated: true)
    }
    
}

extension PhotoSelectorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var image: UIImage = UIImage()
        
        if  let editedImage = info[.editedImage] as? UIImage {
            image = editedImage
            self.postImageView.image = image
            guard let delegate = delegate else { return }
            delegate.photoPickerSelected(image: editedImage)
        } else if let originalImage =  info[.originalImage] as? UIImage  {
            image = originalImage
            self.postImageView.image = image
            guard let delegate = delegate else { return }
            delegate.photoPickerSelected(image: originalImage)
        }
        
        self.pickerController.dismiss(animated: true, completion: nil)
    }
    
}
