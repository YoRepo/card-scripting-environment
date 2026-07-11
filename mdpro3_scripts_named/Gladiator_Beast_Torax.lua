--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Gladiator Beast Torax  (ID: 65984457)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level: 3
-- ATK 1400 | DEF 400
-- Setcode: 0x1019
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card was Special Summoned by the effect of a "Gladiator Beast" monster, at the end of any
-- Battle Phase that this card attacked or was attacked, you can return it to the Deck to draw 1 card.
--[[ __CARD_HEADER_END__ ]]

--剣闘獣トラケス
function c65984457.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(65984457,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c65984457.spcon)
	e1:SetCost(c65984457.spcost)
	e1:SetTarget(c65984457.sptg)
	e1:SetOperation(c65984457.spop)
	c:RegisterEffect(e1)
end
function c65984457.spcon(e,tp,eg,ep,ev,re,r,rp)
	return aux.gbspcon(e,tp,eg,ep,ev,re,r,rp) and e:GetHandler():GetBattledGroupCount()>0
end
function c65984457.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToDeckAsCost() end
	Duel.SendtoDeck(c,nil,SEQ_DECKSHUFFLE,REASON_COST)
end
function c65984457.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c65984457.spop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
