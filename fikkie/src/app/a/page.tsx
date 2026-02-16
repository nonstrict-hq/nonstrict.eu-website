'use client'

import { useEffect, useState } from 'react'
import Image from 'next/image'
import { Logo } from '@/components/Logo'
import appStoreBadge from '@/images/appstorebadge.svg'

const APP_STORE_ID = '6758355442'

/** Build the fikkie.app equivalent URL from query parameters. */
function buildAppArgument(params: URLSearchParams): string {
  const g = params.get('g')
  const s = params.get('s')
  const c = params.get('c')

  const appParams = new URLSearchParams()
  if (g) appParams.set('g', g)
  if (s) appParams.set('s', s)
  if (c) appParams.set('c', c)

  const qs = appParams.toString()
  return `https://fikkie.app/a${qs ? `?${qs}` : ''}`
}

export default function AdvisoryPage() {
  const [street, setStreet] = useState<string | null>(null)
  const [city, setCity] = useState<string | null>(null)
  const [appArgument, setAppArgument] = useState('https://fikkie.app/a')

  useEffect(() => {
    const params = new URLSearchParams(window.location.search)
    setStreet(params.get('s'))
    setCity(params.get('c'))
    setAppArgument(buildAppArgument(params))
  }, [])

  // Dynamically set Apple Smart App Banner meta tag
  useEffect(() => {
    const meta = document.createElement('meta')
    meta.name = 'apple-itunes-app'
    meta.content = `app-id=${APP_STORE_ID}, app-argument=${appArgument}`
    document.head.appendChild(meta)
    return () => {
      document.head.removeChild(meta)
    }
  }, [appArgument])

  const locationLabel =
    street && city
      ? `${street}, ${city}`
      : street ?? city ?? null

  return (
    <div className="flex min-h-screen flex-col items-center justify-center bg-gray-950 px-6 text-center">
      <Logo />

      {locationLabel && (
        <p className="mt-8 text-lg text-gray-300">
          Stookadvies voor <span className="font-semibold text-white">{locationLabel}</span>
        </p>
      )}

      <p className="mt-6 max-w-sm text-gray-400">
        Download Fikkie om het stookadvies te bekijken.
      </p>

      <a
        href={`https://apps.apple.com/app/apple-store/id${APP_STORE_ID}`}
        className="mt-8"
      >
        <Image
          src={appStoreBadge}
          alt="Download in de App Store"
          width={160}
          height={54}
        />
      </a>
    </div>
  )
}
