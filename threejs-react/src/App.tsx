import { RoundedBox, Sparkles } from '@react-three/drei';
import { Canvas, ThreeElements, useFrame, useThree } from '@react-three/fiber';
import { useRef } from 'react';
import * as THREE from 'three';
import './App.css';

function App() {
  return (
    <div className="root">
      <div className="body">
        <h1>Hello, Three.js!</h1>
        <p>
          This is a demo of <a href="https://threejs.org/">Three.js</a> with{" "}
          <a href="https://github.com/pmndrs/react-three-fiber">React Three Fiber</a>.
        </p>
        <p>
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla venenatis vitae lacus congue eleifend. Pellentesque laoreet condimentum nunc eu faucibus. Sed mollis nisl non ante rhoncus, nec ornare urna malesuada. Duis at ipsum eget ex scelerisque imperdiet. In venenatis magna vel mauris auctor volutpat. Sed non lobortis augue.
        </p>
        <p>
          Vivamus molestie, leo quis vulputate finibus, urna sem porttitor magna, eget viverra lacus nisl et lorem. Aenean blandit maximus volutpat. Pellentesque in bibendum nulla. Duis vehicula est sed pharetra dictum. Donec diam diam, placerat in sagittis sit amet. Aliquam molestie metus eget nisi tristique, feugiat pellentesque ipsum mattis. Nam sagittis dignissim condimentum. Maecenas volutpat eros at augue maximus, id pretium neque porttitor.
        </p>
      </div>
      <Canvas
        shadows
        camera={{ position: [0, 0, 3] }}
        style={{ pointerEvents: 'none' }}
        className="canvas">
        <ambientLight intensity={Math.PI / 2} />
        <directionalLight position={[10, 10, 10]} castShadow shadow-mapSize={[2024, 2024]} />
        <spotLight position={[10, 10, 10]} angle={0.15} penumbra={1} decay={0} intensity={Math.PI} />
        <pointLight position={[-10, -10, -10]} decay={0} intensity={Math.PI} />
        <Sparkles
          count={100}
          speed={2}
          color={"#5D6A7D"}
          size={3}
          position={[0, 0, 0]}
          scale={[4, 4, 4]}
        />
        <Box speed={1} position={[-1, 0.5, 0]} />
        <Box speed={1.5} position={[1.2, -0, 0]} />
        <Box speed={0.5} position={[0, -0.5, 0]} />
        <Shadows position={[0, 0, -0.5]} />
      </Canvas>
    </div>
  )
}

function Box({ speed, ...props }: ThreeElements['mesh'] & { speed?: number; }) {
  const ref = useRef<THREE.Mesh>(null!)
  useFrame((_, delta) => {
    ref.current.position.x += delta * (speed ?? 1);
    if (ref.current.position.x > 2.5) {
      ref.current.position.x = -2.5
      ref.current.position.y = Math.random() * 1 - 0.5;
    }
    ref.current.rotation.x += delta * (speed ?? 1);
    ref.current.rotation.z += delta * 0.5;
  });

  return (
    <RoundedBox
      args={[1, 1, 1] as any}
      radius={0.2}
      smoothness={4}
      bevelSegments={4}
      {...props}
      ref={ref}
      castShadow
      scale={0.3}
      creaseAngle={0.4}
    >
      <meshPhongMaterial color={'#603BCE'} />
    </RoundedBox>
  )
}

function Shadows(props: ThreeElements['mesh']) {
  const { viewport } = useThree()
  return (
    <mesh receiveShadow scale={[viewport.width * 2, viewport.height * 2, 1]} {...props}>
      <planeGeometry />
      <shadowMaterial transparent opacity={0.5} />
    </mesh>
  )
}

export default App
