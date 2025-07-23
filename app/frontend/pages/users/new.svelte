<script>
  import State from 'activestate'
  import { useForm } from 'inertiax-svelte';
  import { modal } from '~/lib/ui/Modal.svelte'

  const form = useForm({
    email: ''
  });

  function submit(ev) {
    ev.preventDefault();
    $form.post("/users")
  }
</script>

<div class="container">
  <h1>
    Welcome to the Era of Financial Freedom!
  </h1>

  <p class="subtitle">
    Join the world's largest open-source crypto MLM platform and earn passive income simply by holding our Revenue Share Token ($RST).
  </p>

  <p class="description">
    Enter your email address to get started.
  </p>

  <form onsubmit={submit} class="email-form">
    <div class="form-group">
      <input
        type="email"
        bind:value={$form.email}
        placeholder="Enter your email address"
        class="email-input"
        class:error={$form.errors?.email}
        required
      />
      {#if $form.errors?.email}
        <span class="error-message">{$form.errors.email}</span>
      {/if}
    </div>
    
    <button 
      type="submit" 
      class="submit-btn"
      disabled={$form.processing}
    >
      {#if $form.processing}
        <span class="spinner"></span>
        Getting Started...
      {:else}
        Start Your Journey
      {/if}
    </button>
  </form>
</div>

<style>
  .container {
    max-width: 600px;
    margin: 0 auto;
    padding: 2rem;
    text-align: center;
  }

  h1 {
    font-size: 2.5rem;
    font-weight: bold;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    margin-bottom: 1.5rem;
  }

  .subtitle {
    font-size: 1.2rem;
    color: #666;
    margin-bottom: 1rem;
    line-height: 1.6;
  }

  .description {
    font-size: 1rem;
    color: #888;
    margin-bottom: 2rem;
  }

  .email-form {
    background: white;
    padding: 2rem;
    border-radius: 16px;
    box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
    border: 1px solid #f0f0f0;
  }

  .form-group {
    margin-bottom: 1.5rem;
    text-align: left;
  }

  .email-input {
    width: 100%;
    padding: 1rem 1.5rem;
    font-size: 1rem;
    border: 2px solid #e1e5e9;
    border-radius: 12px;
    transition: all 0.3s ease;
    background: #f8f9fa;
  }

  .email-input:focus {
    outline: none;
    border-color: #667eea;
    background: white;
    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
  }

  .email-input.error {
    border-color: #e74c3c;
    background: #fdf2f2;
  }

  .error-message {
    color: #e74c3c;
    font-size: 0.875rem;
    margin-top: 0.5rem;
    display: block;
  }

  .submit-btn {
    width: 100%;
    padding: 1rem 2rem;
    font-size: 1.1rem;
    font-weight: 600;
    color: white;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border: none;
    border-radius: 12px;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
  }

  .submit-btn:hover:not(:disabled) {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
  }

  .submit-btn:active {
    transform: translateY(0);
  }

  .submit-btn:disabled {
    opacity: 0.7;
    cursor: not-allowed;
  }

  .spinner {
    width: 16px;
    height: 16px;
    border: 2px solid transparent;
    border-top: 2px solid white;
    border-radius: 50%;
    animation: spin 1s linear infinite;
  }

  @keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
  }

  @media (max-width: 768px) {
    .container {
      padding: 1rem;
    }

    h1 {
      font-size: 2rem;
    }

    .email-form {
      padding: 1.5rem;
    }
  }
</style>