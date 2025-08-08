<script>
  import qrcode from '~/lib/qrcode'

  const {
    wallet
  } = $props()

  const link = $derived(`bitcoin://${wallet.address}`)

  function qrPNG() {
    return qrcode.generatePNG(link)
  }
</script>

<header>
  <section>
    <h1>
      Receive Bitcoin
    </h1>
  </section>
</header>

<main>
  <section>
    <img
      src={qrPNG()}
      alt="QR Code for receiving Bitcoin"
      width="200"
      height="200"
    />
    <p>
      <a href={link}>
        {wallet.address}
      </a>
    </p>
  </section>
</main>