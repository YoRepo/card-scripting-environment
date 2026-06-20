--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 王家长眠之谷的祭殿  (ID: 70000776)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 145
--
-- Effect Text:
-- 场上有名字带有「守墓」的怪兽以及「王家长眠之谷」存在的场合才能发动。只要这张卡在场上存在，双方不能把名字带有「守墓」的怪兽以外的怪兽特殊召唤。名字带有「守墓」的怪兽以及「王家长眠之谷」不在场上存在的场
-- 合，这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--ネクロバレーの祭殿
function c70000776.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c70000776.actcon)
	c:RegisterEffect(e1)
	--disable spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,1)
	e2:SetTarget(c70000776.sumlimit)
	c:RegisterEffect(e2)
	--self destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EFFECT_SELF_DESTROY)
	e3:SetCondition(c70000776.sdcon)
	c:RegisterEffect(e3)
end
function c70000776.cfilter1(c)
	return c:IsFaceup() and c:IsSetCard(0x2e)
end
function c70000776.actcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c70000776.cfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
		and Duel.IsEnvironment(47355498)
end
function c70000776.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return not c:IsSetCard(0x2e)
end
function c70000776.sdcon(e)
	return not Duel.IsExistingMatchingCard(c70000776.cfilter1,0,LOCATION_MZONE,LOCATION_MZONE,1,nil)
		or not Duel.IsEnvironment(47355498)
end
