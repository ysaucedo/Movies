//
//  CatalogVC.swift
//  Movies
//
//  Created by Yair Saucedo on 07/01/22.
//

import UIKit
import Kingfisher

class CatalogVC: UIViewController {

    var viewModel = ViewModelCatalog()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var moviesFavorite: UICollectionView!
    @IBOutlet weak var moviesRecommendations: UICollectionView!
    @IBOutlet weak var moviesRated: UICollectionView!
    @IBOutlet weak var showsFavorite: UICollectionView!
    @IBOutlet weak var showsRecommendations: UICollectionView!
    @IBOutlet weak var showsRated: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureView()
        bind()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func configureView() {
        moviesFavorite.delegate = self
        moviesFavorite.dataSource = self
        moviesRecommendations.delegate = self
        moviesRecommendations.dataSource = self
        moviesRated.delegate = self
        moviesRated.dataSource = self
        showsFavorite.delegate = self
        showsFavorite.dataSource = self
        showsRecommendations.delegate = self
        showsRecommendations.dataSource = self
        showsRated.delegate = self
        showsRated.dataSource = self

        getNextPage(category: .popular)
        getNextPage(category: .upcoming)
        getNextPage(category: .top_rated)

        getNextPageSerie(category: .popular)
        getNextPageSerie(category: .latest)
        getNextPageSerie(category: .top_rated)
        

         
    }
    
    private func getNextPage(category:Category) {
        viewModel.retriveData(category: category, completion: {
            (respuesta) in
            if (respuesta != nil) {
                let shareMenu = UIAlertController(title: nil, message: "Ocurrió un error al consultar el servicio. ¿Quieres intentar nuevamente?", preferredStyle: .alert)
                let aceptAction = UIAlertAction(title: "Reintentar", style: .default, handler:  { action in
                    self.configureView()
                })
                let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
                shareMenu.addAction(aceptAction)
                shareMenu.addAction(cancelAction)
                DispatchQueue.main.async {
                    self.present(shareMenu, animated: true, completion: nil)
                }
            }
        })

    }
    
    private func getNextPageSerie(category:Category) {
        viewModel.retriveDataSerie(category: category, completion: {
            (respuesta) in
            if (respuesta != nil) {
                let shareMenu = UIAlertController(title: nil, message: "Ocurrió un error al consultar el servicio. ¿Quieres intentar nuevamente?", preferredStyle: .alert)
                let aceptAction = UIAlertAction(title: "Reintentar", style: .default, handler:  { action in
                    self.configureView()
                })
                let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
                shareMenu.addAction(aceptAction)
                shareMenu.addAction(cancelAction)
                DispatchQueue.main.async {
                    self.present(shareMenu, animated: true, completion: nil)
                }
            }
        })

    }
    
    private func bind() {
 
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.moviesFavorite.reloadData()
                /*
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
                 */
            }
        }
        
        viewModel.refreshDataRecommendations = { [weak self] () in
            DispatchQueue.main.async {
                self?.moviesRecommendations.reloadData()
            }
        }

        viewModel.refreshDataRated = { [weak self] () in
            DispatchQueue.main.async {
                self?.moviesRated.reloadData()
            }
        }
        
        viewModel.refreshDataSerie = { [weak self] () in
            DispatchQueue.main.async {
                self?.showsFavorite.reloadData()
            }
        }
        
        viewModel.refreshDataSerieRecommendations = { [weak self] () in
            DispatchQueue.main.async {
                self?.showsRecommendations.reloadData()
            }
        }

        viewModel.refreshDataSerieRated = { [weak self] () in
            DispatchQueue.main.async {
                self?.showsRated.reloadData()
            }
        }
        
    }

}

extension CatalogVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == moviesFavorite {
            return viewModel.dataArray.count
        } else if collectionView == moviesRated {
            return viewModel.dataArrayRated.count
        } else if collectionView == moviesRecommendations {
            return viewModel.dataArrayRecommendations.count
        } else if collectionView == showsFavorite {
            return viewModel.dataArraySerie.count
        } else if collectionView == showsRated {
            return viewModel.dataArraySerieRated.count
        } else {
            return viewModel.dataArraySerieRecommendations.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CatalogCollectionViewCell
        
        var object: Show?
        var objectSerie: Serie?

        if collectionView == moviesFavorite{
            object = viewModel.dataArray[indexPath.row]
        } else if collectionView == moviesRated {
            object = viewModel.dataArrayRated[indexPath.row]
        } else if collectionView == moviesRecommendations {
            object = viewModel.dataArrayRecommendations[indexPath.row]
        } else if collectionView == showsFavorite {
            objectSerie = viewModel.dataArraySerie[indexPath.row]
        } else if collectionView == showsRated {
            objectSerie = viewModel.dataArraySerieRated[indexPath.row]
        } else {
            objectSerie = viewModel.dataArraySerieRecommendations[indexPath.row]
        }
        
        if let poster_path = object?.poster_path {
            let url = URL(string: "\(urls.regularImageBaseURLString)/\(poster_path)")
            cell.imageShow?.kf.setImage(with: url)
        } else if let poster_path = objectSerie?.poster_path {
            let url = URL(string: "\(urls.regularImageBaseURLString)/\(poster_path)")
            cell.imageShow?.kf.setImage(with: url)
        } else {
            if #available(iOS 13.0, *) {
                cell.imageShow.image = UIImage(systemName: "nosign")
            } else {
                // Fallback on earlier versions
            }
        }
                        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if collectionView == moviesFavorite {
            if indexPath.row == viewModel.dataArray.count - 7 {
                getNextPage(category: .popular)
            }
        } else if collectionView == moviesRated {
            if indexPath.row == viewModel.dataArrayRated.count - 7 {
                getNextPage(category: .top_rated)
            }
        } else if collectionView == moviesRecommendations  {
            if indexPath.row == viewModel.dataArrayRecommendations.count - 7 {
                getNextPage(category: .upcoming)
            }
        } else if collectionView == showsFavorite {
            if indexPath.row == viewModel.dataArraySerie.count - 7 {
                getNextPageSerie(category: .popular)
            }
        } else if collectionView == showsRated {
            if indexPath.row == viewModel.dataArraySerieRated.count - 7 {
                getNextPageSerie(category: .top_rated)
            }
        } else if collectionView == showsRecommendations  {
            if indexPath.row == viewModel.dataArraySerieRecommendations.count - 7 {
                getNextPageSerie(category: .upcoming)
            }
        }
            
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var object: Show?
        var objectSerie: Serie?

        if collectionView == moviesFavorite{
            object = viewModel.dataArray[indexPath.row]
        } else if collectionView == moviesRated {
            object = viewModel.dataArrayRated[indexPath.row]
        } else if collectionView == moviesRecommendations {
            object = viewModel.dataArrayRecommendations[indexPath.row]
        } else if collectionView == showsFavorite {
            objectSerie = viewModel.dataArraySerie[indexPath.row]
        } else if collectionView == showsRated {
            objectSerie = viewModel.dataArraySerieRated[indexPath.row]
        } else {
            objectSerie = viewModel.dataArraySerieRecommendations[indexPath.row]
        }
        
        if object != nil {
            let vc: ShowDetailVC = ShowDetailVC.instantiate(appStoryboard: .main)
            vc.show = object
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if objectSerie != nil {
            let vc: SerieDetailVC = SerieDetailVC.instantiate(appStoryboard: .main)
            vc.show = objectSerie
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
