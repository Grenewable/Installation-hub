# Installation Hub V2 — setup

## What works
- Create, edit, search and print installation guides for solar PV/batteries, heat pumps and other electrical equipment.
- Record exact brand/model, CT clamp direction, wiring notes, special materials, commissioning checklists, faults, manual revisions and verified source URLs.
- Attach photos and PDF manuals (up to 12 MB each) and view them offline from IndexedDB.
- Export/import full JSON backups including file attachments.
- Optional Supabase email/password sign-in and two-way sync of guides and attachments.
- Install to iPhone Home Screen as a PWA after HTTPS deployment; the app shell is cached for offline use.

## Free hosting (example: GitHub Pages)
1. Create a GitHub repository and upload all files in this folder at the repository root.
2. In repository Settings → Pages, select Deploy from a branch, main, root. Wait for the HTTPS link.
3. Open the HTTPS link in iPhone Safari. Use Share → Add to Home Screen.
4. Open the app at least once online. The service worker caches the app shell for offline use. IndexedDB data remains on that iPhone until cleared.

## Optional free cloud sync (Supabase)
1. Create a Supabase project at https://supabase.com/ . Free-tier quotas and policies can change.
2. In SQL Editor run `supabase_schema.sql` once on a fresh project. If policies already exist, adjust them rather than running the same CREATE POLICY commands twice.
3. Under Authentication → Providers, enable email sign-in. Confirm your email after signing up if required. Configure allowed site URL for your GitHub Pages domain.
4. In Supabase project settings, copy Project URL and the public anon/publishable key. **Never use a service_role/secret key in the app.**
5. In Installation Hub → Cloud & backup, enter these, save connection, create account/sign in, and select Sync now.
6. Sign in with the same account on another device and select Sync now.

## Limitations and safety
- This is a static offline-first prototype, not a live AI service. Document finder opens targeted web searches, not verified retrieval. A source is only verified after you manually inspect the official manufacturer's PDF and record its issue/revision and date.
- A real automatic verified-document service would require a trusted backend, manufacturer-domain allowlisting, revision tracking, provenance and model-specific review; it is not included.
- Cloud sync is **manual**, not background automatic. Latest edit wins on conflicting guides. Deletes do not propagate across devices, and attachment deletions do not remove cloud copies.
- Supabase access tokens are stored only in browser session storage; sessions expire and may require re-login.
- The attachment sync transfers all locally stored attachments on each sync; large libraries may use bandwidth and free-tier quotas.
- Local data can be lost if Safari site data is cleared. Export JSON backups regularly. No guarantee of continued offline access if iOS evicts storage.
- Use exact manufacturer documentation and applicable UK electrical requirements; no wiring or commissioning information in this app should be relied on without verification.
- GitHub Pages is public hosting of the **app code**, not the user data. User data stays in the local browser or protected Supabase tables/storage configured with RLS.
