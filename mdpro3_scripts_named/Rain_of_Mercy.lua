--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Rain of Mercy  (ID: 66719324)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- Increase the Life Points of both players by 1000 points.
--[[ __CARD_HEADER_END__ ]]

--恵みの雨
function c66719324.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c66719324.target)
	e1:SetOperation(c66719324.operation)
	c:RegisterEffect(e1)
end
function c66719324.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,PLAYER_ALL,1000)
end
function c66719324.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Recover(tp,1000,REASON_EFFECT)
	Duel.Recover(1-tp,1000,REASON_EFFECT)
end
