
import com.google.gwt.user.client.DOM;
import com.google.gwt.user.client.ui.Composite;
import com.google.gwt.user.client.ui.Frame;
import com.openkm.frontend.client.Main;

/**
 * Administration
 *
 * @author jllort
 *
 */
public class Administration extends Composite {
	private Frame iframe;

	/**
	 * Administration
	 */
	public Administration() {
		iframe = new Frame("about:blank");

		DOM.setElementProperty(iframe.getElement(), "frameborder", "0");
		DOM.setElementProperty(iframe.getElement(), "marginwidth", "0");
		DOM.setElementProperty(iframe.getElement(), "marginheight", "0");
		DOM.setElementProperty(iframe.getElement(), "scrolling", "no");

		// Commented because on IE show clear if allowtransparency=true
		DOM.setElementProperty(iframe.getElement(), "allowtransparency", "false");

		iframe.setUrl(Main.CONTEXT + "/admin/index.jsp");
		iframe.setStyleName("okm-Iframe");

		initWidget(iframe);
	}

	/**
	 * Sets the size on initialization
	 *
	 * @param width The max width of the widget
	 * @param height The max height of the widget
	 */
	public void setSize(int width, int height) {
		iframe.setPixelSize(width - 2, height - 2);
	}
}