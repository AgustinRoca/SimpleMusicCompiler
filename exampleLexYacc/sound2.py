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
Csh4_freq = freq(-8)
D4_freq = freq(-7)
Dsh4_freq = freq(-6)
E4_freq = freq(-5)
F4_freq = freq(-4)
Fsh4_freq = freq(-3)
G4_freq = freq(-2)
Gsh4_freq = freq(-1)

sample_rate = 44100 # never change
bpm = 124
T = 60/bpm # length of a beat (in seconds)

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

# Acordes
do = chord(C4_freq, E4_freq, G4_freq, T)
re_menor = chord(D4_freq, F4_freq, A4_freq, T)
re = chord(D4_freq, Fsh4_freq, A4_freq, T)
mi_menor = chord(E4_freq, G4_freq, B4_freq, T)
fa_menor_sostenido = chord(Fsh4_freq, A4_freq, Csh4_freq, T)
fa = chord(F4_freq, A4_freq, C4_freq, T)
fa_mayor_7 = chord(F4_freq, A4_freq, C4_freq, T, E4_freq)
sol = chord(G4_freq, B4_freq, D4_freq, T)
la_menor = chord(A4_freq, C4_freq, E4_freq, T)

secuencia_1 = [mi_menor, sol, do, sol]
secuencia_2 = secuencia_1 + [la_menor, re]
secuencia_1_por_4 = secuencia_1 + secuencia_1 + secuencia_1 + secuencia_1
intro = secuencia_1
verso_1 = secuencia_1_por_4 + secuencia_2
verso_2 = secuencia_1_por_4 + secuencia_1_por_4 + secuencia_2

cancion = intro + verso_1 + verso_2
volume = [1] * (int(T*sample_rate) * len(cancion)) # volumen constante (debe tomar valores entre 0 y 1)
#volume = np.linspace(1, 0, int(T*sample_rate) * len(cancion), False) # volumen disminuye con el tiempo linealmente
play(cancion, volume)
