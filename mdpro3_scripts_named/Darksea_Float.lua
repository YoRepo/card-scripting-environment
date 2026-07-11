--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Darksea Float  (ID: 70054514)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level: 1
-- ATK 0 | DEF 300
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card on the field is destroyed by a card effect and sent to the Graveyard, the owner of
-- this card draws 1 card.
--[[ __CARD_HEADER_END__ ]]

--ダークシー・フロート
function c70054514.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(70054514,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCondition(c70054514.drcon)
	e1:SetTarget(c70054514.drtg)
	e1:SetOperation(c70054514.drop)
	c:RegisterEffect(e1)
end
function c70054514.drcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_DESTROY) and c:IsReason(REASON_EFFECT) and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c70054514.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c70054514.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
