--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: DDD 反骨王 列奥尼达  (ID: 92536468)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Fiend
-- Level 7
-- Pendulum Scales: L3 / R3
-- ATK 2600 | DEF 1200
-- Setcode: 4271
--
-- Effect Text:
-- ←3 【灵摆】 3→
-- ①：自己受到效果伤害时才能把这个效果发动。这张卡破坏，并且这个回合，给与基本分伤害的效果再变成让基本分回复的效果。
-- 【怪兽效果】
-- ①：自己受到效果伤害时才能发动。这张卡从手卡特殊召唤，自己基本分回复受到的伤害的数值。
-- ②：只要这张卡在怪兽区域存在，自己受到的效果伤害变成0。
--[[ __CARD_HEADER_END__ ]]

--DDD反骨王レオニダス
function c92536468.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--reverse damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(92536468,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EVENT_DAMAGE)
	e2:SetCondition(c92536468.effcon)
	e2:SetTarget(c92536468.revtg)
	e2:SetOperation(c92536468.revop)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(92536468,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_RECOVER)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_HAND)
	e3:SetCode(EVENT_DAMAGE)
	e3:SetCondition(c92536468.effcon)
	e3:SetTarget(c92536468.sptg)
	e3:SetOperation(c92536468.spop)
	c:RegisterEffect(e3)
	--avoid damage
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCode(EFFECT_CHANGE_DAMAGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(1,0)
	e4:SetValue(c92536468.damval)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_NO_EFFECT_DAMAGE)
	c:RegisterEffect(e5)
end
function c92536468.effcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and bit.band(r,REASON_EFFECT)~=0
end
function c92536468.revtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c92536468.revop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.Destroy(c,REASON_EFFECT)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_REVERSE_DAMAGE)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetTargetRange(1,1)
		e1:SetValue(c92536468.revval)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
end
function c92536468.revval(e,re,r,rp,rc)
	return bit.band(r,REASON_EFFECT)~=0
end
function c92536468.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,ev)
end
function c92536468.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		Duel.Recover(tp,ev,REASON_EFFECT)
	end
end
function c92536468.damval(e,re,val,r,rp,rc)
	if bit.band(r,REASON_EFFECT)~=0 then return 0 end
	return val
end
