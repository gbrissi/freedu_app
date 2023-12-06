import prisma from "./config/prismaClient";

const tags: string[] = [
  ...new Set([
    "Artes",
    "Educação Física",
    "Filosofia",
    "Sociologia",
    "Ensino Religioso",
    "Inglés",
    "Espanhol",
    "Física",
    "Química",
    "Biologia",
    "Geografia",
    "História",
    "Matemática",
    "Lingua Portuguesa",
  ]),
];

async function _seedDatabase() {
  tags.forEach((tag: string) => {
    prisma.tag
      .upsert({
        where: { name: tag },
        update: { name: tag },
        create: { name: tag },
      }).then((value) => console.info("Tag created: ", value))
      .catch((err) => console.error(err));
  });
}

_seedDatabase();
