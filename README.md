# Semantic_Person_Search

Semantic person search is the task of matching a
person to a semantic query. For example, given the query ‘1.8m tall man wearing jeans a red
shirt’, a semantic person search method should return images that feature people matching
that description. As such, a semantic search process needs to consider multiple traits.

The model classifies the following traits given an input image:
* Gender
* Torso Clothing Type
* Primary Torso Clothing Colour
* Torso Clothing Texture
* Leg Clothing Type
* Primary Leg Clothing Colour
* Leg Clothing Texture, and
* Luggage

****
## Data
**Note:** Extract the files in the data folder before running the model (eg: data/Test_Data/)

The database in the data folder contains the following semantic
annotations:

* Gender: -1 (unknown), 0 (male), 1 (female)

* Pose: -1 (unknown), 0 (front), 1 (back), 2 (45 degrees), 3 (90 degrees)

* Torso Clothing Type: -1 (unknown), 0 (long), 1 (short)

* Torso Clothing Colour: -1 (unknown), 0 (black), 1 (blue), 2 (brown), 3 (green), 4
(grey), 5 (orange), 6 (pink), 7 (purple), 8 (red), 9 (white), 10 (yellow)

* Torso Clothing Texture: -1 (unknown) , 0 (irregular), 1 (plaid), 2 (diagonal plaid), 3
(plain), 4 (spots), 5 (diagonal stripes), 6 (horizontal stripes), 7 (vertical stripes)

* Leg Clothing Type: -1 (unknown), 0 (long), 1 (short)

* Leg Clothing Colour: -1 (unknown), 0 (black), 1 (brown), 2 (blue), 3 (green), 4 (grey),
5 (orange), 6 (pink), 7 (purple), 8 (red), 9 (white), 10 (yellow)

* Leg Clothing Texture: -1 (unknown) , 0 (irregular), 1 (plaid), 2 (diagonal plaid), 3
(plain), 4 (spots), 5 (diagonal stripes), 6 (horizontal stripes), 7 (vertical stripes)

* Luggage: -1 (unknown), 0 (yes), 1 (no)

In addition, the dataset contains semantic segmentation for each image in the training
data, that breaks the image down into the following regions:

* Leg clothing

* Shoes

* Torso clothing

* Luggage

* Leg skin regions

* Torso/arm skin regions

* Facial skin regions

* Hair
