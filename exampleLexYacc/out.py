import numpy as np
import simpleaudio as sa
import threading
import time

# calculate note frequencies
A_freq = 440 # A4 (Hz)

def freq(distance_from_a4):
    return A_freq * 2 ** (distance_from_a4/12)

A4_freq = freq(0)
Ash4_freq = freq(1)
B4_freq = freq(2)
C4_freq = freq(-9)
Csh4_freq = freq(-20)
D4_freq = freq(-7)
Dsh4_freq = freq(-6)
E4_freq = freq(-5)
F4_freq = freq(-4)
Fsh4_freq = freq(-3)
G4_freq = freq(-2)
Gsh4_freq = freq(-1)

sample_rate = 44100 # never change

# generate sine wave notes
def note(freq, duration):
	t = np.linspace(0, duration, int(duration * sample_rate) , False) # lista de T*sample_rate numeros en el intervalo [0 a T)
	return np.sin(freq * t * 2 * np.pi)

def addnote(audio, from_index, freq, duration):
	n = int(sample_rate * duration)
	audio[from_index: from_index + n] += note(freq, duration)[from_index: from_index + n]

def chord(freq1, freq2, freq3, duration, freq4=0):
	# mix audio together
	audio = np.zeros(int(sample_rate * duration))
	addnote(audio, 0, freq1, duration)
	addnote(audio, 0, freq2, duration)
	addnote(audio, 0, freq3, duration)
	addnote(audio, 0, freq4, duration)

	# normalize to 16-bit range
	audio *= 32767 / np.max(np.abs(audio))
	return audio

def play(chords, volume):
	# start playback
	n = 0
	for chord in chords:
		n+= len(chord)
	final_sound = np.zeros(n)
	offset = 0
	for chord in chords:
		chord_with_volume = chord*volume[offset: offset + len(chord)]
		final_sound[offset : offset + len(chord_with_volume)] = chord_with_volume[0:len(chord_with_volume)]
		offset += len(chord)
	play_obj = sa.play_buffer(final_sound.astype(np.int16), 2, 2, sample_rate)

	# wait for playback to finish before exiting
	play_obj.wait_done()
	return

length_of_beat = 3.000000
volume = 1.000000
note[] notes = [A4,A5,B5]
int i = len(notes)
while i > 0.000000:
	play([notes[i]], 60.000000)
	play([notes[i] + A4], 60.000000)
	play([notes[i] + 8.000000], 60.000000)
	i = i - 1


