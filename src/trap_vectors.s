/*
	generated by trap_vectors.py - do not edit
	Ref: https://github.com/phf/xv6/blob/master/vectors.pl

#!/usr/bin/python3

# Generate trap_vectors.s, the trap/interrupt entry points.
# There has to be one entry point per interrupt number
# since otherwise there's no way for trap() to discover
# the interrupt number.

print("# handlers")
print(".globl alltraps")
for i in range(256):
    print(f".globl trap_vector{i}")
    print(f"trap_vector{i}:")
    if i not in [8, 10, 11, 12, 13, 14, 17]:
        print("  pushl $0")
    print(f"  pushl ${i}")
    print("  jmp alltraps")
print()
print("# trap vector table")
print(".data")
print(".globl trap_vectors")
print("trap_vectors:")
for i in range(256):
    print(f"  .long trap_vector{i}")

*/

# handlers
.globl alltraps
.globl trap_vector0
trap_vector0:
  pushl $0
  pushl $0
  jmp alltraps
.globl trap_vector1
trap_vector1:
  pushl $0
  pushl $1
  jmp alltraps
.globl trap_vector2
trap_vector2:
  pushl $0
  pushl $2
  jmp alltraps
.globl trap_vector3
trap_vector3:
  pushl $0
  pushl $3
  jmp alltraps
.globl trap_vector4
trap_vector4:
  pushl $0
  pushl $4
  jmp alltraps
.globl trap_vector5
trap_vector5:
  pushl $0
  pushl $5
  jmp alltraps
.globl trap_vector6
trap_vector6:
  pushl $0
  pushl $6
  jmp alltraps
.globl trap_vector7
trap_vector7:
  pushl $0
  pushl $7
  jmp alltraps
.globl trap_vector8
trap_vector8:
  pushl $8
  jmp alltraps
.globl trap_vector9
trap_vector9:
  pushl $0
  pushl $9
  jmp alltraps
.globl trap_vector10
trap_vector10:
  pushl $10
  jmp alltraps
.globl trap_vector11
trap_vector11:
  pushl $11
  jmp alltraps
.globl trap_vector12
trap_vector12:
  pushl $12
  jmp alltraps
.globl trap_vector13
trap_vector13:
  pushl $13
  jmp alltraps
.globl trap_vector14
trap_vector14:
  pushl $14
  jmp alltraps
.globl trap_vector15
trap_vector15:
  pushl $0
  pushl $15
  jmp alltraps
.globl trap_vector16
trap_vector16:
  pushl $0
  pushl $16
  jmp alltraps
.globl trap_vector17
trap_vector17:
  pushl $17
  jmp alltraps
.globl trap_vector18
trap_vector18:
  pushl $0
  pushl $18
  jmp alltraps
.globl trap_vector19
trap_vector19:
  pushl $0
  pushl $19
  jmp alltraps
.globl trap_vector20
trap_vector20:
  pushl $0
  pushl $20
  jmp alltraps
.globl trap_vector21
trap_vector21:
  pushl $0
  pushl $21
  jmp alltraps
.globl trap_vector22
trap_vector22:
  pushl $0
  pushl $22
  jmp alltraps
.globl trap_vector23
trap_vector23:
  pushl $0
  pushl $23
  jmp alltraps
.globl trap_vector24
trap_vector24:
  pushl $0
  pushl $24
  jmp alltraps
.globl trap_vector25
trap_vector25:
  pushl $0
  pushl $25
  jmp alltraps
.globl trap_vector26
trap_vector26:
  pushl $0
  pushl $26
  jmp alltraps
.globl trap_vector27
trap_vector27:
  pushl $0
  pushl $27
  jmp alltraps
.globl trap_vector28
trap_vector28:
  pushl $0
  pushl $28
  jmp alltraps
.globl trap_vector29
trap_vector29:
  pushl $0
  pushl $29
  jmp alltraps
.globl trap_vector30
trap_vector30:
  pushl $0
  pushl $30
  jmp alltraps
.globl trap_vector31
trap_vector31:
  pushl $0
  pushl $31
  jmp alltraps
.globl trap_vector32
trap_vector32:
  pushl $0
  pushl $32
  jmp alltraps
.globl trap_vector33
trap_vector33:
  pushl $0
  pushl $33
  jmp alltraps
.globl trap_vector34
trap_vector34:
  pushl $0
  pushl $34
  jmp alltraps
.globl trap_vector35
trap_vector35:
  pushl $0
  pushl $35
  jmp alltraps
.globl trap_vector36
trap_vector36:
  pushl $0
  pushl $36
  jmp alltraps
.globl trap_vector37
trap_vector37:
  pushl $0
  pushl $37
  jmp alltraps
.globl trap_vector38
trap_vector38:
  pushl $0
  pushl $38
  jmp alltraps
.globl trap_vector39
trap_vector39:
  pushl $0
  pushl $39
  jmp alltraps
.globl trap_vector40
trap_vector40:
  pushl $0
  pushl $40
  jmp alltraps
.globl trap_vector41
trap_vector41:
  pushl $0
  pushl $41
  jmp alltraps
.globl trap_vector42
trap_vector42:
  pushl $0
  pushl $42
  jmp alltraps
.globl trap_vector43
trap_vector43:
  pushl $0
  pushl $43
  jmp alltraps
.globl trap_vector44
trap_vector44:
  pushl $0
  pushl $44
  jmp alltraps
.globl trap_vector45
trap_vector45:
  pushl $0
  pushl $45
  jmp alltraps
.globl trap_vector46
trap_vector46:
  pushl $0
  pushl $46
  jmp alltraps
.globl trap_vector47
trap_vector47:
  pushl $0
  pushl $47
  jmp alltraps
.globl trap_vector48
trap_vector48:
  pushl $0
  pushl $48
  jmp alltraps
.globl trap_vector49
trap_vector49:
  pushl $0
  pushl $49
  jmp alltraps
.globl trap_vector50
trap_vector50:
  pushl $0
  pushl $50
  jmp alltraps
.globl trap_vector51
trap_vector51:
  pushl $0
  pushl $51
  jmp alltraps
.globl trap_vector52
trap_vector52:
  pushl $0
  pushl $52
  jmp alltraps
.globl trap_vector53
trap_vector53:
  pushl $0
  pushl $53
  jmp alltraps
.globl trap_vector54
trap_vector54:
  pushl $0
  pushl $54
  jmp alltraps
.globl trap_vector55
trap_vector55:
  pushl $0
  pushl $55
  jmp alltraps
.globl trap_vector56
trap_vector56:
  pushl $0
  pushl $56
  jmp alltraps
.globl trap_vector57
trap_vector57:
  pushl $0
  pushl $57
  jmp alltraps
.globl trap_vector58
trap_vector58:
  pushl $0
  pushl $58
  jmp alltraps
.globl trap_vector59
trap_vector59:
  pushl $0
  pushl $59
  jmp alltraps
.globl trap_vector60
trap_vector60:
  pushl $0
  pushl $60
  jmp alltraps
.globl trap_vector61
trap_vector61:
  pushl $0
  pushl $61
  jmp alltraps
.globl trap_vector62
trap_vector62:
  pushl $0
  pushl $62
  jmp alltraps
.globl trap_vector63
trap_vector63:
  pushl $0
  pushl $63
  jmp alltraps
.globl trap_vector64
trap_vector64:
  pushl $0
  pushl $64
  jmp alltraps
.globl trap_vector65
trap_vector65:
  pushl $0
  pushl $65
  jmp alltraps
.globl trap_vector66
trap_vector66:
  pushl $0
  pushl $66
  jmp alltraps
.globl trap_vector67
trap_vector67:
  pushl $0
  pushl $67
  jmp alltraps
.globl trap_vector68
trap_vector68:
  pushl $0
  pushl $68
  jmp alltraps
.globl trap_vector69
trap_vector69:
  pushl $0
  pushl $69
  jmp alltraps
.globl trap_vector70
trap_vector70:
  pushl $0
  pushl $70
  jmp alltraps
.globl trap_vector71
trap_vector71:
  pushl $0
  pushl $71
  jmp alltraps
.globl trap_vector72
trap_vector72:
  pushl $0
  pushl $72
  jmp alltraps
.globl trap_vector73
trap_vector73:
  pushl $0
  pushl $73
  jmp alltraps
.globl trap_vector74
trap_vector74:
  pushl $0
  pushl $74
  jmp alltraps
.globl trap_vector75
trap_vector75:
  pushl $0
  pushl $75
  jmp alltraps
.globl trap_vector76
trap_vector76:
  pushl $0
  pushl $76
  jmp alltraps
.globl trap_vector77
trap_vector77:
  pushl $0
  pushl $77
  jmp alltraps
.globl trap_vector78
trap_vector78:
  pushl $0
  pushl $78
  jmp alltraps
.globl trap_vector79
trap_vector79:
  pushl $0
  pushl $79
  jmp alltraps
.globl trap_vector80
trap_vector80:
  pushl $0
  pushl $80
  jmp alltraps
.globl trap_vector81
trap_vector81:
  pushl $0
  pushl $81
  jmp alltraps
.globl trap_vector82
trap_vector82:
  pushl $0
  pushl $82
  jmp alltraps
.globl trap_vector83
trap_vector83:
  pushl $0
  pushl $83
  jmp alltraps
.globl trap_vector84
trap_vector84:
  pushl $0
  pushl $84
  jmp alltraps
.globl trap_vector85
trap_vector85:
  pushl $0
  pushl $85
  jmp alltraps
.globl trap_vector86
trap_vector86:
  pushl $0
  pushl $86
  jmp alltraps
.globl trap_vector87
trap_vector87:
  pushl $0
  pushl $87
  jmp alltraps
.globl trap_vector88
trap_vector88:
  pushl $0
  pushl $88
  jmp alltraps
.globl trap_vector89
trap_vector89:
  pushl $0
  pushl $89
  jmp alltraps
.globl trap_vector90
trap_vector90:
  pushl $0
  pushl $90
  jmp alltraps
.globl trap_vector91
trap_vector91:
  pushl $0
  pushl $91
  jmp alltraps
.globl trap_vector92
trap_vector92:
  pushl $0
  pushl $92
  jmp alltraps
.globl trap_vector93
trap_vector93:
  pushl $0
  pushl $93
  jmp alltraps
.globl trap_vector94
trap_vector94:
  pushl $0
  pushl $94
  jmp alltraps
.globl trap_vector95
trap_vector95:
  pushl $0
  pushl $95
  jmp alltraps
.globl trap_vector96
trap_vector96:
  pushl $0
  pushl $96
  jmp alltraps
.globl trap_vector97
trap_vector97:
  pushl $0
  pushl $97
  jmp alltraps
.globl trap_vector98
trap_vector98:
  pushl $0
  pushl $98
  jmp alltraps
.globl trap_vector99
trap_vector99:
  pushl $0
  pushl $99
  jmp alltraps
.globl trap_vector100
trap_vector100:
  pushl $0
  pushl $100
  jmp alltraps
.globl trap_vector101
trap_vector101:
  pushl $0
  pushl $101
  jmp alltraps
.globl trap_vector102
trap_vector102:
  pushl $0
  pushl $102
  jmp alltraps
.globl trap_vector103
trap_vector103:
  pushl $0
  pushl $103
  jmp alltraps
.globl trap_vector104
trap_vector104:
  pushl $0
  pushl $104
  jmp alltraps
.globl trap_vector105
trap_vector105:
  pushl $0
  pushl $105
  jmp alltraps
.globl trap_vector106
trap_vector106:
  pushl $0
  pushl $106
  jmp alltraps
.globl trap_vector107
trap_vector107:
  pushl $0
  pushl $107
  jmp alltraps
.globl trap_vector108
trap_vector108:
  pushl $0
  pushl $108
  jmp alltraps
.globl trap_vector109
trap_vector109:
  pushl $0
  pushl $109
  jmp alltraps
.globl trap_vector110
trap_vector110:
  pushl $0
  pushl $110
  jmp alltraps
.globl trap_vector111
trap_vector111:
  pushl $0
  pushl $111
  jmp alltraps
.globl trap_vector112
trap_vector112:
  pushl $0
  pushl $112
  jmp alltraps
.globl trap_vector113
trap_vector113:
  pushl $0
  pushl $113
  jmp alltraps
.globl trap_vector114
trap_vector114:
  pushl $0
  pushl $114
  jmp alltraps
.globl trap_vector115
trap_vector115:
  pushl $0
  pushl $115
  jmp alltraps
.globl trap_vector116
trap_vector116:
  pushl $0
  pushl $116
  jmp alltraps
.globl trap_vector117
trap_vector117:
  pushl $0
  pushl $117
  jmp alltraps
.globl trap_vector118
trap_vector118:
  pushl $0
  pushl $118
  jmp alltraps
.globl trap_vector119
trap_vector119:
  pushl $0
  pushl $119
  jmp alltraps
.globl trap_vector120
trap_vector120:
  pushl $0
  pushl $120
  jmp alltraps
.globl trap_vector121
trap_vector121:
  pushl $0
  pushl $121
  jmp alltraps
.globl trap_vector122
trap_vector122:
  pushl $0
  pushl $122
  jmp alltraps
.globl trap_vector123
trap_vector123:
  pushl $0
  pushl $123
  jmp alltraps
.globl trap_vector124
trap_vector124:
  pushl $0
  pushl $124
  jmp alltraps
.globl trap_vector125
trap_vector125:
  pushl $0
  pushl $125
  jmp alltraps
.globl trap_vector126
trap_vector126:
  pushl $0
  pushl $126
  jmp alltraps
.globl trap_vector127
trap_vector127:
  pushl $0
  pushl $127
  jmp alltraps
.globl trap_vector128
trap_vector128:
  pushl $0
  pushl $128
  jmp alltraps
.globl trap_vector129
trap_vector129:
  pushl $0
  pushl $129
  jmp alltraps
.globl trap_vector130
trap_vector130:
  pushl $0
  pushl $130
  jmp alltraps
.globl trap_vector131
trap_vector131:
  pushl $0
  pushl $131
  jmp alltraps
.globl trap_vector132
trap_vector132:
  pushl $0
  pushl $132
  jmp alltraps
.globl trap_vector133
trap_vector133:
  pushl $0
  pushl $133
  jmp alltraps
.globl trap_vector134
trap_vector134:
  pushl $0
  pushl $134
  jmp alltraps
.globl trap_vector135
trap_vector135:
  pushl $0
  pushl $135
  jmp alltraps
.globl trap_vector136
trap_vector136:
  pushl $0
  pushl $136
  jmp alltraps
.globl trap_vector137
trap_vector137:
  pushl $0
  pushl $137
  jmp alltraps
.globl trap_vector138
trap_vector138:
  pushl $0
  pushl $138
  jmp alltraps
.globl trap_vector139
trap_vector139:
  pushl $0
  pushl $139
  jmp alltraps
.globl trap_vector140
trap_vector140:
  pushl $0
  pushl $140
  jmp alltraps
.globl trap_vector141
trap_vector141:
  pushl $0
  pushl $141
  jmp alltraps
.globl trap_vector142
trap_vector142:
  pushl $0
  pushl $142
  jmp alltraps
.globl trap_vector143
trap_vector143:
  pushl $0
  pushl $143
  jmp alltraps
.globl trap_vector144
trap_vector144:
  pushl $0
  pushl $144
  jmp alltraps
.globl trap_vector145
trap_vector145:
  pushl $0
  pushl $145
  jmp alltraps
.globl trap_vector146
trap_vector146:
  pushl $0
  pushl $146
  jmp alltraps
.globl trap_vector147
trap_vector147:
  pushl $0
  pushl $147
  jmp alltraps
.globl trap_vector148
trap_vector148:
  pushl $0
  pushl $148
  jmp alltraps
.globl trap_vector149
trap_vector149:
  pushl $0
  pushl $149
  jmp alltraps
.globl trap_vector150
trap_vector150:
  pushl $0
  pushl $150
  jmp alltraps
.globl trap_vector151
trap_vector151:
  pushl $0
  pushl $151
  jmp alltraps
.globl trap_vector152
trap_vector152:
  pushl $0
  pushl $152
  jmp alltraps
.globl trap_vector153
trap_vector153:
  pushl $0
  pushl $153
  jmp alltraps
.globl trap_vector154
trap_vector154:
  pushl $0
  pushl $154
  jmp alltraps
.globl trap_vector155
trap_vector155:
  pushl $0
  pushl $155
  jmp alltraps
.globl trap_vector156
trap_vector156:
  pushl $0
  pushl $156
  jmp alltraps
.globl trap_vector157
trap_vector157:
  pushl $0
  pushl $157
  jmp alltraps
.globl trap_vector158
trap_vector158:
  pushl $0
  pushl $158
  jmp alltraps
.globl trap_vector159
trap_vector159:
  pushl $0
  pushl $159
  jmp alltraps
.globl trap_vector160
trap_vector160:
  pushl $0
  pushl $160
  jmp alltraps
.globl trap_vector161
trap_vector161:
  pushl $0
  pushl $161
  jmp alltraps
.globl trap_vector162
trap_vector162:
  pushl $0
  pushl $162
  jmp alltraps
.globl trap_vector163
trap_vector163:
  pushl $0
  pushl $163
  jmp alltraps
.globl trap_vector164
trap_vector164:
  pushl $0
  pushl $164
  jmp alltraps
.globl trap_vector165
trap_vector165:
  pushl $0
  pushl $165
  jmp alltraps
.globl trap_vector166
trap_vector166:
  pushl $0
  pushl $166
  jmp alltraps
.globl trap_vector167
trap_vector167:
  pushl $0
  pushl $167
  jmp alltraps
.globl trap_vector168
trap_vector168:
  pushl $0
  pushl $168
  jmp alltraps
.globl trap_vector169
trap_vector169:
  pushl $0
  pushl $169
  jmp alltraps
.globl trap_vector170
trap_vector170:
  pushl $0
  pushl $170
  jmp alltraps
.globl trap_vector171
trap_vector171:
  pushl $0
  pushl $171
  jmp alltraps
.globl trap_vector172
trap_vector172:
  pushl $0
  pushl $172
  jmp alltraps
.globl trap_vector173
trap_vector173:
  pushl $0
  pushl $173
  jmp alltraps
.globl trap_vector174
trap_vector174:
  pushl $0
  pushl $174
  jmp alltraps
.globl trap_vector175
trap_vector175:
  pushl $0
  pushl $175
  jmp alltraps
.globl trap_vector176
trap_vector176:
  pushl $0
  pushl $176
  jmp alltraps
.globl trap_vector177
trap_vector177:
  pushl $0
  pushl $177
  jmp alltraps
.globl trap_vector178
trap_vector178:
  pushl $0
  pushl $178
  jmp alltraps
.globl trap_vector179
trap_vector179:
  pushl $0
  pushl $179
  jmp alltraps
.globl trap_vector180
trap_vector180:
  pushl $0
  pushl $180
  jmp alltraps
.globl trap_vector181
trap_vector181:
  pushl $0
  pushl $181
  jmp alltraps
.globl trap_vector182
trap_vector182:
  pushl $0
  pushl $182
  jmp alltraps
.globl trap_vector183
trap_vector183:
  pushl $0
  pushl $183
  jmp alltraps
.globl trap_vector184
trap_vector184:
  pushl $0
  pushl $184
  jmp alltraps
.globl trap_vector185
trap_vector185:
  pushl $0
  pushl $185
  jmp alltraps
.globl trap_vector186
trap_vector186:
  pushl $0
  pushl $186
  jmp alltraps
.globl trap_vector187
trap_vector187:
  pushl $0
  pushl $187
  jmp alltraps
.globl trap_vector188
trap_vector188:
  pushl $0
  pushl $188
  jmp alltraps
.globl trap_vector189
trap_vector189:
  pushl $0
  pushl $189
  jmp alltraps
.globl trap_vector190
trap_vector190:
  pushl $0
  pushl $190
  jmp alltraps
.globl trap_vector191
trap_vector191:
  pushl $0
  pushl $191
  jmp alltraps
.globl trap_vector192
trap_vector192:
  pushl $0
  pushl $192
  jmp alltraps
.globl trap_vector193
trap_vector193:
  pushl $0
  pushl $193
  jmp alltraps
.globl trap_vector194
trap_vector194:
  pushl $0
  pushl $194
  jmp alltraps
.globl trap_vector195
trap_vector195:
  pushl $0
  pushl $195
  jmp alltraps
.globl trap_vector196
trap_vector196:
  pushl $0
  pushl $196
  jmp alltraps
.globl trap_vector197
trap_vector197:
  pushl $0
  pushl $197
  jmp alltraps
.globl trap_vector198
trap_vector198:
  pushl $0
  pushl $198
  jmp alltraps
.globl trap_vector199
trap_vector199:
  pushl $0
  pushl $199
  jmp alltraps
.globl trap_vector200
trap_vector200:
  pushl $0
  pushl $200
  jmp alltraps
.globl trap_vector201
trap_vector201:
  pushl $0
  pushl $201
  jmp alltraps
.globl trap_vector202
trap_vector202:
  pushl $0
  pushl $202
  jmp alltraps
.globl trap_vector203
trap_vector203:
  pushl $0
  pushl $203
  jmp alltraps
.globl trap_vector204
trap_vector204:
  pushl $0
  pushl $204
  jmp alltraps
.globl trap_vector205
trap_vector205:
  pushl $0
  pushl $205
  jmp alltraps
.globl trap_vector206
trap_vector206:
  pushl $0
  pushl $206
  jmp alltraps
.globl trap_vector207
trap_vector207:
  pushl $0
  pushl $207
  jmp alltraps
.globl trap_vector208
trap_vector208:
  pushl $0
  pushl $208
  jmp alltraps
.globl trap_vector209
trap_vector209:
  pushl $0
  pushl $209
  jmp alltraps
.globl trap_vector210
trap_vector210:
  pushl $0
  pushl $210
  jmp alltraps
.globl trap_vector211
trap_vector211:
  pushl $0
  pushl $211
  jmp alltraps
.globl trap_vector212
trap_vector212:
  pushl $0
  pushl $212
  jmp alltraps
.globl trap_vector213
trap_vector213:
  pushl $0
  pushl $213
  jmp alltraps
.globl trap_vector214
trap_vector214:
  pushl $0
  pushl $214
  jmp alltraps
.globl trap_vector215
trap_vector215:
  pushl $0
  pushl $215
  jmp alltraps
.globl trap_vector216
trap_vector216:
  pushl $0
  pushl $216
  jmp alltraps
.globl trap_vector217
trap_vector217:
  pushl $0
  pushl $217
  jmp alltraps
.globl trap_vector218
trap_vector218:
  pushl $0
  pushl $218
  jmp alltraps
.globl trap_vector219
trap_vector219:
  pushl $0
  pushl $219
  jmp alltraps
.globl trap_vector220
trap_vector220:
  pushl $0
  pushl $220
  jmp alltraps
.globl trap_vector221
trap_vector221:
  pushl $0
  pushl $221
  jmp alltraps
.globl trap_vector222
trap_vector222:
  pushl $0
  pushl $222
  jmp alltraps
.globl trap_vector223
trap_vector223:
  pushl $0
  pushl $223
  jmp alltraps
.globl trap_vector224
trap_vector224:
  pushl $0
  pushl $224
  jmp alltraps
.globl trap_vector225
trap_vector225:
  pushl $0
  pushl $225
  jmp alltraps
.globl trap_vector226
trap_vector226:
  pushl $0
  pushl $226
  jmp alltraps
.globl trap_vector227
trap_vector227:
  pushl $0
  pushl $227
  jmp alltraps
.globl trap_vector228
trap_vector228:
  pushl $0
  pushl $228
  jmp alltraps
.globl trap_vector229
trap_vector229:
  pushl $0
  pushl $229
  jmp alltraps
.globl trap_vector230
trap_vector230:
  pushl $0
  pushl $230
  jmp alltraps
.globl trap_vector231
trap_vector231:
  pushl $0
  pushl $231
  jmp alltraps
.globl trap_vector232
trap_vector232:
  pushl $0
  pushl $232
  jmp alltraps
.globl trap_vector233
trap_vector233:
  pushl $0
  pushl $233
  jmp alltraps
.globl trap_vector234
trap_vector234:
  pushl $0
  pushl $234
  jmp alltraps
.globl trap_vector235
trap_vector235:
  pushl $0
  pushl $235
  jmp alltraps
.globl trap_vector236
trap_vector236:
  pushl $0
  pushl $236
  jmp alltraps
.globl trap_vector237
trap_vector237:
  pushl $0
  pushl $237
  jmp alltraps
.globl trap_vector238
trap_vector238:
  pushl $0
  pushl $238
  jmp alltraps
.globl trap_vector239
trap_vector239:
  pushl $0
  pushl $239
  jmp alltraps
.globl trap_vector240
trap_vector240:
  pushl $0
  pushl $240
  jmp alltraps
.globl trap_vector241
trap_vector241:
  pushl $0
  pushl $241
  jmp alltraps
.globl trap_vector242
trap_vector242:
  pushl $0
  pushl $242
  jmp alltraps
.globl trap_vector243
trap_vector243:
  pushl $0
  pushl $243
  jmp alltraps
.globl trap_vector244
trap_vector244:
  pushl $0
  pushl $244
  jmp alltraps
.globl trap_vector245
trap_vector245:
  pushl $0
  pushl $245
  jmp alltraps
.globl trap_vector246
trap_vector246:
  pushl $0
  pushl $246
  jmp alltraps
.globl trap_vector247
trap_vector247:
  pushl $0
  pushl $247
  jmp alltraps
.globl trap_vector248
trap_vector248:
  pushl $0
  pushl $248
  jmp alltraps
.globl trap_vector249
trap_vector249:
  pushl $0
  pushl $249
  jmp alltraps
.globl trap_vector250
trap_vector250:
  pushl $0
  pushl $250
  jmp alltraps
.globl trap_vector251
trap_vector251:
  pushl $0
  pushl $251
  jmp alltraps
.globl trap_vector252
trap_vector252:
  pushl $0
  pushl $252
  jmp alltraps
.globl trap_vector253
trap_vector253:
  pushl $0
  pushl $253
  jmp alltraps
.globl trap_vector254
trap_vector254:
  pushl $0
  pushl $254
  jmp alltraps
.globl trap_vector255
trap_vector255:
  pushl $0
  pushl $255
  jmp alltraps

# trap vector table
.data
.globl trap_vectors
trap_vectors:
  .long trap_vector0
  .long trap_vector1
  .long trap_vector2
  .long trap_vector3
  .long trap_vector4
  .long trap_vector5
  .long trap_vector6
  .long trap_vector7
  .long trap_vector8
  .long trap_vector9
  .long trap_vector10
  .long trap_vector11
  .long trap_vector12
  .long trap_vector13
  .long trap_vector14
  .long trap_vector15
  .long trap_vector16
  .long trap_vector17
  .long trap_vector18
  .long trap_vector19
  .long trap_vector20
  .long trap_vector21
  .long trap_vector22
  .long trap_vector23
  .long trap_vector24
  .long trap_vector25
  .long trap_vector26
  .long trap_vector27
  .long trap_vector28
  .long trap_vector29
  .long trap_vector30
  .long trap_vector31
  .long trap_vector32
  .long trap_vector33
  .long trap_vector34
  .long trap_vector35
  .long trap_vector36
  .long trap_vector37
  .long trap_vector38
  .long trap_vector39
  .long trap_vector40
  .long trap_vector41
  .long trap_vector42
  .long trap_vector43
  .long trap_vector44
  .long trap_vector45
  .long trap_vector46
  .long trap_vector47
  .long trap_vector48
  .long trap_vector49
  .long trap_vector50
  .long trap_vector51
  .long trap_vector52
  .long trap_vector53
  .long trap_vector54
  .long trap_vector55
  .long trap_vector56
  .long trap_vector57
  .long trap_vector58
  .long trap_vector59
  .long trap_vector60
  .long trap_vector61
  .long trap_vector62
  .long trap_vector63
  .long trap_vector64
  .long trap_vector65
  .long trap_vector66
  .long trap_vector67
  .long trap_vector68
  .long trap_vector69
  .long trap_vector70
  .long trap_vector71
  .long trap_vector72
  .long trap_vector73
  .long trap_vector74
  .long trap_vector75
  .long trap_vector76
  .long trap_vector77
  .long trap_vector78
  .long trap_vector79
  .long trap_vector80
  .long trap_vector81
  .long trap_vector82
  .long trap_vector83
  .long trap_vector84
  .long trap_vector85
  .long trap_vector86
  .long trap_vector87
  .long trap_vector88
  .long trap_vector89
  .long trap_vector90
  .long trap_vector91
  .long trap_vector92
  .long trap_vector93
  .long trap_vector94
  .long trap_vector95
  .long trap_vector96
  .long trap_vector97
  .long trap_vector98
  .long trap_vector99
  .long trap_vector100
  .long trap_vector101
  .long trap_vector102
  .long trap_vector103
  .long trap_vector104
  .long trap_vector105
  .long trap_vector106
  .long trap_vector107
  .long trap_vector108
  .long trap_vector109
  .long trap_vector110
  .long trap_vector111
  .long trap_vector112
  .long trap_vector113
  .long trap_vector114
  .long trap_vector115
  .long trap_vector116
  .long trap_vector117
  .long trap_vector118
  .long trap_vector119
  .long trap_vector120
  .long trap_vector121
  .long trap_vector122
  .long trap_vector123
  .long trap_vector124
  .long trap_vector125
  .long trap_vector126
  .long trap_vector127
  .long trap_vector128
  .long trap_vector129
  .long trap_vector130
  .long trap_vector131
  .long trap_vector132
  .long trap_vector133
  .long trap_vector134
  .long trap_vector135
  .long trap_vector136
  .long trap_vector137
  .long trap_vector138
  .long trap_vector139
  .long trap_vector140
  .long trap_vector141
  .long trap_vector142
  .long trap_vector143
  .long trap_vector144
  .long trap_vector145
  .long trap_vector146
  .long trap_vector147
  .long trap_vector148
  .long trap_vector149
  .long trap_vector150
  .long trap_vector151
  .long trap_vector152
  .long trap_vector153
  .long trap_vector154
  .long trap_vector155
  .long trap_vector156
  .long trap_vector157
  .long trap_vector158
  .long trap_vector159
  .long trap_vector160
  .long trap_vector161
  .long trap_vector162
  .long trap_vector163
  .long trap_vector164
  .long trap_vector165
  .long trap_vector166
  .long trap_vector167
  .long trap_vector168
  .long trap_vector169
  .long trap_vector170
  .long trap_vector171
  .long trap_vector172
  .long trap_vector173
  .long trap_vector174
  .long trap_vector175
  .long trap_vector176
  .long trap_vector177
  .long trap_vector178
  .long trap_vector179
  .long trap_vector180
  .long trap_vector181
  .long trap_vector182
  .long trap_vector183
  .long trap_vector184
  .long trap_vector185
  .long trap_vector186
  .long trap_vector187
  .long trap_vector188
  .long trap_vector189
  .long trap_vector190
  .long trap_vector191
  .long trap_vector192
  .long trap_vector193
  .long trap_vector194
  .long trap_vector195
  .long trap_vector196
  .long trap_vector197
  .long trap_vector198
  .long trap_vector199
  .long trap_vector200
  .long trap_vector201
  .long trap_vector202
  .long trap_vector203
  .long trap_vector204
  .long trap_vector205
  .long trap_vector206
  .long trap_vector207
  .long trap_vector208
  .long trap_vector209
  .long trap_vector210
  .long trap_vector211
  .long trap_vector212
  .long trap_vector213
  .long trap_vector214
  .long trap_vector215
  .long trap_vector216
  .long trap_vector217
  .long trap_vector218
  .long trap_vector219
  .long trap_vector220
  .long trap_vector221
  .long trap_vector222
  .long trap_vector223
  .long trap_vector224
  .long trap_vector225
  .long trap_vector226
  .long trap_vector227
  .long trap_vector228
  .long trap_vector229
  .long trap_vector230
  .long trap_vector231
  .long trap_vector232
  .long trap_vector233
  .long trap_vector234
  .long trap_vector235
  .long trap_vector236
  .long trap_vector237
  .long trap_vector238
  .long trap_vector239
  .long trap_vector240
  .long trap_vector241
  .long trap_vector242
  .long trap_vector243
  .long trap_vector244
  .long trap_vector245
  .long trap_vector246
  .long trap_vector247
  .long trap_vector248
  .long trap_vector249
  .long trap_vector250
  .long trap_vector251
  .long trap_vector252
  .long trap_vector253
  .long trap_vector254
  .long trap_vector255
