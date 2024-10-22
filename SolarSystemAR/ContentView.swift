import SwiftUI
import RealityKit
import ARKit

struct ContentView: View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)

        // Directly add the Sun and planets without plane detection

        // Create an anchor for the Sun
        let solarSystemAnchor = AnchorEntity(world: [0, 0, -1.0])  // Fixed position 1 meter in front of the camera
        arView.scene.anchors.append(solarSystemAnchor)

        // Load and position the Sun model
        if let sunModel = try? Entity.load(named: "Sun") {
            sunModel.scale = [0.5, 0.5, 0.5]  // Scale Sun
            solarSystemAnchor.addChild(sunModel)

            // Add planets around the Sun
            addPlanet(named: "Mercury", scale: 0.05, orbitRadius: 0.7, sunEntity: sunModel)
            addPlanet(named: "Venus", scale: 0.09, orbitRadius: 0.9, sunEntity: sunModel)
            addPlanet(named: "Earth", scale: 0.1, orbitRadius: 1.1, sunEntity: sunModel)
            addPlanet(named: "Mars", scale: 0.08, orbitRadius: 1.3, sunEntity: sunModel)
            addPlanet(named: "Jupiter", scale: 0.2, orbitRadius: 1.6, sunEntity: sunModel)
            addPlanet(named: "Saturn", scale: 0.18, orbitRadius: 2.0, sunEntity: sunModel)
            addPlanet(named: "Uranus", scale: 0.15, orbitRadius: 2.4, sunEntity: sunModel)
            addPlanet(named: "Neptune", scale: 0.14, orbitRadius: 2.8, sunEntity: sunModel)
            addPlanet(named: "Pluto", scale: 0.05, orbitRadius: 3.2, sunEntity: sunModel)  // Pluto, the dwarf planet
        } else {
            print("Failed to load Sun model.")
        }

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}

    // Helper function to add planets around the Sun
    func addPlanet(named planetName: String, scale: Float, orbitRadius: Float, sunEntity: Entity) {
        guard let planetModel = try? Entity.load(named: planetName) else {
            print("Failed to load planet: \(planetName)")
            return
        }
        print("Planet \(planetName) loaded successfully!")

        // Set planet scale and position relative to the Sun in a fixed orbit
        planetModel.scale = [scale, scale, scale]
        planetModel.position = [orbitRadius, 0, 0]  // Position the planet in orbit around the Sun

        // Add the planet as a child of the Sun
        sunEntity.addChild(planetModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
