---
type: concept
domains: [work]
status: stable
source-confidence: high
updated: 2026-05-14
---

# Website Images Guide

Reference for image sizing, file formats, and best practices in web design. Use this to make consistent decisions across image placements.

## Aspect Ratios

Identify the shape (ratio) for each section of a site before debating exact pixel dimensions.

| Ratio | Common Size | Use Case |
|-------|-------------|----------|
| **1:1 Square** | 1080×1080px | In-text images, sidebar ads, Instagram |
| **16:9 Panoramic** | 1920×1080px | Hero images, widescreen presentations, video |
| **3:2 Rectangle** | 1080×720px | Print, phone displays |
| **4:3 Rectangle** | 640×480 (small) / 2048×1536 (full) | Legacy screens, full-screen takeovers |
| **1.59:1 Landscape** | Min 1080px wide | Featured images, blog posts, social media |

## Image Categories & Sizes

| Placement | Recommended |
|-----------|-------------|
| **Favicon** | 16×16, 32×32, 180×180 (Apple touch icon) |
| **Logo** | SVG preferred; PNG fallback |
| **Hero / Full-width** | 1920×1080px, 16:9 ratio |
| **Blog / Content featured image** | 1.59:1 ratio, min 1080px wide |
| **In-text / Inline** | 1:1 or 3:2, depends on layout column width |

## File Formats

| Format | Use When |
|--------|----------|
| **JPEG** | Photos with gradients and complex color; smaller than PNG for photographs |
| **PNG** | Transparency needed; logos; text-heavy images; lossless required |
| **WebP** | Modern default — smaller file size than JPEG/PNG at equivalent quality |
| **SVG** | Icons, logos, illustrations — infinitely scalable, tiny file size |
| **GIF** | Simple animations only; prefer `<video>` for complex animations |
| **AVIF** | Next-gen format with excellent compression; browser support still growing |

## SEO & Performance

- Page load speed is a Google ranking factor — image size directly affects it
- Heavy images increase bounce rate
- **Max file size guideline:** aim for under 200KB per image; hero images under 500KB
- Compress before upload: tools like Squoosh, ImageOptim, or build-time image optimization

### Alt Tags
- Descriptive and relevant — tells screen readers and search engines what the image shows
- Don't keyword-stuff
- Empty `alt=""` for decorative images (screen readers skip them)

### File Names
- Use descriptive, hyphenated names: `red-rock-canyon-hero.jpg`
- Avoid generic names: `image1.jpg`, `IMG_4523.png`

## Video & GIF Considerations

- Use `<video autoplay loop muted playsinline>` instead of GIF for larger animations
- Video files are significantly smaller than equivalent GIFs
- **Embedding vs. hosting:** embed from YouTube/Vimeo to offload bandwidth; self-host for full design control or privacy

## Color Profiles

- Use **sRGB** for web images — consistent across browsers and devices
- Wide-gamut profiles (Display P3) may display differently on non-P3 screens

→ Source: [The Ultimate Guide to Website Images 2023](/raw/The%20Ultimate%20Guide%20to%20Website%20Images%202023/The%20Ultimate%20Guide%20to%20Website%20Images%202023.md)
