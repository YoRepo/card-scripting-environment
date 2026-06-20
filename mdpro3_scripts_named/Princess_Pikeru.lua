--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 魔法之国的王女-绒儿  (ID: 75917088)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 4
-- ATK 2000 | DEF 0
--
-- Effect Text:
-- 这张卡不能通常召唤。这张卡只能通过「王女的试炼」的效果才能特殊召唤。自己准备阶段时，回复自己场上存在的怪兽数量×800的数值的基本分。
--[[ __CARD_HEADER_END__ ]]

--魔法の国の王女－ピケル
function c75917088.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--recover
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75917088,0))
	e2:SetCategory(CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c75917088.condition)
	e2:SetTarget(c75917088.target)
	e2:SetOperation(c75917088.operation)
	c:RegisterEffect(e2)
end
function c75917088.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c75917088.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,ct*800)
end
function c75917088.operation(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
	Duel.Recover(p,ct*800,REASON_EFFECT)
end
