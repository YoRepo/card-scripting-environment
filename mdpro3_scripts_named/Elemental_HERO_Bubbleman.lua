--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 元素英雄 水泡侠  (ID: 79979666)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Warrior
-- Level 4
-- ATK 800 | DEF 1200
-- Setcode: 12296
--
-- Effect Text:
-- ①：手卡只有这1张卡的场合，这张卡可以从手卡特殊召唤。
-- ②：这张卡召唤·反转召唤·特殊召唤时才能发动（这个效果在自己的手卡·场上没有其他卡存在的场合才能发动和处理）。自己抽2张。
--[[ __CARD_HEADER_END__ ]]

--E・HERO バブルマン
function c79979666.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c79979666.spcon)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(79979666,1))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_ACTIVATE_CONDITION)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCondition(c79979666.condition)
	e2:SetTarget(c79979666.target)
	e2:SetOperation(c79979666.operation)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	local e4=e2:Clone()
	e4:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e4)
end
function c79979666.spcon(e,c)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_HAND,0)==1
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c79979666.filter(c)
	return not c:IsStatus(STATUS_LEAVE_CONFIRMED)
end
function c79979666.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c79979666.filter,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,e:GetHandler())
end
function c79979666.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c79979666.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(c79979666.filter,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,e:GetHandler()) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
