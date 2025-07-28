<script>
    import State from "activestate";
  import { modal } from "../lib/ui/Modal.svelte";
 
  import { onMount } from "svelte";

  const { children } = $props();

  onMount(() => {
    document.body.classList.add("dashboard");
    return () => {
      document.body.classList.remove("dashboard");
    };
  });
</script>

{#snippet menu()}
  <header>
    <section>
      <h1>{State.user.email}</h1>
    </section>
  </header>
  <main>
    <section>
      <a href="/session" data-method="delete"> Log out </a>
    </section>
  </main>
{/snippet}

<div class="dashboard">
  <header>
    <button class="user" onclick={modal(menu)}>
      <div class="i-mdi:account-circle w-2.5em h-2.5em">Menu</div>
    </button>
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
  .dashboard {
    min-height: 100dvh;
    display: grid;
    max-width: 600px;
    margin: 0 auto;
    grid-template-areas:
      "header"
      "main"
      "nav";
    grid-template-rows: auto 1fr auto;
    border-left: 1px solid var(--color-border);
    border-right: 1px solid var(--color-border);
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
      @media (min-width: 768px) {
        flex-direction: column;
        align-items: flex-start;
        justify-content: start;

        a {
          flex-direction: row;
          font-size: 1em;
          gap: 0.5rem;
        }
      }
    }
    header {
      padding-inline: var(--padding);
      display: flex;
      padding-top: 0.5rem;
      background: #00000022;
      @media (min-width: 768px) {
        padding: 0.5rem;

        background: none;
      }
    }

    :global(> main) {
      padding-top: var(--padding);
      background: #00000022;
      border-left: 1px solid var(--color-border);
      border-right: 1px solid var(--color-border);
    }
    @media screen and (min-width: 768px) {
      border: none;
      max-width: 768px;
      grid-template-areas:
        "header main"
        "nav    main";
      grid-template-columns: 150px 1fr;
      grid-template-rows: auto 1fr;
    }
  }
</style>
