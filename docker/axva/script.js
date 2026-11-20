document.addEventListener('DOMContentLoaded', () => {
  document.documentElement.classList.add('js');

  const year = document.getElementById('year');
  if (year) {
    year.textContent = new Date().getFullYear();
  }

  const revealItems = document.querySelectorAll('.reveal');
  if ('IntersectionObserver' in window) {
    const revealObserver = new IntersectionObserver((entries, observer) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add('is-visible');
          observer.unobserve(entry.target);
        }
      });
    }, { threshold: 0.12 });

    revealItems.forEach((item) => revealObserver.observe(item));
  } else {
    revealItems.forEach((item) => item.classList.add('is-visible'));
  }

  const form = document.getElementById('leadForm');
  if (form) {
    form.addEventListener('submit', (event) => {
      event.preventDefault();
      const status = document.getElementById('formStatus');
      if (status) {
        status.textContent = 'This enquiry form is a design preview and is not connected to an inbox yet.';
      }
    });
  }
});
