//
//  ViewController.swift
//  PictureGram


import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    let backgrounImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "bg")
        return iv
    }()
    
    let imagesCellId = "imagesCellId"
    let albumsCellId = "albumsCellId"
    let imagesArray = ["image1","image2","image3","image4","image5"]
    let albumArray = ["album1","album2","album3","album4","album5","album6","album7","album8","album9"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(ImagesCell.self, forCellWithReuseIdentifier: imagesCellId)
        collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: albumsCellId)
        
        view.addSubview(backgrounImageView)
        view.addSubview(collectionView)
        
        backgrounImageView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        collectionView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return albumArray.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: albumsCellId, for: indexPath) as! AlbumCell
            cell.album = albumArray[indexPath.item]
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imagesCellId, for: indexPath) as! ImagesCell
        cell.images = imagesArray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1{
            return CGSize(width: (view.frame.width / 3) - 16, height: 100)
        }
        return CGSize(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1{
            return UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        }
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
}

class ImagesCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var images: [String]? {
        didSet{
            collectionView.reloadData()
        }
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    let cellId = "cellId"
    
    func setup(){
        //backgroundColor = .red
        addSubview(collectionView)
        collectionView.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(IconsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.showsHorizontalScrollIndicator = false
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! IconsCell
        if let imageName = images?[indexPath.item]{
            cell.imageView.image = UIImage(named: imageName)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: frame.height - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    private class IconsCell: UICollectionViewCell{
        
        let imageView: UIImageView = {
            
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            iv.layer.cornerRadius = 15
            return iv
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            //backgroundColor = .blue
            setup()
        }
        
        func setup(){
            setCellShadow()
            //backgroundColor = .blue
            addSubview(imageView)
            
            imageView.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AlbumCell: UICollectionViewCell{
    
    var album: String?{
        didSet{
            if let albumImage = album{
                albumImageView.image = UIImage(named: albumImage)
            }
        }
    }
    
    let albumImageView: UIImageView = {
        
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 15
        return iv
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
        //backgroundColor = .green
    }
    
    func setup(){
        addSubview(albumImageView)
        setCellShadow()
        albumImageView.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
