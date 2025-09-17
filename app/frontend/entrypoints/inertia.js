import { createInertiaApp } from '@inertiajs/svelte'
import  { mount } from 'svelte';
import Layout from "../layouts/default.svelte"
import { Toaster, toast } from 'svelte-sonner';

createInertiaApp({
  // Disable progress bar
  //
  // see https://inertia-rails.dev/guide/progress-indicators
  // progress: false,

  resolve: (name) => {
    
    const pages = import.meta.glob('../pages/**/*.svelte', {
      eager: true,
    })
    const page = pages[`../pages/${name}.svelte`]
    if (!page) {
      console.error(`Missing Inertia page component: '${name}.svelte'`)
    }

    return { default: page.default, layout: page.layout || Layout }
  },

  setup({ el, App, props }) {
    if (el) {
      mount(App, { target: el, props })
    } else {
      console.error(
        'Missing root element.\n\n' +
          'If you see this error, it probably means you load Inertia.js on non-Inertia pages.\n' +
          'Consider moving <%= vite_javascript_tag "inertia" %> to the Inertia-specific layout instead.',
      )
    }
  },
})

function showFlash(flash) {
  if (flash.notice) toast.success(flash.notice);
  if (flash.error) toast.error(flash.error);
  if (flash.success) toast.success(flash.success);
  if (flash.modal) modal(flash.modal)();
}

document.addEventListener("inertia:success", (event) => {
  const flash = event.detail.page.props.flash;
  showFlash(flash)
})

mount(Toaster, {
  target: document.body,
  props: {
    theme: 'dark',
    position: 'bottom',
    richColors: true,
    duration: ENV === 'test' ? 0 : 5000,
  }
})