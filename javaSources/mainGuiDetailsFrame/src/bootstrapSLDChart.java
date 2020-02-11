import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;
import org.jfree.data.xy.XYSeries;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.renderer.xy.XYLineAndShapeRenderer;
import org.jfree.chart.plot.XYPlot;
import org.jfree.data.xy.XYSeriesCollection;
import java.awt.Color;
import java.io.Serializable;

/**
 *
 * @author avh45
 */
public class bootstrapSLDChart implements Serializable {
    
    public JFreeChart bsSLDChart;
    
    
    /** Creates a new instance of cutThroughsGraph */
    public bootstrapSLDChart(){};
    
    public ChartPanel mkbsSLDChart(XYSeriesCollection data) {
        NumberAxis xAxis = new NumberAxis("z(Ang)");
        NumberAxis yAxis = new NumberAxis("SLD (Ang^-1)");
        xAxis.setAutoRangeIncludesZero(false);
        yAxis.setAutoRangeIncludesZero(false);
        
        XYLineAndShapeRenderer renderer_line = new XYLineAndShapeRenderer();
        renderer_line.setLinesVisible(true);
        renderer_line.setShapesVisible(false);
        
        XYPlot plot = new XYPlot(data, xAxis, yAxis, renderer_line);
        
        plot.setBackgroundPaint(Color.white);
        plot.setDomainGridlinesVisible(false);
        plot.setRangeGridlinesVisible(false);
        JFreeChart chart = new JFreeChart("", plot);
        chart.removeLegend();
        final ChartPanel panel = new ChartPanel(chart);
        panel.getChartRenderingInfo().setEntityCollection(null);
        
        bsSLDChart = chart;
        return panel;
    }  
    
    public XYSeries mkXYSeries(String name) {
        XYSeries s = new XYSeries(name);
    return s;
    }
        
    public XYSeriesCollection mkXYSeriesCollection() {
        XYSeriesCollection c = new XYSeriesCollection();
    return c;
    }
        
   /* public synchronized void updateTheCurve(java.lang.Double data[][], int points) {
        XYPlot linePlot = getThePlot();
        XYSeriesCollection Coll =  (XYSeriesCollection)linePlot.getDataset(0);
        XYSeries thisSeries = Coll.getSeries(0);
        thisSeries.clear();
        for (int i=0 ; i<points-1 ; i++) {
            thisSeries.add(data[i][0],data[i][1],false);
        };
        thisSeries.add(data[points][0],data[points][1]);
    }
    
    public synchronized void updateThepoint(java.lang.Double data[][]) {
        XYPlot pPlot = getThePlot();
        XYSeriesCollection Coll =  (XYSeriesCollection)pPlot.getDataset(1);
        XYSeries thisSeries = Coll.getSeries(0);
        thisSeries.clear();
        thisSeries.add(data[0][0],data[0][1]);
    }
    
    
    public XYPlot getThePlot() {
        XYPlot myPlot = (XYPlot)getChart().getPlot();
        return myPlot;
    }
    
    public JFreeChart getChart() {
        return cutThroughsChart;
    }*/
    
}

