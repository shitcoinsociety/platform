<script>
  import { State } from "activestate"
  import qrcode from "~/lib/qrcode"

  const link = $derived(`${window.location.host}?ref=${State.user?.referral_code}`)

  function qr(node) {
    const data = qrcode.generatePNG(link)
    const img = document.createElement('img')
    img.src = data
    img.alt = "Your QR code"
    img.className = "w-64 h-64"
    node.appendChild(img)
  }

</script>

<main>

    <div class="relative w-full h-full grid place-items-center">     
      <div use:qr></div>
    </div>
</main>
