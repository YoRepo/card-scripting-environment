--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Skull-Mark Ladybug  (ID: 64306248)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Insect
-- Level: 4
-- ATK 500 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is sent to the Graveyard, increase your Life Points by 1000 points.
--[[ __CARD_HEADER_END__ ]]

--髑髏顔 天道虫
function c64306248.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(64306248,0))
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetTarget(c64306248.target)
	e1:SetOperation(c64306248.operation)
	c:RegisterEffect(e1)
end
function c64306248.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,1000)
end
function c64306248.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
