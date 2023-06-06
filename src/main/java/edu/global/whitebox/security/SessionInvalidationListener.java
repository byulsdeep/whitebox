package edu.global.whitebox.security;

import javax.servlet.ServletContext;
import javax.servlet.SessionCookieConfig;
import javax.servlet.SessionTrackingMode;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class SessionInvalidationListener implements HttpSessionListener {

    public void sessionCreated(HttpSessionEvent event) {
        // Do nothing
    }

    public void sessionDestroyed(HttpSessionEvent event) {
        // Invalidate all active sessions
        HttpSession session = event.getSession();
        ServletContext servletContext = session.getServletContext();
        SessionCookieConfig sessionCookieConfig = servletContext.getSessionCookieConfig();

        if (!servletContext.getEffectiveSessionTrackingModes().contains(SessionTrackingMode.COOKIE)) {
            // Cookie-based session tracking is not enabled, so skip setting the max age
            return;
        }

        sessionCookieConfig.setMaxAge(0);
    }
}
