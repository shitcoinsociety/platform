<script>
  import { useForm } from "@inertiajs/svelte";
  const form = useForm({ code: "" });

  function submit(event) {
    event.preventDefault()
    $form.post("/redemptions")
  }
</script>

<main>
  <section>
    <h2>Enter your code</h2>
    <input type="text" bind:value={$form.code} placeholder="XXX" />
    <button class="btn" onclick={submit}>Redeem</button>
  </section>
</main>