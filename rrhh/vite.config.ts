import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  base: '/sgc-santa-margarita/rrhh-app/',
  build: {
    outDir: '../rrhh-app',
    emptyOutDir: true,
  },
})
