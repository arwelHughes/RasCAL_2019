import javax.swing.JInternalFrame;
import javax.swing.JComponent;
import javax.swing.JFrame;
import javax.swing.JPanel;
import org.jdesktop.jxlayer.JXLayer;
import org.jdesktop.jxlayer.plaf.ext.LockableUI;
import org.jdesktop.jxlayer.plaf.effect.BufferedImageOpEffect;
import com.jhlabs.image.BlurFilter;
import java.lang.String;

public class lockableInternalFrame extends JInternalFrame {

    public JXLayer<JComponent> layer;
    public LockableUI blurUI = new LockableUI(new BufferedImageOpEffect(new BlurFilter()));
    
    public lockableInternalFrame(String title) {
        super(title);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        JComponent view = createLayerPanel();
        layer = new JXLayer<JComponent>(view);
        layer.setUI(blurUI);
        add(layer);
    }

    public JComponent createLayerPanel() {
        JComponent panel = new JPanel();
        return panel;
    }

    public void setLocked() {
        blurUI.setLocked(true);
        repaint();
    }

    public void setUnlocked() {
        blurUI.setLocked(false);
        repaint();
    }
}

