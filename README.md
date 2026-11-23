# Lab 2 – 2D Convolution and FIR Filters

## Objective

The objective of this experiment was to understand 2D convolution and image filtering using MATLAB. I investigated image blurring, sharpening, edge detection and boundary handling.

## 1. Delta Image and Impulse Response

I created a 2D delta image and applied a 3x3 average filter. The output showed the impulse response of the filter.

The impulse response h[m,n] describes how a filter responds to an impulse input. It represents the behaviour of the filter.

## 2. Low-Pass Filtering

I compared a 3x3 box filter, a 7x7 box filter and a Gaussian filter.

The 3x3 box filter produced slight smoothing. The 7x7 box filter produced stronger blur and removed more details.

The Gaussian filter produced smoother results. It is preferred over a large box filter because it reduces rapid image changes more smoothly.

## 3. Image Sharpening

I used unsharp masking to sharpen the image.

First, I created a blurred image. Then I subtracted the blurred image from the original to obtain a high-frequency mask. Finally, I added the mask to the original image.

This improved the visibility of image details and edges.

## 4. Edge Detection

I used Sobel filters to detect horizontal and vertical edges.

The gradient magnitude combined both directions and showed the overall edge strength.

I also used a Laplacian filter to detect rapid intensity changes in the image.

## 5. Correlation and Convolution

I compared conv2() and imfilter() with convolution mode.

The maximum difference was approximately 3.33e-16. This value is practically zero. Therefore, both methods produced almost identical results.

## 6. Boundary Handling

I compared replicate, symmetric and circular boundary methods.

- Replicate: Extends the image using the nearest border pixel.
- Symmetric: Reflects the image at its borders.
- Circular: Wraps pixels from the opposite side.

These methods produce different results near image edges and corners.

## 7. Reflections

### 1. Why is Gaussian preferred over a large box low-pass filter?

A Gaussian filter produces smoother blurring and has a smoother frequency response. A large box filter can create stronger unwanted frequency effects.

### 2. What does separability do for computational cost?

A separable Gaussian filter can be applied using two 1D filters instead of one 2D filter. This reduces the number of calculations and improves efficiency.

### 3. How do boundary modes change corners and edges?

Different boundary methods handle missing pixels outside the image differently. Replicate repeats border pixels, symmetric reflects the image, and circular wraps the opposite border. This changes the filtering results near edges and corners.

## Conclusion

This experiment helped me understand how 2D convolution works in image processing. Different filters can blur, sharpen and detect edges. The choice of filter and boundary method affects the final image.

## AI Usage

**Tool used:** ChatGPT

**How I used it:** I used ChatGPT to understand MATLAB filtering commands, convolution and the assignment requirements.

**What I verified or changed:** I ran the MATLAB code, checked all six figures and verified the difference between conv2() and imfilter() using MATLAB.
