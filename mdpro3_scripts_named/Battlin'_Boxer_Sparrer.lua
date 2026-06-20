--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 燃烧拳击手 练习拳手  (ID: 32750341)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Warrior
-- Level 4
-- ATK 1200 | DEF 1400
-- Setcode: 4228
--
-- Effect Text:
-- 自己场上有名字带有「燃烧拳击手」的怪兽存在的场合，这张卡可以从手卡特殊召唤。这个方法特殊召唤过的场合，这个回合自己不能进行战斗阶段。
--[[ __CARD_HEADER_END__ ]]

--BK スパー
function c32750341.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c32750341.spcon)
	e1:SetOperation(c32750341.spop)
	c:RegisterEffect(e1)
end
function c32750341.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x1084)
end
function c32750341.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c32750341.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c32750341.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
