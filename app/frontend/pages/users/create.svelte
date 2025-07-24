<script>
  const {
    close
  } = $props();
</script>

<header>
  <h1>
    Account created!
  </h1>
</header>

<main>
  <p>
    Your account has been successfully created.
  </p>
</main>

<footer>
  <a href="/dashboard" class="btn primary" data-target="_top" onclick={close}>
    Continue
  </a>
</footer>