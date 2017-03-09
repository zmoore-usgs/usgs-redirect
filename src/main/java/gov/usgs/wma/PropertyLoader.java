package gov.usgs.wma;

import javax.naming.NamingException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import gov.usgs.cida.config.DynamicReadOnlyProperties;

/**
 * Loads property regardless of whether or not it's defined in JNDI, JVM props, or Environment Variables
 * @author thongsav
 *
 */
public class PropertyLoader {
	private static final Logger LOG = LoggerFactory.getLogger(PropertyLoader.class);
	private static DynamicReadOnlyProperties props = null;

	private static DynamicReadOnlyProperties getInstance() {
		if (null == props) {
			try {
				props = new DynamicReadOnlyProperties().addJNDIContexts();
			} catch (NamingException e) {
				LOG.warn("Error occured during initProps()", e);
			}
		}
		return props;
	}
	
	public static String getProperty(String prop, String defaultValue) {
		String result = getInstance().getProperty(prop);
		if(result == null) {
			result = defaultValue;
		}
		return result;
	}
}
