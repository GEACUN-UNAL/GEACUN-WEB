-- ==============================================================================
-- GEACUN - ESQUEMA DE BASE DE DATOS Y POLÍTICAS DE SEGURIDAD (SUPABASE POSTGRESQL)
-- Universidad Nacional de Colombia - Grupo de Estudio en Acuicultura
-- ==============================================================================

-- 1. TABLA: CARRUSEL DE INICIO
CREATE TABLE IF NOT EXISTS public.carousel (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    subtitle TEXT,
    image_url TEXT NOT NULL,
    link_url TEXT DEFAULT '#',
    link_text TEXT DEFAULT 'Más información',
    order_num INTEGER DEFAULT 1,
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. TABLA: VIDEOS EDUCATIVOS
CREATE TABLE IF NOT EXISTS public.videos (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    youtube_url TEXT,
    video_id TEXT,
    custom_video_url TEXT,
    category TEXT DEFAULT 'Acuicultura',
    duration TEXT,
    date TEXT,
    featured BOOLEAN DEFAULT FALSE,
    is_demo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. TABLA: DIAPOSITIVAS Y MATERIAL ACADÉMICO
CREATE TABLE IF NOT EXISTS public.slides (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    author TEXT DEFAULT 'GEACUN UNAL',
    category TEXT DEFAULT 'Acuicultura',
    date TEXT,
    file_url TEXT NOT NULL,
    file_name TEXT,
    file_size TEXT,
    downloads_count INTEGER DEFAULT 0,
    is_demo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. TABLA: NOTICIAS Y PUBLICACIONES
CREATE TABLE IF NOT EXISTS public.news (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    summary TEXT,
    content TEXT NOT NULL,
    category TEXT DEFAULT 'General',
    author TEXT DEFAULT 'Comité Editorial GEACUN',
    image_url TEXT NOT NULL,
    date TEXT,
    external_links JSONB DEFAULT '[]'::jsonb,
    references_list JSONB DEFAULT '[]'::jsonb,
    featured BOOLEAN DEFAULT FALSE,
    is_demo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. TABLA: EVENTOS Y ACTIVIDADES DEL CALENDARIO
CREATE TABLE IF NOT EXISTS public.events (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    date TEXT NOT NULL,
    start_time TEXT DEFAULT '09:00',
    end_time TEXT DEFAULT '11:00',
    location TEXT DEFAULT 'Universidad Nacional de Colombia, Sede Bogotá',
    poster_url TEXT,
    organizer TEXT DEFAULT 'GEACUN UNAL',
    registration_url TEXT,
    category TEXT DEFAULT 'Académico',
    featured BOOLEAN DEFAULT FALSE,
    is_demo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 6. TABLA: INFORMACIÓN INSTITUCIONAL
CREATE TABLE IF NOT EXISTS public.institutional (
    id TEXT PRIMARY KEY DEFAULT 'main',
    history TEXT,
    mission TEXT,
    vision TEXT,
    objectives JSONB DEFAULT '[]'::jsonb,
    areas_of_interest JSONB DEFAULT '[]'::jsonb,
    academic_networks JSONB DEFAULT '[]'::jsonb,
    gallery JSONB DEFAULT '[]'::jsonb,
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 7. TABLA: CONFIGURACIÓN GENERAL DEL SITIO
CREATE TABLE IF NOT EXISTS public.site_settings (
    id TEXT PRIMARY KEY DEFAULT 'main',
    site_name TEXT DEFAULT 'GEACUN',
    full_name TEXT DEFAULT 'Grupo de Estudio en Acuicultura',
    institution TEXT DEFAULT 'Universidad Nacional de Colombia',
    tagline TEXT DEFAULT 'Ciencia, investigación y desarrollo en acuicultura y ecosistemas acuáticos',
    welcome_title TEXT DEFAULT 'Bienvenidos a GEACUN',
    welcome_text TEXT DEFAULT 'GEACUN es un espacio académico creado para estudiantes interesados en conocer, aprender y compartir experiencias alrededor de la acuicultura y el mundo de los organismos acuáticos.',
    contact_email TEXT DEFAULT 'geacun_bog@unal.edu.co',
    contact_phone TEXT DEFAULT '+57 (1) 3165000 Ext. 15300',
    address TEXT DEFAULT 'Facultad de Medicina Veterinaria y de Zootecnia - Ciudad Universitaria, Edificio 500. Bogotá D.C., Colombia',
    social_links JSONB DEFAULT '{"facebook": "", "instagram": "", "youtube": "", "twitter": ""}'::jsonb,
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==============================================================================
-- SEGURIDAD: ROW LEVEL SECURITY (RLS)
-- ==============================================================================

ALTER TABLE public.carousel ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.videos ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.slides ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.news ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.events ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.institutional ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.site_settings ENABLE ROW LEVEL SECURITY;

-- Políticas de lectura pública (cualquier visitante puede consultar la información)
DROP POLICY IF EXISTS "Public read carousel" ON public.carousel;
CREATE POLICY "Public read carousel" ON public.carousel FOR SELECT USING (true);

DROP POLICY IF EXISTS "Public read videos" ON public.videos;
CREATE POLICY "Public read videos" ON public.videos FOR SELECT USING (true);

DROP POLICY IF EXISTS "Public read slides" ON public.slides;
CREATE POLICY "Public read slides" ON public.slides FOR SELECT USING (true);

DROP POLICY IF EXISTS "Public read news" ON public.news;
CREATE POLICY "Public read news" ON public.news FOR SELECT USING (true);

DROP POLICY IF EXISTS "Public read events" ON public.events;
CREATE POLICY "Public read events" ON public.events FOR SELECT USING (true);

DROP POLICY IF EXISTS "Public read institutional" ON public.institutional;
CREATE POLICY "Public read institutional" ON public.institutional FOR SELECT USING (true);

DROP POLICY IF EXISTS "Public read site_settings" ON public.site_settings;
CREATE POLICY "Public read site_settings" ON public.site_settings FOR SELECT USING (true);

-- Políticas de administración (únicamente el usuario administrador autenticado puede crear/modificar/eliminar)
DROP POLICY IF EXISTS "Admin write carousel" ON public.carousel;
CREATE POLICY "Admin write carousel" ON public.carousel FOR ALL TO authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Admin write videos" ON public.videos;
CREATE POLICY "Admin write videos" ON public.videos FOR ALL TO authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Admin write slides" ON public.slides;
CREATE POLICY "Admin write slides" ON public.slides FOR ALL TO authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Admin write news" ON public.news;
CREATE POLICY "Admin write news" ON public.news FOR ALL TO authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Admin write events" ON public.events;
CREATE POLICY "Admin write events" ON public.events FOR ALL TO authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Admin write institutional" ON public.institutional;
CREATE POLICY "Admin write institutional" ON public.institutional FOR ALL TO authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Admin write site_settings" ON public.site_settings;
CREATE POLICY "Admin write site_settings" ON public.site_settings FOR ALL TO authenticated USING (true) WITH CHECK (true);

-- ==============================================================================
-- FUNCIÓN RPC: INCREMENTO DE DESCARGAS DE DIAPOSITIVAS
-- ==============================================================================
CREATE OR REPLACE FUNCTION public.increment_slide_download(slide_id TEXT)
RETURNS INTEGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  new_count INTEGER;
BEGIN
  UPDATE public.slides
  SET downloads_count = COALESCE(downloads_count, 0) + 1
  WHERE id = slide_id
  RETURNING downloads_count INTO new_count;
  RETURN new_count;
END;
$$;

-- Permitir ejecución anónima para registrar descargas de estudiantes
GRANT EXECUTE ON FUNCTION public.increment_slide_download(TEXT) TO anon, authenticated;

-- ==============================================================================
-- BUCKETS DE ALMACENAMIENTO (STORAGE)
-- ==============================================================================
INSERT INTO storage.buckets (id, name, public) 
VALUES ('geacun-images', 'geacun-images', true)
ON CONFLICT (id) DO NOTHING;

INSERT INTO storage.buckets (id, name, public) 
VALUES ('geacun-slides', 'geacun-slides', true)
ON CONFLICT (id) DO NOTHING;

-- Políticas de almacenamiento: lectura pública
DROP POLICY IF EXISTS "Public read geacun-images" ON storage.objects;
CREATE POLICY "Public read geacun-images" 
ON storage.objects FOR SELECT 
USING (bucket_id = 'geacun-images');

DROP POLICY IF EXISTS "Public read geacun-slides" ON storage.objects;
CREATE POLICY "Public read geacun-slides" 
ON storage.objects FOR SELECT 
USING (bucket_id = 'geacun-slides');

-- Políticas de almacenamiento: gestión administrativa
DROP POLICY IF EXISTS "Admin manage geacun-images" ON storage.objects;
CREATE POLICY "Admin manage geacun-images" 
ON storage.objects FOR ALL TO authenticated 
USING (bucket_id = 'geacun-images') 
WITH CHECK (bucket_id = 'geacun-images');

DROP POLICY IF EXISTS "Admin manage geacun-slides" ON storage.objects;
CREATE POLICY "Admin manage geacun-slides" 
ON storage.objects FOR ALL TO authenticated 
USING (bucket_id = 'geacun-slides') 
WITH CHECK (bucket_id = 'geacun-slides');

-- ==============================================================================
-- POBLACIÓN INICIAL DE DATOS (SEED DATA)
-- ==============================================================================

-- 1. Carrusel
INSERT INTO public.carousel (id, title, subtitle, image_url, link_url, link_text, order_num, active)
VALUES 
('car-1', 'Investigación y Desarrollo en Acuicultura Sostenible', 'Generamos conocimiento científico aplicado a la producción y conservación de organismos acuáticos en Colombia.', 'https://images.unsplash.com/photo-1544551763-46a013bb70d5?auto=format&fit=crop&w=1920&q=80', '#about', 'Conoce Nuestra Misión', 1, true),
('car-2', 'Fisiología, Sanidad y Nutrición de Organismos Acuáticos', 'Espacio de profundización y formación práctica para futuros profesionales e investigadores.', 'https://images.unsplash.com/photo-1522069169874-c58ec4b76be5?auto=format&fit=crop&w=1920&q=80', '#videos', 'Ver Biblioteca Audiovisual', 2, true),
('car-3', 'Sistemas de Recirculación y Nuevas Tecnologías', 'Innovación en el manejo del agua, calidad fisicoquímica y modelación de sistemas acuícolas.', 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=1920&q=80', '#slides', 'Consultar Diapositivas', 3, true)
ON CONFLICT (id) DO NOTHING;

-- 2. Videos
INSERT INTO public.videos (id, title, description, youtube_url, video_id, category, duration, date, featured, is_demo)
VALUES
('vid-1', 'Fundamentos de los Sistemas de Recirculación en Acuicultura (RAS)', 'Conferencia técnica sobre biofiltración, balance de oxígeno, remoción de sólidos y diseño hidráulico en producción intensiva.', 'https://www.youtube.com/watch?v=ScMzIvxBSi4', 'ScMzIvxBSi4', 'Sistemas de producción', '42 min', '2026-03-15', true, true),
('vid-2', 'Anatomía Interna y Fisiología Branquial en Teleósteos', 'Sesión práctica guiada sobre morfometría, estructura branquial y mecanismo contracorriente de intercambio gaseoso en peces de agua dulce.', 'https://www.youtube.com/watch?v=kY3j9sF21vE', 'kY3j9sF21vE', 'Anatomía de peces', '35 min', '2026-02-28', true, true),
('vid-3', 'Parámetros Fisicoquímicos y Monitoreo de Calidad de Agua', 'Medición in-situ de oxígeno disuelto, pH, temperatura, amonio no ionizado y alcalinidad en estanques y biofloc.', 'https://www.youtube.com/watch?v=EngW7tLk6R8', 'EngW7tLk6R8', 'Calidad del agua', '28 min', '2026-01-20', false, true),
('vid-4', 'Nutrición y Formulación de Dietas para Tilapia y Trucha', 'Requerimientos proteicos, energéticos y perfiles de aminoácidos esenciales en las distintas etapas de desarrollo.', 'https://www.youtube.com/watch?v=0kE238E6dLE', '0kE238E6dLE', 'Nutrición y alimentación', '50 min', '2025-11-12', false, true),
('vid-5', 'Sanidad Acuícola y Diagnóstico Parasitario en Laboratorio', 'Metodología de raspado de piel, aletas y branquias para identificación microscópica de protozoarios y monogeneos.', 'https://www.youtube.com/watch?v=lTRiuFIWV54', 'lTRiuFIWV54', 'Sanidad acuícola', '38 min', '2025-10-05', true, true),
('vid-6', 'Biotecnología Reproductiva y Criopreservación Seminal en Peces Nativos', 'Inducción hormonal con extracto de hipófisis de carpa y análogos de GnRH en especies de la cuenca del Magdalena y Orinoco.', 'https://www.youtube.com/watch?v=hTWKbfoikeg', 'hTWKbfoikeg', 'Reproducción', '45 min', '2025-09-18', false, true)
ON CONFLICT (id) DO NOTHING;

-- 3. Diapositivas
INSERT INTO public.slides (id, title, description, author, category, date, file_url, file_name, file_size, downloads_count, is_demo)
VALUES
('sli-1', 'Morfología y Fisiología Digestiva de Peces Teleósteos', 'Presentación magistral sobre adaptaciones morfofuncionales según los hábitos tróficos (carnívoros, omnívoros y herbívoros).', 'GEACUN - Área de Fisiología Animal', 'Fisiología', '2026-03-10', 'https://raw.githubusercontent.com/mozilla/pdf.js/ba2edeae/web/compressed.tracemonkey-pldi-09.pdf', 'fisiologia_digestiva_peces.pdf', '2.4 MB', 84, true),
('sli-2', 'Parámetros Críticos y Dinámica del Nitrógeno en Sistemas Acuícolas', 'Ciclo del nitrógeno, toxicidad del amoníaco libre (NH3), nitritos (NO2) y estrategias de bioremediación bacteriana.', 'Dra. Elena Vargas (Docente Invitada)', 'Calidad del agua', '2026-02-18', 'https://raw.githubusercontent.com/mozilla/pdf.js/ba2edeae/web/compressed.tracemonkey-pldi-09.pdf', 'calidad_agua_nitrogeno.pdf', '3.1 MB', 120, true),
('sli-3', 'Principales Patógenos Bacterianos y Micóticos en Piscicultura Continental', 'Identificación clínica de Aeromonas hydrophila, Flavobacterium columnare y Saprolegnia en cultivo de tilapia y cachama.', 'Semillero de Sanidad Acuícola GEACUN', 'Patología', '2026-01-25', 'https://raw.githubusercontent.com/mozilla/pdf.js/ba2edeae/web/compressed.tracemonkey-pldi-09.pdf', 'patologia_acuicola_bacterias.pdf', '4.8 MB', 95, true),
('sli-4', 'Diseño e Ingeniería de Sistemas de Recirculación Acuícola (SRA/RAS)', 'Dimensionamiento de sedimentadores, biofiltros de lecho móvil (MBBR), fraccionadores de espuma y reactores UV.', 'Ing. Carlos Mendoza & GEACUN', 'Sistemas de producción', '2025-11-30', 'https://raw.githubusercontent.com/mozilla/pdf.js/ba2edeae/web/compressed.tracemonkey-pldi-09.pdf', 'diseno_sistemas_ras.pdf', '5.2 MB', 160, true),
('sli-5', 'Ictiología Sistemática: Peces de las Cuencas Hidrográficas de Colombia', 'Clasificación taxonómica, caracteres diagnósticos y estado de conservación de la ictiofauna dulceacuícola neotropical.', 'Área de Ictiología y Biodiversidad', 'Ictiología', '2025-10-14', 'https://raw.githubusercontent.com/mozilla/pdf.js/ba2edeae/web/compressed.tracemonkey-pldi-09.pdf', 'ictiologia_colombia.pdf', '3.7 MB', 110, true)
ON CONFLICT (id) DO NOTHING;

-- 4. Noticias
INSERT INTO public.news (id, title, summary, content, category, author, image_url, date, external_links, references_list, featured, is_demo)
VALUES
('new-1', 'GEACUN abre convocatoria semestral para nuevos integrantes de la UNAL', 'Invitamos a estudiantes de Medicina Veterinaria, Zootecnia, Biología, Ingeniería Agronómica e interesados en la acuicultura a vincularse a las líneas de estudio.', 'El Grupo de Estudio en Acuicultura de la Universidad Nacional de Colombia (GEACUN) abre formalmente sus inscripciones para el nuevo ciclo académico.\n\nLos miembros activos participarán en:\n- Sesiones de discusión científica quincenales.\n- Talleres de análisis fisicoquímico y microbiológico de aguas.\n- Salidas de campo a granjas piscícolas en Cundinamarca, Huila y Meta.\n- Proyectos de investigación formativa y ponencias en congresos nacionales.\n\nRequisitos: Ser estudiante activo de pregrado o posgrado de la Universidad Nacional de Colombia con interés comprobado en las ciencias acuáticas.', 'Convocatorias', 'Comité de Coordinación GEACUN', 'https://images.unsplash.com/photo-1516684732162-798a0062be99?auto=format&fit=crop&w=1200&q=80', '2026-03-20', '[{"title": "Formulario de Postulación UNAL", "url": "https://unal.edu.co"}]'::jsonb, '["Estatuto Estudiantil y Reglamento de Grupos de Estudio UNAL Sede Bogotá."]'::jsonb, true, true),
('new-2', 'Avances en la investigación de probióticos autóctonos para dietas de tilapia', 'Resultados preliminares demuestran que el uso de bacterias ácido-lácticas mejora la conversión alimenticia y la respuesta inmune frente a patógenos.', 'Investigadores vinculados a los laboratorios de nutrición animal y acuicultura de la UNAL presentaron los resultados de la suplementación con cepas nativas de Bacillus y Lactobacillus.\n\nDurante el ensayo de 60 días se registró un incremento del 14% en la ganancia diaria de peso y una disminución significativa de la mortalidad por infecciones bacterianas oportunistas.', 'Investigación', 'Línea de Nutrición y Sanidad', 'https://images.unsplash.com/photo-1532094349884-543bc11b234d?auto=format&fit=crop&w=1200&q=80', '2026-02-15', '[{"title": "Artículo en Revista MVZ UNAL", "url": "https://revistas.unal.edu.co"}]'::jsonb, '["Rodríguez et al. (2025). Efecto de probióticos en juveniles de Oreochromis niloticus."]'::jsonb, true, true),
('new-3', 'Participación destacada de GEACUN en el Congreso Latinoamericano de Acuicultura', 'Integrantes del grupo expusieron tres trabajos de investigación sobre calidad de agua y reproducción inducida de peces nativos colombianos.', 'Una delegación de 6 estudiantes representantes de GEACUN asistió al evento internacional, presentando ponencias orales y en modalidad póster.\n\nLos trabajos abordaron temáticas cruciales para la biodiversidad colombiana, entre ellas la estandarización de protocolos de reproducción artificial en Yamú (Brycon amazonicus).', 'Eventos y Congresos', 'Delegación Académica', 'https://images.unsplash.com/photo-1540575467063-178a50c2df87?auto=format&fit=crop&w=1200&q=80', '2026-01-18', '[{"title": "Memorias del Congreso", "url": "https://alaqua.org"}]'::jsonb, '["Actas del XIV Congreso de Acuicultura de las Américas, 2026."]'::jsonb, false, true)
ON CONFLICT (id) DO NOTHING;

-- 5. Eventos
INSERT INTO public.events (id, title, description, date, start_time, end_time, location, poster_url, organizer, registration_url, category, featured, is_demo)
VALUES
('eve-1', 'Seminario: Avances en Sistemas de Recirculación Acuícola (RAS)', 'Jornada intensiva teórico-práctica sobre cálculo de biofiltros, recirculación de flujo y manejo ambiental en piscicultura intensiva.', '2026-11-15', '09:00', '13:00', 'Auditorio Edificio 500, Facultad de Medicina Veterinaria y de Zootecnia, UNAL Bogotá', 'https://images.unsplash.com/photo-1584727638096-042c45049ebe?auto=format&fit=crop&w=800&q=80', 'GEACUN & Dpto. de Producción Animal', 'https://unal.edu.co', 'Seminario', true, true),
('eve-2', 'Taller Práctico: Toma de Muestras y Análisis de Calidad de Agua', 'Práctica de campo y laboratorio para medición con multiparámetro, kits colorimétricos y titulación de alcalinidad y dureza.', '2026-11-22', '14:00', '18:00', 'Laboratorio de Limnología y Acuicultura - UNAL', 'https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=800&q=80', 'Semillero de Calidad de Agua GEACUN', 'https://unal.edu.co', 'Taller', true, true),
('eve-3', 'Jornada de Morfometría y Disección Anatómica de Teleósteos', 'Actividad práctica para estudiantes de primeros semestres enfocada en el reconocimiento macroscópico de órganos internos, aparato digestivo y branquias.', '2026-12-05', '08:00', '12:00', 'Sala de Disección de Anatomía Animal - UNAL', 'https://images.unsplash.com/photo-1530595467537-0b5996c41f2d?auto=format&fit=crop&w=800&q=80', 'Área de Anatomía e Ictiología', '', 'Práctica', false, true),
('eve-4', 'Reunión General de Planeación de Actividades y Proyectos', 'Sesión ordinaria con todos los integrantes para coordinar los proyectos de investigación formativa y el cronograma del semestre.', '2026-11-08', '16:00', '18:00', 'Aula 204, Edificio de Zootecnia UNAL (y transmisión Meet)', 'https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?auto=format&fit=crop&w=800&q=80', 'Coordinación General GEACUN', '', 'Reunión', false, true)
ON CONFLICT (id) DO NOTHING;

-- 6. Institucional
INSERT INTO public.institutional (id, history, mission, vision, objectives, areas_of_interest, academic_networks, gallery)
VALUES (
    'main',
    'El Grupo de Estudio en Acuicultura de la Universidad Nacional de Colombia (GEACUN) nació por iniciativa de estudiantes y docentes de la Facultad de Medicina Veterinaria y de Zootecnia apasionados por la ciencia acuícola, la ictiología y la biotecnología acuática. A lo largo de los años se ha consolidado como un semillero interdisciplinario que congrega a futuros médicos veterinarios, zootecnistas, biólogos e ingenieros, promoviendo el aprendizaje autónomo, la investigación aplicada y la vinculación con el sector productivo nacional.',
    'Fomentar el estudio, la investigación formativa, la actualización técnica y la divulgación científica en el área de la acuicultura y el aprovechamiento responsable de los recursos hidrobiológicos, fortaleciendo las capacidades académicas y prácticas de los estudiantes de la Universidad Nacional de Colombia en beneficio del desarrollo sostenible del país.',
    'Para el 2030, ser reconocidos como el grupo de estudio estudiantil de referencia nacional e internacional en acuicultura y ciencias de organismos acuáticos, destacado por su rigurosidad científica, innovación técnica, liderazgo investigativo y contribución al bienestar de los ecosistemas acuáticos.',
    '[
        "Propiciar espacios de discusión científica periódica sobre avances biológicos, tecnológicos y sanitarios en acuicultura continental y marina.",
        "Impulsar proyectos de investigación formativa guiados por docentes e investigadores de la Universidad Nacional de Colombia.",
        "Capacitar a los integrantes mediante talleres prácticos de laboratorio en sanidad, calidad del agua, nutrición y reproducción.",
        "Divulgar el conocimiento científico a la comunidad académica y al sector productivo a través de conferencias, seminarios y publicaciones.",
        "Generar alianzas con centros de investigación, granjas piscícolas y redes académicas afines a nivel nacional e internacional."
    ]'::jsonb,
    '[
        {"id": "area-1", "name": "Sistemas de Producción y Tecnología", "description": "Sistemas de Recirculación (RAS), Biofloc, acuaponía y optimización hidráulica de estanques.", "icon": "Layers"},
        {"id": "area-2", "name": "Sanidad y Patología Acuícola", "description": "Diagnóstico parasitológico, microbiológico e inmunología preventiva en organismos cultivados.", "icon": "ShieldCheck"},
        {"id": "area-3", "name": "Nutrición y Fisiología Digestiva", "description": "Formulación de piensos balanceados, digestibilidad, aditivos funcionales y probióticos nativos.", "icon": "Dna"},
        {"id": "area-4", "name": "Calidad de Agua y Bioremediación", "description": "Monitoreo fisicoquímico continuo, balance iónico, microalgas y tratamiento de efluentes.", "icon": "Droplets"},
        {"id": "area-5", "name": "Biotecnología Reproductiva", "description": "Manejo de reproductores, inducción hormonal, incubación y larvicultura de especies nativas.", "icon": "HeartHandshake"},
        {"id": "area-6", "name": "Ictiología y Conservación", "description": "Ecología trófica, biodiversidad hidrobiológica y conservación de especies dulceacuícolas amenazadas.", "icon": "Fish"}
    ]'::jsonb,
    '[
        {"id": "net-1", "name": "Universidad Nacional de Colombia", "description": "Facultad de Medicina Veterinaria y de Zootecnia (Sede Bogotá).", "url": "https://unal.edu.co"},
        {"id": "net-2", "name": "Red Colombiana de Acuicultura (RCA)", "description": "Articulación entre academia, industria e instituciones de fomento del sector piscícola.", "url": "https://minagricultura.gov.co"},
        {"id": "net-3", "name": "Asociación Latinoamericana de Acuicultura (ALAqua)", "description": "Comunidad científica de fomento y cooperación técnica en el continente.", "url": "https://alaqua.org"},
        {"id": "net-4", "name": "Red de Semilleros de Investigación UNAL (RedSIUN)", "description": "Espacio institucional de fomento a la investigación formativa universitaria.", "url": "https://investigacion.unal.edu.co"}
    ]'::jsonb,
    '[
        {"id": "gal-1", "title": "Monitoreo de biomasa en estanques experimentales", "imageUrl": "https://images.unsplash.com/photo-1544551763-46a013bb70d5?auto=format&fit=crop&w=1000&q=80", "category": "Campo"},
        {"id": "gal-2", "title": "Sesión de microscopía y parasitología de branquias", "imageUrl": "https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=1000&q=80", "category": "Laboratorio"},
        {"id": "gal-3", "title": "Práctica de inducción hormonal y desove artificial", "imageUrl": "https://images.unsplash.com/photo-1522069169874-c58ec4b76be5?auto=format&fit=crop&w=1000&q=80", "category": "Reproducción"},
        {"id": "gal-4", "title": "Medición de oxígeno y pH con sonda multiparámetro", "imageUrl": "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=1000&q=80", "category": "Calidad de Agua"},
        {"id": "gal-5", "title": "Seminario académico y presentación de ponencias", "imageUrl": "https://images.unsplash.com/photo-1540575467063-178a50c2df87?auto=format&fit=crop&w=1000&q=80", "category": "Académico"},
        {"id": "gal-6", "title": "Evaluación morfométrica y nutricional de alevinos", "imageUrl": "https://images.unsplash.com/photo-1516684732162-798a0062be99?auto=format&fit=crop&w=1000&q=80", "category": "Investigación"}
    ]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET updated_at = NOW();

-- 7. Configuración General
INSERT INTO public.site_settings (id, site_name, full_name, institution, tagline, welcome_title, welcome_text, contact_email, contact_phone, address, social_links)
VALUES (
    'main',
    'GEACUN',
    'Grupo de Estudio en Acuicultura',
    'Universidad Nacional de Colombia',
    'Ciencia, investigación y desarrollo en acuicultura y ecosistemas acuáticos',
    'Bienvenidos a GEACUN',
    'GEACUN es un espacio académico creado para estudiantes interesados en conocer, aprender y compartir experiencias alrededor de la acuicultura y el mundo de los organismos acuáticos.',
    'geacun_bog@unal.edu.co',
    '+57 (1) 3165000 Ext. 15300',
    'Facultad de Medicina Veterinaria y de Zootecnia - Ciudad Universitaria, Edificio 500. Bogotá D.C., Colombia',
    '{"facebook": "https://facebook.com/geacun.unal", "instagram": "https://instagram.com/geacun_unal", "youtube": "https://youtube.com", "twitter": "https://x.com/geacun_unal"}'::jsonb
)
ON CONFLICT (id) DO UPDATE SET updated_at = NOW();
