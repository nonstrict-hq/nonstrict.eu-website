<script setup lang="ts">
import { withBase } from 'vitepress'

type FeatureIcon = string | { src: string; alt: string }

interface Feature {
  icon: FeatureIcon
  title: string
  points: string[]
}

const featureGroups: Feature[] = [
  {
    icon: { src: withBase('/swift.png'), alt: 'Swift' },
    title: 'Swift support',
    points: [
      'Modern SPM package with SwiftUI & concurrency support',
      'Drop-in UI components for quick experiments'
    ]
  },
  {
    icon: { src: withBase('/electron.png'), alt: 'Electron' },
    title: 'Electron support',
    points: [
      'First-class bridge with TypeScript definitions',
      'Tap into native performance right from Electron'
    ]
  },
  {
    icon: '🔴',
    title: 'Screen and audio recording',
    points: [
      'Capture displays, windows, and system audio together',
      'Record iPad and iPhone devices via cable'
    ]
  },
  {
    icon: '🎥',
    title: 'Camera and mic recording',
    points: [
      'Keep all sources frame-perfect and in sync',
      'Output single files, HLS, or low-level raw streams'
    ]
  },
  {
    icon: '⌨️',
    title: 'User input recording',
    points: [
      'Capture keyboard presses, mouse movement, and clicks',
      'Power overlays and interaction analytics'
    ]
  },
  {
    icon: '🔐',
    title: 'Discovery and permissions',
    points: [
      'List available devices and media sources from one API',
      'Guide users through macOS permission prompts'
    ]
  },
  {
    icon: '🛡️',
    title: 'Battle-tested',
    points: [
      'Handles hundreds of real-world edge cases',
      'Built on years of production usage at scale'
    ]
  },
  {
    icon: '🚀',
    title: 'High performance',
    points: [
      'Native-optimized pipeline for smooth captures',
      'Efficient resource usage in Swift and Electron'
    ]
  },
  {
    icon: '🧑‍💻',
    title: 'Lovely developer experience',
    points: [
      'Modern, well-documented APIs with ready-to-use outputs',
      'Direct support from the RecordKit team'
    ]
  }
]
</script>

<template>
  <section id="features" class="rk-section">
    <h2>Features</h2>
    <div class="features-grid">
      <article v-for="feature in featureGroups" :key="feature.title" class="feature-card">
        <span class="feature-icon" aria-hidden="true">
          <template v-if="typeof feature.icon === 'string'">
            {{ feature.icon }}
          </template>
          <template v-else>
            <img :src="feature.icon.src" :alt="feature.icon.alt" />
          </template>
        </span>
        <h3>{{ feature.title }}</h3>
        <ul>
          <li v-for="point in feature.points" :key="point">{{ point }}</li>
        </ul>
      </article>
    </div>
  </section>
</template>
