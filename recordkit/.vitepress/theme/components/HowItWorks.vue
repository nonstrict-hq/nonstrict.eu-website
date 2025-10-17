<script setup lang="ts">
import { ref } from 'vue'
import VPSwitch from 'vitepress/dist/client/theme-default/components/VPSwitch.vue'
import { VPButton } from 'vitepress/theme'

const mode = ref<'swift' | 'electron'>('swift')

const toggleMode = () => {
  mode.value = mode.value === 'swift' ? 'electron' : 'swift'
}
</script>

<template>
  <section id="how-it-works" class="rk-section rk-how-it-works">
    <div class="rk-narrow">
      <h2>How it works</h2>

      <div class="mode-switch" role="group" aria-label="Select implementation guide">
        <button
          type="button"
          class="mode-label"
          :class="{ active: mode === 'swift' }"
          @click="mode = 'swift'"
        >
          Swift
        </button>

        <VPSwitch
          class="mode-switch-control"
          :class="{ 'is-electron': mode === 'electron' }"
          :aria-checked="mode === 'electron'"
          role="switch"
          :title="mode === 'swift' ? 'Switch to Electron guide' : 'Switch to Swift guide'"
          @click="toggleMode"
        >
          <span class="mode-switch-icon swift" aria-hidden="true">
            <img src="/recordkit/swift.png" alt="" />
          </span>
          <span class="mode-switch-icon electron" aria-hidden="true">
            <img src="/recordkit/electron.png" alt="" />
          </span>
        </VPSwitch>

        <button
          type="button"
          class="mode-label"
          :class="{ active: mode === 'electron' }"
          @click="mode = 'electron'"
        >
          Electron
        </button>
      </div>

      <div v-if="mode === 'swift'" class="how-content">
        <ol>
          <li>
            <strong>Install via Swift Package Manager</strong>
          </li>

          <li>
            <strong>Start a recording</strong>
<pre><code>let recorder = RKRecorder([(...)])

try await recorder.prepare()

recorder.start()</code></pre>
          </li>

          <li>
            <strong>Stop the Recording</strong>
<pre><code>try await recorder.stop()</code></pre>
          </li>

          <li><strong>That's it!</strong></li>

          <li><a href="try-swift">Read the full guide now</a> to get up and running in minutes</li>
        </ol>

      </div>

      <div v-else class="how-content">
        <ol>
          <li>
            <strong>Install via npm, pnpm or yarn</strong>
          </li>

          <li>
            <strong>Start a recording</strong>
<pre><code>import { createRecorder } from '@nonstrict/recordkit'

const rk = createRecorder()

await rk.start({ screen: true, systemAudio: true }</code></pre>
          </li>

          <li>
            <strong>Stop the recording</strong>
<pre><code>await rk.stop()
</code></pre>
          </li>

          <li><strong>That's it!</strong></li>

          <li><a href="try-electron">Read the full guide now</a> to get up and running in minutes</li>
        </ol>

      </div>
      <p>&nbsp;</p>
      <CtaButtons />
    </div>
  </section>
</template>

<style scoped>
.mode-switch {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1rem;
  margin: 1rem auto 2rem;
}

.mode-label {
  border: none;
  background: none;
  font-size: 1.05rem;
  font-weight: 500;
  color: var(--rk-muted);
  cursor: pointer;
  transition: color 0.2s ease, transform 0.2s ease;
  padding: 0.3rem 0.5rem;
}

.mode-label:hover,
.mode-label:focus-visible {
  color: var(--rk-link-hover);
}

.mode-label.active {
  color: var(--rk-link);
  transform: translateY(-2px);
}

.mode-switch-control {
  width: 86px;
  height: 40px;
  border-radius: 20px;
  border: 2px solid var(--vp-input-border-color);
  background-color: var(--vp-input-switch-bg-color);
  transition: border-color 0.25s ease, background-color 0.25s ease;
}

.mode-switch-control:hover {
  border-color: var(--vp-c-brand-1);
}

.mode-switch-control :deep(.check) {
  top: 2px;
  left: 2px;
  width: 32px;
  height: 32px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.mode-switch-control :deep(.icon) {
  width: 32px;
  height: 32px;
  display: block;
  position: relative;
  border-radius: 50%;
  overflow: hidden;
}

.mode-switch-icon {
  position: absolute;
  inset: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 0.85rem;
  font-weight: 600;
  color: var(--vp-c-text-2);
  opacity: 0;
  transition: opacity 0.2s ease;
}

.mode-switch-icon img {
  width: 20px;
  height: 20px;
  object-fit: contain;
}

.mode-switch-control :deep(.icon) .mode-switch-icon.swift {
  opacity: 1;
}

.mode-switch-control :deep(.icon) .mode-switch-icon.electron {
  opacity: 0;
}

.mode-switch-control.is-electron :deep(.icon) .mode-switch-icon.swift {
  opacity: 0;
}

.mode-switch-control.is-electron :deep(.icon) .mode-switch-icon.electron {
  opacity: 1;
}

.mode-switch-control.is-electron :deep(.check) {
  transform: translateX(46px);
}

.how-content {
  margin-top: 1.5rem;
}

.how-link {
  margin-top: 0.5rem;
  text-align: center;
}

.cta {
  display: block;
  margin: 1.5rem auto 0;
}

@media (max-width: 720px) {
  .mode-switch {
    gap: 0.75rem;
  }

  .mode-switch-control {
    width: 72px;
  }

  .mode-switch-control.is-electron :deep(.check) {
    transform: translateX(36px);
  }
}
</style>
