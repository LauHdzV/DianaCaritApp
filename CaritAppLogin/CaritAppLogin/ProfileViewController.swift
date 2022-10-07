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
    
    
    
    // Declaracion de valores iniciales
    let valoresTabla = [2.0, 3.0, 1.0, 2.0, 3.0, 5.0, 2.0, 3.0, 1.0, 2.0, 3.0, 5.0]
    let etiquetasFechas = ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Declaracion de grafica de pastel
        pieChart.addChartData(data: [
            JPieChartDataSet(percent: 15, colors: [UIColor.caritasAcua,UIColor.caritasAcua]),
            JPieChartDataSet(percent: 10, colors: [UIColor.caritasGris,UIColor.caritasGris]),
            JPieChartDataSet(percent: 45, colors: [UIColor.caritasRosita,UIColor.caritasRosita]),
            JPieChartDataSet(percent: 30, colors: [UIColor.caritasNaranja,UIColor.caritasNaranja])
         ])
        
         pieChart.lineWidth = 0.85
        
        // Declaracion de grafica de barras
        barChart.maxValue = 18.0
        barChart.drawChart(valoresTabla,etiquetasFechas)
        
        
        
    }
    

}
