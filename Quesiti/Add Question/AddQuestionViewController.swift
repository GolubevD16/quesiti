//
//  AddQuestionViewController.swift
//  Quesiti
//
//  Created by Даниил Ярмоленко on 29.10.2021.
//

import UIKit
import GoogleMaps
import GooglePlaces


class AddQuestionViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate, UITextFieldDelegate  {
    
    
    var presenter: AddQuestionViewPresenter!
    var zoom: Float = 15.0
    let currentLocationMarker = GMSMarker()
    var locationManager = CLLocationManager()
    var chosenPlace: MyPlace?
    let circle = GMSCircle()
    var radius: Int = 200
    var adressLabel = ""
    //    var circle = GMSCircle()
    var question = [
        Question(title: "Какая погода", userID: "bjhksdf23", latitude: 24.8655, longitude: 67.0011, radius: 1000, image: UIImage(named: "people1"), name: "Daniil Yarmolenko"),
        Question(title: "Какая погода", userID: "bjhksdf23", latitude: 24.868, longitude: 67.0011, radius: 1000, image: UIImage(named: "people2"), name: "Daniil Yarmolenko"),
        Question(title: "Какая погода", userID: "bjhksdf23", latitude: 24.878, longitude: 67.0011, radius: 1000, image: UIImage(named: "people3"), name: "Daniil Yarmolenko")
    ]
    
    let customMarkerWidth: Int = 50
    let customMarkerHeight: Int = 70
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        myMapView.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        setupViews()
        
        initGoogleMaps()
        
        txtFieldSearch.delegate = self
        
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        let filter = GMSAutocompleteFilter()
        autoCompleteController.autocompleteFilter = filter
        
        self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
        return false
    } // delegdt textfield
    
    // MARK: GOOGLE AUTO COMPLETE DELEGATE
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let latitude = place.coordinate.latitude
        let longitude = place.coordinate.longitude
        
        //        showPartyMarkers(lat: longitude, long: longitude)
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 17.0)
        myMapView.camera = camera
        txtFieldSearch.text=place.formattedAddress
        chosenPlace = MyPlace(name: place.formattedAddress!, lat: latitude, long: longitude)
        let marker=GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = "\(place.name ?? "")"
        marker.snippet = "\(place.formattedAddress!)"
        marker.map = myMapView
        
        self.dismiss(animated: true, completion: nil) // dismiss after place selected
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("ERROR AUTO COMPLETE \(error)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func initGoogleMaps() {
        let camera = GMSCameraPosition.camera(withLatitude: locationManager.location?.coordinate.latitude ?? 27.0, longitude: locationManager.location?.coordinate.longitude ?? 27.0, zoom: 17.0)
        self.myMapView.camera = camera
        self.myMapView.delegate = self
        self.myMapView.isMyLocationEnabled = true
        let long = locationManager.location?.coordinate.longitude
        let lat = locationManager.location?.coordinate.latitude
        if (lat != nil && long != nil) {
            
            self.setupCircle(latitide: lat ?? 0.0, longitude: long ?? 0.0, radius: radius)
        }
        let position = CLLocationCoordinate2D(latitude: lat ?? 0.0, longitude: long ?? 0.0)
        let marker = GMSMarker(position: position)
        marker.title = "Hello World"
        marker.map = myMapView
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while getting location \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.delegate = nil
        locationManager.stopUpdatingLocation()
        let location = locations.last
        let lat = (location?.coordinate.latitude)!
        let long = (location?.coordinate.longitude)!
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: zoom)
        
        self.myMapView.animate(to: camera)
        //        showPartyMarkers(lat: lat, long: long)
    }
    
    // MARK: GOOGLE MAP DELEGATE
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        mapView.clear()
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        let position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let marker = GMSMarker(position: position)
        marker.title = "Hello World"
        marker.map = mapView
        self.setupCircle(latitide: latitude, longitude: longitude, radius: radius)
        
        
    }
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocode(coordinate: position.target)
    }
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        
        btnNextAction()
    }
    
    //    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
    //        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return false }
    //        let img = customMarkerView.img!
    //        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: img, borderColor: UIColor.white, tag: customMarkerView.tag)
    //
    //        marker.iconView = customMarker
    //        //        let camera = GMSCameraPosition.
    //        return false
    //    }
    //
    //    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
    //            zoom = mapView.camera.zoom
    //        }
    
    
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        
        addQuestionPreviewView.setData(radius: "\(radius)", adress: adressLabel)
        return addQuestionPreviewView
    }
    //    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
    //        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return }
    //        let tag = customMarkerView.tag
    //        restaurantTapped(tag: tag)
    //    }
    //
    //    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
    //        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return }
    //        let img = customMarkerView.img!
    //        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: img, borderColor: UIColor.darkGray, tag: customMarkerView.tag)
    //        marker.iconView = customMarker
    //    }
    
    
    //    func showPartyMarkers(lat: Double, long: Double) {
    //        myMapView.clear()
    //        for i in 0..<question.count {
    //            let marker = GMSMarker()
    //            let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: question[i].image, borderColor: UIColor.darkGray, tag: i)
    //            marker.iconView = customMarker
    ////            marker.position = CLLocationCoordinate2D(latitude: lat + 0.001*Double(i), longitude: long - 0.001*Double(i))
    //            marker.position = CLLocationCoordinate2D(latitude: question[i].latitude, longitude: question[i].longitude)
    //            marker.map = self.myMapView
    //        }
    //    }
    //
    
    //    private func setupCircle(){
    //        let circleCenter = CLLocationCoordinate2DMake(CLLocationDegrees(locationManager.location?.coordinate.latitude ?? 0.0), CLLocationDegrees(locationManager.location?.coordinate.longitude ?? 0.0))
    //        circle.position = circleCenter
    //        circle.fillColor = UIColor(red: 0.35, green: 0, blue: 0, alpha:  0.05)
    //        circle.strokeColor = UIColor.red
    //        circle.strokeWidth = 1
    //        circle.map = myMapView
    //
    //        circle.radius = 200
    //    }
    
    func setupTextField(textField: UITextField, img: UIImage){
        textField.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        imageView.image = img
        imageView.tintColor = ThemeColors.mainColor
        let paddingView = UIView(frame:CGRect(x: 0, y: 0, width: 30, height: 30))
        paddingView.addSubview(imageView)
        textField.leftView = paddingView
    }
    func setupCircle(latitide: CLLocationDegrees, longitude: CLLocationDegrees, radius: Int){
        let circleCenter = CLLocationCoordinate2DMake(CLLocationDegrees(latitide), CLLocationDegrees(longitude))
        circle.position = circleCenter
        circle.fillColor = UIColor(red: 0.35, green: 0, blue: 0, alpha:  0.05)
        circle.strokeColor = UIColor.red
        circle.strokeWidth = 1
        circle.map = myMapView
        
        circle.radius = CLLocationDistance(radius)
    }
    
    func setupViews() {
        self.view.addSubview(myMapView)
        myMapView.topAnchor.constraint(equalTo: view.topAnchor).isActive=true
        myMapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive=true
        myMapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive=true
        myMapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive=true
        

        
        self.view.addSubview(txtFieldSearch)
        txtFieldSearch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive=true
        txtFieldSearch.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive=true
        txtFieldSearch.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive=true
        txtFieldSearch.heightAnchor.constraint(equalToConstant: 35).isActive=true
        setupTextField(textField: txtFieldSearch, img: UIImage(systemName: "mappin.circle") ?? #imageLiteral(resourceName: "map_Pin"))
        
        //        questionPreviewView=QuestionPreviewView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 100, height: 200))
        addQuestionPreviewView = AddQuestionPreviewView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 100, height: 70))
        self.view.addSubview(slider)
        
        self.view.addSubview(containerRadiusLabel)
        containerRadiusLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive=true
        containerRadiusLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive=true
        containerRadiusLabel.heightAnchor.constraint(equalToConstant: 20).isActive=true
        containerRadiusLabel.widthAnchor.constraint(equalToConstant: 200).isActive=true
        
        containerRadiusLabel.addSubview(textRadius)
        textRadius.centerYAnchor.constraint(equalTo: containerRadiusLabel.centerYAnchor).isActive=true
        textRadius.centerXAnchor.constraint(equalTo: containerRadiusLabel.centerXAnchor).isActive=true
        
        
        self.view.addSubview(btnMyLocation)
        btnMyLocation.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive=true
        btnMyLocation.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive=true
        btnMyLocation.widthAnchor.constraint(equalToConstant: 40).isActive=true
        btnMyLocation.heightAnchor.constraint(equalTo: btnMyLocation.widthAnchor).isActive=true
        
        self.view.addSubview(btncClose)
        btncClose.topAnchor.constraint(equalTo: view.topAnchor, constant: 35).isActive=true
        btncClose.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive=true
        btncClose.widthAnchor.constraint(equalToConstant: 50).isActive=true
        btncClose.heightAnchor.constraint(equalTo: btncClose.widthAnchor).isActive=true
        
        self.view.addSubview(btnNext)
        btnNext.topAnchor.constraint(equalTo: view.topAnchor, constant: 35).isActive=true
        btnNext.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive=true
        btnNext.widthAnchor.constraint(equalToConstant: 50).isActive=true
        btnNext.heightAnchor.constraint(equalTo: btnNext.widthAnchor).isActive=true
        //
        //
        //        self.view.addSubview(btnZoomMinus)
        //        btnZoomMinus.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70).isActive=true
        //        btnZoomMinus.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive=true
        //        btnZoomMinus.widthAnchor.constraint(equalToConstant: 50).isActive=true
        //        btnZoomMinus.heightAnchor.constraint(equalTo: btnZoomMinus.widthAnchor).isActive=true
        //
        //        self.view.addSubview(btnZoomPlus)
        //        btnZoomPlus.bottomAnchor.constraint(equalTo: btnZoomMinus.topAnchor, constant: -20).isActive=true
        //        btnZoomPlus.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive=true
        //        btnZoomPlus.widthAnchor.constraint(equalTo: btnZoomMinus.widthAnchor).isActive=true
        //        btnZoomPlus.heightAnchor.constraint(equalTo: btnZoomPlus.widthAnchor).isActive=true
        
        
        
        //        slider.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90).isActive=true
        //        slider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive=true
        //        slider.widthAnchor.constraint(equalToConstant: 200).isActive=true
        //        slider.heightAnchor.constraint(equalToConstant: 50).isActive=true
        //
        //
        //        self.view.addSubview(btnZoomMinus)
        //        btnZoomMinus.bottomAnchor.constraint(equalTo: btnZoomPlus.bottomAnchor, constant: -50).isActive=true
        //        btnZoomPlus.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive=true
        //        btnZoomMinus.widthAnchor.constraint(equalToConstant: 50).isActive=true
        //        btnZoomMinus.heightAnchor.constraint(equalTo: btnMyLocation.widthAnchor).isActive=true
    }
    
    
    
    let myMapView: GMSMapView = {
        let map = GMSMapView()
        map.translatesAutoresizingMaskIntoConstraints=false
        return map
    }()
    
    let txtFieldSearch: UITextField = {
        let tf=UITextField()
        tf.layer.cornerRadius = 15
        tf.backgroundColor = .white
        tf.layer.borderColor = UIColor.darkGray.cgColor
        tf.placeholder="Search for a location"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var addQuestionPreviewView: AddQuestionPreviewView = {
        let rest = AddQuestionPreviewView()
        return rest
    }()
    
    let btnMyLocation: UIButton = {
        let btn=UIButton()
        btn.backgroundColor = UIColor.white
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        btn.layer.masksToBounds = false
        btn.layer.shadowRadius = 2.0
        btn.layer.shadowOpacity = 0.5
        
        let config = UIImage.SymbolConfiguration(textStyle: .title2)
        btn.setImage(UIImage(systemName: "location.fill", withConfiguration: config), for: .normal)
        btn.layer.cornerRadius = 20
        //        btn.tintColor = UIColor.gray
        btn.imageView?.tintColor = ThemeColors.mainColor
        btn.addTarget(self, action: #selector(btnMyLocationAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()
    
    let btncClose: UIButton = {
        let btn=UIButton()
        btn.backgroundColor = UIColor.clear
        let config = UIImage.SymbolConfiguration(textStyle: .title1)
        
        
        btn.setImage(UIImage(systemName: "xmark", withConfiguration: config), for: .normal)
        btn.imageView?.tintColor = ThemeColors.mainColor
        btn.layer.cornerRadius = 25
        btn.clipsToBounds=true
        //        btn.tintColor = UIColor.gray
        btn.imageView?.tintColor = ThemeColors.secondaryColor
        btn.addTarget(self, action: #selector(btnClose(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()
    let btnNext: UIButton = {
        let btn=UIButton()
        btn.backgroundColor = UIColor.clear
        let config = UIImage.SymbolConfiguration(textStyle: .title1)
        btn.setImage(UIImage(systemName: "chevron.right", withConfiguration: config), for: .normal)
        btn.layer.cornerRadius = 25
        btn.clipsToBounds=true
        //        btn.tintColor = UIColor.gray
        
        btn.imageView?.tintColor = ThemeColors.secondaryColor
        btn.addTarget(self, action: #selector(btnNextAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()
    
    //
    //    let btnZoomPlus: UIButton = {
    //        let btn = UIButton()
    //        btn.backgroundColor = UIColor.white
    //        btn.setImage(UIImage(systemName: "plus.circle"), for: .normal)
    //        btn.layer.cornerRadius = 25
    //        btn.clipsToBounds=true
    //        btn.tintColor = UIColor.gray
    //        btn.imageView?.tintColor=UIColor.gray
    //        btn.addTarget(self, action: #selector(btnZoomPlusAction), for: .touchUpInside)
    //        btn.translatesAutoresizingMaskIntoConstraints=false
    //        return btn
    //    }()
    //
    //    let btnZoomMinus: UIButton = {
    //        let btn = UIButton()
    //        let config = UIImage.SymbolConfiguration(textStyle: .title1)
    //        btn.backgroundColor = UIColor.white
    //        btn.setImage(UIImage(systemName: "minus.circle", withConfiguration: config), for: .normal)
    //        btn.layer.cornerRadius = 25
    //        btn.clipsToBounds=true
    //        btn.tintColor = UIColor.cyan
    //        //        btn.imageEdgeInsets = UIEdgeInsets(
    //        //                top: 0,
    //        //                left: 0,
    //        //                bottom: 0,
    //        //                right: 0)
    //        btn.imageView?.tintColor = .cyan
    //        btn.imageView?.sizeToFit()
    //        btn.addTarget(self, action: #selector(btnZoomMinusAction), for: .touchUpInside)
    //        btn.translatesAutoresizingMaskIntoConstraints=false
    //        return btn
    //    }()
    //    (frame:CGRect(x: 200, y: 200, width: 300, height: 20))
    let containerRadiusLabel: UIView = {
        let v = UIView()
        v.backgroundColor = ThemeColors.secondaryColor
        v.layer.cornerRadius = 10
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let textRadius: UILabel = {
       let title = UILabel()
        title.textColor = .white
        title.translatesAutoresizingMaskIntoConstraints=false
        title.text = "Радиус зоны действия 200 м"
        title.font = UIFont.systemFont(ofSize: 10)
        title.textAlignment = .center
        return title
    }()
    var slider: UISlider {
        let slider = UISlider(frame:CGRect(x: 20, y: view.frame.width*2 - 60, width: view.frame.width-40, height: 20))
        slider.minimumValue = 200
        slider.maximumValue = 2000
        slider.isContinuous = true
        slider.tintColor = UIColor.black
        slider.addTarget(self, action: #selector(AddQuestionViewController.sliderValueChanged(_:)), for: .valueChanged)
        //        slider.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive=true
        //        slider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -20).isActive=true
        //        slider.translatesAutoresizingMaskIntoConstraints=false
        //        slider.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
        return slider
    }
    
    @objc func restaurantTapped(tag: Int) {
        let rest = DetailsVC()
        rest.passedData = question[tag]
        self.navigationController?.pushViewController(rest, animated: true)
    }
    
    @objc func btnMyLocationAction() {
        let location: CLLocation? = myMapView.myLocation
        
        
        myMapView.clear()
        var latitude = location?.coordinate.latitude
        var longitude = location?.coordinate.longitude
       
        if location != nil {
            myMapView.animate(toLocation: (location?.coordinate)!)
            self.setupCircle(latitide: latitude ?? 0.0, longitude: longitude ?? 0.0, radius: radius)
        }
        let position = CLLocationCoordinate2D(latitude: latitude ?? 0.0, longitude: longitude ?? 0.0)
        let marker = GMSMarker(position: position)
        marker.title = "Hello World"
        marker.map = myMapView
    }
    
    @objc func btnZoomPlusAction() {
        let zoomPlus = zoom+1
        myMapView.animate(toZoom: zoomPlus)
    }
    @objc func btnZoomMinusAction() {
        let zoomMinus = zoom-1
        myMapView.animate(toZoom: zoomMinus)
    }
    @objc func sliderValueChanged(_ sender: UISlider!){
        let currentValue = Int(sender.value)
        print("value is" , Int(sender.value))
        updateCircle(value: currentValue)
    }
    @objc func btnClose(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    @objc func btnNextAction(){
        let next: addQuestionTwoVC = addQuestionTwoVC()
        //        next.data = AskQuestion(title: "", userID: "", latitude: <#T##Double#>, longitude: <#T##Double#>, adress: <#T##String#>, radius: <#T##Int#>, image: <#T##UIImage?#>)
        next.modalPresentationStyle = .fullScreen
        transitionVc(vc: next, duration: 0.5, type: .fromRight)
    }
    
    private func updateCircle(value: Int){
        DispatchQueue.main.async {
            self.circle.radius = CLLocationDistance(value)
            let update = GMSCameraUpdate.fit(self.circle.bounds())
            self.textRadius.text = "Радиус зоны действия \(value) м"
            self.myMapView.animate(with: update)
            self.radius = value
        }
    }
    
    
    //    @objc func handleLongPress(recognizer: UILongPressGestureRecognizer)
    //     {
    //        if (recognizer.state == UIGestureRecognizerState.began)
    //        {
    //            let longPressPoint = recognizer.location(in: self.mapView);
    //            let coordinate = mapView.projection.coordinate(for: longPressPoint )
    //            //Now you have Coordinate of map add marker on that location
    //            let marker = GMSMarker(position: coordinate)
    //            marker.opacity = 0.6
    //            marker.title = "Current Location"
    //            marker.snippet = ""
    //            marker.map = mapView
    //        }
    //    }
    func reverseGeocode(coordinate: CLLocationCoordinate2D) {
        // 1
        let geocoder = GMSGeocoder()
        
        // 2
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard
                let address = response?.firstResult(),
                let lines = address.lines
            else {
                return
            }
            self.adressLabel = lines.joined(separator: "\n")
        }
    }
}

