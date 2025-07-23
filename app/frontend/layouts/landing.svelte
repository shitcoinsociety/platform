<script>
  import './landing.css';

  import { modal } from '~/lib/ui/Modal.svelte';

  const {
    children
  } = $props();
</script>

<header>
  <div class="container">
    <div class="flex items-center gap-4">
      <div class="logo grow">
        <img src="~/assets/logo.png?h=42" alt="Logo" class="logo-image" />
        <span class="logo-text">Shitcoin Swap</span>
      </div>
      <a target="_blank" class="text-gray" href="https://github.com/shitcoinswap">
        <div class="i-mdi:github w-1.8em h-1.8em">GitHub</div>
      </a>
      <button class="signup-btn" onclick={modal("/users/new")}>
        Sign Up
      </button>
    </div>
  </div>
</header>


{@render children()}



<style>
  header {
    position: sticky;
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 16px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
    border: 1px solid rgba(255, 255, 255, 0.2);
    z-index: 1;
    padding: 0.5rem 0rem;
    margin-inline: 1rem;
    top: 1rem;
    
  }


  .logo {
    display: flex;
    align-items: center;
    gap: 0.5rem;
  }

  .logo-text {
    font-size: 1.25rem;
    font-weight: bold;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
  }

  .signup-btn {
    padding: 0.5rem 1rem;
    font-size: 0.85rem;
    font-weight: 600;
    color: white;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border: none;
    border-radius: 10px;
    cursor: pointer;
    transition: all 0.3s ease;
  }

  .signup-btn:hover {
    transform: translateY(-1px);
    box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
  }


  @media (min-width: 768px) {
    header {
      top: 1rem;
      padding: 0.75rem 1.5rem;
    }

    .logo-text {
      font-size: 1.5rem;
    }

    .signup-btn {
      padding: 0.75rem 1.5rem;
      font-size: 0.9rem;
    }
  }
</style>