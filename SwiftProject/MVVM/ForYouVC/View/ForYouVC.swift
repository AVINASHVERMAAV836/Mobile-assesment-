//
//  ViewController.swift
//  SwiftProject
//
//  Created by Admin on 02/04/24.
//

import UIKit
import SDWebImage

//MARK: @IBOutlet.........................
class ForYouVC: UIViewController {
    
    @IBOutlet weak var foryouTV: UITableView!
    var forYouVM = ForYouViewModel()
    var forYouResponse: ForyouResponse?
    
}

//MARK: View Controller life Cycle......................
extension ForYouVC{
    override func viewDidLoad() {
        super.viewDidLoad()
        forYouVM.delegate = self
        foryouTV.register(UINib(nibName: "ForYouTVCell", bundle: nil), forCellReuseIdentifier: "ForYouTVCell")
        forYouVM.getTrackList()
    }

}

//MARK: UITableView Delegate and Datasource......................
extension ForYouVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forYouResponse?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = foryouTV.dequeueReusableCell(withIdentifier: "ForYouTVCell") as? ForYouTVCell else{
            return UITableViewCell()
        }
        cell.artistName.text = forYouResponse?.data?[indexPath.row].artist ?? ""
        cell.trackName.text = forYouResponse?.data?[indexPath.row].name ?? ""
        cell.trackImg.layer.cornerRadius = 25.0
        let coverId = forYouResponse?.data?[indexPath.row].cover ?? ""
        let url = URL(string: "\(imageUrl)\(coverId)")
        cell.trackImg.sd_setImage(with: url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ViewControllerAssesories.songVC
        vc.selectedIndex = indexPath.row
        vc.songResponseData = forYouResponse?.data
        self.navigationController?.present(vc, animated: true)
    }
    
}


//MARK: ForYouViewModelDelegate.......................
extension ForYouVC: ForYouViewModelDelegate{
    func didReceiveTrackListResponse(response: ForyouResponse?) {
        if response?.data != nil{
            forYouResponse = response
        }else{
            self.displayAlert("Data not found!")
        }
        
        self.foryouTV.reloadData()
    }
    
    func displayAlert(_ message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (_) in
            alertController.dismiss(animated: true) 
        }
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion: nil)
    }
}


