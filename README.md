# Movies

Prueba Técnica iOS

El proyecto consta de las siguientes capas

View Conformado por los elementos de la interfase (Stooryboard) y las clases UIViewController 
-Main.storyboard 
-CatalogVC
-ShowDetailVC
-SerieDetailVC 
-VideoCollectionViewCell

Model -Show -Serie -ShowTheMovie -SerieTheMovie -Video

ViewModel 
-ViewModelCatalog 
-ViewModelDetail 
-ViewModelSerieDetail

Network 
-TheMovieDB 
-SerieDB 
-VideoDB

Persist 
-Model.xcdatamodeld

Responsabilidad de las capas: View: Encargada de mostrar los elementos visuales de la App Model: Representan las entidades de nuestro modelo ViewModel: Capa que conecta la vista con los provider de datos, em este caso tenemos proveedoores de red y de base de datos loca para modo fuera de línea. Network: Consume la API Rest para traernos la informaión. Persist: Consiste en la base de datos local.
