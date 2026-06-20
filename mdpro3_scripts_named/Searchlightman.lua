--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 探照灯人  (ID: 67646312)
-- Type: Monster / Effect / Toon
-- Attribute: LIGHT
-- Race: Machine
-- Level 3
-- ATK 1000 | DEF 1000
--
-- Effect Text:
-- 反转：这个回合对方玩家不能在场上把卡盖放。
--[[ __CARD_HEADER_END__ ]]

--サーチライトメン
function c67646312.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(67646312,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c67646312.operation)
	c:RegisterEffect(e1)
end
function c67646312.operation(e,tp,eg,ep,ev,re,r,rp)
	--cannot set
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_MSET)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_SSET)
	Duel.RegisterEffect(e2,tp)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CANNOT_TURN_SET)
	Duel.RegisterEffect(e3,tp)
	local e4=e1:Clone()
	e4:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e4:SetTarget(c67646312.sumlimit)
	Duel.RegisterEffect(e4,tp)
end
function c67646312.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return bit.band(sumpos,POS_FACEDOWN)>0
end
