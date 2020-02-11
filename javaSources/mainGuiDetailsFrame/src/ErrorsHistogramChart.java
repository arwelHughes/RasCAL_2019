import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.statistics.SimpleHistogramDataset;
import org.jfree.data.xy.IntervalXYDataset;
import java.io.Serializable;


public class ErrorsHistogramChart implements Serializable{

    public ErrorsHistogramChart(){};


    public ChartPanel MakeErrorsHistogramChart(IntervalXYDataset dataset) {
    
         /*JFreeChart chart = ChartFactory.createHistogram(
             "",
             null,
             null,
             dataset,
             PlotOrientation.VERTICAL,
             true,
             false,
             false
         );  */  
         JFreeChart chart = MakeErrorsHistogramGraph(dataset);
         chart.getXYPlot().setForegroundAlpha(0.75f);
         chart.removeLegend();
         final ChartPanel panel = new ChartPanel(chart);
         return panel;
    };
    
    public JFreeChart MakeErrorsHistogramGraph(IntervalXYDataset dataset) {
         JFreeChart chart = ChartFactory.createHistogram(
             "",
             null,
             null,
             dataset,
             PlotOrientation.VERTICAL,
             true,
             false,
             false
         );
         chart.getXYPlot().setForegroundAlpha(0.75f);
         return chart;
    }
    
    public IntervalXYDataset makeIntervalXYDataset() {
        SimpleHistogramDataset dataset = new SimpleHistogramDataset("");
        dataset.setAdjustForBinSize(false);
        return dataset;
    }
    
    public Double[][] convertArray(double[][] v, int rows) {
        
        Double[][] myObj  = new Double[rows][2];
        for (int r=0;r<rows;r++){
            myObj[r][0] = (java.lang.Double)v[r][0];
            myObj[r][1] = (java.lang.Double)v[r][1];
        }
        return myObj;
    };
    
}
