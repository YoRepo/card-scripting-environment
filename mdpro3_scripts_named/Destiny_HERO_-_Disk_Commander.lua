--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Destiny HERO - Disk Commander  (ID: 56570271)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level: 1
-- ATK 300 | DEF 300
-- Setcode: 0xc008
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be Special Summoned from the GY the turn this card was sent to the GY.
-- If this card is Special Summoned from the GY: You can draw 2 cards.
-- You can only use this effect of "Destiny HERO - Disk Commander" once per Duel.
--[[ __CARD_HEADER_END__ ]]

--D-HERO ディスクガイ
function c56570271.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(56570271,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,56570271+EFFECT_COUNT_CODE_DUEL)
	e1:SetCondition(c56570271.condition)
	e1:SetTarget(c56570271.target)
	e1:SetOperation(c56570271.operation)
	c:RegisterEffect(e1)
	--spsummon limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetValue(c56570271.splimit)
	c:RegisterEffect(e2)
end
function c56570271.splimit(e,se,sp,st)
	local c=e:GetHandler()
	return not c:IsLocation(LOCATION_GRAVE) or Duel.GetTurnCount()~=c:GetTurnID() or c:IsReason(REASON_RETURN)
end
function c56570271.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonLocation(LOCATION_GRAVE)
end
function c56570271.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c56570271.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
