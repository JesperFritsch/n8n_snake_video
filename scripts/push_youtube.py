import argparse
import os

from googleapiclient.discovery import build
from googleapiclient.http import MediaFileUpload
from google.oauth2.credentials import Credentials

credentials = Credentials(
    token=None,
    refresh_token=os.getenv('YT_REFRESH_TOKEN'),
    client_id=os.getenv('YT_CLIENT_ID'),
    client_secret=os.getenv('YT_CLIENT_SECRET'),
    token_uri='https://oauth2.googleapis.com/token'
)
def push_to_youtube(video_path, title, description):
    youtube = build('youtube', 'v3', credentials=credentials)

    request = youtube.videos().insert(
        part='snippet,status',
        body={
            'snippet': {
                'title': title,
                'description': description,
                'categoryId': '22'
            },
            'status': {
                'privacyStatus': 'public'
            }
        },
        media_body=MediaFileUpload(video_path, mimetype='video/mp4', resumable=True)
    )

    request.execute()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Upload a video to YouTube.')
    parser.add_argument('video_path', help='Path to the video file')
    parser.add_argument('title', help='Title of the YouTube video')
    parser.add_argument('description', help='Description of the YouTube video')

    args = parser.parse_args()
    push_to_youtube(args.video_path, args.title, args.description)