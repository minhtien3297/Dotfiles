---
name: http-caching
description: 'Guidance for HTTP caching design and debugging across browsers, CDNs, reverse proxies, and APIs. Use when configuring Cache-Control, ETag, Last-Modified, Expires, or Vary headers, diagnosing stale responses, or designing cache strategies for static and dynamic content.'
---

# HTTP Caching

Use this skill when working on HTTP caching behavior for browsers, CDNs, reverse proxies, or origin APIs.

## When to Use This Skill

- Configuring `Cache-Control`, `ETag`, `Last-Modified`, `Expires`, or `Vary`
- Designing caching for static assets, HTML documents, JSON APIs, or edge-delivered content
- Debugging stale content, cache misses, revalidation loops, or incorrect shared caching
- Reviewing browser, CDN, or proxy cache behavior for correctness and performance

## Working Rules

- Prefer explicit cache semantics over implicit defaults.
- Separate immutable asset caching from dynamic page or API caching.
- Treat personalized or authenticated responses as non-shared unless proven safe.
- Validate how browser cache, CDN cache, and origin revalidation interact before changing TTLs.

## Checklist

- Confirm which cache layer should store the response.
- Set `Cache-Control` for freshness, revalidation, and shared-cache behavior.
- Use `ETag` or `Last-Modified` when conditional requests are intended.
- Add `Vary` only for dimensions that truly change the representation.
- Avoid storing sensitive content in shared caches.
- Test with real response headers and `304 Not Modified` flows.
