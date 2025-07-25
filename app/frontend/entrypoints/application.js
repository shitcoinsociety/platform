import "uno.css"
import '~/layouts/global.css'

import { createInertiaApp } from 'inertiax-svelte'
import { mount } from 'svelte'
import State, { subscribe } from 'activestate';
import resolve from "./util/resolve";
import { Toaster, toast } from 'svelte-sonner';
import '~/lib/ui/loading'
import { modal } from '~/lib/ui/Modal.svelte';

subscribe('GlobalChannel')

function showFlash(flash) {
  if (flash.notice) toast.success(flash.notice);
  if (flash.error) toast.error(flash.error);
  if (flash.success) toast.success(flash.success);
  if (flash.modal) modal(flash.modal)();
}

let unsubscribe;
function handleProps(props) {
  if (!props) return;
  if (props.flash) showFlash(props.flash);
  if (props.user_sgid) {
    unsubscribe = subscribe("UserChannel", {sgid: props.user_sgid});
  } else {
    unsubscribe?.()
    // TODO: find a nicer way to reset state after logging out
    State.user = null;
  }
}


mount(Toaster, {
  target: document.body,
  props: {
    position: 'top-center',
    richColors: true,
    duration: ENV === 'test' ? 500 : 5000,
  }
})

createInertiaApp({ 
  resolve,
  setup({ el, App, props }) {
    mount(App, { target: el, props })
    handleProps(props?.initialPage?.props);
  },
})

document.addEventListener("inertia:success", (event) => {
  const props = event.detail.page.props;
  handleProps(props);
})

document.addEventListener("inertia:error", (event) => {
  const errors = event.detail.errors;
  errors.forEach(error => {
    console.log(error)
    typeof error === 'string' && toast.error(error);
  })
})