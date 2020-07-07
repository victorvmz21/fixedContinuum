//
//  AddPostTableViewController.swift
//  Continuum
//
//  Created by Victor Monteiro on 6/30/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

class AddPostTableViewController: UITableViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var captionTextField: UITextField!
    
    //MARK: - Properties
    var image: UIImage?
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        captionTextField.text = ""
        
    }
    
  
    @IBAction func addPostButtonTapped(_ sender: UIButton) {
        
        guard let image = image else  {
            showAlertWhenThereIsNoImage(alertType: "image")
            return }
        
        guard let caption = captionTextField.text, !caption.isEmpty else {
            showAlertWhenThereIsNoImage(alertType: "caption")
            return }
        
        PostController.shared.createPostWith(photo: image, caption: caption) { (post) in
            DispatchQueue.main.async {
                self.tabBarController?.selectedIndex = 0
            }
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.tabBarController?.selectedIndex = 0
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
    
 
    // MARK: - Table view data source
   
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPickerPhotoVC" {
            let destination = segue.destination as? PhotoSelectorViewController
            destination?.delegate = self
        }
     }
}

extension AddPostTableViewController: PhotoSelectorDelegate {
    func photoPickerSelected(image: UIImage) {
        self.image = image
    }
}
