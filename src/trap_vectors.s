/*
	generated by vectors.pl - do not edit
	Ref: https://github.com/phf/xv6/blob/master/vectors.pl

#!/usr/bin/perl -w

# Generate vectors.S, the trap/interrupt entry points.
# There has to be one entry point per interrupt number
# since otherwise there's no way for trap() to discover
# the interrupt number.

print "# generated by vectors.pl - do not edit\n";
print "# handlers\n";
print ".globl alltraps\n";
for(my $i = 0; $i < 256; $i++){
    print ".globl vector$i\n";
    print "vector$i:\n";
    if(!($i == 8 || ($i >= 10 && $i <= 14) || $i == 17)){
        print "  pushl \$0\n";
    }
    print "  pushl \$$i\n";
    print "  jmp alltraps\n";
}

print "\n# vector table\n";
print ".data\n";
print ".globl vectors\n";
print "vectors:\n";
for(my $i = 0; $i < 256; $i++){
    print "  .long vector$i\n";
}

*/

# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
  pushl $0
  jmp alltraps
.globl vector1
vector1:
  pushl $0
  pushl $1
  jmp alltraps
.globl vector2
vector2:
  pushl $0
  pushl $2
  jmp alltraps
.globl vector3
vector3:
  pushl $0
  pushl $3
  jmp alltraps
.globl vector4
vector4:
  pushl $0
  pushl $4
  jmp alltraps
.globl vector5
vector5:
  pushl $0
  pushl $5
  jmp alltraps
.globl vector6
vector6:
  pushl $0
  pushl $6
  jmp alltraps
.globl vector7
vector7:
  pushl $0
  pushl $7
  jmp alltraps
.globl vector8
vector8:
  pushl $8
  jmp alltraps
.globl vector9
vector9:
  pushl $0
  pushl $9
  jmp alltraps
.globl vector10
vector10:
  pushl $10
  jmp alltraps
.globl vector11
vector11:
  pushl $11
  jmp alltraps
.globl vector12
vector12:
  pushl $12
  jmp alltraps
.globl vector13
vector13:
  pushl $13
  jmp alltraps
.globl vector14
vector14:
  pushl $14
  jmp alltraps
.globl vector15
vector15:
  pushl $0
  pushl $15
  jmp alltraps
.globl vector16
vector16:
  pushl $0
  pushl $16
  jmp alltraps
.globl vector17
vector17:
  pushl $17
  jmp alltraps
.globl vector18
vector18:
  pushl $0
  pushl $18
  jmp alltraps
.globl vector19
vector19:
  pushl $0
  pushl $19
  jmp alltraps
.globl vector20
vector20:
  pushl $0
  pushl $20
  jmp alltraps
.globl vector21
vector21:
  pushl $0
  pushl $21
  jmp alltraps
.globl vector22
vector22:
  pushl $0
  pushl $22
  jmp alltraps
.globl vector23
vector23:
  pushl $0
  pushl $23
  jmp alltraps
.globl vector24
vector24:
  pushl $0
  pushl $24
  jmp alltraps
.globl vector25
vector25:
  pushl $0
  pushl $25
  jmp alltraps
.globl vector26
vector26:
  pushl $0
  pushl $26
  jmp alltraps
.globl vector27
vector27:
  pushl $0
  pushl $27
  jmp alltraps
.globl vector28
vector28:
  pushl $0
  pushl $28
  jmp alltraps
.globl vector29
vector29:
  pushl $0
  pushl $29
  jmp alltraps
.globl vector30
vector30:
  pushl $0
  pushl $30
  jmp alltraps
.globl vector31
vector31:
  pushl $0
  pushl $31
  jmp alltraps
.globl vector32
vector32:
  pushl $0
  pushl $32
  jmp alltraps
.globl vector33
vector33:
  pushl $0
  pushl $33
  jmp alltraps
.globl vector34
vector34:
  pushl $0
  pushl $34
  jmp alltraps
.globl vector35
vector35:
  pushl $0
  pushl $35
  jmp alltraps
.globl vector36
vector36:
  pushl $0
  pushl $36
  jmp alltraps
.globl vector37
vector37:
  pushl $0
  pushl $37
  jmp alltraps
.globl vector38
vector38:
  pushl $0
  pushl $38
  jmp alltraps
.globl vector39
vector39:
  pushl $0
  pushl $39
  jmp alltraps
.globl vector40
vector40:
  pushl $0
  pushl $40
  jmp alltraps
.globl vector41
vector41:
  pushl $0
  pushl $41
  jmp alltraps
.globl vector42
vector42:
  pushl $0
  pushl $42
  jmp alltraps
.globl vector43
vector43:
  pushl $0
  pushl $43
  jmp alltraps
.globl vector44
vector44:
  pushl $0
  pushl $44
  jmp alltraps
.globl vector45
vector45:
  pushl $0
  pushl $45
  jmp alltraps
.globl vector46
vector46:
  pushl $0
  pushl $46
  jmp alltraps
.globl vector47
vector47:
  pushl $0
  pushl $47
  jmp alltraps
.globl vector48
vector48:
  pushl $0
  pushl $48
  jmp alltraps
.globl vector49
vector49:
  pushl $0
  pushl $49
  jmp alltraps
.globl vector50
vector50:
  pushl $0
  pushl $50
  jmp alltraps
.globl vector51
vector51:
  pushl $0
  pushl $51
  jmp alltraps
.globl vector52
vector52:
  pushl $0
  pushl $52
  jmp alltraps
.globl vector53
vector53:
  pushl $0
  pushl $53
  jmp alltraps
.globl vector54
vector54:
  pushl $0
  pushl $54
  jmp alltraps
.globl vector55
vector55:
  pushl $0
  pushl $55
  jmp alltraps
.globl vector56
vector56:
  pushl $0
  pushl $56
  jmp alltraps
.globl vector57
vector57:
  pushl $0
  pushl $57
  jmp alltraps
.globl vector58
vector58:
  pushl $0
  pushl $58
  jmp alltraps
.globl vector59
vector59:
  pushl $0
  pushl $59
  jmp alltraps
.globl vector60
vector60:
  pushl $0
  pushl $60
  jmp alltraps
.globl vector61
vector61:
  pushl $0
  pushl $61
  jmp alltraps
.globl vector62
vector62:
  pushl $0
  pushl $62
  jmp alltraps
.globl vector63
vector63:
  pushl $0
  pushl $63
  jmp alltraps
.globl vector64
vector64:
  pushl $0
  pushl $64
  jmp alltraps
.globl vector65
vector65:
  pushl $0
  pushl $65
  jmp alltraps
.globl vector66
vector66:
  pushl $0
  pushl $66
  jmp alltraps
.globl vector67
vector67:
  pushl $0
  pushl $67
  jmp alltraps
.globl vector68
vector68:
  pushl $0
  pushl $68
  jmp alltraps
.globl vector69
vector69:
  pushl $0
  pushl $69
  jmp alltraps
.globl vector70
vector70:
  pushl $0
  pushl $70
  jmp alltraps
.globl vector71
vector71:
  pushl $0
  pushl $71
  jmp alltraps
.globl vector72
vector72:
  pushl $0
  pushl $72
  jmp alltraps
.globl vector73
vector73:
  pushl $0
  pushl $73
  jmp alltraps
.globl vector74
vector74:
  pushl $0
  pushl $74
  jmp alltraps
.globl vector75
vector75:
  pushl $0
  pushl $75
  jmp alltraps
.globl vector76
vector76:
  pushl $0
  pushl $76
  jmp alltraps
.globl vector77
vector77:
  pushl $0
  pushl $77
  jmp alltraps
.globl vector78
vector78:
  pushl $0
  pushl $78
  jmp alltraps
.globl vector79
vector79:
  pushl $0
  pushl $79
  jmp alltraps
.globl vector80
vector80:
  pushl $0
  pushl $80
  jmp alltraps
.globl vector81
vector81:
  pushl $0
  pushl $81
  jmp alltraps
.globl vector82
vector82:
  pushl $0
  pushl $82
  jmp alltraps
.globl vector83
vector83:
  pushl $0
  pushl $83
  jmp alltraps
.globl vector84
vector84:
  pushl $0
  pushl $84
  jmp alltraps
.globl vector85
vector85:
  pushl $0
  pushl $85
  jmp alltraps
.globl vector86
vector86:
  pushl $0
  pushl $86
  jmp alltraps
.globl vector87
vector87:
  pushl $0
  pushl $87
  jmp alltraps
.globl vector88
vector88:
  pushl $0
  pushl $88
  jmp alltraps
.globl vector89
vector89:
  pushl $0
  pushl $89
  jmp alltraps
.globl vector90
vector90:
  pushl $0
  pushl $90
  jmp alltraps
.globl vector91
vector91:
  pushl $0
  pushl $91
  jmp alltraps
.globl vector92
vector92:
  pushl $0
  pushl $92
  jmp alltraps
.globl vector93
vector93:
  pushl $0
  pushl $93
  jmp alltraps
.globl vector94
vector94:
  pushl $0
  pushl $94
  jmp alltraps
.globl vector95
vector95:
  pushl $0
  pushl $95
  jmp alltraps
.globl vector96
vector96:
  pushl $0
  pushl $96
  jmp alltraps
.globl vector97
vector97:
  pushl $0
  pushl $97
  jmp alltraps
.globl vector98
vector98:
  pushl $0
  pushl $98
  jmp alltraps
.globl vector99
vector99:
  pushl $0
  pushl $99
  jmp alltraps
.globl vector100
vector100:
  pushl $0
  pushl $100
  jmp alltraps
.globl vector101
vector101:
  pushl $0
  pushl $101
  jmp alltraps
.globl vector102
vector102:
  pushl $0
  pushl $102
  jmp alltraps
.globl vector103
vector103:
  pushl $0
  pushl $103
  jmp alltraps
.globl vector104
vector104:
  pushl $0
  pushl $104
  jmp alltraps
.globl vector105
vector105:
  pushl $0
  pushl $105
  jmp alltraps
.globl vector106
vector106:
  pushl $0
  pushl $106
  jmp alltraps
.globl vector107
vector107:
  pushl $0
  pushl $107
  jmp alltraps
.globl vector108
vector108:
  pushl $0
  pushl $108
  jmp alltraps
.globl vector109
vector109:
  pushl $0
  pushl $109
  jmp alltraps
.globl vector110
vector110:
  pushl $0
  pushl $110
  jmp alltraps
.globl vector111
vector111:
  pushl $0
  pushl $111
  jmp alltraps
.globl vector112
vector112:
  pushl $0
  pushl $112
  jmp alltraps
.globl vector113
vector113:
  pushl $0
  pushl $113
  jmp alltraps
.globl vector114
vector114:
  pushl $0
  pushl $114
  jmp alltraps
.globl vector115
vector115:
  pushl $0
  pushl $115
  jmp alltraps
.globl vector116
vector116:
  pushl $0
  pushl $116
  jmp alltraps
.globl vector117
vector117:
  pushl $0
  pushl $117
  jmp alltraps
.globl vector118
vector118:
  pushl $0
  pushl $118
  jmp alltraps
.globl vector119
vector119:
  pushl $0
  pushl $119
  jmp alltraps
.globl vector120
vector120:
  pushl $0
  pushl $120
  jmp alltraps
.globl vector121
vector121:
  pushl $0
  pushl $121
  jmp alltraps
.globl vector122
vector122:
  pushl $0
  pushl $122
  jmp alltraps
.globl vector123
vector123:
  pushl $0
  pushl $123
  jmp alltraps
.globl vector124
vector124:
  pushl $0
  pushl $124
  jmp alltraps
.globl vector125
vector125:
  pushl $0
  pushl $125
  jmp alltraps
.globl vector126
vector126:
  pushl $0
  pushl $126
  jmp alltraps
.globl vector127
vector127:
  pushl $0
  pushl $127
  jmp alltraps
.globl vector128
vector128:
  pushl $0
  pushl $128
  jmp alltraps
.globl vector129
vector129:
  pushl $0
  pushl $129
  jmp alltraps
.globl vector130
vector130:
  pushl $0
  pushl $130
  jmp alltraps
.globl vector131
vector131:
  pushl $0
  pushl $131
  jmp alltraps
.globl vector132
vector132:
  pushl $0
  pushl $132
  jmp alltraps
.globl vector133
vector133:
  pushl $0
  pushl $133
  jmp alltraps
.globl vector134
vector134:
  pushl $0
  pushl $134
  jmp alltraps
.globl vector135
vector135:
  pushl $0
  pushl $135
  jmp alltraps
.globl vector136
vector136:
  pushl $0
  pushl $136
  jmp alltraps
.globl vector137
vector137:
  pushl $0
  pushl $137
  jmp alltraps
.globl vector138
vector138:
  pushl $0
  pushl $138
  jmp alltraps
.globl vector139
vector139:
  pushl $0
  pushl $139
  jmp alltraps
.globl vector140
vector140:
  pushl $0
  pushl $140
  jmp alltraps
.globl vector141
vector141:
  pushl $0
  pushl $141
  jmp alltraps
.globl vector142
vector142:
  pushl $0
  pushl $142
  jmp alltraps
.globl vector143
vector143:
  pushl $0
  pushl $143
  jmp alltraps
.globl vector144
vector144:
  pushl $0
  pushl $144
  jmp alltraps
.globl vector145
vector145:
  pushl $0
  pushl $145
  jmp alltraps
.globl vector146
vector146:
  pushl $0
  pushl $146
  jmp alltraps
.globl vector147
vector147:
  pushl $0
  pushl $147
  jmp alltraps
.globl vector148
vector148:
  pushl $0
  pushl $148
  jmp alltraps
.globl vector149
vector149:
  pushl $0
  pushl $149
  jmp alltraps
.globl vector150
vector150:
  pushl $0
  pushl $150
  jmp alltraps
.globl vector151
vector151:
  pushl $0
  pushl $151
  jmp alltraps
.globl vector152
vector152:
  pushl $0
  pushl $152
  jmp alltraps
.globl vector153
vector153:
  pushl $0
  pushl $153
  jmp alltraps
.globl vector154
vector154:
  pushl $0
  pushl $154
  jmp alltraps
.globl vector155
vector155:
  pushl $0
  pushl $155
  jmp alltraps
.globl vector156
vector156:
  pushl $0
  pushl $156
  jmp alltraps
.globl vector157
vector157:
  pushl $0
  pushl $157
  jmp alltraps
.globl vector158
vector158:
  pushl $0
  pushl $158
  jmp alltraps
.globl vector159
vector159:
  pushl $0
  pushl $159
  jmp alltraps
.globl vector160
vector160:
  pushl $0
  pushl $160
  jmp alltraps
.globl vector161
vector161:
  pushl $0
  pushl $161
  jmp alltraps
.globl vector162
vector162:
  pushl $0
  pushl $162
  jmp alltraps
.globl vector163
vector163:
  pushl $0
  pushl $163
  jmp alltraps
.globl vector164
vector164:
  pushl $0
  pushl $164
  jmp alltraps
.globl vector165
vector165:
  pushl $0
  pushl $165
  jmp alltraps
.globl vector166
vector166:
  pushl $0
  pushl $166
  jmp alltraps
.globl vector167
vector167:
  pushl $0
  pushl $167
  jmp alltraps
.globl vector168
vector168:
  pushl $0
  pushl $168
  jmp alltraps
.globl vector169
vector169:
  pushl $0
  pushl $169
  jmp alltraps
.globl vector170
vector170:
  pushl $0
  pushl $170
  jmp alltraps
.globl vector171
vector171:
  pushl $0
  pushl $171
  jmp alltraps
.globl vector172
vector172:
  pushl $0
  pushl $172
  jmp alltraps
.globl vector173
vector173:
  pushl $0
  pushl $173
  jmp alltraps
.globl vector174
vector174:
  pushl $0
  pushl $174
  jmp alltraps
.globl vector175
vector175:
  pushl $0
  pushl $175
  jmp alltraps
.globl vector176
vector176:
  pushl $0
  pushl $176
  jmp alltraps
.globl vector177
vector177:
  pushl $0
  pushl $177
  jmp alltraps
.globl vector178
vector178:
  pushl $0
  pushl $178
  jmp alltraps
.globl vector179
vector179:
  pushl $0
  pushl $179
  jmp alltraps
.globl vector180
vector180:
  pushl $0
  pushl $180
  jmp alltraps
.globl vector181
vector181:
  pushl $0
  pushl $181
  jmp alltraps
.globl vector182
vector182:
  pushl $0
  pushl $182
  jmp alltraps
.globl vector183
vector183:
  pushl $0
  pushl $183
  jmp alltraps
.globl vector184
vector184:
  pushl $0
  pushl $184
  jmp alltraps
.globl vector185
vector185:
  pushl $0
  pushl $185
  jmp alltraps
.globl vector186
vector186:
  pushl $0
  pushl $186
  jmp alltraps
.globl vector187
vector187:
  pushl $0
  pushl $187
  jmp alltraps
.globl vector188
vector188:
  pushl $0
  pushl $188
  jmp alltraps
.globl vector189
vector189:
  pushl $0
  pushl $189
  jmp alltraps
.globl vector190
vector190:
  pushl $0
  pushl $190
  jmp alltraps
.globl vector191
vector191:
  pushl $0
  pushl $191
  jmp alltraps
.globl vector192
vector192:
  pushl $0
  pushl $192
  jmp alltraps
.globl vector193
vector193:
  pushl $0
  pushl $193
  jmp alltraps
.globl vector194
vector194:
  pushl $0
  pushl $194
  jmp alltraps
.globl vector195
vector195:
  pushl $0
  pushl $195
  jmp alltraps
.globl vector196
vector196:
  pushl $0
  pushl $196
  jmp alltraps
.globl vector197
vector197:
  pushl $0
  pushl $197
  jmp alltraps
.globl vector198
vector198:
  pushl $0
  pushl $198
  jmp alltraps
.globl vector199
vector199:
  pushl $0
  pushl $199
  jmp alltraps
.globl vector200
vector200:
  pushl $0
  pushl $200
  jmp alltraps
.globl vector201
vector201:
  pushl $0
  pushl $201
  jmp alltraps
.globl vector202
vector202:
  pushl $0
  pushl $202
  jmp alltraps
.globl vector203
vector203:
  pushl $0
  pushl $203
  jmp alltraps
.globl vector204
vector204:
  pushl $0
  pushl $204
  jmp alltraps
.globl vector205
vector205:
  pushl $0
  pushl $205
  jmp alltraps
.globl vector206
vector206:
  pushl $0
  pushl $206
  jmp alltraps
.globl vector207
vector207:
  pushl $0
  pushl $207
  jmp alltraps
.globl vector208
vector208:
  pushl $0
  pushl $208
  jmp alltraps
.globl vector209
vector209:
  pushl $0
  pushl $209
  jmp alltraps
.globl vector210
vector210:
  pushl $0
  pushl $210
  jmp alltraps
.globl vector211
vector211:
  pushl $0
  pushl $211
  jmp alltraps
.globl vector212
vector212:
  pushl $0
  pushl $212
  jmp alltraps
.globl vector213
vector213:
  pushl $0
  pushl $213
  jmp alltraps
.globl vector214
vector214:
  pushl $0
  pushl $214
  jmp alltraps
.globl vector215
vector215:
  pushl $0
  pushl $215
  jmp alltraps
.globl vector216
vector216:
  pushl $0
  pushl $216
  jmp alltraps
.globl vector217
vector217:
  pushl $0
  pushl $217
  jmp alltraps
.globl vector218
vector218:
  pushl $0
  pushl $218
  jmp alltraps
.globl vector219
vector219:
  pushl $0
  pushl $219
  jmp alltraps
.globl vector220
vector220:
  pushl $0
  pushl $220
  jmp alltraps
.globl vector221
vector221:
  pushl $0
  pushl $221
  jmp alltraps
.globl vector222
vector222:
  pushl $0
  pushl $222
  jmp alltraps
.globl vector223
vector223:
  pushl $0
  pushl $223
  jmp alltraps
.globl vector224
vector224:
  pushl $0
  pushl $224
  jmp alltraps
.globl vector225
vector225:
  pushl $0
  pushl $225
  jmp alltraps
.globl vector226
vector226:
  pushl $0
  pushl $226
  jmp alltraps
.globl vector227
vector227:
  pushl $0
  pushl $227
  jmp alltraps
.globl vector228
vector228:
  pushl $0
  pushl $228
  jmp alltraps
.globl vector229
vector229:
  pushl $0
  pushl $229
  jmp alltraps
.globl vector230
vector230:
  pushl $0
  pushl $230
  jmp alltraps
.globl vector231
vector231:
  pushl $0
  pushl $231
  jmp alltraps
.globl vector232
vector232:
  pushl $0
  pushl $232
  jmp alltraps
.globl vector233
vector233:
  pushl $0
  pushl $233
  jmp alltraps
.globl vector234
vector234:
  pushl $0
  pushl $234
  jmp alltraps
.globl vector235
vector235:
  pushl $0
  pushl $235
  jmp alltraps
.globl vector236
vector236:
  pushl $0
  pushl $236
  jmp alltraps
.globl vector237
vector237:
  pushl $0
  pushl $237
  jmp alltraps
.globl vector238
vector238:
  pushl $0
  pushl $238
  jmp alltraps
.globl vector239
vector239:
  pushl $0
  pushl $239
  jmp alltraps
.globl vector240
vector240:
  pushl $0
  pushl $240
  jmp alltraps
.globl vector241
vector241:
  pushl $0
  pushl $241
  jmp alltraps
.globl vector242
vector242:
  pushl $0
  pushl $242
  jmp alltraps
.globl vector243
vector243:
  pushl $0
  pushl $243
  jmp alltraps
.globl vector244
vector244:
  pushl $0
  pushl $244
  jmp alltraps
.globl vector245
vector245:
  pushl $0
  pushl $245
  jmp alltraps
.globl vector246
vector246:
  pushl $0
  pushl $246
  jmp alltraps
.globl vector247
vector247:
  pushl $0
  pushl $247
  jmp alltraps
.globl vector248
vector248:
  pushl $0
  pushl $248
  jmp alltraps
.globl vector249
vector249:
  pushl $0
  pushl $249
  jmp alltraps
.globl vector250
vector250:
  pushl $0
  pushl $250
  jmp alltraps
.globl vector251
vector251:
  pushl $0
  pushl $251
  jmp alltraps
.globl vector252
vector252:
  pushl $0
  pushl $252
  jmp alltraps
.globl vector253
vector253:
  pushl $0
  pushl $253
  jmp alltraps
.globl vector254
vector254:
  pushl $0
  pushl $254
  jmp alltraps
.globl vector255
vector255:
  pushl $0
  pushl $255
  jmp alltraps

# vector table
.data
.globl vectors
vectors:
  .long vector0
  .long vector1
  .long vector2
  .long vector3
  .long vector4
  .long vector5
  .long vector6
  .long vector7
  .long vector8
  .long vector9
  .long vector10
  .long vector11
  .long vector12
  .long vector13
  .long vector14
  .long vector15
  .long vector16
  .long vector17
  .long vector18
  .long vector19
  .long vector20
  .long vector21
  .long vector22
  .long vector23
  .long vector24
  .long vector25
  .long vector26
  .long vector27
  .long vector28
  .long vector29
  .long vector30
  .long vector31
  .long vector32
  .long vector33
  .long vector34
  .long vector35
  .long vector36
  .long vector37
  .long vector38
  .long vector39
  .long vector40
  .long vector41
  .long vector42
  .long vector43
  .long vector44
  .long vector45
  .long vector46
  .long vector47
  .long vector48
  .long vector49
  .long vector50
  .long vector51
  .long vector52
  .long vector53
  .long vector54
  .long vector55
  .long vector56
  .long vector57
  .long vector58
  .long vector59
  .long vector60
  .long vector61
  .long vector62
  .long vector63
  .long vector64
  .long vector65
  .long vector66
  .long vector67
  .long vector68
  .long vector69
  .long vector70
  .long vector71
  .long vector72
  .long vector73
  .long vector74
  .long vector75
  .long vector76
  .long vector77
  .long vector78
  .long vector79
  .long vector80
  .long vector81
  .long vector82
  .long vector83
  .long vector84
  .long vector85
  .long vector86
  .long vector87
  .long vector88
  .long vector89
  .long vector90
  .long vector91
  .long vector92
  .long vector93
  .long vector94
  .long vector95
  .long vector96
  .long vector97
  .long vector98
  .long vector99
  .long vector100
  .long vector101
  .long vector102
  .long vector103
  .long vector104
  .long vector105
  .long vector106
  .long vector107
  .long vector108
  .long vector109
  .long vector110
  .long vector111
  .long vector112
  .long vector113
  .long vector114
  .long vector115
  .long vector116
  .long vector117
  .long vector118
  .long vector119
  .long vector120
  .long vector121
  .long vector122
  .long vector123
  .long vector124
  .long vector125
  .long vector126
  .long vector127
  .long vector128
  .long vector129
  .long vector130
  .long vector131
  .long vector132
  .long vector133
  .long vector134
  .long vector135
  .long vector136
  .long vector137
  .long vector138
  .long vector139
  .long vector140
  .long vector141
  .long vector142
  .long vector143
  .long vector144
  .long vector145
  .long vector146
  .long vector147
  .long vector148
  .long vector149
  .long vector150
  .long vector151
  .long vector152
  .long vector153
  .long vector154
  .long vector155
  .long vector156
  .long vector157
  .long vector158
  .long vector159
  .long vector160
  .long vector161
  .long vector162
  .long vector163
  .long vector164
  .long vector165
  .long vector166
  .long vector167
  .long vector168
  .long vector169
  .long vector170
  .long vector171
  .long vector172
  .long vector173
  .long vector174
  .long vector175
  .long vector176
  .long vector177
  .long vector178
  .long vector179
  .long vector180
  .long vector181
  .long vector182
  .long vector183
  .long vector184
  .long vector185
  .long vector186
  .long vector187
  .long vector188
  .long vector189
  .long vector190
  .long vector191
  .long vector192
  .long vector193
  .long vector194
  .long vector195
  .long vector196
  .long vector197
  .long vector198
  .long vector199
  .long vector200
  .long vector201
  .long vector202
  .long vector203
  .long vector204
  .long vector205
  .long vector206
  .long vector207
  .long vector208
  .long vector209
  .long vector210
  .long vector211
  .long vector212
  .long vector213
  .long vector214
  .long vector215
  .long vector216
  .long vector217
  .long vector218
  .long vector219
  .long vector220
  .long vector221
  .long vector222
  .long vector223
  .long vector224
  .long vector225
  .long vector226
  .long vector227
  .long vector228
  .long vector229
  .long vector230
  .long vector231
  .long vector232
  .long vector233
  .long vector234
  .long vector235
  .long vector236
  .long vector237
  .long vector238
  .long vector239
  .long vector240
  .long vector241
  .long vector242
  .long vector243
  .long vector244
  .long vector245
  .long vector246
  .long vector247
  .long vector248
  .long vector249
  .long vector250
  .long vector251
  .long vector252
  .long vector253
  .long vector254
  .long vector255
