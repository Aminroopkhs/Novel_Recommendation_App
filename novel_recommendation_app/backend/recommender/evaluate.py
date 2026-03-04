import numpy as np
import time
from sklearn.metrics.pairwise import cosine_similarity
from database import SessionLocal
from models import Novel
from recommender.embedder import get_embedder

TEST_QUERIES = [
    {
        "query": "slow burn marriage of convenience historical romance strong female lead",
        "relevant_ids": [1, 2]  # manually adjust based on your DB
    },
    {
        "query": "enemies to lovers contemporary witty banter",
        "relevant_ids": [3, 4]
    }
]

def evaluate(model_name):

    print(f"\n🔍 Evaluating model: {model_name}")

    db = SessionLocal()
    novels = db.query(Novel).all()

    embeddings = np.load(f"embeddings/novel_embeddings_{model_name}.npy")

    embedder = get_embedder(model_name)

    precision_scores = []
    query_times = []

    for test in TEST_QUERIES:

        start = time.time()

        query_vec = embedder.embed([test["query"]])[0]
        sims = cosine_similarity([query_vec], embeddings)[0]
        top_k = sims.argsort()[::-1][:5]

        end = time.time()
        query_times.append(end - start)

        precision = len(set(top_k) & set(test["relevant_ids"])) / 5
        precision_scores.append(precision)

    print(f"🎯 Precision@5: {sum(precision_scores)/len(precision_scores):.2f}")
    print(f"⚡ Avg Query Time: {sum(query_times)/len(query_times):.4f} seconds")
