import UIKit
import RealityKit
import SwiftUI

class MuseumViewController: UIViewController {
    
    var memoryStand: ModelEntity?
    var currentMemoryIndex = 0 {
        didSet {
            informationLabel.text = "You can place \(memories.count - currentMemoryIndex) more memory stand"
        }
    }
    
    // from parent
    var memories: [MemoryItem] = []
    
    private var arView: ARView = {
        let arView = ARView(frame: .zero)
        arView.translatesAutoresizingMaskIntoConstraints = false
        
        //        let floorAnchor = AnchorEntity(plane: .horizontal,
        //                                       classification: .floor,
        //                                       minimumBounds: [1.1, 1.1])
        
        //        arView.scene.addAnchor(floorAnchor)
        
        return arView
    }()
    
    private var informationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.layer.backgroundColor = .init(gray: 1, alpha: 0.6)
        label.layer.cornerRadius = 8
        label.numberOfLines = 2
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(arView)
        view.addSubview(informationLabel)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        arView.addGestureRecognizer(tapGesture)
        
        memoryStand = try! Entity.loadModel(named: "chosen-stand")
        
        informationLabel.text = "Tap the location where you want to place your memory\nYou can place \(memories.count - currentMemoryIndex) more memory stand"
        
        setupLayouts()
    }
    
    func setupLayouts() {
        NSLayoutConstraint.activate([
            arView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            arView.topAnchor.constraint(equalTo: view.topAnchor),
            arView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            arView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            informationLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            informationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            informationLabel.heightAnchor.constraint(equalToConstant: 64),
            informationLabel.widthAnchor.constraint(equalToConstant: 500)
        ])
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: arView)
        
        if memories.count - currentMemoryIndex > 0 {
            addUnanchoredEntityWhereTapped(location)
        } else {
            informationLabel.text = "You have put all of your memories.\nCreate more memory to put more"
            UIView.animate(withDuration: 0.2) { [self] in
                informationLabel.transform = informationLabel.transform.scaledBy(x: 1.2, y: 1.2)
                informationLabel.textColor = .red
            } completion: { _ in
                self.informationLabel.transform = .identity
                self.informationLabel.textColor = .black
            }
        }
    }
    
    @discardableResult
    func addUnanchoredEntityWhereTapped(_ touchPoint:CGPoint)  -> Bool {
        let results = arView.raycast(from: touchPoint,
                                     allowing: .estimatedPlane,
                                     alignment: .horizontal)
        if let result = results.first,
           let entity = memoryStand?.clone(recursive: true),
           let descriptionModel = createDescriptionModel(),
           let imageModel = createImageModel() {
            let anchorEntity = AnchorEntity(world: result.worldTransform)
            //                entity.position.y = -1.5
            
            
            arView.scene.addAnchor(anchorEntity)
            anchorEntity.addChild(entity)
            anchorEntity.addChild(imageModel)
            anchorEntity.addChild(descriptionModel)
            currentMemoryIndex += 1
            return true
        }
        return false
    }
    
    func createDescriptionModel() -> ModelEntity? {
        let descriptionView = DescriptionContainerView(title: memories[currentMemoryIndex].title,
                                                       description: memories[currentMemoryIndex].body)
        let renderer = ImageRenderer(content: descriptionView)
        
        guard let uiImage = renderer.uiImage else { return nil }
        let texture = try! TextureResource.generate(from: uiImage.cgImage!, options: .init(semantic: .normal))
        
        let paperMaterial = createPaperMaterial(withTexture: texture)
        
        let descriptionMesh: MeshResource = .generatePlane(width: 0.5, depth: 0.3)
        let descriptionModel = ModelEntity(mesh: descriptionMesh, materials: [paperMaterial])
        descriptionModel.transform = Transform(pitch: .pi/5.6)
        descriptionModel.position.x = 0.023
        descriptionModel.position.y = 0.995
        descriptionModel.position.z = 0.225
        
        return descriptionModel
    }
    
    func createImageModel() -> ModelEntity? {
        let imageView = ImageContainerView(uiImage: memories[currentMemoryIndex].image)
        let renderer = ImageRenderer(content: imageView)
        
        guard let uiImage = renderer.uiImage else { return nil }
        let texture = try! TextureResource.generate(from: uiImage.cgImage!, options: .init(semantic: .normal))
        
        let paperMaterial = createPaperMaterial(withTexture: texture)
        
        let descriptionMesh: MeshResource = .generatePlane(width: 0.72, depth: 0.96)
        let descriptionModel = ModelEntity(mesh: descriptionMesh, materials: [paperMaterial])
        descriptionModel.transform = Transform(pitch: .pi/2)
        descriptionModel.position.x = 0.023
        descriptionModel.position.y = 1.595
        descriptionModel.position.z = -0.208
        
        return descriptionModel
    }
    
    func createPaperMaterial(withTexture texture: TextureResource) -> SimpleMaterial {
        var paperMaterial = SimpleMaterial()
        paperMaterial.color = .init(texture: .init(texture))
        paperMaterial.metallic = .float(0)
        paperMaterial.roughness = .float(1)
        
        return paperMaterial
    }
    
}
