import "uno.css"

import { createInertiaApp } from 'inertiax-svelte'
import { mount } from 'svelte'
import resolve from "./util/resolve";
import { Toaster, toast } from 'svelte-sonner';

// Function to show flash messages using svelte-sonner
function showFlash(flash) {
  if (flash.notice) toast.success(flash.notice);
  if (flash.error) toast.error(flash.error);
  if (flash.success) toast.success(flash.success);
}

mount(Toaster, {
  target: document.body,
  props: {
    position: 'top-center',
    richColors: true
  }
})

createInertiaApp({ 
  resolve,
  setup({ el, App, props }) {
    const flash = props?.initialPage?.props?.flash;
    if (flash) showFlash(flash);
    mount(App, { target: el, props })
  },
})

document.addEventListener("inertia:success", (event) => {
  const flash = event.detail.page.props.flash;
  if (flash) showFlash(flash);
})