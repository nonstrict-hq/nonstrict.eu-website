import Image from 'next/image'
import logo from '@/images/logo-color.png'

export function Logo() {
  return (
    <div className="flex items-center gap-x-5">
      <Image
        src={logo}
        alt=""
        width={36}
        height={52}
        className="drop-shadow-[0_0_20px_rgba(0,0,0,0.4)]"
      />
      <span className="text-white text-4xl font-bold tracking-wide">Fikkie</span>
    </div>
  )
}
