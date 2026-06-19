// Sidebar accordion — auto-detects active page, opens the right group
(function () {
  function init() {
    const current = location.pathname.split('/').pop() || 'dashboard.html'

    // Mark active link
    document.querySelectorAll('.sb-nav .nav-link[href]').forEach(a => {
      if (a.getAttribute('href') === current) a.classList.add('active')
    })

    // Auto-open group that contains the active link
    document.querySelectorAll('.nav-group-body').forEach(body => {
      if (body.querySelector('.nav-link.active')) {
        body.classList.add('open')
        const btn = document.querySelector(`.nav-group-btn[data-target="${body.id}"]`)
        if (btn) btn.classList.add('open')
      }
    })

    // Toggle on click
    document.querySelectorAll('.nav-group-btn').forEach(btn => {
      btn.addEventListener('click', () => {
        const body = document.getElementById(btn.dataset.target)
        const isOpen = body.classList.contains('open')
        document.querySelectorAll('.nav-group-body').forEach(b => b.classList.remove('open'))
        document.querySelectorAll('.nav-group-btn').forEach(b => b.classList.remove('open'))
        if (!isOpen) {
          body.classList.add('open')
          btn.classList.add('open')
        }
      })
    })
  }

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', init)
  else init()
})()
