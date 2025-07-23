import "uno.css"
import '~/layouts/global.css'

import { createInertiaApp } from 'inertiax-svelte'
import { mount } from 'svelte'
import { subscribe } from 'activestate';
import resolve from "./util/resolve";
import { Toaster, toast } from 'svelte-sonner';
import '~/lib/ui/loading'
import { modal } from '~/lib/ui/Modal.svelte';

function showFlash(flash) {
  if (flash.notice) toast.success(flash.notice);
  if (flash.error) toast.error(flash.error);
  if (flash.success) toast.success(flash.success);
  if (flash.modal) modal(flash.modal)();
}


subscribe('GlobalChannel')

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
    mount(App, { target: el, props })
    if (flash) showFlash(flash);
  },
})

document.addEventListener("inertia:success", (event) => {
  const flash = event.detail.page.props.flash;
  if (flash) showFlash(flash);
})