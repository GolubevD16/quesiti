//
//  ViewController.swift
//  MapDemo
//
//  Created by Даниил Ярмоленко on 07.11.2021.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SwiftUI

struct MyPlace {
    var name: String
    var lat: Double
    var long: Double
}

class MapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate, UITextFieldDelegate {
    var presenter: MapViewPresenter!
    var zoom: Float = 15.0
    let currentLocationMarker = GMSMarker()
    var locationManager = CLLocationManager()
    var chosenPlace: MyPlace?
    //    var circle = GMSCircle()
    var question = [
        Question(title: "Какая погода ?", userID: "bjhksdf23", latitude: 24.8655, longitude: 67.0011, radius: 1000, image: UIImage(named: "people1"), name: "Daniil Yarmolenko"),
        Question(title: "Сегодня большая очередь в библиотеке ?", userID: "bjhksdf23", latitude: 24.868, longitude: 67.0011, radius: 1000, image: UIImage(named: "people2"), name: "Alex"),
        Question(title: "Кто хочет пойти в кино на премьеру ?", userID: "bjhksdf23", latitude: 24.878, longitude: 67.0011, radius: 1000, image: UIImage(named: "people3"), name: "Sofia")
    ]
    
    let customMarkerWidth: Int = 50
    let customMarkerHeight: Int = 70
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        myMapView.delegate=self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        setupViews()
        
        initGoogleMaps()
        
        txtFieldSearch.delegate=self
        
        
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
        
        showPartyMarkers(lat: longitude, long: longitude)
        
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
        showPartyMarkers(lat: lat, long: long)
    }
    
    // MARK: GOOGLE MAP DELEGATE
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return false }
        let img = customMarkerView.img!
        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: img, borderColor: UIColor.white, tag: customMarkerView.tag)
        
        marker.iconView = customMarker
        //        let camera = GMSCameraPosition.
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        zoom = mapView.camera.zoom
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return nil }
        let data = question[customMarkerView.tag]
        questionPreviewView.setData(title: data.title, img: data.image, name: data.name)
        return questionPreviewView
    }
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return }
        let tag = customMarkerView.tag
        var long = locationManager.location?.coordinate.longitude // сравнить с координатами вопроса
        var lat = locationManager.location?.coordinate.latitude // сравнить с координатами
        
        
        restaurantTapped(tag: tag)
    }
    
    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return }
        let img = customMarkerView.img!
        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: img, borderColor: UIColor.darkGray, tag: customMarkerView.tag)
        marker.iconView = customMarker
    }
    
    
    func showPartyMarkers(lat: Double, long: Double) {
        myMapView.clear()
        for i in 0..<question.count {
            let marker = GMSMarker()
            let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: question[i].image, borderColor: UIColor.darkGray, tag: i)
            marker.iconView = customMarker
            //            marker.position = CLLocationCoordinate2D(latitude: lat + 0.001*Double(i), longitude: long - 0.001*Double(i))
            marker.position = CLLocationCoordinate2D(latitude: question[i].latitude, longitude: question[i].longitude)
            marker.map = self.myMapView
        }
    }
    
    
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
        let paddingView = UIView(frame:CGRect(x: 0, y: 0, width: 30, height: 30))
        paddingView.addSubview(imageView)
        textField.leftView = paddingView
    }
    
    func setupViews() {
        self.view.addSubview(myMapView)
        myMapView.topAnchor.constraint(equalTo: view.topAnchor).isActive=true
        myMapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive=true
        myMapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive=true
        myMapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive=true
        
        self.view.addSubview(txtFieldSearch)
        txtFieldSearch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive=true
        txtFieldSearch.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive=true
        txtFieldSearch.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive=true
        txtFieldSearch.heightAnchor.constraint(equalToConstant: 35).isActive=true
        setupTextField(textField: txtFieldSearch, img: #imageLiteral(resourceName: "map_Pin"))
        
        questionPreviewView=QuestionPreviewView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 150, height: 100))
        
        self.view.addSubview(btnMyLocation)
        btnMyLocation.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive=true
        btnMyLocation.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive=true
        btnMyLocation.widthAnchor.constraint(equalToConstant: 50).isActive=true
        btnMyLocation.heightAnchor.constraint(equalTo: btnMyLocation.widthAnchor).isActive=true
        
        self.view.addSubview(btnAddQuestion)
        btnAddQuestion.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65).isActive=true
        btnAddQuestion.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        btnAddQuestion.widthAnchor.constraint(equalToConstant: 50).isActive=true
        btnAddQuestion.heightAnchor.constraint(equalTo: btnAddQuestion.widthAnchor).isActive=true
        
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
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .white
        tf.layer.borderColor = UIColor.darkGray.cgColor
        tf.placeholder="Search for a location"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var questionPreviewView: QuestionPreviewView = {
        let rest = QuestionPreviewView()
        return rest
    }()
    
    let btnMyLocation: UIButton = {
        let btn=UIButton()
        btn.backgroundColor = UIColor.clear
        let config = UIImage.SymbolConfiguration(textStyle: .title1)
        btn.setImage(UIImage(systemName: "location.fill", withConfiguration: config), for: .normal)
        btn.layer.cornerRadius = 25
        btn.clipsToBounds=true
        //        btn.tintColor = UIColor.gray
        btn.imageView?.tintColor=UIColor.blue
        btn.addTarget(self, action: #selector(btnMyLocationAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()
    
    //    let btnZoomPlus: UIButton = {
    //       let btn = UIButton()
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
    let btnAddQuestion: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        //        let config = UIImage.SymbolConfiguration(textStyle: .)
        let config = UIImage.SymbolConfiguration(textStyle: .title1)
        btn.backgroundColor = ThemeColors.mainColor
        btn.setImage(UIImage(systemName: "plus.circle", withConfiguration: config), for: .normal)
        btn.layer.cornerRadius = 25
        btn.clipsToBounds=true
        btn.tintColor = UIColor.white
        //        btn.imageEdgeInsets = UIEdgeInsets(
        //                top: 0,
        //                left: 0,
        //                bottom: 0,
        //                right: 0)
        
        btn.imageView?.sizeToFit()
        //        let squarePath = UIBezierPath()
        //        let squareLayer = CAShapeLayer()
        //        //change the CGPoint values to get the triangle of the shape you want
        //        squarePath.move(to: CGPoint(x: 24, y: 0))
        //
        //        squarePath.addLine(to: CGPoint(x: 49, y: 24))
        //        squarePath.addLine(to: CGPoint(x: 24, y: 49))
        //        squarePath.addLine(to: CGPoint(x: 0, y: 24))
        ////        squarePath.addLine(to: CGPoint(x: 100, y: 0))
        //        squarePath.close()
        //        squareLayer.path = squarePath.cgPath
        //        squareLayer.fillColor = ThemeColors.mainColor.cgColor
        //        let myImageLayer = CALayer()
        //        let myImage = UIImage(systemName: "plus.circle")!.cgImage
        //        myImageLayer.frame = btn.bounds
        //        myImageLayer.contents = myImage
        //        squareLayer.addSublayer(myImageLayer)
        //
        //        btn.layer.addSublayer(squareLayer)
        //        btn.clipsToBounds=true
        btn.addTarget(self, action: #selector(btnAddQuestionAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()
    
    //    let btnZoomMinus: UIButton = {
    //       let btn = UIButton()
    //        let config = UIImage.SymbolConfiguration(textStyle: .title1)
    //        btn.backgroundColor = UIColor.white
    //        btn.setImage(UIImage(systemName: "minus.circle", withConfiguration: config), for: .normal)
    //        btn.layer.cornerRadius = 25
    //        btn.clipsToBounds=true
    //        btn.tintColor = UIColor.cyan
    ////        btn.imageEdgeInsets = UIEdgeInsets(
    ////                top: 0,
    ////                left: 0,
    ////                bottom: 0,
    ////                right: 0)
    //        btn.imageView?.tintColor = .cyan
    //        btn.imageView?.sizeToFit()
    //        btn.addTarget(self, action: #selector(btnZoomMinusAction), for: .touchUpInside)
    //        btn.translatesAutoresizingMaskIntoConstraints=false
    //        return btn
    //    }()
    
    @objc func restaurantTapped(tag: Int) {
        let rest = DetailsVC()
        rest.passedData = question[tag]
        self.navigationController?.pushViewController(rest, animated: true)
    }
    
    @objc func btnMyLocationAction() {
        let location: CLLocation? = myMapView.myLocation
        if location != nil {
            myMapView.animate(toLocation: (location?.coordinate)!)
        }
    }
    
    @objc func btnZoomPlusAction() {
        let zoomPlus = zoom+1
        myMapView.animate(toZoom: zoomPlus)
    }
    @objc func btnAddQuestionAction() {
        let addQuuestion: AddQuestionViewController = AddQuestionViewController()
        addQuuestion.modalPresentationStyle = .fullScreen
        self.present(addQuuestion, animated: true, completion: nil)
    }
    @objc func btnZoomMinusAction() {
        let zoomMinus = zoom-1
        myMapView.animate(toZoom: zoomMinus)
    }
}

extension UIViewController {
    func transitionVc(vc: UIViewController, duration: CFTimeInterval, type: CATransitionSubtype) {
        let customVcTransition = vc
        let transition = CATransition()
        transition.duration = duration
        transition.type = CATransitionType.push
        transition.subtype = type
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(customVcTransition, animated: false, completion: nil)
    }
    func transitionOutVc(duration: CFTimeInterval, type: CATransitionSubtype) {
        let transition = CATransition()
        transition.duration = duration
        transition.type = CATransitionType.push
        transition.subtype = type
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false)
    }
}
