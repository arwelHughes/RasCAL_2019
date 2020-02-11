import java.lang.Double;
import java.io.Serializable;


public class varTest implements Serializable{
    
    public varTest(){
    }
    
    public double testMethod(Double[][] var){
        return (double)var[0][0];
    };
    
    public Double[][] convertArray(double[][] v, int rows) {
        
        Double[][] myObj  = new Double[rows][2];
        for (int r=0;r<rows;r++){
            myObj[r][0] = (java.lang.Double)v[r][0];
            myObj[r][1] = (java.lang.Double)v[r][1];
        }
        return myObj;
    };
}
