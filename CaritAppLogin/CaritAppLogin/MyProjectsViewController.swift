//
//  MyProjectsViewController.swift
//  CaritAppLogin
//
//  Created by Alberto Estrada on 07/09/22.
//

import UIKit

class MyProjectsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    let images = ["alimentos"]
    let titles = ["Banco de Ropa"]
    let dates = ["9:00 am - 11:00 am Lun Mar Mie Jue Vie"]

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celli = collectionView.dequeueReusableCell(withReuseIdentifier: "post5", for: indexPath) as! Post5
        celli.image.image = UIImage(named: images[indexPath.row])
        celli.title.text = titles[indexPath.row]
        celli.date.text = dates[indexPath.row]
        
        return celli
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

class Post5: UICollectionViewCell {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    
    @IBOutlet weak var date: UILabel!
    override func awakeFromNib() {
        background.layer.cornerRadius = 12
        image.layer.cornerRadius = 12
        }
}
