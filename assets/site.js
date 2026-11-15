(function () {
  // Menu (small screens)
  var menu = document.getElementById('menu');
  var openBtn = document.querySelector('[data-open-menu]');
  var closeBtn = document.querySelector('[data-close-menu]');
  function setMenu(open) {
    menu.classList.toggle('open', open);
    document.body.classList.toggle('locked', open);
    menu.setAttribute('aria-hidden', open ? 'false' : 'true');
  }
  if (menu && openBtn && closeBtn) {
    openBtn.addEventListener('click', function () { setMenu(true); });
    closeBtn.addEventListener('click', function () { setMenu(false); });
    menu.querySelectorAll('a').forEach(function (a) { a.addEventListener('click', function () { setMenu(false); }); });
    document.addEventListener('keydown', function (e) { if (e.key === 'Escape') setMenu(false); });
  }

  // Audio players: one plays at a time
  var players = [].slice.call(document.querySelectorAll('.player'));
  function fmt(s) { s = Math.max(0, Math.floor(s || 0)); var m = Math.floor(s / 60); return m + ':' + ('0' + (s % 60)).slice(-2); }
  players.forEach(function (p) {
    var audio = p.querySelector('audio');
    var btn = p.querySelector('.pbtn');
    var bar = p.querySelector('.bar');
    var cur = p.querySelector('.cur');
    var dur = p.querySelector('.dur');
    var n = 64, bars = [];
    for (var i = 0; i < n; i++) {
      var b = document.createElement('i');
      // gentle, repeatable waveform shape
      var h = 22 + Math.round(70 * Math.abs(Math.sin(i * 0.55) * Math.cos(i * 0.21 + (p.dataset.seed || 1))));
      b.style.height = h + '%';
      bar.appendChild(b); bars.push(b);
    }
    function paint() {
      var f = audio.duration ? audio.currentTime / audio.duration : 0;
      var on = Math.round(f * n);
      bars.forEach(function (b, i) { b.classList.toggle('on', i < on); });
      cur.textContent = fmt(audio.currentTime);
    }
    audio.addEventListener('loadedmetadata', function () { dur.textContent = fmt(audio.duration); });
    audio.addEventListener('timeupdate', paint);
    audio.addEventListener('play', function () {
      players.forEach(function (o) { if (o !== p) { o.querySelector('audio').pause(); } });
      p.classList.add('playing'); btn.setAttribute('aria-label', 'Pause ' + p.dataset.title);
    });
    audio.addEventListener('pause', function () { p.classList.remove('playing'); btn.setAttribute('aria-label', 'Play ' + p.dataset.title); });
    audio.addEventListener('ended', function () { p.classList.remove('playing'); });
    btn.addEventListener('click', function () { if (audio.paused) audio.play(); else audio.pause(); });
    bar.addEventListener('click', function (e) {
      var r = bar.getBoundingClientRect();
      if (audio.duration) { audio.currentTime = ((e.clientX - r.left) / r.width) * audio.duration; paint(); if (audio.paused) audio.play(); }
    });
  });

  // Hero button plays the reel and scrolls to it
  var hero = document.querySelector('[data-play-reel]');
  if (hero && players[0]) {
    hero.addEventListener('click', function () {
      players[0].scrollIntoView({ behavior: 'smooth', block: 'center' });
      players[0].querySelector('audio').play();
    });
  }

  // Video cards become playable when the video file is in the site
  var modal = document.querySelector('.modal');
  var mv = modal && modal.querySelector('video');
  document.querySelectorAll('.vcard[data-video]').forEach(function (c) {
    var src = c.getAttribute('data-video');
    fetch(src, { method: 'HEAD' }).then(function (r) {
      if (!r.ok || !/^video\//.test(r.headers.get('content-type') || '')) return;
      c.classList.add('ready');
      c.setAttribute('aria-label', 'Play ' + c.querySelector('.vt').textContent);
      c.addEventListener('click', function () {
        players.forEach(function (o) { o.querySelector('audio').pause(); });
        mv.src = src; modal.classList.add('open'); mv.play();
      });
    }).catch(function () {});
  });
  function closeModal() { if (!modal) return; mv.pause(); mv.removeAttribute('src'); mv.load(); modal.classList.remove('open'); }
  if (modal) {
    modal.querySelector('button').addEventListener('click', closeModal);
    modal.addEventListener('click', function (e) { if (e.target === modal) closeModal(); });
    document.addEventListener('keydown', function (e) { if (e.key === 'Escape') closeModal(); });
  }

  // Hide the floating button once the contact form is on screen
  var fl = document.querySelector('.float'), contact = document.getElementById('contact');
  if (fl && contact && 'IntersectionObserver' in window) {
    new IntersectionObserver(function (en) { fl.classList.toggle('hide', en[0].isIntersecting); }).observe(contact);
  }

  // Fade in
  var items = document.querySelectorAll('.reveal');
  if ('IntersectionObserver' in window) {
    var io = new IntersectionObserver(function (en) {
      en.forEach(function (x) { if (x.isIntersecting) { x.target.classList.add('in'); io.unobserve(x.target); } });
    }, { rootMargin: '0px 0px -8% 0px' });
    items.forEach(function (el) { io.observe(el); });
  } else { items.forEach(function (el) { el.classList.add('in'); }); }

  // Thank you page after the enquiry form
  document.querySelectorAll('form.enq').forEach(function (f) {
    var nx = f.querySelector('input[name="_next"]');
    if (nx) nx.value = new URL('thanks/index.html', document.baseURI.replace(/[^/]*$/, '')).href;
  });

  var y = document.getElementById('year');
  if (y) y.textContent = new Date().getFullYear();
})();
