--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Skelengel  (ID: 60694662)
-- Type: Monster / Effect / Flip
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 2
-- ATK 900 | DEF 400
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: Draw 1 card.
--[[ __CARD_HEADER_END__ ]]

--スケルエンジェル
function c60694662.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(60694662,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c60694662.target)
	e1:SetOperation(c60694662.operation)
	c:RegisterEffect(e1)
end
function c60694662.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c60694662.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
