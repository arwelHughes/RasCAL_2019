javaaddpath 'C:\Gwaith2007\Java\jfreechart-1.0.5\jfreechart-1.0.5\lib';
javaaddpath 'C:\Gwaith2007\Rascal\JavaSources\newMDI\build\classes';


import org.jfree.*;
import org.jfree.chart.*;
import org.jfree.data.xy.*;
import org.jfree.chart.*;
%import XYSeries.class;

npoints = 500;
series = XYSeries();
for i = 1:npoints;
   y_of_x(i) = cos(i*(pi/180)); 
   series.add(y_of_x(i)); 
end