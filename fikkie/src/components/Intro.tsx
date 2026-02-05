import Link from 'next/link'
import Image from 'next/image'

import { Logo } from '@/components/Logo'
import appStoreBadge from '@/images/appstorebadge.svg'

export function Intro() {
  return (
    <>
      <div>
        <Link href="/">
          <Logo />
        </Link>
      </div>
      <h1 className="mt-14 font-display text-4xl/tight font-bold text-white">
        Stookwijzer in je broekzak
      </h1>
      <a href="https://apps.apple.com/app/apple-store/id6758355442">
        <Image
          className="mt-6"
          src={appStoreBadge}
          alt="Download in de App Store"
          width={120}
          height={40}
        />
      </a>
    </>
  )
}

export function IntroFooter() {
  return (
    <div className="space-y-1 text-center lg:text-left">
      <p className="text-[0.8125rem]/6 text-gray-500">
        Brought to you by{' '}
        <a href="https://nonstrict.eu/" className="hover:text-gray-400 transition-colors">
          Nonstrict
        </a>
        .
      </p>
      <div className="flex flex-wrap justify-center gap-x-4 gap-y-2 text-[0.8125rem]/6 text-gray-500 lg:justify-start">
        <Link href="/privacy" className="hover:text-gray-400 transition-colors">
          Privacy
        </Link>
        <span className="text-gray-700">|</span>
        <Link
          href="/gebruiksvoorwaarden"
          className="hover:text-gray-400 transition-colors"
        >
          Voorwaarden
        </Link>
        <span className="text-gray-700">|</span>
        <a
          href="mailto:team+fikkie@nonstrict.com"
          className="hover:text-gray-400 transition-colors"
        >
          Contact
        </a>
        <span className="text-gray-700">|</span>
        <Link href="/en" className="hover:text-gray-400 transition-colors">
          EN
        </Link>
      </div>
    </div>
  )
}
