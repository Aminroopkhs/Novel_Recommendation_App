"""
BERT-based recommender.

Exports:
    generate_novel_embeddings(novels) -> np.ndarray  shape (N, hidden)
    generate_user_embedding(user_genres) -> np.ndarray  shape (hidden,)
    recommend_novels(novels, novel_embeddings, user_embedding, top_k) -> list[Novel]
"""

import numpy as np
from recommender.models.bert_model import BERTEmbedder
from recommender.preprocess import split_novel_text

# ── lazy singleton so the model loads only once per process ──────────────────
_embedder: BERTEmbedder | None = None


def _get_embedder() -> BERTEmbedder:
    global _embedder
    if _embedder is None:
        _embedder = BERTEmbedder()
    return _embedder


# ─────────────────────────────────────────────────────────────────────────────
# PUBLIC API
# ─────────────────────────────────────────────────────────────────────────────

def generate_novel_embeddings(novels) -> np.ndarray:
    """
    Build one embedding per novel by concatenating
    genre + tropes + synopsis into a single text string.

    Returns shape (len(novels), hidden_size).
    """
    embedder = _get_embedder()
    texts = []
    for novel in novels:
        parts = split_novel_text(novel)
        text = f"{parts['genre']} {parts['tropes']} {parts['synopsis']}"
        texts.append(text.strip() or novel.title or "unknown")

    return embedder.embed(texts)  # (N, hidden)


def generate_user_embedding(user_genres: list[str]) -> np.ndarray:
    """
    Build a single user embedding from a list of preferred genres.

    Returns shape (hidden_size,).
    """
    embedder = _get_embedder()
    text = " ".join(user_genres)
    return embedder.embed([text])[0]  # (hidden,)


def _cosine_similarity(a: np.ndarray, b: np.ndarray) -> float:
    norm_a = np.linalg.norm(a)
    norm_b = np.linalg.norm(b)
    if norm_a == 0.0 or norm_b == 0.0:
        return 0.0
    return float(np.dot(a, b) / (norm_a * norm_b))


def recommend_novels(
    novels,
    novel_embeddings: np.ndarray,
    user_embedding: np.ndarray,
    top_k: int = 5,
) -> list:
    """
    Rank novels by cosine similarity to the user embedding.

    Returns up to *top_k* Novel ORM objects, highest similarity first.
    The caller (FastAPI endpoint) serialises them automatically.
    """
    scores = [
        _cosine_similarity(user_embedding, novel_embeddings[i])
        for i in range(len(novels))
    ]

    sorted_indices = sorted(
        range(len(scores)), key=lambda i: scores[i], reverse=True
    )

    return [novels[i] for i in sorted_indices[:top_k]]
