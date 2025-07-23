<script>
  const {
    close
  } = $props();
</script>

<main>
  <section>
    Account created successfully!
  </section>
</main>

<footer>
  <a href="/dashboard" class="btn primary" data-target="_top" onclick={close}>
    Go to Dashboard
  </a>
</footer>