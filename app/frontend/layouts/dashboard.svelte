<script>
  import './dashboard.css'
  import {onMount} from 'svelte';

  const {
    children
  } = $props();

  onMount(() => {
    document.body.classList.add('dashboard');
    return () => {
      document.body.classList.remove('dashboard');
    };
  });
</script>

<header>
  <a href="/session" data-method="delete">
    Log out
  </a>
</header>

{@render children()}

<nav class="justify-evenly flex">
  <a href="/dashboard">Home</a>
</nav>