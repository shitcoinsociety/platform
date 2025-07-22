import { defineConfig, presetIcons } from 'unocss'
import presetWind4 from '@unocss/preset-wind4'
export default defineConfig({
  presets: [
    presetWind4({
      preflights: {
        reset: true,
      }
    }),
    presetIcons({
      scale: 1.2,
      extraProperties: {
        'display': 'inline-block',
        'vertical-align': 'middle',
      },
      warn: true,
    })
  ],
})