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

<div class="dashboard">
  <header>
    <a href="/session" data-method="delete">
      Log out
    </a>
  </header>
  
  {@render children()}
  
  <nav class="justify-evenly flex">
    <a href="/dashboard">
      <div class="i-bitcoin-icons:home-outline w-2.5em h-2.5em"></div>
      Home
    </a>
  </nav>
</div>
  
<style>
  nav {
    border-top: 1px solid var(--color-border);

    a {
      display: flex;
      font-size: 0.8em;
      flex-direction: column;
      align-items: center;
      padding: 0.5rem;
      color: var(--color-text);
      text-decoration: none;
    }
  }
  .dashboard {
    min-height: 100dvh;
    display: grid;
    max-width: 600px;
    background: #00000022;
    border-left: 1px solid var(--color-border);
    border-right: 1px solid var(--color-border);
    margin: 0 auto;
    grid-template-areas:
      "header"
      "main"
      "nav";
    grid-template-rows: auto 1fr auto;
  }
</style>