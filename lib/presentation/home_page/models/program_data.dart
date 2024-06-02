class Program {
  final String title;
  final String description;
  final List<String> photos;

  Program({
    required this.title,
    required this.description,
    required this.photos,
  });
}

List<Program> mockProgramData = [
  Program(
    title: 'Terapi wicara',
    description: 'Program terapi wicara untuk meningkatkan kemampuan bicara anak.',
    photos: ['https://example.com/photo1.jpg', 'https://example.com/photo2.jpg'],
  ),
  Program(
    title: 'Pijat stimulasi',
    description: 'Program pijat stimulasi untuk merangsang perkembangan motorik anak.',
    photos: ['https://example.com/photo3.jpg', 'https://example.com/photo4.jpg'],
  ),
  Program(
    title: 'English Special Club',
    description: 'Club khusus untuk belajar bahasa Inggris dengan cara menyenangkan.',
    photos: ['https://example.com/photo5.jpg', 'https://example.com/photo6.jpg'],
  ),
  Program(
    title: 'Outing Class',
    description: 'Kelas luar ruangan untuk pembelajaran langsung di alam.',
    photos: ['https://example.com/photo7.jpg', 'https://example.com/photo8.jpg'],
  ),
  Program(
    title: 'Catering Sehat',
    description: 'Program catering sehat untuk anak-anak.',
    photos: ['https://example.com/photo9.jpg', 'https://example.com/photo10.jpg'],
  ),
];
