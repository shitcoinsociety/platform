import { sentryVitePlugin } from "@sentry/vite-plugin";
import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import { svelte } from '@sveltejs/vite-plugin-svelte';
import extractorSvelte from '@unocss/extractor-svelte'
import UnoCSS from 'unocss/vite'
import { resolve } from 'path'
import { importAssets } from 'svelte-preprocess-import-assets'
import { sveltePreprocess } from 'svelte-preprocess';
import { imagetools } from 'vite-imagetools'

export default defineConfig(({ mode }) => {
  const config = {
    plugins: [
      RubyPlugin(),
      UnoCSS({
        extractors: [
          extractorSvelte(),
        ],
        /* more options */
      }),
      svelte({
        preprocess: [
          // mdsvex({ extension: '.md.svelte' }),
          importAssets()
        ],
        compilerOptions: {
          css: "injected",
          dev: mode === "development"
        }
      }),
      imagetools(),
      mode !== "development" && sentryVitePlugin({
        org: "shitcoinsociety",
        project: "platform"
      })
    ],

    resolve: {
      alias: {
        '@': resolve('./app/assets')
      }
    },

    build: {
      sourcemap: true
    },
    
    css: {
      devSourcemap: mode === "development"
    }
  }
  return config
})