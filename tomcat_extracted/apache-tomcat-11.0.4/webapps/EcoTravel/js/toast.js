// Simple toast manager
class Toast {
  constructor() {
    this.container = document.createElement('div');
    this.container.className = 'toast-container';
    document.body.appendChild(this.container);
  }

  show(message, options = {}) {
    const toast = document.createElement('div');
    toast.className = 'toast';
    toast.textContent = message;
    const duration = options.duration || 3000;
    toast.style.setProperty('--toast-delay', `${duration}ms`);
    this.container.appendChild(toast);
    setTimeout(() => toast.remove(), duration + 300);
  }
}

// Expose a singleton
window.toast = new Toast();
