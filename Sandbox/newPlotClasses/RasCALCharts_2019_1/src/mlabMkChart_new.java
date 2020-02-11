import java.awt.Paint;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.DefaultDrawingSupplier;
import org.jfree.chart.renderer.xy.XYLineAndShapeRenderer;
import org.jfree.chart.util.LogFormat;
import org.jfree.data.xy.XYIntervalSeriesCollection;
import org.jfree.data.xy.XYSeries;
import org.jfree.data.xy.IntervalXYDataset;
import org.jfree.data.xy.XYIntervalSeries;
import org.jfree.data.xy.XYSeriesCollection;
import org.jfree.chart.plot.XYPlot;
import org.jfree.chart.axis.LogarithmicAxis;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.renderer.xy.XYErrorRenderer;
import org.jfree.chart.renderer.xy.DeviationRenderer;
import org.jfree.util.ShapeUtilities;
import java.awt.Color;
import java.awt.Shape;
import java.awt.geom.Ellipse2D;
import java.io.Serializable;
import org.jfree.chart.axis.LogAxis;


public class mlabMkChart_new implements Serializable{
    
    public JFreeChart refChart;
    public JFreeChart sldChart;
    public boolean finished;
    public LogarithmicAxis refXAxisLog = new LogarithmicAxis("Qz");
    public NumberAxis refAxisLin = new NumberAxis("Qz");
    public LogarithmicAxis intAxisLog = new LogarithmicAxis("R");
    public NumberAxis intAxisLin = new NumberAxis("R");

    public static final Color VERY_DARK_RED = new Color(0x80, 0x00, 0x00);
    public static final Color DARK_RED = new Color(0xc0, 0x00, 0x00);
    public static final Color LIGHT_RED = new Color(0xFF, 0x40, 0x40);
    public static final Color VERY_DARK_YELLOW = new Color(0x80, 0x80, 0x00);
    public static final Color VERY_DARK_GREEN = new Color(0x00, 0x80, 0x00);
    public static final Color DARK_GREEN = new Color(0x00, 0xC0, 0x00);
    public static final Color VERY_DARK_CYAN = new Color(0x00, 0x80, 0x80);
    public static final Color DARK_CYAN = new Color(0x00, 0xC0, 0xC0);
    public static final Color VERY_DARK_BLUE = new Color(0x00, 0x00, 0x80);
    public static final Color DARK_BLUE = new Color(0x00, 0x00, 0xC0);
    public static final Color VERY_DARK_MAGENTA = new Color(0x80, 0x00, 0x80);
    public static final Color DARK_MAGENTA = new Color(0xC0, 0x00, 0xC0);
    
    public mlabMkChart_new(){};
    
    public XYSeries mkXYSeries(String name) {
        XYSeries s = new XYSeries(name);
        return s;
    }
    
    public XYIntervalSeries mkIntervalXY(String name) {
        XYIntervalSeries s = new XYIntervalSeries(name);
        return s;
    }
    
    public IntervalXYDataset mkXYIntervalSeriesCollection(){
        XYIntervalSeriesCollection dataset = new XYIntervalSeriesCollection();
        return dataset;
    }
    
    public XYSeriesCollection mkXYSeriesCollection() {
        XYSeriesCollection c = new XYSeriesCollection();
        return c;
    }
    
    
    
    public ChartPanel mkSLDChart(XYSeriesCollection coll) {
        NumberAxis xAxis = new NumberAxis("z");
        NumberAxis yAxis = new NumberAxis("SLD");
        XYLineAndShapeRenderer renderer = new XYLineAndShapeRenderer();
        renderer.setLinesVisible(true);
        renderer.setShapesVisible(false);
        XYPlot plot = new XYPlot(coll, xAxis, yAxis, renderer);
        plot.setBackgroundPaint(Color.white);
        plot.setDomainGridlinesVisible(false);
        plot.setRangeGridlinesVisible(false);
        JFreeChart chart = new JFreeChart("", plot);
 
        chart.removeLegend();
        chart.getPlot().setDrawingSupplier(new DefaultDrawingSupplier(
                    new Paint[] {VERY_DARK_RED, 
                    VERY_DARK_GREEN,
                    VERY_DARK_BLUE,
                    VERY_DARK_MAGENTA,
                    VERY_DARK_YELLOW,
                    DARK_RED, 
                    DARK_GREEN,
                    DARK_BLUE,
                    DARK_MAGENTA},
                    DefaultDrawingSupplier.DEFAULT_OUTLINE_PAINT_SEQUENCE,
                    DefaultDrawingSupplier.DEFAULT_STROKE_SEQUENCE,
                    DefaultDrawingSupplier.DEFAULT_OUTLINE_STROKE_SEQUENCE,
                    DefaultDrawingSupplier.DEFAULT_SHAPE_SEQUENCE)); 
        
        //chart.setAntiAlias(false);
        final ChartPanel panel = new ChartPanel(chart);
        panel.getChartRenderingInfo().setEntityCollection(null);
        panel.setDisplayToolTips(false);
        this.sldChart = chart;
        return panel;
    }
    
    public ChartPanel mkRefChart(XYSeriesCollection pointsColl, XYSeriesCollection linesColl, String name, double minval) {
        
        //refAxisLin = new NumberAxis("Qz");
        //refXAxisLog = new LogarithmicAxis("Qz");
        LogAxis yAxisLog = new LogAxis("Ref");
        yAxisLog.setNumberFormatOverride(new LogFormat(10.0, "10e", true));
        yAxisLog.setSmallestValue(minval);
        //yAxisLog.setStandardTickUnits(LogarithmicAxis.createIntegerTickUnits());
        //yAxisLog.setStrictValuesFlag(false);
        
        //Make the symbols plot....
        XYLineAndShapeRenderer rendererPoints = new XYLineAndShapeRenderer();
        rendererPoints.setBaseShapesVisible(true);
        rendererPoints.setBaseShapesFilled(false);
        rendererPoints.setBaseLinesVisible(false);
        
        //Make the lines plot....
        XYLineAndShapeRenderer rendererLines = new XYLineAndShapeRenderer();
        rendererLines.setBaseLinesVisible(true);
        rendererLines.setBaseShapesVisible(false);
        
        XYPlot plot = new XYPlot(pointsColl, refXAxisLog, yAxisLog, rendererPoints);
        
        plot.setDataset(1,linesColl);
        plot.setRenderer(1,rendererLines);
        
        plot.setBackgroundPaint(Color.white);
        plot.setDomainGridlinesVisible(false);
        plot.setRangeGridlinesVisible(false);
        
        JFreeChart chart = new JFreeChart("", plot);
        chart.removeLegend();
        chart.getPlot().setDrawingSupplier(new DefaultDrawingSupplier(
                    new Paint[] {VERY_DARK_RED, 
                    VERY_DARK_GREEN,
                    VERY_DARK_BLUE,
                    VERY_DARK_MAGENTA,
                    VERY_DARK_YELLOW,
                    DARK_RED, 
                    DARK_GREEN,
                    DARK_BLUE,
                    DARK_MAGENTA},
                    DefaultDrawingSupplier.DEFAULT_OUTLINE_PAINT_SEQUENCE,
                    DefaultDrawingSupplier.DEFAULT_STROKE_SEQUENCE,
                    DefaultDrawingSupplier.DEFAULT_OUTLINE_STROKE_SEQUENCE,
                    DefaultDrawingSupplier.DEFAULT_SHAPE_SEQUENCE)); 
        
        //chart.setAntiAlias(false);
        final ChartPanel panel = new ChartPanel(chart);
        panel.getChartRenderingInfo().setEntityCollection(null);
        panel.setDisplayToolTips(false);
        this.refChart = chart;
        return panel;
    }
    

    public ChartPanel mkRefShadedChart(XYIntervalSeriesCollection pointsColl, XYSeriesCollection linesColl, XYIntervalSeriesCollection shadingColl, String name, double minval, double numberOfContrasts) {
        
        linesColl.setIntervalWidth(0.0);
        
        //refAxisLin = new NumberAxis("Qz");
        //refXAxisLog = new LogarithmicAxis("Qz");
        LogAxis yAxisLog = new LogAxis("Ref");
        yAxisLog.setNumberFormatOverride(new LogFormat(10.0, "10e", true));
        yAxisLog.setSmallestValue(minval);
        //yAxisLog.setStandardTickUnits(LogarithmicAxis.createIntegerTickUnits());
        //yAxisLog.setStrictValuesFlag(false);
        
        //Make the symbols renderer....
        XYErrorRenderer rendererPoints = new XYErrorRenderer();
        Shape dot = new Ellipse2D.Double(-2,-2,4,4);
        rendererPoints.setSeriesShape(0,dot);        
        rendererPoints.setBaseShapesVisible(true);
        rendererPoints.setBaseShapesFilled(false);

        //rendererPoints.setBaseLinesVisible(false);
        
        //Make the lines renderer....
        XYLineAndShapeRenderer rendererLines = new XYLineAndShapeRenderer();
        rendererLines.setBaseLinesVisible(true);
        rendererLines.setBaseShapesVisible(false);
        
        //Now make the shading renderer
        DeviationRenderer rendererShading = new DeviationRenderer();
        rendererShading.setBaseLinesVisible(false);
        rendererShading.setBaseShapesVisible(false);
        //rendererShading.setSeriesFillPaint(0, new Color(255, 200, 200));
        //rendererShading.setSeriesFillPaint(1, new Color(255, 200, 200));
        
        rendererShading.setAutoPopulateSeriesFillPaint(true);
        for (int i = 0 ; i < numberOfContrasts ; i++) {
            rendererShading.setSeriesFillPaint(i, new Color(255, 200, 200));
        }
        
        
        //Produce the plot and add the three renderers
        XYPlot plot = new XYPlot(pointsColl, refXAxisLog, yAxisLog, rendererPoints);  //first (points) plot is plot 0
        
        plot.setDataset(1,linesColl);
        plot.setRenderer(1,rendererLines);
       
        plot.setDataset(2,shadingColl);
        plot.setRenderer(2,rendererShading);
        
        plot.setBackgroundPaint(Color.white);
        plot.setDomainGridlinesVisible(false);
        plot.setRangeGridlinesVisible(false);
        
        JFreeChart chart = new JFreeChart("", plot);
        chart.removeLegend();
        chart.getPlot().setDrawingSupplier(new DefaultDrawingSupplier(
                    new Paint[] {VERY_DARK_RED, 
                    VERY_DARK_GREEN,
                    VERY_DARK_BLUE,
                    VERY_DARK_MAGENTA,
                    VERY_DARK_YELLOW,
                    DARK_RED, 
                    DARK_GREEN,
                    DARK_BLUE,
                    DARK_MAGENTA},
                    DefaultDrawingSupplier.DEFAULT_OUTLINE_PAINT_SEQUENCE,
                    DefaultDrawingSupplier.DEFAULT_STROKE_SEQUENCE,
                    DefaultDrawingSupplier.DEFAULT_OUTLINE_STROKE_SEQUENCE,
                    DefaultDrawingSupplier.DEFAULT_SHAPE_SEQUENCE)); 
        
        //chart.setAntiAlias(false);
        final ChartPanel panel = new ChartPanel(chart);
        panel.getChartRenderingInfo().setEntityCollection(null);
        panel.setDisplayToolTips(false);
        this.refChart = chart;
        return panel;
    }    
    
    public ChartPanel mkRefErrorbarChart(XYIntervalSeriesCollection pointsColl, XYSeriesCollection linesColl, String name, double minval) {
        
        linesColl.setIntervalWidth(0.0);
        
        //refAxisLin = new NumberAxis("Qz");
        //refXAxisLog = new LogarithmicAxis("Qz");
        LogAxis yAxisLog = new LogAxis("Ref");
        yAxisLog.setNumberFormatOverride(new LogFormat(10.0, "10e", true));
        yAxisLog.setSmallestValue(minval);
        //yAxisLog.setStandardTickUnits(LogarithmicAxis.createIntegerTickUnits());
        //yAxisLog.setStrictValuesFlag(false);
        
        //Make the symbols renderer....
        XYErrorRenderer rendererPoints = new XYErrorRenderer();
        //DeviationRenderer rendererPoints = new DeviationRenderer();
        rendererPoints.setBaseShapesVisible(true);
        rendererPoints.setBaseShapesFilled(false);
        rendererPoints.setBaseLinesVisible(false);
        
        //Make the lines renderer....
        XYLineAndShapeRenderer rendererLines = new XYLineAndShapeRenderer();
        rendererLines.setBaseLinesVisible(true);
        rendererLines.setBaseShapesVisible(false);
        
        XYPlot plot = new XYPlot(pointsColl, refXAxisLog, yAxisLog, rendererPoints);
        
        plot.setDataset(1,linesColl);
        plot.setRenderer(1,rendererLines);
        
        plot.setBackgroundPaint(Color.white);
        plot.setDomainGridlinesVisible(false);
        plot.setRangeGridlinesVisible(false);
        
        JFreeChart chart = new JFreeChart("", plot);
        chart.removeLegend();
        chart.getPlot().setDrawingSupplier(new DefaultDrawingSupplier(
                    new Paint[] {VERY_DARK_RED, 
                    VERY_DARK_GREEN,
                    VERY_DARK_BLUE,
                    VERY_DARK_MAGENTA,
                    VERY_DARK_YELLOW,
                    DARK_RED, 
                    DARK_GREEN,
                    DARK_BLUE,
                    DARK_MAGENTA},
                    DefaultDrawingSupplier.DEFAULT_OUTLINE_PAINT_SEQUENCE,
                    DefaultDrawingSupplier.DEFAULT_STROKE_SEQUENCE,
                    DefaultDrawingSupplier.DEFAULT_OUTLINE_STROKE_SEQUENCE,
                    DefaultDrawingSupplier.DEFAULT_SHAPE_SEQUENCE)); 
        
        //chart.setAntiAlias(false);
        final ChartPanel panel = new ChartPanel(chart);
        panel.getChartRenderingInfo().setEntityCollection(null);
        panel.setDisplayToolTips(false);
        this.refChart = chart;
        return panel;
    }
    
    public synchronized void updateTheReflData(java.lang.Double data[][], int points, int contrast) {
    
        XYPlot refPlot = getThePlot();
        XYSeriesCollection pointColl =  (XYSeriesCollection) refPlot.getDataset(0);
        XYSeries thisSeries = pointColl.getSeries(contrast);
        thisSeries.clear();
        for (int i=0 ; i<points-1 ; i++) {
            thisSeries.add(data[i][0],data[i][1],false);
        };
        thisSeries.add(data[points][0],data[points][1]);
    }
    
    
        public synchronized void updateTheReflErrorData(java.lang.Double data[][], int points, int contrast) {
    
        XYPlot refPlot = getThePlot();
        XYIntervalSeriesCollection pointColl =  (XYIntervalSeriesCollection) refPlot.getDataset(0);
        XYIntervalSeries thisSeries = pointColl.getSeries(contrast);
        thisSeries.clear();
        refChart.setNotify(false);
        for (int i=0 ; i<points ; i++) {
            thisSeries.add(data[i][0],data[i][1],data[i][2],data[i][3],data[i][4],data[i][5]);
        };
        refChart.setNotify(true);
    }
    
    
    
    public synchronized void updateTheReflSims(java.lang.Double data[][], int points, int contrast) {
    
        XYPlot refPlot = getThePlot();
        XYSeriesCollection pointColl =  (XYSeriesCollection) refPlot.getDataset(1);
        XYSeries thisSeries = pointColl.getSeries(contrast);
        thisSeries.clear();
        for (int i=0 ; i<points-1 ; i++) {
            thisSeries.add(data[i][0],data[i][1],false);
        };
        thisSeries.add(data[points][0],data[points][1]);
    }    
    
    public synchronized void updateTheSLDs(java.lang.Double data[][], int points, int contrast){
        
        XYPlot sldPlot = getTheSldPlot();
        XYSeriesCollection pointColl =  (XYSeriesCollection) sldPlot.getDataset(0);
        XYSeries thisSeries = pointColl.getSeries(contrast);
        thisSeries.clear();
        for (int i=0 ; i<points-1 ; i++) {
            thisSeries.add(data[i][0],data[i][1],false);
        };
        thisSeries.add(data[points][0],data[points][1]);
    }
    
    public XYPlot getTheSldPlot() {
        XYPlot myPlot = (XYPlot)getSldChart().getPlot();
        return myPlot;
    }
    
    public XYPlot getThePlot() {
        XYPlot myPlot = (XYPlot)getRefChart().getPlot();
        return myPlot;
    }
    
    
    public void setTheRefXAxisToLinear(){
        XYPlot thisPlot = getThePlot();
        thisPlot.setDomainAxis(refAxisLin);
    }

    public void setTheRefXAxisToLog(){
        XYPlot thisPlot = getThePlot();
        thisPlot.setDomainAxis(refXAxisLog);
    }
    
    public void setTheYAxisToLog() {
        XYPlot thisPlot = getThePlot();
        thisPlot.setRangeAxis(intAxisLog);
    }
    
    public void setTheYAxisToLinear() {
        XYPlot thisPlot = getThePlot();
        thisPlot.setRangeAxis(intAxisLin);
    }
    
    
    public XYLineAndShapeRenderer mkNewRenderer() {
        XYLineAndShapeRenderer myRenderer = new XYLineAndShapeRenderer();
        return myRenderer;
    }
    
    public XYErrorRenderer mkXYRenderer() {
        XYErrorRenderer rend = new XYErrorRenderer();
        //rend.setDrawYError(true);
        //rend.setDrawXError(false);
        return rend;
    }
    
    public DeviationRenderer mkXYShadedRenderer() {
        DeviationRenderer rend = new DeviationRenderer();
        return rend;
    }
    
    public XYLineAndShapeRenderer setRenderBlack(XYLineAndShapeRenderer thisRenderer, int series) {
        thisRenderer.setSeriesPaint(series,Color.black);
        return thisRenderer;
    }

    public JFreeChart getRefChart() {
        return refChart;
    }
    
    public void setRefChart(ChartPanel newChart) {
        refChart = newChart.getChart();
    } 

    public JFreeChart getSldChart() {
        return sldChart;
    }

    public boolean isFinished() {
        return finished;
    }

    public void setFinished(boolean finished) {
        this.finished = finished;
    }

    public LogarithmicAxis getRefXAxisLog() {
        return refXAxisLog;
    }

    public NumberAxis getRefAxisLin() {
        return refAxisLin;
    }
    
    public Double[][] convertArray(double[][] v, int rows) {
        
        Double[][] myObj  = new Double[rows][2];
        for (int r=0;r<rows;r++){
            myObj[r][0] = (java.lang.Double)v[r][0];
            myObj[r][1] = (java.lang.Double)v[r][1];
        }
        return myObj;
    };
    
        public Double[][] convertErrorbarArray(double[][] v, int rows) {
        
        Double[][] myObj  = new Double[rows][6];
        for (int r=0;r<rows;r++){
            myObj[r][0] = (java.lang.Double)v[r][0];
            myObj[r][1] = (java.lang.Double)v[r][1];
            myObj[r][2] = (java.lang.Double)v[r][2];
            myObj[r][3] = (java.lang.Double)v[r][3];
            myObj[r][4] = (java.lang.Double)v[r][4];
            myObj[r][5] = (java.lang.Double)v[r][5];
        }
        return myObj;
    };
}

