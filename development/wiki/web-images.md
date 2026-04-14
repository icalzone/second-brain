# Web Images Guide

A reference for working with images on the web — formats, optimization, responsive images, and performance best practices.

## Image Formats

| Format | Best For | Transparency | Animation |
|---|---|---|---|
| **JPEG/JPG** | Photographs, complex images | No | No |
| **PNG** | Logos, icons, screenshots with text | Yes | No |
| **WebP** | Modern replacement for JPEG + PNG | Yes | Yes |
| **AVIF** | Next-gen, better compression than WebP | Yes | Yes |
| **SVG** | Icons, logos, illustrations (vector) | Yes | Yes (CSS/JS) |
| **GIF** | Simple animations (legacy; use WebP/video instead) | Yes (1-bit) | Yes |

**Rule of thumb:** Use WebP for most images, AVIF where supported, fallback to JPEG/PNG.

```html
<picture>
  <source srcset="image.avif" type="image/avif">
  <source srcset="image.webp" type="image/webp">
  <img src="image.jpg" alt="Description">
</picture>
```

## Optimization Techniques

### Compression
- **Lossy compression** (JPEG, WebP) — reduces size by discarding data; quality setting 75–85 is usually ideal
- **Lossless compression** (PNG, WebP lossless) — reduces size without quality loss

**Tools:**
- [Squoosh](https://squoosh.app/) — browser-based visual comparison
- [Sharp](https://sharp.pixelplumbing.com/) — Node.js image processing
- ImageMagick — command-line Swiss army knife
- Cloudinary, imgix — CDN-based image optimization APIs

### Right-Sizing
Never serve a 4000px image for a 400px display slot. Resize before uploading.

```sh
# Resize with Sharp (Node.js)
const sharp = require('sharp');
sharp('input.jpg').resize(800).toFile('output.webp');
```

## Responsive Images

### srcset (Resolution Switching)
```html
<img
  src="image-800.jpg"
  srcset="image-400.jpg 400w, image-800.jpg 800w, image-1200.jpg 1200w"
  sizes="(max-width: 600px) 400px, (max-width: 900px) 800px, 1200px"
  alt="Description"
>
```

### art direction with `<picture>`
```html
<picture>
  <source media="(max-width: 600px)" srcset="image-portrait.webp">
  <source media="(min-width: 601px)" srcset="image-landscape.webp">
  <img src="image-landscape.jpg" alt="Description">
</picture>
```

## Lazy Loading

```html
<!-- Native lazy loading (supported in all modern browsers) -->
<img src="image.jpg" loading="lazy" alt="...">
```

Always set `width` and `height` attributes to prevent layout shift (CLS):
```html
<img src="image.jpg" width="800" height="600" loading="lazy" alt="...">
```

## Performance Best Practices

1. **Serve from a CDN** — reduces latency for globally distributed users
2. **Use WebP/AVIF** with JPEG/PNG fallbacks
3. **Compress images** — aim for under 100KB per image where possible
4. **Use `loading="lazy"`** for below-the-fold images
5. **Set width + height** to prevent cumulative layout shift
6. **Preload LCP images** — the Largest Contentful Paint image should not be lazy loaded
   ```html
   <link rel="preload" as="image" href="hero.webp">
   ```
7. **Cache aggressively** — images should have a long cache lifetime (1 year+)

## CMS / Optimizely Image Handling

When working in Optimizely CMS, images are typically served through media content properties. For performance:
- Use ImageResizer or similar middleware to serve correctly sized images
- Store originals in blob storage (see [[optimizely-cms]])
- Apply compression at the CDN layer

## Sources
- `development/raw/The Ultimate Guide to Website Images 2023/`

## Related
- [[javascript]] — JS optimization (complements image performance)
- [[optimizely-cms]] — CMS image handling
- [[README]] — Development wiki home
