import 'package:myportofolio_mobile/models/portfolio_content.dart';

/// Profil bersumber dari `main/views.py` dan `templates/index.html` website.
const portfolioDetails = PortfolioDetails(
  displayName: 'Noe Andrew',
  bio:
      'Information Systems at Universitas Indonesia student passionate about '
      'software engineering and fintech. Been fortunate enough to win several '
      "hackathons and innovation competitions, but I'm equally proud of my wins "
      'on the dance floor. Collaborative problem-solver who thrives working '
      'with teams on technical challenges.',
  studyProgram: 'S1 Sistem Informasi',
  university: 'Universitas Indonesia',
  email: 'noeandrewjms@gmail.com',
  githubUrl: 'https://github.com/noeandrew-jm',
  linkedinUrl: 'https://www.linkedin.com/in/noeandrew',
  roles: [
    'a Full Stack Developer',
    'Well - known Performer',
    'An Experienced MC',
    'Leader',
  ],
);

/// Salinan konten publik tabel `main_project` dalam arsip website.
///
/// Arsip berisi satu proyek. Gambar memakai aset Lanjut.id yang juga digunakan
/// pada pengalaman terkait di website.
const List<PortfolioEntry> portfolioProjects = [
  PortfolioEntry(
    title: 'Lanjut.id',
    subtitle: 'Python · JavaScript',
    description:
        'Platform B2B otonom untuk menjaga pelanggan bisnis berlangganan dan '
        'memantau kesehatan operasional usaha bagi BNI.',
    imageAsset: 'assets/images/Lanjut.id.png',
    linkUrl: 'https://Lanjut.id',
    tags: ['Python', 'JavaScript'],
  ),
];

/// Salinan tabel `main_experience`, termasuk kategori dan periode tampilnya.
/// Periode mengikuti `started_at` dan `ended_at` yang digunakan template web.
const List<PortfolioEntry> portfolioExperiences = [
  PortfolioEntry(
    title: 'IT DEV - DDP 0',
    subtitle: 'Part-Time',
    description:
        'Built frontend and authentication system for DDP-0, a bootcamp '
        'platform serving 1,000+ students learning fundamental programming '
        'at Universitas Indonesia. Implemented responsive UI for registration '
        'and course management, integrated Google OAuth for secure access, '
        'and optimized application for high-volume concurrent users.',
    imageAsset: 'assets/images/ddp0.jpg',
    period: 'Ongoing since September 2026',
  ),
  PortfolioEntry(
    title: 'Hackathon 2026 Winner - FocusBuddy',
    subtitle: 'Freelance',
    description:
        'As software engineer, built complete stack (frontend, backend, '
        'Google Auth) and designed AI/ML pipeline for task decomposition, '
        'duration prediction, and personalized recommendations. Delivered '
        'production-ready solution in six days.',
    imageAsset: 'assets/images/focusbud.jpg',
    period: 'Ongoing since September 2026',
  ),
  PortfolioEntry(
    title: 'Frontend, UI/UX, and Designer for Lanjut.id',
    subtitle: 'Freelance',
    description:
        'Designed and built the frontend, UI/UX, and pitch deck for LANJUT.ID, '
        'an AI Agent that converts merchant transaction data into relevant '
        'renewal offers. Crafted the merchant and BNI dashboard experience, '
        'translated the four-stage AI pipeline (Sense, Decide, Act, Learn) '
        'into an intuitive interface, and delivered the pitch narrative that '
        'positioned LANJUT.ID within the BNI ecosystem.',
    imageAsset: 'assets/images/Lanjut.id.png',
    period: 'Ongoing since September 2026',
  ),
];

/// Salinan tabel `main_achievement` sesuai urutan tampil pada website.
const List<PortfolioEntry> portfolioAchievements = [
  PortfolioEntry(
    title: 'RISTEK Hackathon 2026 Winner - FocusBuddy & Best Exhibition',
    subtitle: 'Winner & Best Exhibition',
    description:
        'Won RISTEK Hackathon 2026 with FocusBuddy, an AI-powered productivity '
        'platform. As software engineer, built complete stack (frontend, '
        'backend, Google Auth) and designed AI/ML pipeline for task '
        'decomposition, duration prediction, and personalized recommendations. '
        'Delivered production-ready solution in six days.',
    imageAsset: 'assets/images/RISTEK HACKATHON.jpeg',
  ),
  PortfolioEntry(
    title: 'PKM - GFT Universitas Indonesia',
    subtitle: 'Third Place Winner',
    description:
        'Won third place for IoT-enabled algae cultivation system addressing '
        'indoor oxygen deficiency. Designed integrated solution combining '
        'natural oxygen generation through algae with smart sensor network '
        'for automated oxygen distribution across building zones. Focused on '
        'sustainable, cost-effective air quality management for '
        'under-resourced environments.',
    imageAsset: 'assets/images/PKM.jpeg',
  ),
];
