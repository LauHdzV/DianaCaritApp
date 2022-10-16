//
//  ProfileViewController.swift
//  CaritAppLogin
//
//  Created by Alberto Estrada on 07/09/22.
//

import UIKit

class ProfileViewController: UIViewController {

    // Declaracion de objetos
    @IBOutlet weak var pieChart: JPieChart!
    @IBOutlet weak var barChart: BarChartView!
    
    let defaults = UserDefaults.standard
    var idVoluntario: Int!
    
    struct Perfil: Decodable{
        var horasPorMes : [Double]
        var horasPorProyecto: [Float]
        var horasTotales: Float
        var meses: [String]
        var nombre: String!
        var nombreCorto: String!
        var porcentajePorProyecto: [Float]
        var proyectosParticipando: [String]
    }
    
    var perfil: Perfil!

    
    // Declaracion de valores iniciales
    let valoresTabla = [2.0, 3.0, 1.0, 2.0, 3.0, 5.0, 2.0, 3.0, 1.0, 2.0, 3.0, 5.0]
    let etiquetasFechas = ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]
    
    func getPerfil() {
        self.idVoluntario = defaults.integer(forKey: "idVoluntario")
        let url3 = "https://equipo04.tc2007b.tec.mx:10202/perfil/\(self.idVoluntario!)"
        guard let url = URL(string: url3) else { return }
        
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            let decoder2 = JSONDecoder()

            do{
                let resultadoGeneral = try decoder2.decode(Perfil.self, from: data!)
                let Pokelist = resultadoGeneral
                self.perfil = Pokelist
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getPerfil()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)){
            // Declaracion de grafica de pastel
            self.pieChart.addChartData(data: [
                JPieChartDataSet(percent: 15, colors: [UIColor.caritasAcua,UIColor.caritasAcua]),
                JPieChartDataSet(percent: 10, colors: [UIColor.caritasGris,UIColor.caritasGris]),
                JPieChartDataSet(percent: 45, colors: [UIColor.caritasRosita,UIColor.caritasRosita]),
                JPieChartDataSet(percent: 30, colors: [UIColor.caritasNaranja,UIColor.caritasNaranja])
             ])
            
            self.pieChart.lineWidth = 0.85
            
            // Declaracion de grafica de barras
            self.barChart.maxValue = 18.0
            self.barChart.drawChart(self.perfil.horasPorMes,self.perfil.meses)

        }
        
        
    }
    

}
