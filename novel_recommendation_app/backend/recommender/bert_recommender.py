from sentence_transformers import SentenceTransformer
from sklearn.metrics.pairwise import cosine_similarity
import numpy as np

# Load model once (IMPORTANT)
model = SentenceTransformer("all-MiniLM-L6-v2")


def build_novel_text(novel):
    """
    Combine novel fields into one text block
    """
    return f"""
    Genre: {novel.genre}
    Tropes: {novel.tropes}
    Synopsis: {novel.synopsis}
    """


def generate_novel_embeddings(novels):
    """
    novels: list of Novel ORM objects
    returns: numpy array of embeddings
    """
    texts = [build_novel_text(n) for n in novels]
    embeddings = model.encode(texts, convert_to_numpy=True)
    return embeddings


def generate_user_embedding(user_genres):
    """
    user_genres: list[str]
    """
    if not user_genres:
        return None

    text = " ".join(user_genres)
    return model.encode([text], convert_to_numpy=True)[0]


def recommend_novels(
    novels,
    novel_embeddings,
    user_embedding,
    top_k=5
):
    """
    Returns top_k novels based on cosine similarity
    """
    if user_embedding is None:
        return []

    scores = cosine_similarity(
        [user_embedding],
        novel_embeddings
    )[0]

    top_indices = np.argsort(scores)[::-1][:top_k]

    return [
        {
            "novel_id": novels[i].id,
            "title": novels[i].title,
            "author": novels[i].author,
            "genre": novels[i].genre,
            "score": float(scores[i]),
        }
        for i in top_indices
    ]
