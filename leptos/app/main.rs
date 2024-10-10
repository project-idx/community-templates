use leptos::*;

fn main() {
    mount_to_body(|| {
        view! {
            <div class="bg-animate">
                <div class="container">
                    <div class="links">
                        <a href="https://discord.gg/x8NhWWYTV2" target="_blank">
                            <img src="https://leptos.dev/images/discord_logo.svg" alt="Discord"/>
                        </a>
                        <a href="https://github.com/leptos-rs/leptos" target="_blank">
                            <img src="https://leptos.dev/images/github_logo.svg" alt="GitHub"/>
                        </a>
                    </div>
                    <h1 class="title">"Leptos Framework"</h1>
                    <div class="grid">
                        <a href="https://leptos.dev/" target="_blank" class="website">
                            <span>"Website"</span>
                            <span>"Go to the official website"</span>
                        </a>
                        <a href="https://book.leptos.dev/" target="_blank" class="book">
                            <span>"Book"</span>
                            <span>"Learn core concepts"</span>
                        </a>
                        <a href="https://docs.rs/leptos/latest" target="_blank" class="docs">
                            <span>"Docs"</span>
                            <span>"Explore the API & modules"</span>
                        </a>
                        <a href="https://youtu.be/K_TmEPAD9Ig" target="_blank" class="video">
                            <span>"Video"</span>
                            <span>"Get started with the intro tutorial"</span>
                        </a>
                    </div>
                </div>
            </div>
            <style>{STYLE}</style>
        }
    })
}

const STYLE: &'static str = "@keyframes waveAnimation {
  0% {
    background-image: linear-gradient(60deg, #ec4899 25%, #8b5cf6 25%, #ec4899 50%, #8b5cf6 50%, #ec4899 75%, #8b5cf6 75%);
    background-size: 400% 400%;
  }
  50% {
    background-image: linear-gradient(120deg, #ec4899 25%, #8b5cf6 25%, #ec4899 50%, #8b5cf6 50%, #ec4899 75%, #8b5cf6 75%);
    background-size: 200% 200%;
  }
  100% {
    background-image: linear-gradient(60deg, #ec4899 25%, #8b5cf6 25%, #ec4899 50%, #8b5cf6 50%, #ec4899 75%, #8b5cf6 75%);
    background-size: 400% 400%;
  }
}

html, body {
  padding: 0;
  margin: 0;
}

.bg-animate {
  animation: waveAnimation 8s ease infinite;
  background-position: 0 50%;
  display: flex;
  height: 100vh;
  width: 100vw;
}

.container {
  margin: auto;
  display: flex;
  flex-direction: column;
  border-radius: 10px;
  background-color: rgba(255, 255, 255, 0.8);
  padding: 32px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
  backdrop-filter: blur(10px);
  position: relative;
}

.links {
  position: absolute;
  right: 16px;
  top: 16px;
}

.links a {
  display: inline-block;
  margin-right: 8px;
}

.links img {
  height: 32px;
  width: 32px;
  filter: invert(100%);
}

.title {
  margin: 24px auto 24px auto;
  background-image: linear-gradient(to right, #ec4899, #8b5cf6);
  background-clip: text;
  -webkit-background-clip: text;
  color: transparent;
  text-align: center;
  font-size: 2.5rem;
  font-weight: 800;
}

.grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 40px;
  margin: auto;
}

.grid a {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  border-radius: 10px;
  border: 1px solid #e5e7eb; /* Gray-200 equivalent */
  background-color: rgba(0, 0, 0, 0.1);
  padding: 16px;
  text-decoration: none;
  font-weight: 700;
  font-size: 1.125rem;
  color: transparent;
  background-clip: text;
  -webkit-background-clip: text;
  box-shadow: 0 4px 6px -2px rgba(0, 0, 0, 0.1), 0 2px 4px -2px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(10px);
  transition: all 0.2s ease;
}
.grid a:hover {
  transform: scale(1.05);
  background-color: rgba(0, 0, 0, 0.2);
  box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1);
}
.grid a span:first-child {
  margin-bottom: 8px;
}
.grid a span:last-child {
  text-align: center;
  font-size: 0.875rem;
  color: #4b5563; /* Gray-600 equivalent */
}
.website {
  background-image: linear-gradient(to right, #ec4899, #8b5cf6);
}
.book {
  background-image: linear-gradient(to right, #06b6d4, #3b82f6);
}
.docs {
  background-image: linear-gradient(to right, #22c55e, #10b981);
}
.video {
  background-image: linear-gradient(to right, #eab308, #f97316);
}";

