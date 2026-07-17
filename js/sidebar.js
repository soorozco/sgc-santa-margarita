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

    // Auto-open nested sub-group (e.g. Libros Electrónicos) with active link
    document.querySelectorAll('.nav-sub-body').forEach(body => {
      if (body.querySelector('.nav-link.active')) {
        body.classList.add('open')
        const btn = document.querySelector(`.nav-sub-btn[data-target="${body.id}"]`)
        if (btn) btn.classList.add('open')
      }
    })

    // Toggle on click (main groups — accordion)
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

    // Toggle on click (nested sub-groups — independent, no acordeón)
    document.querySelectorAll('.nav-sub-btn').forEach(btn => {
      btn.addEventListener('click', e => {
        e.stopPropagation()
        const body = document.getElementById(btn.dataset.target)
        if (!body) return
        body.classList.toggle('open')
        btn.classList.toggle('open')
      })
    })

    // ── Mobile hamburger ─────────────────────────────────────────
    const sidebar  = document.getElementById('sidebar')
    const overlay  = document.getElementById('sidebar-overlay')
    const hamburger = document.getElementById('btn-hamburger')

    function openSidebar() {
      if (sidebar)  sidebar.classList.add('open')
      if (overlay)  overlay.classList.add('show')
    }
    function closeSidebar() {
      if (sidebar)  sidebar.classList.remove('open')
      if (overlay)  overlay.classList.remove('show')
    }

    if (hamburger) hamburger.addEventListener('click', openSidebar)
    if (overlay)   overlay.addEventListener('click', closeSidebar)

    // Close sidebar when a nav link is clicked on mobile
    document.querySelectorAll('.sb-nav .nav-link').forEach(a => {
      a.addEventListener('click', () => {
        if (window.innerWidth <= 700) closeSidebar()
      })
    })
  }

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', init)
  else init()
})()
