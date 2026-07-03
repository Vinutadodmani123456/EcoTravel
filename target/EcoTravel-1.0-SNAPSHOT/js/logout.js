// Logout handler using native confirm and toast
function attachLogoutHandler(buttonId, logoutUrl) {
  const btn = document.getElementById(buttonId);
  if (!btn) return;
  btn.addEventListener('click', (e) => {
    e.preventDefault();
    const confirmed = confirm('Are you sure you want to log out?');
    if (confirmed) {
      if (window.toast) {
        window.toast.show('Logging out...');
      }
      // Redirect after short delay to allow toast visibility
      setTimeout(() => {
        window.location.href = logoutUrl;
      }, 800);
    }
  });
}

// Initialize for admin and user (if user button exists on other pages)
attachLogoutHandler('adminLogoutBtn', '/admin/logout');
attachLogoutHandler('userLogoutBtn', '/logout');
