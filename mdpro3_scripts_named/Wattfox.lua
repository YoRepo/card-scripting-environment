--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 电气狐  (ID: 46897277)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Thunder
-- Level 2
-- ATK 800 | DEF 100
-- Setcode: 14
--
-- Effect Text:
-- 这张卡被对方破坏的场合，那个回合对方不能作怪兽的特殊召唤以及把魔法·陷阱·效果怪兽的效果发动。
--[[ __CARD_HEADER_END__ ]]

--エレキツネ
function c46897277.initial_effect(c)
	--act limit
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(46897277,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCondition(c46897277.condition)
	e1:SetOperation(c46897277.operation)
	c:RegisterEffect(e1)
end
function c46897277.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and e:GetHandler():IsPreviousControler(tp)
end
function c46897277.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(0,1)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetReset(RESET_PHASE+PHASE_END)
	e2:SetTargetRange(0,1)
	Duel.RegisterEffect(e2,tp)
end
