import { useId } from 'react'
import Image from 'next/image'
import logo from '@/images/logo.png'

export function Logo() {
  let id = useId()

  return (
    <div className="flex items-center gap-x-4">
      <Image src={logo} alt="" width={42} height={42} />
      <span className="text-white text-2xl font-medium tracking-wide">Keep Going</span>
    </div>
  )
}
