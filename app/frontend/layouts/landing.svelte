<script>
  import State from 'activestate';
  import { modal } from '~/lib/ui/Modal.svelte';

  const {
    children
  } = $props();

  let scrollY = $state(0);
</script>


<svelte:window bind:scrollY />

<header class:scrolled={scrollY > 20}>
  <div class="container full">
    <div class="flex items-center gap-4">
      <div class="logo grow">
        <img src="~/assets/logo.png?h=42" alt="Logo" class="logo-image" />
        <span class="logo-text hidden sm:block">Shitcoin Swap</span>
      </div>
      <a target="_blank" href="https://github.com/shitcoinswap">
        <div class="i-mdi:github w-1.8em h-1.8em">GitHub</div>
      </a>
      {#if State.user}
        <a href="/session" data-method="delete">
          Log Out
        </a>
        <a class="btn primary" href="/dashboard">
          Dashboard
        </a>
      {:else}
        <button onclick={modal("/session/new")}>
          Log in
        </button>
        <button class="btn primary" onclick={modal("/users/new")}>
          Sign up
        </button>
      {/if}
    </div>
  </div>
</header>

{@render children()}

<style>
  :global {
    body {
      background: url("/marinabay.jpg") no-repeat center center fixed;
      background-size: cover;
      position: relative;
      min-height: 100dvh;
    }
    #app {
      position: relative;
      min-height: 100dvh;
      background: radial-gradient(ellipse at center, rgba(0,0,0,0.3) 0%, rgba(0,0,0,0.8) 100%);
    }

    .container {
      max-width: 800px;
      margin: 0 auto;
      padding-inline: 1rem;
    }

    @media (min-width: 768px) {
      .container {
        padding-inline: 2rem;
      }
    }
  }
  header {
    position: sticky;
    border-radius: 10px;
    z-index: 1;
    padding: 0.5rem 0rem;
    margin-inline: 1rem;
    top: 1rem;
    color: white;
    transition: background 0.3s ease;
  }
  header button, header a {
    font-size: 0.9rem;
    font-weight: 600;
  }
  .logo-text {
    font-size: 1.5rem;
    font-weight: bold;
    transition: all 0.3s ease;
  }
  .logo-image {
    filter: brightness(10);
    transition: all 0.3s ease;
  }
  header.scrolled {
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
    background: rgba(255, 255, 255, 0.05);
    backdrop-filter: blur(10px);

    .logo-image {
      filter: brightness(1);
    }
  }

  header .btn.primary {
    font-size: 0.9rem;
    padding: 0.75rem 1.5rem;
  }
  .logo {
    display: flex;
    align-items: center;
    gap: 0.5rem;
  }


  @media (min-width: 768px) {
    header {
      top: 1rem;
      padding: 0.75rem 1.5rem;
    }

    .logo-text {
      font-size: 1.5rem;
    }
  }
</style>