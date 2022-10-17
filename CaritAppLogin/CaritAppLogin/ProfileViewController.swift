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
    
    @IBOutlet weak var totalHoras: UILabel!
    
    @IBOutlet weak var proyecto1: UILabel!
    @IBOutlet weak var proyecto2: UILabel!
    @IBOutlet weak var proyecto3: UILabel!
    @IBOutlet weak var proyecto4: UILabel!
    
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
    let valoresTabla = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
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
            
            self.totalHoras.text = String(self.perfil.horasTotales)
            // Declaracion de grafica de pastel
            
            var pieChart = [JPieChartDataSet]()
            var aux = 0
            self.proyecto1.text = ""
            self.proyecto2.text = ""
            self.proyecto3.text = ""
            self.proyecto4.text = ""
            
            for i in self.perfil.porcentajePorProyecto{
                if aux == 0 {
                    pieChart.append(JPieChartDataSet(percent: CGFloat(i), colors: [UIColor.caritasAcua,UIColor.caritasAcua]))
                    self.proyecto1.text = self.perfil.proyectosParticipando[aux]

                } else if aux == 1 {
                    pieChart.append(JPieChartDataSet(percent: CGFloat(i), colors: [UIColor.caritasGris,UIColor.caritasGris]))
                    self.proyecto2.text = self.perfil.proyectosParticipando[aux]

                } else if aux == 2 {
                    pieChart.append(JPieChartDataSet(percent: CGFloat(i), colors: [UIColor.caritasRosita,UIColor.caritasRosita]))
                    self.proyecto3.text = self.perfil.proyectosParticipando[aux]

                } else if aux == 3 {
                    pieChart.append(JPieChartDataSet(percent: CGFloat(i), colors: [UIColor.caritasNaranja,UIColor.caritasNaranja]))
                    self.proyecto4.text = self.perfil.proyectosParticipando[aux]
                }
                aux = aux + 1
            }
            
            if pieChart.isEmpty {
                self.pieChart.addChartData(data: [JPieChartDataSet(percent: 100, colors: [UIColor.caritasAcua,UIColor.caritasAcua])])
            } else {
                self.pieChart.addChartData(data: pieChart)
            }
                        
            self.pieChart.lineWidth = 0.85
            
            // Declaracion de grafica de barras
            self.barChart.maxValue = Double(self.perfil.horasTotales)
            if self.perfil.horasPorProyecto.isEmpty{
                self.barChart.drawChart(self.valoresTabla,self.etiquetasFechas)
            } else {
                self.barChart.drawChart(self.perfil.horasPorMes,self.perfil.meses)
            }
        }
        
        
    }
    

}
