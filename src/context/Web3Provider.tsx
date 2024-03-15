"use client"

import '@rainbow-me/rainbowkit/styles.css';
import { WagmiProvider } from 'wagmi';
import { getDefaultConfig, RainbowKitProvider, } from '@rainbow-me/rainbowkit';
import { bscTestnet } from 'wagmi/chains';
import { QueryClientProvider, QueryClient, } from "@tanstack/react-query";
import { ReactNode } from 'react';

const config = getDefaultConfig({
  appName: 'Test',
  projectId: 'e1cd37f7e93f177de4dbf6686e8d83b0',
  chains: [bscTestnet],
  ssr: true,
});

const queryClient = new QueryClient();
const Web3Provider = ({ children }: { children: ReactNode }) => {

  return (
    <WagmiProvider config={config}>
      <QueryClientProvider client={queryClient}>
        <RainbowKitProvider>
          {children}
        </RainbowKitProvider>
      </QueryClientProvider>
    </WagmiProvider>
  );
};


export default Web3Provider;