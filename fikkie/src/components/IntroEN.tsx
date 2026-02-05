import Link from 'next/link'
import Image from 'next/image'

import { Logo } from '@/components/Logo'
import appStoreBadge from '@/images/appstorebadge.svg'

export function IntroEN() {
  return (
    <>
      <div>
        <Link href="/en">
          <Logo />
        </Link>
      </div>
      <h1 className="mt-14 font-display text-4xl/tight font-bold text-white">
        Wood burning advisory in your pocket
      </h1>
      <p className="mt-4 text-sm/6 text-gray-300">
        Fikkie gives you instant wood burning advice from the official Dutch
        StookWijzer for your exact location. No postal codes, no hassle. Open
        the app and know immediately.
      </p>
      <a href="https://apps.apple.com/app/apple-store/id6758355442">
        <Image
          className="mt-6"
          src={appStoreBadge}
          alt="Download on the App Store"
          width={120}
          height={40}
        />
      </a>
      <div className="mt-8 flex flex-wrap justify-center gap-x-4 gap-y-3 text-sm text-gray-400 lg:justify-start">
        <Link href="/en/privacy" className="hover:text-white transition-colors">
          Privacy
        </Link>
        <span className="text-gray-600">|</span>
        <Link href="/en/terms" className="hover:text-white transition-colors">
          Terms
        </Link>
        <span className="text-gray-600">|</span>
        <a
          href="mailto:team+fikkie@nonstrict.com"
          className="hover:text-white transition-colors"
        >
          Contact
        </a>
        <span className="text-gray-600">|</span>
        <Link href="/" className="hover:text-white transition-colors">
          NL
        </Link>
      </div>
    </>
  )
}

export function IntroFooterEN() {
  return (
    <p className="text-[0.8125rem]/6 text-gray-500">
      Brought to you by{' '}
      <a href="https://nonstrict.eu/" className="hover:text-gray-400 transition-colors">
        Nonstrict
      </a>
      .
    </p>
  )
}
