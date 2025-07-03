# Use an official Python runtime as a parent image
# The readme mentions Python 3.10 or superior, so we'll use a slim version of 3.10
FROM python:3.13.5-alpine3.22
# Set the working directory in the container
WORKDIR /app

# Copy the dependencies file to the working directory
# This is done first to leverage Docker's layer caching.
# The dependencies layer will only be rebuilt if requirements.txt changes.
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application's code to the working directory
COPY . .

# Expose the port the app runs on (uvicorn's default is 8000)
EXPOSE 8000

# Define the command to run the app when the container starts
# Use 0.0.0.0 to make the application accessible from outside the container
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]