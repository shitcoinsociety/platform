<script module>
  import { mount, unmount } from 'svelte';
  import { Frame } from 'inertiax-svelte';
  import { history } from 'inertiax-core';
  import Modal from './Modal.svelte';
  import { fade } from 'svelte/transition';
  import { cubicOut } from 'svelte/easing';

  export function modal(content, options) {
    return function(ev) {
      const props = {
        close,
        ...options
      }
      if (typeof content == "string") props.src = content;
      else props.children = content;
      ev?.preventDefault();
      let instance = null;
      function open() {
        instance = mount(Modal, {
          target: document.body,
          intro: true,
          props
        });
      }
      function close() {
        unmount(instance, {outro: true});
      }
      history.pushExternal('', {
        arrive: open,
        recede: close
      })
    }
  }

  function variable(node, { delay = 0 }) {
    // duration on desktop is 300, on mobile 400
    const duration = window.innerWidth > 768 ? 300 : 400;
    return {
      delay,
      duration,
      easing: cubicOut,
      tick: (t) => {
        node.style.setProperty("--transition", t);
      },
      // css: (t) => `--transition: ${t}`
    };
  }

</script>

<script>
  const { 
    close,
    ...rest
  } = $props();
</script>

<div class="modal_wrapper">
  <button class="modal_back_button" onclick={close} aria-label="Back" transition:fade|global={{duration: 200}}></button>
  <div class="modal" aria-modal="true" transition:variable|global>
    <Frame {close} {...rest}>
      <div class="absolute inset-0 grid place-items-center">
        <div class="spinner"></div>
      </div>
    </Frame>
  </div>
</div>

<style>
  .modal_back_button {
    position: fixed;
    inset: 0;
    cursor: default;
    background-color: rgba(0, 0, 0, 0.6);
  }
  
  .modal_wrapper {
    position: fixed;
    inset: 0;
    display: grid;
    place-items: center;
    z-index: 10;
  }

  .modal {
    background-color: rgba(15, 15, 15, 0.75);
    border-radius: 1rem;
    border: 1px solid var(--color-border);
    backdrop-filter: blur(8px);
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    overflow-x: clip;
    overflow-y: auto;
    width: 100%;
    min-height: 400px;
    max-height: calc(100vh - 40px);
    z-index: 100;
    position: fixed;
    bottom: 0;
    transform: translateY(calc((1 - var(--transition)) * 100%));

    @media (min-width: 600px) {
      max-width: 420px;
      bottom: auto;
      position: relative;
      transform: translateY(calc((1 - var(--transition)) * 20px));
      opacity: var(--transition);
    }
  }
</style>