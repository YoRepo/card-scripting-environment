--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 魔方人  (ID: 17530001)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level 4
-- ATK 600 | DEF 1900
--
-- Effect Text:
-- ①：1回合1次，自己主要阶段才能发动。掷1次骰子。只要这只怪兽在场上表侧表示存在，双方不能把和出现的数目相同等级的怪兽召唤·特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--キューブン
function c17530001.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(17530001,0))
	e1:SetCategory(CATEGORY_DICE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c17530001.target)
	e1:SetOperation(c17530001.operation)
	c:RegisterEffect(e1)
end
function c17530001.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c17530001.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	local dc=Duel.TossDice(tp,1)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetTargetRange(1,1)
	e1:SetTarget(c17530001.tglimit)
	e1:SetLabel(dc)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	c:RegisterEffect(e2)
end
function c17530001.tglimit(e,c)
	return c:IsLevel(e:GetLabel())
end
