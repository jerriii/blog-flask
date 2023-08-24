import json
import uuid
import os
import math
import spacy
from datetime import datetime

from flask import Flask, render_template, url_for, request, session, redirect, jsonify, flash, make_response
from flask_wtf.csrf import CSRFProtect
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import func,or_,and_
from sqlalchemy_serializer import SerializerMixin
from werkzeug.utils import secure_filename
from werkzeug.security import check_password_hash, generate_password_hash
from profanity_filter import ProfanityFilter

with open('config.json', 'r') as c:
    parameters = json.load(c)["parameters"]

app = Flask(__name__)
csrf = CSRFProtect(app)
app.secret_key = 'secret-key'
app.config['UPLOAD_FOLDER'] = parameters['upload_location']
app.config['SQLALCHEMY_DATABASE_URI'] = parameters['local_uri']
db = SQLAlchemy(app)


def render_my_template(*args, **kwargs):
    return render_template(*args, **kwargs, parameters=parameters)


class Users(db.Model, SerializerMixin):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    phone = db.Column(db.String(20), nullable=False)
    password = db.Column(db.String(255), nullable=False)


class UserPosts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    tagline = db.Column(db.String(200), nullable=False)
    slug = db.Column(db.String(100), nullable=False)
    content = db.Column(db.Text, nullable=False)
    content_type = db.Column(db.String(50), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    img_file = db.Column(db.String(255), nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    user = db.relationship('Users', backref=db.backref('user_posts', lazy=True))


class Posts(db.Model, SerializerMixin):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    slug = db.Column(db.String(100), nullable=False, unique=True)
    content = db.Column(db.Text, nullable=False)
    content_type = db.Column(db.String(50), nullable=False)
    tagline = db.Column(db.String(100), nullable=False)
    date = db.Column(db.DateTime, nullable=True)
    img_file = db.Column(db.String(100), nullable=True)
    overall_rating = db.Column(db.Float, default=0.0)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    user = db.relationship('Users', backref=db.backref('posts', lazy=True))


class Ratings(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    post_id = db.Column(db.Integer, db.ForeignKey('user_posts.sno'), nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    user = db.relationship('Users', backref=db.backref('ratings', lazy=True))
    rating = db.Column(db.Integer, nullable=False)
    comment = db.Column(db.Text)


content_type_options = [
    {"value": "educational", "label": "Educational"},
    {"value": "entertainment", "label": "Entertainment"},
    {"value": "sports", "label": "Sports"},
]


def is_user_logged_in():
    return 'user_id' in session


def get_current_user():
    user_id = session.get('user_id')
    if user_id:
        return Users.query.get(user_id)
    return None


@app.context_processor
def inject_user():
    current_user = get_current_user()
    return dict(current_user=current_user)


@app.route("/")
def home():
    posts = Posts.query.all()

    for post in posts:
        ratings = Ratings.query.filter_by(post_id=post.sno).all()
        if ratings:
            total_ratings = sum(rating.rating for rating in ratings)
            overall_rating = total_ratings / len(ratings)
            post.overall_rating = overall_rating
            post_obj = Posts.query.get(post.sno)
            if post_obj:
                post_obj.overall_rating = overall_rating
                db.session.commit()

    posts = sorted(posts, key=lambda post: post.date, reverse=True)
    last = math.ceil(len(posts) / int(parameters['no_of_posts']))
    page = request.args.get('page')
    if not str(page).isnumeric():
        page = 1
    page = int(page)
    posts = posts[(page - 1) * int(parameters['no_of_posts']): (page - 1) * int(parameters['no_of_posts']) + int(
        parameters['no_of_posts'])]

    # Fetch usernames from user_ids
    usernames = {}
    for post in posts:
        user = Users.query.get(post.user_id)
        if user:
            usernames[post.user_id] = user.username
        else:
            usernames[post.user_id] = "Unknown"  # Default username if user is not found

    if page == 1:
        prev = "#"
        nxt = "/?page=" + str(page + 1)
    elif page == last:
        prev = "/?page=" + str(page - 1)
        nxt = "#"
    else:
        prev = "/?page=" + str(page - 1)
        nxt = "/?page=" + str(page + 1)

    home_bg_url = url_for('static', filename='assets/img/home-bg.jpg')
    return render_my_template('index.html', home_bg_url=home_bg_url, posts=posts, prev=prev, next=nxt,
                              usernames=usernames)


def set_user_in_session(user_id=None, user=None, logout=False):
    if logout:
        session.pop('user', None)
        session.pop('user_id', None)
    elif user_id is not None:
        session['user_id'] = user_id
        session.pop('user', None)
    elif user is not None:
        session['user'] = user
        session.pop('user_id', None)


@app.route('/user_login', methods=['GET', 'POST'])
def user_login():
    if is_user_logged_in():
        return redirect(url_for('user_post'))

    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']

        user = Users.query.filter_by(email=email).first()
        if user and check_password_hash(user.password, password):
            set_user_in_session(user_id=user.id)
            session.pop('user', None)

            flash('Login successful.', 'success')
            return redirect(url_for('home'))
        else:
            flash('Invalid credentials. Please try again.', 'error')

    validation_js = url_for('static', filename='js/validation.js')
    sign_in = url_for('static', filename='css/sign-in.css')
    return render_my_template('user_login.html', sign_in=sign_in, validation_js=validation_js)


@app.route('/user_register', methods=['GET', 'POST'])
def user_register():
    if is_user_logged_in():
        return redirect(url_for('user_post'))

    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        email = request.form['email']
        phone = request.form['phone']

        hashed_password = generate_password_hash(password)
        new_user = Users(username=username, password=hashed_password, email=email, phone=phone)
        db.session.add(new_user)
        db.session.commit()

        flash('Registration successful. Please login.', 'success')
        return redirect(url_for('user_login'))

    validation_js = url_for('static', filename='js/validation.js')
    sign_in = url_for('static', filename='css/sign-in.css')
    return render_my_template('user_register.html', sign_in=sign_in, validation_js=validation_js)


def set_profane_extension(token):
    profane_words = ["shit", "fuck", "bitch"]
    return token.text.lower() in profane_words


def save_image_file(img_file):
    MAX_FILE_SIZE_BYTES = 5 * 1024 * 1024
    if img_file and allowed_file(img_file.filename):
        original_filename = secure_filename(img_file.filename)
        ext = os.path.splitext(original_filename)[1].lower()
        filename = str(uuid.uuid4()) + ext
        img_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)

        img_file.save(img_path)

        if 0 < os.path.getsize(img_path) <= MAX_FILE_SIZE_BYTES:
            return filename
        else:
            os.remove(img_path)
            return None
    else:
        return None


def allowed_file(filename):
    ALLOWED_EXTENSIONS = {'jpg', 'jpeg', 'png'}
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


@app.route('/user_post', methods=['GET', 'POST'])
def user_post():
    if not is_user_logged_in():
        return redirect(url_for('user_login'))

    if request.method == 'POST':
        title = request.form['title']
        tagline = request.form['tagline']
        slug = request.form['slug']
        content = request.form['content']
        content_type = request.form['content_type']
        date = datetime.now()
        img_file = request.files['img_file']

        errors = {}

        if not title:
            errors['title'] = 'A title is required.'
        if not tagline:
            errors['tagline'] = 'A tagline is required.'
        if not slug:
            errors['slug'] = 'Slug is required.'
        if not content:
            errors['content'] = 'Content is required.'
        if not content_type:
            errors['content_type'] = 'Content Type is required.'
        if not img_file:
            errors['img_file'] = 'Image File is required.'
        elif not allowed_file(img_file.filename):
            errors['img_file'] = 'Invalid file type. Only .jpg, .jpeg, and .png images are supported.'

        if errors:
            for key, value in errors.items():
                flash(value, 'error')
            # Store the form data in the session to be used in the next request
            session['post_form_data'] = request.form
            return redirect(url_for('user_post'))

        # Check if the image file was successfully saved
        filename = save_image_file(img_file)
        if not filename:
            flash('Error saving the image file. Please try again.', 'error')
            session['post_form_data'] = request.form
            return redirect(url_for('user_post'))

        user_id = session.get('user_id')

        nlp = spacy.load('en_core_web_sm')
        pf = ProfanityFilter(nlps={'en': nlp})

        spacy.tokens.Token.set_extension('is_profane', getter=set_profane_extension, force=True)

        if pf.is_profane(title) or pf.is_profane(tagline) or pf.is_profane(slug) or pf.is_profane(content):
            new_post = UserPosts(title=title, tagline=tagline, slug=slug, content=content, content_type=content_type,
                                 date=date, img_file=filename,
                                 user_id=user_id)
            db.session.add(new_post)
            db.session.commit()

            flash('Post contains inappropriate content. It will be reviewed before publishing.', 'warning')
        else:
            new_post = Posts(title=title, tagline=tagline, slug=slug, content=content, content_type=content_type,
                             date=date,
                             img_file=filename, user_id=user_id)
            db.session.add(new_post)
            db.session.commit()
            flash('Post submitted successfully.', 'success')
            session.pop('post_form_data', None)

        return redirect(url_for('user_post'))

    about_bg_url = url_for('static', filename="assets/img/about-bg.jpg")
    return render_my_template('user_post.html', errors={}, about_bg_url=about_bg_url,
                              content_type_options=content_type_options)


@app.route("/post/<string:post_slug>", methods=['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    post_id = post.sno
    file_path = 'assets/img/' + post.img_file
    post_bg_url = url_for('static', filename=file_path)
    user_id = session.get('user_id')

    ratings = Ratings.query.filter_by(post_id=post_id).join(Users).all()

    # Recommendation Logic
    recommended_posts = Posts.query.filter(and_(
        Posts.content_type == post.content_type,
        Posts.overall_rating >= 3,
        Posts.slug != post_slug  # Exclude the current post
    )).order_by(Posts.overall_rating.desc(), Posts.date.desc()).all()

    recommended_posts += Posts.query.filter(and_(
        Posts.content_type == post.content_type,
        Posts.overall_rating == 0,
        Posts.slug != post_slug  # Exclude the current post
    )).order_by(Posts.date.desc()).all()

    recommended_posts += Posts.query.filter(and_(
        Posts.content_type == post.content_type,
        Posts.overall_rating >= 1,
        Posts.overall_rating < 3,
        Posts.slug != post_slug  # Exclude the current post
    )).order_by(Posts.overall_rating.desc(), Posts.date.desc()).all()

    # Get all distinct content types except the current post's content_type
    content_types = Posts.query.with_entities(Posts.content_type).distinct().filter(
        Posts.content_type != post.content_type  # Exclude the current content_type
    ).all()

    # 4. Recommend high-rated posts or latest posts for each distinct content_type
    for content_type in content_types:
        high_rated_other = Posts.query.filter(
            and_(
                Posts.content_type == content_type[0],
                Posts.overall_rating >= 4,
                Posts.slug != post_slug  # Exclude the current post
            )
        ).order_by(Posts.overall_rating.desc(), Posts.date.desc()).first()

        if high_rated_other:
            recommended_posts.append(high_rated_other)
        else:
            latest_unrated_other = Posts.query.filter(and_(
                Posts.content_type == content_type[0],
                Posts.overall_rating >= 1,
                Posts.overall_rating < 3,
                Posts.slug != post_slug  # Exclude the current post
            )).order_by(Posts.date.desc()).first()

            if latest_unrated_other:
                recommended_posts.append(latest_unrated_other)
            else:
                latest_zero_other = Posts.query.filter(and_(
                    Posts.content_type == content_type[0],
                    Posts.overall_rating == 0,
                    Posts.slug != post_slug  # Exclude the current post
                )).order_by(Posts.date.desc()).first()

                if latest_zero_other:
                    recommended_posts.append(latest_zero_other)

    items_per_page = 3
    page = request.args.get('page', 1, type=int)
    total_posts = len(recommended_posts)
    total_pages = (total_posts + items_per_page - 1) // items_per_page

    start_idx = (page - 1) * items_per_page
    end_idx = start_idx + items_per_page
    current_posts = recommended_posts[start_idx:end_idx]

    return render_my_template('post.html', post_bg_url=post_bg_url, post=post, post_id=post_id, user_id=user_id,
                              ratings=ratings, current_posts=current_posts, total_pages=total_pages, current_page=page)


@app.route("/submit_rating_comment", methods=["POST"])
def submit_rating_comment():
    if request.method == "POST":
        user_id = session.get("user_id")
        post_id = request.json.get("post_id")
        rating = request.json.get("rating")
        comment = request.json.get("comment")

        if user_id and post_id and rating:
            existing_rating = Ratings.query.filter_by(post_id=post_id, user_id=user_id).first()
            if existing_rating:
                existing_rating.rating = rating
                existing_rating.comment = comment
            else:
                new_rating = Ratings(post_id=post_id, user_id=user_id, rating=rating, comment=comment)
                db.session.add(new_rating)

            db.session.commit()

            response_data = {"success": True, "message": "Rating and comment submitted successfully."}
            return jsonify(response_data)
        else:
            flash("Invalid data.", "error")
            return {"message": "Invalid data."}, 400


@app.route('/check_slug')
def check_slug():
    entered_slug = request.args.get('slug')

    # Check if the entered slug already exists in the database
    existing_post = UserPosts.query.filter_by(slug=entered_slug).first()
    if existing_post:
        return {'exists': True}
    else:
        return {'exists': False}


@app.route("/about")
def about():
    about_bg_url = url_for('static', filename='assets/img/about-bg.jpg')
    return render_my_template('about.html', about_bg_url=about_bg_url)


@app.route("/users")
def users():
    user = Users.query.all()
    home_bg_url = url_for('static', filename='assets/img/home-bg.jpg')
    return render_my_template('users.html', home_bg_url=home_bg_url, user=user)


@app.route("/profile")
def profile():
    user_id = session.get('user_id')

    if not user_id:
        return redirect(url_for('home'))

    user = Users.query.filter_by(id=user_id).first()
    post = Posts.query.filter_by(user_id=user_id).all()

    about_bg_url = url_for('static', filename='assets/img/about-bg.jpg')
    return render_my_template('profile.html', about_bg_url=about_bg_url, user=user, post=post)


@app.route("/dashboard", methods=['POST', 'GET'])
def dashboard():
    if 'user' in session and session['user'] == parameters['admin_user']:
        post = Posts.query.all()
        home_bg_url = url_for('static', filename='assets/img/home-bg.jpg')
        return render_my_template('dashboard.html', home_bg_url=home_bg_url, post=post)

    if request.method == 'POST':
        username = request.form.get('uname')
        userpass = request.form.get('upass')
        if username == parameters['admin_user'] and userpass == parameters['admin_password']:
            session['user'] = username
            post = Posts.query.all()
            home_bg_url = url_for('static', filename='assets/img/home-bg.jpg')
            return render_my_template('dashboard.html', post=post, home_bg_url=home_bg_url)

    sign_in = url_for('static', filename='css/sign-in.css')
    return render_my_template('login.html', sign_in=sign_in)


@app.route("/approve_post", methods=['GET'])
def approve_posts():
    if 'user' in session and session['user'] == parameters['admin_user']:
        user_posts = UserPosts.query.all()
        home_bg_url = url_for('static', filename='assets/img/home-bg.jpg')
        return render_my_template('approve_post.html', user_posts=user_posts, home_bg_url=home_bg_url)
    else:
        flash('You need to log in as an admin to access this page.', 'warning')
        return redirect('/dashboard')


@app.route("/check/<int:post_id>", methods=['GET', 'POST'])
def check(post_id):
    if 'user' in session and session['user'] == parameters['admin_user']:
        user_posts = UserPosts.query.get_or_404(post_id)

        if request.method == 'POST' and 'approve' in request.form:
            # Get the data from the UserPosts and add it to Posts database
            title = user_posts.title
            tagline = user_posts.tagline
            slug = user_posts.slug
            content = user_posts.content
            content_type = user_posts.content_type
            date = datetime.now().strftime('%Y-%m-%d')
            img_file = user_posts.img_file
            user_id = user_posts.user_id

            post = Posts(title=title, tagline=tagline, slug=slug, content=content, content_type=content_type, date=date,
                         img_file=img_file, user_id=user_id)
            db.session.add(post)
            db.session.commit()

            # Delete the entry from UserPosts after approval
            db.session.delete(user_posts)
            db.session.commit()

            flash('Post approved and added to Posts database.', 'success')
            return redirect('/dashboard')

        return render_my_template('check.html', user_posts=user_posts)
    else:
        flash('You need to log in as an admin to access this page.', 'warning')
        return redirect('/dashboard')


@app.route("/logout")
def logout():
    session.pop('user')
    return redirect('/')


@app.route('/user_logout')
def user_logout():
    set_user_in_session(logout=True)
    session.clear()
    response = make_response(redirect(url_for('home')))
    response.headers['Cache-Control'] = 'no-store, must-revalidate, max-age=0, no-cache, private'

    flash('You have been logged out.', 'success')
    return response


@app.after_request
def add_cache_control(response):
    response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = '0'
    return response


@app.route("/edit/<string:sno>", methods=['POST', 'GET'])
def edit(sno):
    if 'user' in session and session['user'] == parameters['admin_user']:
        if request.method == 'POST':
            title = request.form.get('title')
            tagline = request.form.get('tagline')
            slug = request.form.get('slug')
            content = request.form.get('content')
            content_type = request.form.get('content_type')
            img_file = request.files['img_file']
            # date = datetime.now().strftime('%Y-%m-%d')
            filename = None

            if img_file and allowed_file(img_file.filename):
                filename = secure_filename(img_file.filename)
                img_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
                img_file.save(img_path)

            if sno == '0':
                flash('You cannot add post', 'warning')
                return redirect('/dashboard')

            else:
                post = Posts.query.filter_by(sno=sno).first()
                post.title = title
                post.slug = slug
                post.content = content
                post.content_type = content_type
                post.tagline = tagline

                if img_file and allowed_file(img_file.filename):
                    old_img_path = os.path.join(app.config['UPLOAD_FOLDER'], post.img_file)
                    if os.path.exists(old_img_path):
                        os.remove(old_img_path)

                    post.img_file = filename

            db.session.commit()
            return redirect('/dashboard')

        home_bg_url = url_for('static', filename='/assets/img/home-bg.jpg')
        post = Posts.query.filter_by(sno=sno).first()
        return render_my_template('edit.html', sno=sno, post=post, home_bg_url=home_bg_url,
                                  content_type_options=content_type_options)


@app.route("/cancel")
def cancel():
    return redirect("/dashboard")


@app.route("/delete/<string:sno>", methods=['POST', 'GET'])
def delete(sno):
    if 'user' in session and session['user'] == parameters['admin_user']:
        post = Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
        return redirect('/dashboard')


def update_remaining_post_ratings():
    subquery = db.session.query(
        Ratings.post_id,
        func.avg(Ratings.rating).label('avg_rating')
    ).group_by(Ratings.post_id).subquery()

    posts = db.session.query(Posts, subquery.c.avg_rating). \
        outerjoin(subquery, Posts.sno == subquery.c.post_id).all()

    for post, avg_rating in posts:
        post.overall_rating = avg_rating or 0.0  # Handle the case when there are no ratings

    # Commit the changes to the database
    db.session.commit()


@app.route("/delete_user/<int:user_id>", methods=['POST', 'GET'])
def delete_user(user_id):
    if 'user' in session and session['user'] == parameters['admin_user']:
        session.pop('user_id', None)
        # Step 1: Delete user, posts, and ratings
        user = Users.query.get(user_id)
        if user:
            # Delete the ratings related to the user
            Ratings.query.filter_by(user_id=user_id).delete()

            # Delete the user's posts and related ratings
            user_posts = UserPosts.query.filter_by(user_id=user_id).all()
            for post in user_posts:
                Ratings.query.filter_by(post_id=post.sno).delete()
            UserPosts.query.filter_by(user_id=user_id).delete()

            # Delete the user's main posts and related ratings
            user_main_posts = Posts.query.filter_by(user_id=user_id).all()
            for post in user_main_posts:
                Ratings.query.filter_by(post_id=post.sno).delete()
            Posts.query.filter_by(user_id=user_id).delete()

            db.session.commit()

            update_remaining_post_ratings()

            Users.query.filter_by(id=user_id).delete()

            # Commit the changes to the database
            db.session.commit()

            flash('User and related data deleted successfully.', 'message')
            return redirect(url_for("users"))

        else:
            flash('User not found.', 'message')
            return redirect(url_for("users"))
    else:
        flash('Unauthorized', 'message')
        return redirect(url_for("users"))


@app.route("/delete_account", methods=['POST', 'GET'])
def delete_account():
    user_id_to_delete = session.get('user_id')

    session.pop('user_id', None)

    # Delete user-related data
    Ratings.query.filter_by(user_id=user_id_to_delete).delete()

    user_posts = UserPosts.query.filter_by(user_id=user_id_to_delete).all()
    for post in user_posts:
        Ratings.query.filter_by(post_id=post.sno).delete()
    UserPosts.query.filter_by(user_id=user_id_to_delete).delete()

    user_main_posts = Posts.query.filter_by(user_id=user_id_to_delete).all()
    for post in user_main_posts:
        Ratings.query.filter_by(post_id=post.sno).delete()
    Posts.query.filter_by(user_id=user_id_to_delete).delete()

    # Commit the changes to the database to delete user-related data
    db.session.commit()

    # Update overall_rating for remaining posts
    update_remaining_post_ratings()

    # Delete the user
    Users.query.filter_by(id=user_id_to_delete).delete()

    # Commit the changes to the database to delete the user
    db.session.commit()

    return redirect(url_for("home"))


app.run(debug=True)
