-- ================================================================
-- Nový domov – Supabase schema
-- Spusti celý tento súbor v Supabase → SQL Editor
-- ================================================================

-- 1. Tabuľka pre zaškrtnuté položky
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS checklist_items (
  key              TEXT PRIMARY KEY,          -- "kuchyna_0_3"
  checked_by       TEXT        NOT NULL,      -- "Lukáš"
  checked_by_email TEXT        NOT NULL,      -- "relo1231@gmail.com"
  checked_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  store            TEXT        NOT NULL,      -- "IKEA" | "Alza" | "Mall" | vlastný text
  updated_at       TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 2. Row Level Security – len prihlásení používatelia čítajú/píšu
-- ----------------------------------------------------------------
ALTER TABLE checklist_items ENABLE ROW LEVEL SECURITY;

CREATE POLICY "auth_select" ON checklist_items
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "auth_insert" ON checklist_items
  FOR INSERT TO authenticated WITH CHECK (true);

CREATE POLICY "auth_update" ON checklist_items
  FOR UPDATE TO authenticated USING (true);

CREATE POLICY "auth_delete" ON checklist_items
  FOR DELETE TO authenticated USING (true);

-- 3. Realtime – povolenie zmien v reálnom čase
-- ----------------------------------------------------------------
ALTER PUBLICATION supabase_realtime ADD TABLE checklist_items;

-- ================================================================
-- Po spustení SQL:
--
-- 1. Choď do Authentication → Settings
--    • Vypni "Enable email confirmations" (aby sa dalo prihlásiť hneď)
--    • Nastav Site URL na tvoju Vercel URL (napr. https://novy-domov.vercel.app)
--
-- 2. Choď do Authentication → Users → "Invite user"
--    Vytvor dvoch používateľov:
--    • relo1231@gmail.com           (heslo si zvolíš)
--    • michaela.palsova26@gmail.com (heslo si zvolíš)
-- ================================================================
