import numpy as np
from sklearn.metrics.pairwise import cosine_similarity

from database import SessionLocal
from models import Novel
from recommender.embedder import get_embedder
from recommender.preprocess import split_novel_text


WEIGHTS = {
    "tropes": 0.5,
    "genre": 0.3,
    "synopsis": 0.2
}

# load embeddings
embeddings = np.load("embeddings/novel_embeddings_e5.npy")

# database
db = SessionLocal()
novels = db.query(Novel).all()

# model
embedder = get_embedder("e5")


def get_recommendations(genre, tropes, synopsis, top_k=5):

    # create embeddings for each feature
    trope_vec = embedder.embed([tropes])[0]
    genre_vec = embedder.embed([genre])[0]
    synopsis_vec = embedder.embed([synopsis])[0]

    # weighted embedding
    query_vec = (
        WEIGHTS["tropes"] * trope_vec
        + WEIGHTS["genre"] * genre_vec
        + WEIGHTS["synopsis"] * synopsis_vec
    )

    # similarity
    sims = cosine_similarity([query_vec], embeddings)[0]

    # top results
    top_indices = sims.argsort()[::-1][:top_k]

    results = []

    for idx in top_indices:
        novel = novels[idx]

        results.append({
            "title": novel.title,
            "genre": novel.genre,
            "tropes": novel.tropes,
            "synopsis": novel.synopsis,
            "image_url": novel.image_url
        })

    return results


# ----------- TEST ------------

if __name__ == "__main__":

    results = get_recommendations(
        genre= "romance",
        tropes ="brother's bestfriend",
        synopsis= "fall in love"
    )

    for r in results:
        print(r)