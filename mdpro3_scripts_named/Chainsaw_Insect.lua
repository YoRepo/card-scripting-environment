--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Chainsaw Insect  (ID: 77252217)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Insect
-- Level: 4
-- ATK 2400 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card battled, at the end of the Damage Step: Your opponent draws 1 card.
--[[ __CARD_HEADER_END__ ]]

--電動刃虫
function c77252217.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(77252217,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetCondition(aux.dsercon)
	e1:SetTarget(c77252217.drtg)
	e1:SetOperation(c77252217.drop)
	c:RegisterEffect(e1)
end
function c77252217.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,1)
end
function c77252217.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
